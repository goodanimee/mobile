import 'package:flutter/material.dart' hide Title;
import 'package:flutter_test/flutter_test.dart';
import 'package:goodanime/models/common.dart';
import 'package:goodanime/models/media_min.dart';
import 'package:goodanime/models/user_activity.dart';
import 'package:goodanime/pages/profile/tabs/activity_tab.dart';

/// Widget tests for [ProfileActivityTab].
void main() {
  const sampleMedia = MediaMin(
    id: 21,
    type: 'ANIME',
    title: Title(
      english: 'One Piece',
      native: 'ONE PIECE',
      romaji: 'One Piece',
      userPreferred: 'One Piece',
    ),
    averageScore: 88,
    coverImage: CoverImage(
      medium: '',
      large: '',
      extraLarge: '',
      color: '#e4a15d',
    ),
    episodes: 1100,
    chapters: 0,
    volumes: 0,
    format: 'TV',
    isAdult: false,
    isFavourite: false,
    siteUrl: 'https://anilist.co/anime/21',
  );

  final sampleActivities = <UserActivity>[
    const UserActivity(
      id: 101,
      type: 'ANIME_LIST',
      createdAt: 1700000000,
      likeCount: 3,
      replyCount: 1,
      status: 'watched episode',
      progress: '1 - 3',
      user: UserActivityAuthor(id: 42, name: 'thedrone7'),
      media: sampleMedia,
    ),
    const UserActivity(
      id: 102,
      type: 'TEXT',
      createdAt: 1700000100,
      likeCount: 7,
      replyCount: 2,
      textHtml: '<p>Finished an awesome arc today!</p>',
      user: UserActivityAuthor(id: 42, name: 'thedrone7'),
    ),
    const UserActivity(
      id: 103,
      type: 'MESSAGE',
      createdAt: 1700000200,
      likeCount: 1,
      isPrivate: true,
      textHtml: '<p>Check out this recommendation.</p>',
      user: UserActivityAuthor(id: 99, name: 'friendUser'),
      recipient: UserActivityAuthor(id: 42, name: 'thedrone7'),
    ),
  ];

  Widget buildActivityTab({
    required FetchUserActivitiesCallback fetchActivities,
    ToggleActivityLikeCallback? toggleLike,
    ValueChanged<int>? onOpenMedia,
    ScrollController? scrollController,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          controller: scrollController,
          child: ProfileActivityTab(
            userId: 42,
            scrollController: scrollController,
            fetchActivities: fetchActivities,
            toggleLike: toggleLike,
            onOpenMedia: onOpenMedia,
          ),
        ),
      ),
    );
  }

  testWidgets('renders ListActivity, TextActivity, and MessageActivity cards', (
    tester,
  ) async {
    int? openedMediaId;

    await tester.pumpWidget(
      buildActivityTab(
        fetchActivities:
            ({required userId, required page, required typeIn}) async {
              return UserActivityPage(
                pageInfo: const PageInfo(hasNextPage: false, currentPage: 1),
                activities: sampleActivities,
              );
            },
        onOpenMedia: (id) => openedMediaId = id,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('All'), findsOneWidget);
    expect(find.text('List Updates'), findsOneWidget);
    expect(find.text('Status Posts'), findsOneWidget);
    expect(find.text('Messages'), findsOneWidget);

    expect(
      find.textContaining('Watched episode 1 - 3 of One Piece'),
      findsOneWidget,
    );
    expect(
      find.textContaining('Finished an awesome arc today!'),
      findsOneWidget,
    );
    expect(find.text('friendUser'), findsOneWidget);
    expect(find.text('Private'), findsOneWidget);
    expect(
      find.textContaining('Check out this recommendation.'),
      findsOneWidget,
    );

    await tester.tap(find.textContaining('Watched episode 1 - 3 of One Piece'));
    await tester.pump();
    expect(openedMediaId, 21);
  });

  testWidgets('switching filter pills queries expected typeIn list', (
    tester,
  ) async {
    final recordedTypes = <List<String>>[];

    await tester.pumpWidget(
      buildActivityTab(
        fetchActivities:
            ({required userId, required page, required typeIn}) async {
              recordedTypes.add(typeIn);
              return UserActivityPage(
                pageInfo: const PageInfo(hasNextPage: false, currentPage: 1),
                activities: sampleActivities
                    .where((a) => typeIn.isEmpty || typeIn.contains(a.type))
                    .toList(),
              );
            },
      ),
    );
    await tester.pumpAndSettle();

    expect(recordedTypes, [<String>[]]);

    await tester.tap(find.text('Status Posts'));
    await tester.pumpAndSettle();

    expect(recordedTypes.last, ['TEXT']);
    expect(
      find.textContaining('Finished an awesome arc today!'),
      findsOneWidget,
    );
    expect(
      find.textContaining('Watched episode 1 - 3 of One Piece'),
      findsNothing,
    );
  });

  testWidgets('optimistically toggles like count and rolls back on failure', (
    tester,
  ) async {
    var shouldFail = false;

    await tester.pumpWidget(
      buildActivityTab(
        fetchActivities:
            ({required userId, required page, required typeIn}) async {
              return UserActivityPage(
                pageInfo: const PageInfo(hasNextPage: false, currentPage: 1),
                activities: [sampleActivities[1]],
              );
            },
        toggleLike: (id) async {
          if (shouldFail) {
            throw Exception('Network error');
          }
        },
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('7'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('activity-like-102')));
    await tester.pumpAndSettle();
    expect(find.text('8'), findsOneWidget);

    shouldFail = true;
    await tester.tap(find.byKey(const ValueKey('activity-like-102')));
    await tester.pumpAndSettle();

    expect(find.text('8'), findsOneWidget);
    expect(find.textContaining('Failed to update like'), findsOneWidget);
  });

  testWidgets('renders empty state when user has no activities', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildActivityTab(
        fetchActivities:
            ({required userId, required page, required typeIn}) async {
              return const UserActivityPage(
                pageInfo: PageInfo(hasNextPage: false, currentPage: 1),
                activities: [],
              );
            },
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('No recent activity.'), findsOneWidget);
  });
}
