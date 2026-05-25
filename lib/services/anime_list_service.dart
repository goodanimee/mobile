import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/media_list_api.dart';
import '../models/common.dart';
import '../models/media_list.dart';
import '../models/media_list_entry.dart';
import '../utils/app_options.dart';
import 'auth_service.dart';
import '../proto/media_list.pb.dart' as pb_list;
import '../proto/api.pb.dart';

/// Service for managing user anime list data and caches.
class AnimeListService {
  static const String _cacheKeyLists = 'cached_anime_lists';

  /// Retrieves the user anime lists from cache or network.
  static Future<List<MediaList>> getLists(
    int userId, {
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh) {
      final cached = await _getListsFromDiskCache();
      if (cached != null) return cached;
    }
    return await _fetchNetworkLists(userId);
  }

  /// Retrieves the user anime lists from local disk cache.
  static Future<List<MediaList>?> _getListsFromDiskCache() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedJson = prefs.getString(_cacheKeyLists);
    if (cachedJson != null) {
      try {
        final List<dynamic> decoded = jsonDecode(cachedJson);
        return decoded
            .map(
              (l) => MediaList.fromProto(
                pb_list.MediaListGroup.fromBuffer(base64Decode(l as String)),
              ),
            )
            .toList();
      } catch (_) {}
    }

    return null;
  }

  /// Fetches fresh user anime lists from the network.
  static Future<List<MediaList>> _fetchNetworkLists(int userId) async {
    final token = await AuthService.getRawToken() ?? '';
    final response = await MediaListApi.fetchMediaList(userId, token);
    final rawLists = response.lists;

    final allEntries = <MediaListEntryWithMedia>[];
    for (final list in rawLists) {
      for (final entry in list.entries) {
        allEntries.add(entry);
      }
    }

    final Map<MediaListStatus, List<MediaListEntryWithMedia>> grouped = {
      MediaListStatus.current: [],
      MediaListStatus.repeating: [],
      MediaListStatus.planning: [],
      MediaListStatus.completed: [],
      MediaListStatus.paused: [],
      MediaListStatus.dropped: [],
    };

    for (final entry in allEntries) {
      final status = entry.status ?? MediaListStatus.current;
      grouped[status] ??= [];
      grouped[status]!.add(entry);
    }

    final orderedStatuses = [
      MediaListStatus.current,
      MediaListStatus.planning,
      MediaListStatus.completed,
      MediaListStatus.repeating,
      MediaListStatus.paused,
      MediaListStatus.dropped,
    ];

    final List<MediaList> processedLists = [];

    for (final status in orderedStatuses) {
      if (grouped.containsKey(status)) {
        final name = status.displayName;

        processedLists.add(
          MediaList(name: name, status: status, entries: grouped[status] ?? []),
        );
      }
    }

    for (final status in grouped.keys) {
      if (!orderedStatuses.contains(status) && grouped[status]!.isNotEmpty) {
        final name = status.displayName;
        processedLists.add(
          MediaList(name: name, status: status, entries: grouped[status] ?? []),
        );
      }
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _cacheKeyLists,
      jsonEncode(
        processedLists
            .map((l) => base64Encode(l.toProto().writeToBuffer()))
            .toList(),
      ),
    );
    return processedLists;
  }

  /// Updates or deletes an entry in the provided anime lists.
  static Future<List<MediaList>> updateEntryInLists(
    List<MediaList> currentLists,
    int mediaId,
    AnimeOptionsResult result,
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

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        _cacheKeyLists,
        jsonEncode(
          updatedLists
              .map((l) => base64Encode(l.toProto().writeToBuffer()))
              .toList(),
        ),
      );
      return updatedLists;
    }

    if (result.entry == null) return currentLists;

    const orderedStatuses = [
      MediaListStatus.current,
      MediaListStatus.planning,
      MediaListStatus.completed,
      MediaListStatus.repeating,
      MediaListStatus.paused,
      MediaListStatus.dropped,
    ];

    MediaListEntryWithMedia? movedEntry;
    MediaListStatus? targetStatus = result.entry!.status;

    final updatedLists = currentLists.map((section) {
      final entries = List<MediaListEntryWithMedia>.from(section.entries);
      final idx = entries.indexWhere((e) => e.media.id == mediaId);

      if (idx == -1) {
        return section;
      }

      final entry = entries[idx];
      final oldStatus = entry.status;
      final newStatus = result.entry!.status;

      if (targetStatus != null && oldStatus != newStatus) {
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
      final targetIdx = updatedLists.indexWhere(
        (s) => s.status == targetStatus,
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
          return pos > orderedStatuses.indexOf(targetStatus);
        });
        final newSection = MediaList(
          name: targetStatus.displayName,
          status: targetStatus,
          entries: [movedEntry!],
        );
        if (insertAt == -1) {
          updatedLists.add(newSection);
        } else {
          updatedLists.insert(insertAt, newSection);
        }
      }
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _cacheKeyLists,
      jsonEncode(
        updatedLists
            .map((l) => base64Encode(l.toProto().writeToBuffer()))
            .toList(),
      ),
    );

    return updatedLists;
  }

  /// Saves or updates an anime list entry.
  static Future<MediaListEntry> saveEntry({
    required int mediaId,
    MediaListStatus? status,
    int? progress,
    double? score,
    DateTime? startDate,
    DateTime? finishDate,
  }) async {
    final token = await AuthService.getRawToken() ?? '';
    final req = SaveMediaListEntryRequest(mediaId: mediaId);

    if (status != null) req.status = status.toString();
    if (progress != null) req.progress = progress;
    if (score != null) req.score = score;

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

    return await MediaListApi.saveMediaListEntry(req, token);
  }

  /// Deletes an anime list entry by its entry ID.
  static Future<void> deleteEntry(int entryId) async {
    final token = await AuthService.getRawToken() ?? '';
    final req = DeleteMediaListEntryRequest(entryId: entryId);
    await MediaListApi.deleteMediaListEntry(req, token);
  }
}
