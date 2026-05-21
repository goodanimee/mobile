import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/user_api.dart';
import '../api/media_list_api.dart';
import 'auth_service.dart';

class AnimeListRepo {
  static const String _cacheKeyLists = 'cached_anime_lists';
  static const String _cacheKeyViewer = 'cached_viewer';

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

  static Future<List<dynamic>?> getCachedLists() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedJson = prefs.getString(_cacheKeyLists);
    if (cachedJson != null) {
      try {
        return jsonDecode(cachedJson) as List<dynamic>;
      } catch (_) {}
    }

    return null;
  }

  static Future<List<dynamic>> fetchNetworkLists(int userId) async {
    final token = await AuthService.getRawToken() ?? '';
    final response = await MediaListApi.fetchMediaList(userId, token);
    final rawLists = response.collection.lists;

    final allEntries = [];
    for (final list in rawLists) {
      for (final entry in list.entries) {
        final media = entry.media;
        final entryMap = <String, dynamic>{
          'status': entry.status,
          'progress': entry.progress,
          'repeat': entry.repeat,
          'score': entry.score,
          'id': entry.id,
          'media': {
            'id': media.id,
            'title': {
              'userPreferred': media.title.userPreferred,
              'english': media.title.english,
              'native': media.title.native,
              'romaji': media.title.romaji,
            },
            'averageScore': media.averageScore,
            'bannerImage': media.bannerImage.isNotEmpty
                ? media.bannerImage
                : null,
            'coverImage': {
              'medium': media.coverImage.medium,
              'large': media.coverImage.large,
              'extraLarge': media.coverImage.extraLarge,
              'color': media.coverImage.color.isNotEmpty
                  ? media.coverImage.color
                  : null,
            },
            'description': media.description,
            'duration': media.duration,
            'episodes': media.episodes,
            'format': media.format,
            'genres': media.genres,
            'isAdult': media.isAdult,
            'isFavourite': media.isFavourite,
            'popularity': media.popularity,
            'season': media.season,
            'seasonYear': media.seasonYear,
            'status': media.status,
          },
        };

        if (entry.hasStartedAt()) {
          entryMap['startedAt'] = {
            'year': entry.startedAt.year,
            'month': entry.startedAt.month,
            'day': entry.startedAt.day,
          };
        }

        if (entry.hasCompletedAt()) {
          entryMap['completedAt'] = {
            'year': entry.completedAt.year,
            'month': entry.completedAt.month,
            'day': entry.completedAt.day,
          };
        }

        allEntries.add(entryMap);
      }
    }

    final Map<String, List<dynamic>> grouped = {
      'CURRENT': [],
      'REPEATING': [],
      'PLANNING': [],
      'COMPLETED': [],
      'PAUSED': [],
      'DROPPED': [],
    };

    for (final entry in allEntries) {
      final status = entry['status'] as String? ?? 'UNKNOWN';
      grouped[status] ??= [];
      grouped[status]!.add(entry);
    }

    final orderedStatuses = [
      'CURRENT',
      'PLANNING',
      'COMPLETED',
      'REPEATING',
      'PAUSED',
      'DROPPED',
    ];

    final processedLists = <Map<String, dynamic>>[];

    for (final status in orderedStatuses) {
      final name = status == 'CURRENT' ? 'WATCHING' : status;
      processedLists.add({'name': name, 'entries': grouped[status] ?? []});
    }

    for (final status in grouped.keys) {
      if (!orderedStatuses.contains(status) && grouped[status]!.isNotEmpty) {
        final name = status == 'CURRENT' ? 'WATCHING' : status;
        processedLists.add({'name': name, 'entries': grouped[status]});
      }
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_cacheKeyLists, jsonEncode(processedLists));
    return processedLists;
  }

  static Future<List<dynamic>> updateEntryInLists(
    List<dynamic> currentLists,
    int mediaId,
    Map<String, dynamic> updates,
  ) async {
    if (updates['deleted'] == true) {
      final updatedLists = currentLists.map((s) {
        final section = Map<String, dynamic>.from(s as Map<String, dynamic>);
        final entries = (section['entries'] as List<dynamic>)
            .map((e) => Map<String, dynamic>.from(e as Map<String, dynamic>))
            .toList();

        entries.removeWhere(
          (e) => (e['media'] as Map<String, dynamic>?)?['id'] == mediaId,
        );

        section['entries'] = entries;
        return section;
      }).toList();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_cacheKeyLists, jsonEncode(updatedLists));
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
      final st = updates['status'] as String;
      targetName = st == 'CURRENT' ? 'WATCHING' : st;
    }

    Map<String, dynamic>? movedEntry;

    final updatedLists = currentLists.map((s) {
      final section = Map<String, dynamic>.from(s as Map<String, dynamic>);
      final entries = (section['entries'] as List<dynamic>)
          .map((e) => Map<String, dynamic>.from(e as Map<String, dynamic>))
          .toList();

      final idx = entries.indexWhere(
        (e) => (e['media'] as Map<String, dynamic>?)?['id'] == mediaId,
      );

      if (idx == -1) {
        section['entries'] = entries;
        return section;
      }

      final entry = entries[idx];
      final oldStatus = entry['status'] as String?;

      updates.forEach((key, value) {
        entry[key] = value;
      });

      final newStatus = entry['status'] as String?;

      if (targetName != null && oldStatus != newStatus) {
        movedEntry = Map<String, dynamic>.from(entry);
        entries.removeAt(idx);
      }

      section['entries'] = entries;
      return section;
    }).toList();

    if (movedEntry != null && targetName != null) {
      final targetIdx = updatedLists.indexWhere((s) => s['name'] == targetName);
      if (targetIdx != -1) {
        (updatedLists[targetIdx]['entries'] as List).add(movedEntry);
      } else {
        final insertAt = updatedLists.indexWhere((s) {
          final pos = orderedNames.indexOf(s['name'] as String);
          return pos > orderedNames.indexOf(targetName!);
        });
        final newSection = {
          'name': targetName,
          'entries': <dynamic>[movedEntry],
        };
        if (insertAt == -1) {
          updatedLists.add(newSection);
        } else {
          updatedLists.insert(insertAt, newSection);
        }
      }
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_cacheKeyLists, jsonEncode(updatedLists));

    return updatedLists;
  }
}
