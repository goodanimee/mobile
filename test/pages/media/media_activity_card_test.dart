import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:goodanime/components/lucide_icons_helper.dart';
import 'package:goodanime/models/common.dart';
import 'package:goodanime/models/media_activity.dart';
import 'package:goodanime/models/viewer.dart';
import 'package:goodanime/pages/activity/page.dart';
import 'package:goodanime/pages/media/tabs/reviews_tab.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

void main() {
  final sampleActivity = ListActivity(
    id: 991,
    createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000 - 3600,
    isLiked: false,
    likeCount: 42,
    replyCount: 7,
    progress: '12',
    status: 'watched episode',
    user: const Viewer(
      id: 101,
      name: 'Spike',
      avatarMedium: 'https://example.com/spike.png',
      createdAt: 0,
    ),
  );

  Widget createSubject({
    required List<ListActivity> activities,
    Future<bool> Function(int)? toggleActivityLike,
    void Function(int)? onOpenComments,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: MediaReviewsTab(
          mediaId: 1,
          mediaName: 'Cowboy Bebop',
          mediaType: 'ANIME',
          fetchActivities: (mediaId, page) async {
            return ListActivityConnection(
              pageInfo: const PageInfo(hasNextPage: false, currentPage: 1),
              nodes: activities,
            );
          },
          toggleActivityLike: toggleActivityLike,
          onOpenComments: onOpenComments,
        ),
      ),
    );
  }

  testWidgets(
    'renders activity cards with wider dimensions and comment button to the left of like button',
    (tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createSubject(activities: [sampleActivity]));
      await tester.pumpAndSettle();

      expect(find.text('Spike'), findsOneWidget);
      expect(find.text('7'), findsOneWidget);
      expect(find.text('42'), findsOneWidget);

      final commentIconFinder = find.byIcon(LucideIcons.messageSquare);
      final likeIconFinder = find.byType(LucideHeartIcon);

      expect(commentIconFinder, findsOneWidget);
      expect(likeIconFinder, findsOneWidget);

      final commentTopLeft = tester.getTopLeft(commentIconFinder);
      final likeTopLeft = tester.getTopLeft(likeIconFinder);
      expect(
        commentTopLeft.dx < likeTopLeft.dx,
        isTrue,
        reason: 'Comment button should be to the left of Like button',
      );

      final cardFinder = find.byKey(
        ValueKey('activity_card_${sampleActivity.id}'),
      );
      expect(cardFinder, findsOneWidget);
      final cardSize = tester.getSize(cardFinder);
      expect(
        cardSize.width,
        equals(336.0),
        reason: 'Card should be sized to 84% width (400 * 0.84 = 336)',
      );
    },
  );

  testWidgets('tapping comment button triggers onOpenComments callback', (
    tester,
  ) async {
    int? openedActivityId;

    await tester.pumpWidget(
      createSubject(
        activities: [sampleActivity],
        onOpenComments: (id) => openedActivityId = id,
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(LucideIcons.messageSquare));
    await tester.pumpAndSettle();

    expect(openedActivityId, equals(991));
  });

  testWidgets('tapping like button triggers toggleActivityLike callback', (
    tester,
  ) async {
    int? likedActivityId;

    await tester.pumpWidget(
      createSubject(
        activities: [sampleActivity],
        toggleActivityLike: (id) async {
          likedActivityId = id;
          return true;
        },
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(LucideHeartIcon));
    await tester.pumpAndSettle();

    expect(likedActivityId, equals(991));
  });

  testWidgets('tapping activity card navigates to ActivityPage', (
    tester,
  ) async {
    await tester.pumpWidget(createSubject(activities: [sampleActivity]));
    await tester.pumpAndSettle();

    await tester.tap(
      find.byKey(ValueKey('activity_card_${sampleActivity.id}')),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.byType(ActivityPage), findsOneWidget);
  });
}
