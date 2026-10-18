import 'dart:async';
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
import 'custom_list_service.dart';

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

  /// Saves the user media lists to local disk cache.
  static Future<void> saveListsToCache(
    List<MediaList> lists,
    String mediaType,
  ) => _saveListToDiskCache(lists, mediaType);

  /// Fetches fresh user media lists from the network.
  static Future<List<MediaList>> _fetchNetworkLists(
    int userId,
    String mediaType,
  ) async {
    String token = '';
    try {
      token = await AuthService.getValidToken();
    } on AuthExpiredException {
      token = '';
    } catch (_) {
      token = await AuthService.getRawToken() ?? '';
    }

    MediaListCollection response;
    try {
      response = await MediaListApi.fetchMediaList(userId, token, mediaType);
    } catch (e) {
      if (token.isNotEmpty && e.toString().contains('Invalid token')) {
        await AuthService.clearToken();
        response = await MediaListApi.fetchMediaList(userId, '', mediaType);
      } else {
        rethrow;
      }
    }
    final rawLists = response.lists;
    final customListNames = rawLists
        .where((l) => l.isCustomList || l.status == null)
        .map((l) => l.name)
        .where((name) => name.isNotEmpty)
        .toList();

    if (customListNames.isNotEmpty) {
      final existing = CustomListService.instance.getCustomLists(mediaType);
      final merged = {...existing, ...customListNames}.toList();
      unawaited(CustomListService.instance.setCustomLists(mediaType, merged));
    }

    final Map<int, MediaListEntryWithMedia> uniqueEntries = {};
    for (final list in rawLists) {
      for (final entry in list.entries) {
        uniqueEntries[entry.media.id] = entry;
      }
    }
    final allEntries = uniqueEntries.values.toList();

    final Map<MediaListStatus, List<MediaListEntryWithMedia>> grouped = {
      MediaListStatus.current: [],
      MediaListStatus.planning: [],
      MediaListStatus.completed: [],
      MediaListStatus.paused: [],
      MediaListStatus.dropped: [],
    };

    for (final entry in allEntries) {
      if (entry.hiddenFromStatusLists) continue;
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

    final allCustomListNames = {
      ...CustomListService.instance.getCustomLists(mediaType),
      ...customListNames,
    }.toList();

    for (final customName in allCustomListNames) {
      final rawList = rawLists
          .where(
            (l) => (l.isCustomList || l.status == null) && l.name == customName,
          )
          .firstOrNull;

      final customEntries = <MediaListEntryWithMedia>[];
      final seenMediaIds = <int>{};

      if (rawList != null) {
        for (final entry in rawList.entries) {
          if (seenMediaIds.add(entry.media.id)) {
            customEntries.add(entry);
          }
        }
      }

      for (final entry in allEntries) {
        if (entry.customLists.contains(customName) &&
            seenMediaIds.add(entry.media.id)) {
          customEntries.add(entry);
        }
      }

      processedLists.add(
        MediaList(name: customName, isCustomList: true, entries: customEntries),
      );
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
          isCustomList: section.isCustomList,
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
    final isHiddenFromStatusLists = result.entry!.hiddenFromStatusLists;

    final updatedLists = currentLists.map((section) {
      final entries = List<MediaListEntryWithMedia>.from(section.entries);
      final idx = entries.indexWhere((e) => e.media.id == mediaId);

      if (section.isCustomList) {
        final inCustomList = result.entry!.customLists.contains(section.name);
        if (inCustomList) {
          if (idx != -1) {
            entries[idx] = result.entry!;
          } else {
            entries.add(result.entry!);
          }
        } else if (idx != -1) {
          entries.removeAt(idx);
        }
        return MediaList(
          name: section.name,
          isCustomList: true,
          status: section.status,
          entries: entries,
        );
      }

      if (isHiddenFromStatusLists) {
        if (idx != -1) entries.removeAt(idx);
        return MediaList(
          name: section.name,
          isCustomList: section.isCustomList,
          status: section.status,
          entries: entries,
        );
      }

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
        isCustomList: section.isCustomList,
        status: section.status,
        entries: entries,
      );
    }).toList();

    if (!isHiddenFromStatusLists &&
        movedEntry != null &&
        targetStatus != null) {
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
          isCustomList: section.isCustomList,
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

    for (final customName in result.entry!.customLists) {
      final exists = updatedLists.any(
        (s) => s.isCustomList && s.name == customName,
      );
      if (!exists) {
        updatedLists.add(
          MediaList(
            name: customName,
            isCustomList: true,
            entries: [result.entry!],
          ),
        );
      }
    }

    await _saveListToDiskCache(updatedLists, mediaType);

    return updatedLists;
  }

  /// Builds a protobuf request for saving or updating a media list entry.
  static SaveMediaListEntryRequest buildSaveEntryRequest({
    required int mediaId,
    MediaListStatus? status,
    int? progress,
    double? score,
    DateTime? startDate,
    DateTime? finishDate,
    int? progressVolumes,
    int? repeat,
    bool? private,
    bool? hiddenFromStatusLists,
    List<String>? customLists,
    String? notes,
  }) {
    final req = SaveMediaListEntryRequest(mediaId: mediaId);

    if (status != null) req.status = status.toString();
    if (progress != null) req.progress = progress;
    if (score != null) req.score = score;
    if (progressVolumes != null) req.progressVolumes = progressVolumes;
    if (repeat != null) req.repeat = repeat;
    if (private != null) req.private = private;
    if (hiddenFromStatusLists != null) {
      req.hiddenFromStatusLists = hiddenFromStatusLists;
    }
    if (customLists != null) {
      req.customLists = CustomListsInput(customLists: customLists);
    }
    if (notes != null) req.notes = notes;

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

    return req;
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
    bool? private,
    bool? hiddenFromStatusLists,
    List<String>? customLists,
    String? notes,
  }) async {
    final token = await AuthService.getRawToken() ?? '';
    final req = buildSaveEntryRequest(
      mediaId: mediaId,
      status: status,
      progress: progress,
      score: score,
      startDate: startDate,
      finishDate: finishDate,
      progressVolumes: progressVolumes,
      repeat: repeat,
      private: private,
      hiddenFromStatusLists: hiddenFromStatusLists,
      customLists: customLists,
      notes: notes,
    );

    return MediaListApi.saveMediaListEntry(req, token);
  }

  /// Deletes an media list entry by its entry ID.
  static Future<void> deleteEntry(int entryId) async {
    final token = await AuthService.getRawToken() ?? '';
    final req = DeleteMediaListEntryRequest(entryId: entryId);
    await MediaListApi.deleteMediaListEntry(req, token);
  }
}
