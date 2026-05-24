import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/user_api.dart';
import '../api/media_list_api.dart';
import '../models/common.dart';
import '../models/media_list.dart';
import '../utils/app_options.dart';
import 'auth_service.dart';
import '../proto/media_list.pb.dart' as pb_list;
import '../proto/viewer.pb.dart' as pb_viewer;
import '../models/viewer.dart';

/// Repository for managing user anime list data and caches
class AnimeListRepo {
  static const String _cacheKeyLists = 'cached_anime_lists';
  static const String _cacheKeyViewer = 'cached_viewer';

  /// Retrieves the cached or remote user ID
  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedStr = prefs.getString(_cacheKeyViewer);

    if (cachedStr != null) {
      try {
        final viewer = Viewer.fromProto(
          pb_viewer.Viewer.fromBuffer(base64Decode(cachedStr)),
        );
        return viewer.id;
      } catch (_) {}
    }

    try {
      final token = await AuthService.getRawToken() ?? '';
      final viewer = await UserApi.fetchViewer(token);

      await prefs.setString(
        _cacheKeyViewer,
        base64Encode(viewer.toProto().writeToBuffer()),
      );
      await prefs.setInt(
        'cached_viewer_at',
        DateTime.now().millisecondsSinceEpoch,
      );
      return viewer.id;
    } catch (e) {
      return null;
    }
  }

  /// Retrieves the user anime lists from local disk cache
  static Future<List<MediaList>?> getCachedLists() async {
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

  /// Fetches fresh user anime lists from the network
  static Future<List<MediaList>> fetchNetworkLists(int userId) async {
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

  /// Updates or deletes an entry in the provided anime lists
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

    const orderedNames = [
      'WATCHING',
      'PLANNING',
      'COMPLETED',
      'REPEATING',
      'PAUSED',
      'DROPPED',
    ];

    MediaListEntryWithMedia? movedEntry;
    String? targetName = result.entry!.status?.displayName;

    final updatedLists = currentLists.map((section) {
      final entries = List<MediaListEntryWithMedia>.from(section.entries);
      final idx = entries.indexWhere((e) => e.media.id == mediaId);

      if (idx == -1) {
        return section;
      }

      final entry = entries[idx];
      final oldStatus = entry.status;
      final newStatus = result.entry!.status;

      if (targetName != null && oldStatus != newStatus) {
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

    if (movedEntry != null && targetName != null) {
      final targetIdx = updatedLists.indexWhere((s) => s.name == targetName);
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
          final pos = orderedNames.indexOf(s.name);
          return pos > orderedNames.indexOf(targetName);
        });
        final newSection = MediaList(
          name: targetName,
          status: MediaListStatus.fromString(
            targetName == 'WATCHING' ? 'current' : targetName.toLowerCase(),
          ),
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
}
