import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../api/media_list_api.dart';
import '../models/common.dart';
import '../models/media_list.dart';
import '../models/media_list_entry.dart';
import '../proto/api.pb.dart';
import '../proto/media_list.pb.dart' as pb_list;
import '../utils/app_options.dart';
import 'auth_service.dart';

/// Service for managing user media lists and caches.
class MediaListService {
  static const String _cacheKeyAnimeLists = 'cached_anime_lists';
  static const String _cacheKeyMangaLists = 'cached_manga_lists';

  /// Retrieves the user media lists from cache or network.
  static Future<List<MediaList>> getLists(
    int userId,
    String mediaType, {
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh) {
      final cached = await _getListsFromDiskCache(mediaType);
      if (cached != null) return cached;
    }
    return _fetchNetworkLists(userId, mediaType);
  }

  /// Retrieves the user media lists from local disk cache.
  static Future<List<MediaList>?> _getListsFromDiskCache(
    String mediaType,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final cachedStr = prefs.getString(
      mediaType == 'MANGA' ? _cacheKeyMangaLists : _cacheKeyAnimeLists,
    );
    if (cachedStr != null) {
      try {
        final collection = pb_list.MediaListCollection.fromBuffer(
          base64Decode(cachedStr),
        );
        return collection.lists.map(MediaList.fromProto).toList();
      } catch (_) {}
    }

    return null;
  }

  /// Saves the user media lists to local disk cache.
  static Future<void> _saveListToDiskCache(
    List<MediaList> lists,
    String mediaType,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final collection = pb_list.MediaListCollection(
      lists: lists.map((l) => l.toProto()),
    );
    await prefs.setString(
      mediaType == 'MANGA' ? _cacheKeyMangaLists : _cacheKeyAnimeLists,
      base64Encode(collection.writeToBuffer()),
    );
  }

  /// Fetches fresh user media lists from the network.
  static Future<List<MediaList>> _fetchNetworkLists(
    int userId,
    String mediaType,
  ) async {
    final token = await AuthService.getRawToken() ?? '';
    final response = await MediaListApi.fetchMediaList(
      userId,
      token,
      mediaType,
    );
    final rawLists = response.lists;

    final allEntries = <MediaListEntryWithMedia>[];
    for (final list in rawLists) {
      for (final entry in list.entries) {
        allEntries.add(entry);
      }
    }

    final Map<MediaListStatus, List<MediaListEntryWithMedia>> grouped = {
      MediaListStatus.current: [],
      MediaListStatus.planning: [],
      MediaListStatus.completed: [],
      MediaListStatus.paused: [],
      MediaListStatus.dropped: [],
    };

    for (final entry in allEntries) {
      final status = entry.status ?? MediaListStatus.current;
      final displayStatus = status == MediaListStatus.repeating
          ? MediaListStatus.current
          : status;
      grouped[displayStatus] ??= [];
      grouped[displayStatus]!.add(entry);
    }

    final orderedStatuses = [
      MediaListStatus.current,
      MediaListStatus.planning,
      MediaListStatus.completed,
      MediaListStatus.paused,
      MediaListStatus.dropped,
    ];

    final List<MediaList> processedLists = [];

    for (final status in orderedStatuses) {
      if (grouped.containsKey(status)) {
        final name = status.displayName(isManga: mediaType == 'MANGA');

        processedLists.add(
          MediaList(name: name, status: status, entries: grouped[status] ?? []),
        );
      }
    }

    for (final status in grouped.keys) {
      if (!orderedStatuses.contains(status) && grouped[status]!.isNotEmpty) {
        final name = status.displayName(isManga: mediaType == 'MANGA');
        processedLists.add(
          MediaList(name: name, status: status, entries: grouped[status] ?? []),
        );
      }
    }

    await _saveListToDiskCache(processedLists, mediaType);
    return processedLists;
  }

  /// Updates or deletes an entry in the provided media lists.
  static Future<List<MediaList>> updateEntryInLists(
    List<MediaList> currentLists,
    int mediaId,
    MediaOptionsResult result,
    String mediaType,
  ) async {
    if (result.deleted) {
      final updatedLists = currentLists.map((section) {
        final entries = List<MediaListEntryWithMedia>.from(section.entries);
        entries.removeWhere((e) => e.media.id == mediaId);
        return MediaList(
          name: section.name,
          status: section.status,
          entries: entries,
        );
      }).toList();

      await _saveListToDiskCache(updatedLists, mediaType);
      return updatedLists;
    }

    if (result.entry == null) return currentLists;

    const orderedStatuses = [
      MediaListStatus.current,
      MediaListStatus.planning,
      MediaListStatus.completed,
      MediaListStatus.paused,
      MediaListStatus.dropped,
    ];

    MediaListEntryWithMedia? movedEntry;
    final MediaListStatus? targetStatus = result.entry!.status;

    final updatedLists = currentLists.map((section) {
      final entries = List<MediaListEntryWithMedia>.from(section.entries);
      final idx = entries.indexWhere((e) => e.media.id == mediaId);

      if (idx == -1) {
        return section;
      }

      final entry = entries[idx];
      final oldStatus = entry.status;
      final newStatus = result.entry!.status;

      final oldSectionStatus = oldStatus == MediaListStatus.repeating
          ? MediaListStatus.current
          : oldStatus;
      final newSectionStatus = newStatus == MediaListStatus.repeating
          ? MediaListStatus.current
          : newStatus;

      if (targetStatus != null && oldSectionStatus != newSectionStatus) {
        movedEntry = result.entry;
        entries.removeAt(idx);
      } else {
        entries[idx] = result.entry!;
      }

      return MediaList(
        name: section.name,
        status: section.status,
        entries: entries,
      );
    }).toList();

    if (movedEntry != null && targetStatus != null) {
      final targetSectionStatus = targetStatus == MediaListStatus.repeating
          ? MediaListStatus.current
          : targetStatus;
      final targetIdx = updatedLists.indexWhere(
        (s) => s.status == targetSectionStatus,
      );
      if (targetIdx != -1) {
        final section = updatedLists[targetIdx];
        final entries = List<MediaListEntryWithMedia>.from(section.entries)
          ..add(movedEntry!);
        updatedLists[targetIdx] = MediaList(
          name: section.name,
          status: section.status,
          entries: entries,
        );
      } else {
        final insertAt = updatedLists.indexWhere((s) {
          final pos = s.status != null
              ? orderedStatuses.indexOf(s.status!)
              : -1;
          return pos > orderedStatuses.indexOf(targetSectionStatus);
        });
        final newSection = MediaList(
          name: targetSectionStatus.displayName(isManga: mediaType == 'MANGA'),
          status: targetSectionStatus,
          entries: [movedEntry!],
        );
        if (insertAt == -1) {
          updatedLists.add(newSection);
        } else {
          updatedLists.insert(insertAt, newSection);
        }
      }
    }

    await _saveListToDiskCache(updatedLists, mediaType);

    return updatedLists;
  }

  /// Saves or updates an media list entry.
  static Future<MediaListEntry> saveEntry({
    required int mediaId,
    MediaListStatus? status,
    int? progress,
    double? score,
    DateTime? startDate,
    DateTime? finishDate,
    int? progressVolumes,
    int? repeat,
  }) async {
    final token = await AuthService.getRawToken() ?? '';
    final req = SaveMediaListEntryRequest(mediaId: mediaId);

    if (status != null) req.status = status.toString();
    if (progress != null) req.progress = progress;
    if (score != null) req.score = score;
    if (progressVolumes != null) req.progressVolumes = progressVolumes;
    if (repeat != null) req.repeat = repeat;

    if (startDate != null) {
      req.startedAt = FuzzyDateInput(
        year: startDate.year,
        month: startDate.month,
        day: startDate.day,
      );
    }
    if (finishDate != null) {
      req.completedAt = FuzzyDateInput(
        year: finishDate.year,
        month: finishDate.month,
        day: finishDate.day,
      );
    }

    return MediaListApi.saveMediaListEntry(req, token);
  }

  /// Deletes an media list entry by its entry ID.
  static Future<void> deleteEntry(int entryId) async {
    final token = await AuthService.getRawToken() ?? '';
    final req = DeleteMediaListEntryRequest(entryId: entryId);
    await MediaListApi.deleteMediaListEntry(req, token);
  }
}
