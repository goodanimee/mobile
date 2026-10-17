import 'package:flutter_test/flutter_test.dart';
import 'package:goodanime/models/common.dart';
import 'package:goodanime/models/media_list.dart';
import 'package:goodanime/models/media_min.dart';
import 'package:goodanime/services/media_list_service.dart';
import 'package:goodanime/utils/app_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

MediaMin _createMedia(int id, {String type = 'ANIME'}) {
  return MediaMin(
    id: id,
    type: type,
    title: Title(
      english: 'Media $id',
      native: 'Media $id',
      romaji: 'Media $id',
      userPreferred: 'Media $id',
    ),
    averageScore: 75,
    coverImage: const CoverImage(
      medium: '',
      large: '',
      extraLarge: '',
      color: '#000000',
    ),
    episodes: 12,
    chapters: 0,
    volumes: 0,
    format: 'TV',
    isAdult: false,
    isFavourite: false,
    siteUrl: 'https://anilist.co/anime/$id',
  );
}

MediaListEntryWithMedia _createEntry({
  required int id,
  required int mediaId,
  required MediaListStatus status,
  int progress = 0,
}) {
  return MediaListEntryWithMedia(
    id: id,
    status: status,
    progress: progress,
    score: 8.0,
    repeat: 0,
    progressVolumes: 0,
    media: _createMedia(mediaId),
  );
}

/// Unit tests for [MediaListService.updateEntryInLists].
void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('MediaListService.updateEntryInLists', () {
    test(
      'updates entry in-place when status section does not change',
      () async {
        final entry1 = _createEntry(
          id: 1,
          mediaId: 10,
          status: MediaListStatus.current,
          progress: 3,
        );
        final entry2 = _createEntry(
          id: 2,
          mediaId: 20,
          status: MediaListStatus.current,
          progress: 5,
        );
        final initialLists = [
          MediaList(
            name: 'WATCHING',
            status: MediaListStatus.current,
            entries: [entry1, entry2],
          ),
        ];

        final updatedEntry1 = entry1.copyWith(progress: 4);
        final result = await MediaListService.updateEntryInLists(
          initialLists,
          10,
          MediaOptionsResult(entry: updatedEntry1),
          'ANIME',
        );

        expect(result.length, 1);
        expect(result.first.entries.length, 2);
        expect(result.first.entries.first.progress, 4);
        expect(result.first.entries.last.media.id, 20);
      },
    );

    test('migrates entry between existing status sections', () async {
      final entry = _createEntry(
        id: 1,
        mediaId: 10,
        status: MediaListStatus.planning,
      );
      final initialLists = [
        const MediaList(
          name: 'WATCHING',
          status: MediaListStatus.current,
          entries: [],
        ),
        MediaList(
          name: 'PLANNING',
          status: MediaListStatus.planning,
          entries: [entry],
        ),
      ];

      final moved = entry.copyWith(
        status: MediaListStatus.current,
        progress: 1,
      );
      final result = await MediaListService.updateEntryInLists(
        initialLists,
        10,
        MediaOptionsResult(entry: moved),
        'ANIME',
      );

      final currentSection = result.firstWhere(
        (s) => s.status == MediaListStatus.current,
      );
      final planningSection = result.firstWhere(
        (s) => s.status == MediaListStatus.planning,
      );

      expect(currentSection.entries.map((e) => e.media.id), [10]);
      expect(planningSection.entries, isEmpty);
    });

    test('creates missing target section in canonical status order', () async {
      final planningEntry = _createEntry(
        id: 1,
        mediaId: 10,
        status: MediaListStatus.planning,
      );
      final droppedEntry = _createEntry(
        id: 2,
        mediaId: 20,
        status: MediaListStatus.dropped,
      );
      final initialLists = [
        MediaList(
          name: 'PLANNING',
          status: MediaListStatus.planning,
          entries: [planningEntry],
        ),
        MediaList(
          name: 'DROPPED',
          status: MediaListStatus.dropped,
          entries: [droppedEntry],
        ),
      ];

      final completedEntry = planningEntry.copyWith(
        status: MediaListStatus.completed,
        progress: 12,
      );
      final result = await MediaListService.updateEntryInLists(
        initialLists,
        10,
        MediaOptionsResult(entry: completedEntry),
        'ANIME',
      );

      expect(result.map((s) => s.status).toList(), [
        MediaListStatus.planning,
        MediaListStatus.completed,
        MediaListStatus.dropped,
      ]);
      expect(result[1].name, 'COMPLETED');
      expect(result[1].entries.single.media.id, 10);
    });

    test('maps repeating status into the current status section', () async {
      final completedEntry = _createEntry(
        id: 1,
        mediaId: 10,
        status: MediaListStatus.completed,
        progress: 12,
      );
      final initialLists = [
        const MediaList(
          name: 'WATCHING',
          status: MediaListStatus.current,
          entries: [],
        ),
        MediaList(
          name: 'COMPLETED',
          status: MediaListStatus.completed,
          entries: [completedEntry],
        ),
      ];

      final repeatingEntry = completedEntry.copyWith(
        status: MediaListStatus.repeating,
        progress: 1,
        repeat: 1,
      );
      final result = await MediaListService.updateEntryInLists(
        initialLists,
        10,
        MediaOptionsResult(entry: repeatingEntry),
        'ANIME',
      );

      final currentSection = result.firstWhere(
        (s) => s.status == MediaListStatus.current,
      );
      final completedSection = result.firstWhere(
        (s) => s.status == MediaListStatus.completed,
      );

      expect(currentSection.entries.length, 1);
      expect(currentSection.entries.single.status, MediaListStatus.repeating);
      expect(completedSection.entries, isEmpty);
    });

    test(
      'keeps repeating entry in current section when transitioning current -> repeating',
      () async {
        final currentEntry = _createEntry(
          id: 1,
          mediaId: 10,
          status: MediaListStatus.current,
          progress: 5,
        );
        final initialLists = [
          MediaList(
            name: 'WATCHING',
            status: MediaListStatus.current,
            entries: [currentEntry],
          ),
        ];

        final repeatingEntry = currentEntry.copyWith(
          status: MediaListStatus.repeating,
          progress: 1,
          repeat: 1,
        );
        final result = await MediaListService.updateEntryInLists(
          initialLists,
          10,
          MediaOptionsResult(entry: repeatingEntry),
          'ANIME',
        );

        expect(result.length, 1);
        expect(result.single.entries.length, 1);
        expect(result.single.entries.single.status, MediaListStatus.repeating);
      },
    );

    test('removes entry from its section when deleted is true', () async {
      final entry1 = _createEntry(
        id: 1,
        mediaId: 10,
        status: MediaListStatus.current,
      );
      final entry2 = _createEntry(
        id: 2,
        mediaId: 20,
        status: MediaListStatus.current,
      );
      final initialLists = [
        MediaList(
          name: 'WATCHING',
          status: MediaListStatus.current,
          entries: [entry1, entry2],
        ),
      ];

      final result = await MediaListService.updateEntryInLists(
        initialLists,
        10,
        const MediaOptionsResult(deleted: true),
        'ANIME',
      );

      expect(result.single.entries.map((e) => e.media.id), [20]);
    });
  });
}
