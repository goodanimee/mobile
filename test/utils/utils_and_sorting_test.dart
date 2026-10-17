import 'package:flutter/material.dart' hide Title;
import 'package:flutter_test/flutter_test.dart';
import 'package:goodanime/models/common.dart';
import 'package:goodanime/models/media_list.dart';
import 'package:goodanime/models/media_min.dart';
import 'package:goodanime/utils/utils.dart';

MediaListEntryWithMedia _createSortEntry({
  required int id,
  String title = 'Anime',
  double score = 0,
  int averageScore = 0,
  int progress = 0,
  int? startYear = 2024,
  FuzzyDate? startedAt,
  FuzzyDate? completedAt,
}) {
  return MediaListEntryWithMedia(
    id: id,
    status: MediaListStatus.current,
    progress: progress,
    score: score,
    repeat: 0,
    progressVolumes: 0,
    startedAt: startedAt,
    completedAt: completedAt,
    media: MediaMin(
      id: id,
      type: 'ANIME',
      title: Title(
        english: title,
        native: title,
        romaji: title,
        userPreferred: title,
      ),
      averageScore: averageScore,
      coverImage: const CoverImage(
        medium: '',
        large: '',
        extraLarge: '',
        color: '#FFFFFF',
      ),
      episodes: 12,
      chapters: 0,
      volumes: 0,
      format: 'TV',
      isAdult: false,
      isFavourite: false,
      siteUrl: 'https://anilist.co/anime/$id',
      startYear: startYear,
    ),
  );
}

/// Unit tests for [MediaListSortUtils], [StringUtils], and [ColorUtils].
void main() {
  group('MediaListSortUtils.sortEntries', () {
    test(
      'sorts entries by title case-insensitively in ascending and descending order',
      () {
        final entries = [
          _createSortEntry(id: 1, title: 'Vinland Saga'),
          _createSortEntry(id: 2, title: 'attack on titan'),
          _createSortEntry(id: 3, title: 'Mob Psycho 100'),
        ];

        MediaListSortUtils.sortEntries(
          entries,
          sortType: 'title',
          isAscending: true,
        );
        expect(entries.map((e) => e.id).toList(), [2, 3, 1]);

        MediaListSortUtils.sortEntries(
          entries,
          sortType: 'title',
          isAscending: false,
        );
        expect(entries.map((e) => e.id).toList(), [1, 3, 2]);
      },
    );

    test(
      'sorts scored entries first and falls back to community averageScore when unscored',
      () {
        final entries = [
          _createSortEntry(id: 1, averageScore: 70),
          _createSortEntry(id: 2, score: 8.5, averageScore: 60),
          _createSortEntry(id: 3, averageScore: 90),
          _createSortEntry(id: 4, score: 9.5, averageScore: 50),
        ];

        MediaListSortUtils.sortEntries(
          entries,
          sortType: 'score',
          isAscending: false,
        );
        expect(entries.map((e) => e.id).toList(), [4, 2, 3, 1]);

        MediaListSortUtils.sortEntries(
          entries,
          sortType: 'score',
          isAscending: true,
        );
        expect(entries.map((e) => e.id).toList(), [2, 4, 1, 3]);
      },
    );

    test(
      'sorts by progress and release_date while keeping missing release years at the end',
      () {
        final entries = [
          _createSortEntry(id: 1, progress: 5, startYear: null),
          _createSortEntry(id: 2, progress: 12, startYear: 2020),
          _createSortEntry(id: 3, progress: 1, startYear: 2023),
        ];

        MediaListSortUtils.sortEntries(
          entries,
          sortType: 'progress',
          isAscending: false,
        );
        expect(entries.map((e) => e.id).toList(), [2, 1, 3]);

        MediaListSortUtils.sortEntries(
          entries,
          sortType: 'release_date',
          isAscending: false,
        );
        expect(entries.map((e) => e.id).toList(), [3, 2, 1]);

        MediaListSortUtils.sortEntries(
          entries,
          sortType: 'release_date',
          isAscending: true,
        );
        expect(entries.map((e) => e.id).toList(), [2, 3, 1]);
      },
    );

    test(
      'sorts by started_date and completed_date using fuzzy date comparison',
      () {
        final entries = [
          _createSortEntry(id: 1),
          _createSortEntry(
            id: 2,
            startedAt: const FuzzyDate(year: 2023, month: 4, day: 10),
          ),
          _createSortEntry(
            id: 3,
            startedAt: const FuzzyDate(year: 2023, month: 10, day: 2),
          ),
        ];

        MediaListSortUtils.sortEntries(
          entries,
          sortType: 'started_date',
          isAscending: false,
        );
        expect(entries.map((e) => e.id).toList(), [3, 2, 1]);
      },
    );
  });

  group('MediaListSortUtils.compareFuzzyDates', () {
    test(
      'compares year, month, and day hierarchy and sorts null/zero components last',
      () {
        const d2022 = FuzzyDate(year: 2022, month: 5, day: 1);
        const d2023May1 = FuzzyDate(year: 2023, month: 5, day: 1);
        const d2023May15 = FuzzyDate(year: 2023, month: 5, day: 15);
        const d2023NoMonth = FuzzyDate(year: 2023);

        expect(
          MediaListSortUtils.compareFuzzyDates(
            d2022,
            d2023May1,
            ascending: true,
          ),
          lessThan(0),
        );
        expect(
          MediaListSortUtils.compareFuzzyDates(
            d2023May1,
            d2023May15,
            ascending: false,
          ),
          greaterThan(0),
        );
        expect(
          MediaListSortUtils.compareFuzzyDates(
            d2023May1,
            d2023NoMonth,
            ascending: true,
          ),
          lessThan(0),
        );
        expect(
          MediaListSortUtils.compareFuzzyDates(null, d2022, ascending: true),
          greaterThan(0),
        );
        expect(
          MediaListSortUtils.compareFuzzyDates(null, null, ascending: true),
          0,
        );
      },
    );
  });

  group('StringUtils & ColorUtils', () {
    test(
      'StringUtils formats language abbreviations, capitalization, durations, and plurals',
      () {
        expect(StringUtils.getLanguageAbbreviation('Japanese'), 'JP');
        expect(StringUtils.getLanguageAbbreviation('English'), 'EN');
        expect(StringUtils.getLanguageAbbreviation(null), 'Link');
        expect(StringUtils.capitalize('SLICE OF LIFE'), 'Slice Of Life');
        expect(StringUtils.formatAiringDuration(3600 * 48), '2 days');
        expect(StringUtils.formatAiringDuration(3600 * 5), '5 hours');
        expect(StringUtils.formatAiringDuration(1200), 'an hour');
        expect(StringUtils.pluralize(1, 'Episode', 'Episodes'), 'Episode');
        expect(StringUtils.pluralize(12, 'Episode', 'Episodes'), 'Episodes');
      },
    );

    test(
      'ColorUtils.fromHex parses 6-digit and 8-digit hex strings and falls back on invalid input',
      () {
        expect(ColorUtils.fromHex('#3B82F6'), const Color(0xFF3B82F6));
        expect(ColorUtils.fromHex('803B82F6'), const Color(0x803B82F6));
        expect(
          ColorUtils.fromHex('invalid', fallback: Colors.transparent),
          Colors.transparent,
        );
        expect(ColorUtils.fromHex(null, fallback: Colors.black), Colors.black);
      },
    );
  });
}
