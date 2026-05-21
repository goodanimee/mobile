import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/user_api.dart';
import '../api/media_list_api.dart';
import '../models/common.dart';
import '../models/media_list.dart';
import 'auth_service.dart';

/// Repository for managing user anime list data and caches
class AnimeListRepo {
  static const String _cacheKeyLists = 'cached_anime_lists';
  static const String _cacheKeyViewer = 'cached_viewer';

  /// Retrieves the cached or remote user ID
  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedJson = prefs.getString(_cacheKeyViewer);

    if (cachedJson != null) {
      try {
        final data = jsonDecode(cachedJson);
        return data['id'] as int?;
      } catch (_) {}
    }

    try {
      final token = await AuthService.getRawToken() ?? '';
      final viewer = await UserApi.fetchViewer(token);

      final viewerMap = {
        'id': viewer.id,
        'name': viewer.name,
        'createdAt': viewer.createdAt,
        'avatar': {'medium': viewer.avatarMedium},
      };

      await prefs.setString(_cacheKeyViewer, jsonEncode(viewerMap));
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
            .map((l) => MediaList.fromJson(Map<String, dynamic>.from(l as Map)))
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
      MediaListStatus.CURRENT: [],
      MediaListStatus.REPEATING: [],
      MediaListStatus.PLANNING: [],
      MediaListStatus.COMPLETED: [],
      MediaListStatus.PAUSED: [],
      MediaListStatus.DROPPED: [],
    };

    for (final entry in allEntries) {
      final status = entry.status ?? MediaListStatus.CURRENT;
      grouped[status] ??= [];
      grouped[status]!.add(entry);
    }

    final orderedStatuses = [
      MediaListStatus.CURRENT,
      MediaListStatus.PLANNING,
      MediaListStatus.COMPLETED,
      MediaListStatus.REPEATING,
      MediaListStatus.PAUSED,
      MediaListStatus.DROPPED,
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
      jsonEncode(processedLists.map((l) => l.toJson()).toList()),
    );
    return processedLists;
  }

  /// Updates or deletes an entry in the provided anime lists
  static Future<List<MediaList>> updateEntryInLists(
    List<MediaList> currentLists,
    int mediaId,
    Map<String, dynamic> updates,
  ) async {
    if (updates['deleted'] == true) {
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
        jsonEncode(updatedLists.map((l) => l.toJson()).toList()),
      );
      return updatedLists;
    }

    const orderedNames = [
      'WATCHING',
      'PLANNING',
      'COMPLETED',
      'REPEATING',
      'PAUSED',
      'DROPPED',
    ];
    String? targetName;

    if (updates.containsKey('status')) {
      final st = MediaListStatus.fromJson(updates['status'] as String?);
      if (st != null) {
        targetName = st.displayName;
      }
    }

    MediaListEntryWithMedia? movedEntry;

    final updatedLists = currentLists.map((section) {
      final entries = List<MediaListEntryWithMedia>.from(section.entries);
      final idx = entries.indexWhere((e) => e.media.id == mediaId);

      if (idx == -1) {
        return section;
      }

      final entry = entries[idx];
      final oldStatus = entry.status?.name;

      final updatedEntry = entry.copyWith(
        status: updates.containsKey('status')
            ? MediaListStatus.fromJson(updates['status']?.toString())
            : entry.status,
        progress: updates.containsKey('progress')
            ? updates['progress'] as int?
            : entry.progress,
        score: updates.containsKey('score')
            ? (updates['score'] as num?)?.toDouble()
            : entry.score,
        repeat: updates.containsKey('repeat')
            ? updates['repeat'] as int?
            : entry.repeat,
        startedAt: updates.containsKey('startedAt')
            ? (updates['startedAt'] != null
                  ? FuzzyDate.fromJson(
                      Map<String, dynamic>.from(updates['startedAt'] as Map),
                    )
                  : null)
            : entry.startedAt,
        completedAt: updates.containsKey('completedAt')
            ? (updates['completedAt'] != null
                  ? FuzzyDate.fromJson(
                      Map<String, dynamic>.from(updates['completedAt'] as Map),
                    )
                  : null)
            : entry.completedAt,
      );

      final newStatus = updatedEntry.status?.name;

      if (targetName != null && oldStatus != newStatus) {
        movedEntry = updatedEntry;
        entries.removeAt(idx);
      } else {
        entries[idx] = updatedEntry;
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
          return pos > orderedNames.indexOf(targetName!);
        });
        final newSection = MediaList(
          name: targetName,
          status: MediaListStatus.fromJson(
            targetName == 'WATCHING' ? 'CURRENT' : targetName,
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
      jsonEncode(updatedLists.map((l) => l.toJson()).toList()),
    );

    return updatedLists;
  }
}
