import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:goodanime/models/user_statistics.dart';
import 'package:goodanime/pages/profile/tabs/statistics_tab.dart';
import 'package:goodanime/pages/profile/widgets/episode_distribution_chart.dart';
import 'package:goodanime/pages/profile/widgets/quick_metrics_grid.dart';
import 'package:goodanime/pages/profile/widgets/release_year_chart.dart';
import 'package:goodanime/pages/profile/widgets/score_distribution_chart.dart';
import 'package:goodanime/pages/profile/widgets/status_format_breakdown.dart';

void main() {
  const sampleStats = UserStatistics(
    anime: UserMediaStatistics(
      count: 120,
      meanScore: 82.4,
      standardDeviation: 9.6,
      minutesWatched: 18400,
      episodesWatched: 750,
      scores: [
        UserScoreStat(
          score: 8,
          count: 40,
          meanScore: 80.0,
          minutesWatched: 6000,
          chaptersRead: 0,
        ),
        UserScoreStat(
          score: 9,
          count: 30,
          meanScore: 90.0,
          minutesWatched: 4500,
          chaptersRead: 0,
        ),
        UserScoreStat(
          score: 10,
          count: 15,
          meanScore: 100.0,
          minutesWatched: 2500,
          chaptersRead: 0,
        ),
      ],
      lengths: [
        UserLengthStat(
          length: '12',
          count: 50,
          meanScore: 83.0,
          minutesWatched: 7000,
          chaptersRead: 0,
        ),
        UserLengthStat(
          length: '24',
          count: 25,
          meanScore: 84.0,
          minutesWatched: 6000,
          chaptersRead: 0,
        ),
      ],
      statuses: [
        UserStatusStat(
          status: 'COMPLETED',
          count: 80,
          meanScore: 84.0,
          minutesWatched: 12000,
          chaptersRead: 0,
        ),
        UserStatusStat(
          status: 'CURRENT',
          count: 15,
          meanScore: 81.0,
          minutesWatched: 2000,
          chaptersRead: 0,
        ),
      ],
      formats: [
        UserFormatStat(
          format: 'TV',
          count: 90,
          meanScore: 83.0,
          minutesWatched: 14000,
          chaptersRead: 0,
        ),
        UserFormatStat(
          format: 'MOVIE',
          count: 15,
          meanScore: 85.0,
          minutesWatched: 1800,
          chaptersRead: 0,
        ),
      ],
      releaseYears: [
        UserReleaseYearStat(
          releaseYear: 2021,
          count: 25,
          meanScore: 81.0,
          minutesWatched: 3500,
          chaptersRead: 0,
        ),
        UserReleaseYearStat(
          releaseYear: 2022,
          count: 35,
          meanScore: 84.0,
          minutesWatched: 5000,
          chaptersRead: 0,
        ),
      ],
    ),
    manga: UserMediaStatistics(
      count: 45,
      meanScore: 79.5,
      standardDeviation: 8.2,
      chaptersRead: 850,
      volumesRead: 60,
      scores: [
        UserScoreStat(
          score: 7,
          count: 10,
          meanScore: 70.0,
          minutesWatched: 0,
          chaptersRead: 150,
        ),
        UserScoreStat(
          score: 8,
          count: 25,
          meanScore: 80.0,
          minutesWatched: 0,
          chaptersRead: 400,
        ),
      ],
      lengths: [
        UserLengthStat(
          length: '50',
          count: 20,
          meanScore: 80.0,
          minutesWatched: 0,
          chaptersRead: 300,
        ),
      ],
      statuses: [
        UserStatusStat(
          status: 'COMPLETED',
          count: 30,
          meanScore: 80.0,
          minutesWatched: 0,
          chaptersRead: 500,
        ),
      ],
      formats: [
        UserFormatStat(
          format: 'MANGA',
          count: 40,
          meanScore: 80.0,
          minutesWatched: 0,
          chaptersRead: 750,
        ),
      ],
      releaseYears: [
        UserReleaseYearStat(
          releaseYear: 2020,
          count: 15,
          meanScore: 79.0,
          minutesWatched: 0,
          chaptersRead: 250,
        ),
      ],
    ),
  );

  Widget buildTab({
    int userId = 42,
    UserStatistics? initialStats,
    Future<UserStatistics> Function({required int userId})? fetcher,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: ProfileStatisticsTab(
            userId: userId,
            initialStats: initialStats,
            fetcher: fetcher ?? ({required userId}) async => sampleStats,
          ),
        ),
      ),
    );
  }

  testWidgets('renders media selector with anime and manga pills', (
    tester,
  ) async {
    await tester.pumpWidget(buildTab(initialStats: sampleStats));
    await tester.pumpAndSettle();

    expect(find.text('Anime'), findsOneWidget);
    expect(find.text('Manga'), findsOneWidget);
  });

  testWidgets('renders quick metrics grid cards for anime (THE-175)', (
    tester,
  ) async {
    await tester.pumpWidget(buildTab(initialStats: sampleStats));
    await tester.pumpAndSettle();

    expect(find.byType(QuickMetricsGrid), findsOneWidget);
    expect(find.text('Total Anime'), findsOneWidget);
    expect(find.text('120'), findsOneWidget);
    expect(find.text('Episodes Watched'), findsOneWidget);
    expect(find.text('750'), findsOneWidget);
    expect(find.text('Mean Score'), findsOneWidget);
    expect(find.text('8.2'), findsOneWidget);
    expect(find.text('Standard Dev'), findsOneWidget);
    expect(find.text('9.6'), findsOneWidget);
  });

  testWidgets('switches to manga and updates metrics cards', (tester) async {
    await tester.pumpWidget(buildTab(initialStats: sampleStats));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Manga'));
    await tester.pumpAndSettle();

    expect(find.text('Total Manga'), findsOneWidget);
    expect(find.text('45'), findsOneWidget);
    expect(find.text('Chapters Read'), findsOneWidget);
    expect(find.text('850'), findsOneWidget);
    expect(find.text('Volumes Read'), findsOneWidget);
    expect(find.text('60'), findsOneWidget);
    expect(find.text('8.0'), findsOneWidget);
    expect(find.text('8.2'), findsOneWidget);
  });

  testWidgets(
    'renders score distribution chart and toggles metrics (THE-176)',
    (tester) async {
      await tester.pumpWidget(buildTab(initialStats: sampleStats));
      await tester.pumpAndSettle();

      expect(find.byType(ScoreDistributionChart), findsOneWidget);
      expect(find.text('Score Distribution'), findsOneWidget);

      final hoursToggle = find.descendant(
        of: find.byType(ScoreDistributionChart),
        matching: find.text('Hours'),
      );
      expect(hoursToggle, findsOneWidget);
      await tester.tap(hoursToggle);
      await tester.pumpAndSettle();
    },
  );

  testWidgets(
    'renders episode distribution chart and toggles metrics (THE-177)',
    (tester) async {
      await tester.pumpWidget(buildTab(initialStats: sampleStats));
      await tester.pumpAndSettle();

      expect(find.byType(EpisodeDistributionChart), findsOneWidget);
      expect(find.text('Episode Count Distribution'), findsOneWidget);

      final scoreToggle = find.descendant(
        of: find.byType(EpisodeDistributionChart),
        matching: find.text('Score'),
      );
      expect(scoreToggle, findsOneWidget);
      await tester.tap(scoreToggle);
      await tester.pumpAndSettle();
    },
  );

  testWidgets(
    'renders status and format breakdown segmented bars and legends (THE-178)',
    (tester) async {
      await tester.pumpWidget(buildTab(initialStats: sampleStats));
      await tester.pumpAndSettle();

      expect(find.byType(StatusFormatBreakdown), findsOneWidget);
      expect(find.text('Status Distribution'), findsOneWidget);
      expect(find.text('Format Distribution'), findsOneWidget);
      expect(find.text('Completed'), findsOneWidget);
      expect(find.text('Watching'), findsOneWidget);
      expect(find.text('TV'), findsOneWidget);
      expect(find.text('Movie'), findsOneWidget);
    },
  );

  testWidgets(
    'renders release year chart and chronologically ordered years (THE-179)',
    (tester) async {
      await tester.pumpWidget(buildTab(initialStats: sampleStats));
      await tester.pumpAndSettle();

      expect(find.byType(ReleaseYearChart), findsOneWidget);
      expect(find.text('Release Year Distribution'), findsOneWidget);
      expect(find.text('2021'), findsOneWidget);
      expect(find.text('2022'), findsOneWidget);
    },
  );

  testWidgets('renders empty state when statistics count is zero', (
    tester,
  ) async {
    const emptyStats = UserStatistics();

    await tester.pumpWidget(buildTab(initialStats: emptyStats));
    await tester.pumpAndSettle();

    expect(find.text('No Anime statistics found'), findsOneWidget);
  });

  testWidgets('hides missing graph sections when their data is empty', (
    tester,
  ) async {
    const partialStats = UserStatistics(
      anime: UserMediaStatistics(
        count: 10,
        episodesWatched: 50,
        minutesWatched: 1200,
        statuses: [
          UserStatusStat(
            status: 'COMPLETED',
            count: 10,
            meanScore: 0.0,
            minutesWatched: 1200,
            chaptersRead: 0,
          ),
        ],
      ),
    );

    await tester.pumpWidget(buildTab(initialStats: partialStats));
    await tester.pumpAndSettle();

    expect(find.text('Total Anime'), findsOneWidget);
    expect(find.text('Score Distribution'), findsNothing);
    expect(find.text('Episode Count Distribution'), findsNothing);
    expect(find.text('Format Distribution'), findsNothing);
    expect(find.text('Release Year Distribution'), findsNothing);
    expect(find.text('Status Distribution'), findsOneWidget);
  });

  testWidgets('renders error view and retries on tap', (tester) async {
    var callCount = 0;
    Future<UserStatistics> failingFetcher({required int userId}) async {
      callCount++;
      if (callCount == 1) {
        throw Exception('Network error');
      }
      return sampleStats;
    }

    await tester.pumpWidget(buildTab(fetcher: failingFetcher));
    await tester.pumpAndSettle();

    expect(find.text('Failed to load statistics.'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);

    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();

    expect(find.text('Total Anime'), findsOneWidget);
    expect(callCount, 2);
  });
}
