import 'package:flutter_test/flutter_test.dart';
import 'package:goodanime/models/user_statistics.dart';
import 'package:goodanime/proto/user.pb.dart' as pb;

void main() {
  group('UserStatistics models and proto mapping', () {
    test('converts from protobuf correctly', () {
      final pbStats = pb.UserStatistics(
        anime: pb.UserMediaStatistics(
          count: 50,
          meanScore: 78.4,
          standardDeviation: 10.2,
          minutesWatched: 14400,
          episodesWatched: 600,
          scores: [
            pb.UserScoreStat(
              score: 8,
              count: 20,
              meanScore: 80.0,
              minutesWatched: 4800,
            ),
          ],
          lengths: [
            pb.UserLengthStat(
              length: '12',
              count: 25,
              meanScore: 79.0,
              minutesWatched: 6000,
            ),
          ],
          statuses: [
            pb.UserStatusStat(status: 'COMPLETED', count: 40, meanScore: 80.0),
          ],
          formats: [
            pb.UserFormatStat(format: 'TV', count: 35, meanScore: 79.5),
          ],
          releaseYears: [
            pb.UserReleaseYearStat(
              releaseYear: 2022,
              count: 15,
              meanScore: 81.0,
            ),
          ],
        ),
        manga: pb.UserMediaStatistics(
          count: 10,
          meanScore: 82.0,
          chaptersRead: 500,
          volumesRead: 40,
        ),
      );

      final domain = UserStatistics.fromProto(pbStats);
      expect(domain.anime.count, 50);
      expect(domain.anime.meanScore, 78.4);
      expect(domain.anime.standardDeviation, 10.2);
      expect(domain.anime.minutesWatched, 14400);
      expect(domain.anime.episodesWatched, 600);
      expect(domain.anime.scores.length, 1);
      expect(domain.anime.scores.first.score, 8);
      expect(domain.anime.scores.first.count, 20);
      expect(domain.anime.lengths.first.length, '12');
      expect(domain.anime.statuses.first.status, 'COMPLETED');
      expect(domain.anime.formats.first.format, 'TV');
      expect(domain.anime.releaseYears.first.releaseYear, 2022);

      expect(domain.manga.count, 10);
      expect(domain.manga.chaptersRead, 500);
      expect(domain.manga.volumesRead, 40);
    });

    test('handles null proto gracefully', () {
      final domain = UserStatistics.fromProto(null);
      expect(domain.anime.count, 0);
      expect(domain.manga.count, 0);
      expect(domain.anime.scores, isEmpty);
    });
  });

  group('StatisticsMathUtils', () {
    test('computeMeanScore computes weighted mean correctly', () {
      final scores = [
        const UserScoreStat(
          score: 8,
          count: 2,
          meanScore: 8.0,
          minutesWatched: 0,
          chaptersRead: 0,
        ),
        const UserScoreStat(
          score: 10,
          count: 2,
          meanScore: 10.0,
          minutesWatched: 0,
          chaptersRead: 0,
        ),
      ];

      final mean = StatisticsMathUtils.computeMeanScore(scores);
      expect(mean, 9.0);
    });

    test('computeMeanScore excludes zero-score entries', () {
      final scores = [
        const UserScoreStat(
          score: 0,
          count: 100,
          meanScore: 0.0,
          minutesWatched: 0,
          chaptersRead: 0,
        ),
        const UserScoreStat(
          score: 7,
          count: 3,
          meanScore: 7.0,
          minutesWatched: 0,
          chaptersRead: 0,
        ),
        const UserScoreStat(
          score: 9,
          count: 1,
          meanScore: 9.0,
          minutesWatched: 0,
          chaptersRead: 0,
        ),
      ];

      final mean = StatisticsMathUtils.computeMeanScore(scores);
      expect(mean, 7.5);
    });

    test('computeMeanScore returns 0 when no valid rated entries exist', () {
      expect(StatisticsMathUtils.computeMeanScore([]), 0.0);
      final onlyZeroes = [
        const UserScoreStat(
          score: 0,
          count: 10,
          meanScore: 0.0,
          minutesWatched: 0,
          chaptersRead: 0,
        ),
      ];
      expect(StatisticsMathUtils.computeMeanScore(onlyZeroes), 0.0);
    });

    test('computeStandardDeviation calculates population std dev', () {
      final scores = [
        const UserScoreStat(
          score: 6,
          count: 1,
          meanScore: 6.0,
          minutesWatched: 0,
          chaptersRead: 0,
        ),
        const UserScoreStat(
          score: 8,
          count: 2,
          meanScore: 8.0,
          minutesWatched: 0,
          chaptersRead: 0,
        ),
        const UserScoreStat(
          score: 10,
          count: 1,
          meanScore: 10.0,
          minutesWatched: 0,
          chaptersRead: 0,
        ),
      ];

      final stdDev = StatisticsMathUtils.computeStandardDeviation(scores);
      expect((stdDev - 1.4142).abs() < 0.001, isTrue);
    });

    test(
      'computeStandardDeviation returns 0 for empty or zero-score lists',
      () {
        expect(StatisticsMathUtils.computeStandardDeviation([]), 0.0);
        final onlyZero = [
          const UserScoreStat(
            score: 0,
            count: 5,
            meanScore: 0.0,
            minutesWatched: 0,
            chaptersRead: 0,
          ),
        ];
        expect(StatisticsMathUtils.computeStandardDeviation(onlyZero), 0.0);
      },
    );

    test('minutesToDays, formatDays, and formatHours format correctly', () {
      expect(StatisticsMathUtils.minutesToDays(1440), 1.0);
      expect(StatisticsMathUtils.formatDays(2160), '1.5');
      expect(StatisticsMathUtils.formatHours(150), '2.5');
    });

    test('computeScoreHistogram pads 1-10 buckets and excludes zero score', () {
      final rawScores = [
        const UserScoreStat(
          score: 0,
          count: 12,
          meanScore: 0.0,
          minutesWatched: 0,
          chaptersRead: 0,
        ),
        const UserScoreStat(
          score: 5,
          count: 4,
          meanScore: 5.0,
          minutesWatched: 0,
          chaptersRead: 0,
        ),
        const UserScoreStat(
          score: 8,
          count: 9,
          meanScore: 8.0,
          minutesWatched: 0,
          chaptersRead: 0,
        ),
      ];

      final histogram = StatisticsMathUtils.computeScoreHistogram(rawScores);
      expect(histogram.length, 10);
      for (var i = 0; i < 10; i++) {
        expect(histogram[i].score, i + 1);
      }
      expect(histogram[0].count, 0);
      expect(histogram[4].count, 4);
      expect(histogram[7].count, 9);
      expect(histogram[9].count, 0);
    });

    test(
      'sortChronologicalYears sorts ascending and filters invalid years',
      () {
        final rawYears = [
          const UserReleaseYearStat(
            releaseYear: 2024,
            count: 10,
            meanScore: 80.0,
            minutesWatched: 0,
            chaptersRead: 0,
          ),
          const UserReleaseYearStat(
            releaseYear: 0,
            count: 2,
            meanScore: 0.0,
            minutesWatched: 0,
            chaptersRead: 0,
          ),
          const UserReleaseYearStat(
            releaseYear: 2018,
            count: 5,
            meanScore: 75.0,
            minutesWatched: 0,
            chaptersRead: 0,
          ),
          const UserReleaseYearStat(
            releaseYear: 2021,
            count: 8,
            meanScore: 78.0,
            minutesWatched: 0,
            chaptersRead: 0,
          ),
        ];

        final sorted = StatisticsMathUtils.sortChronologicalYears(rawYears);
        expect(sorted.length, 3);
        expect(sorted[0].releaseYear, 2018);
        expect(sorted[1].releaseYear, 2021);
        expect(sorted[2].releaseYear, 2024);
      },
    );

    test('calculatePercentage handles normal and edge cases', () {
      expect(StatisticsMathUtils.calculatePercentage(25, 100), 25.0);
      expect(StatisticsMathUtils.calculatePercentage(5, 0), 0.0);
      expect(StatisticsMathUtils.calculatePercentage(5, -10), 0.0);
    });
  });
}
