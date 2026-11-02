import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:goodanime/components/app_fab.dart';
import 'package:goodanime/models/user_activity.dart';
import 'package:goodanime/pages/activity/page.dart';
import 'package:goodanime/pages/profile/widgets/user_activity_card.dart';

void main() {
  const dummyAuthor = UserActivityAuthor(id: 101, name: 'MakiseKurisu');

  final dummyTextActivity = UserActivity(
    id: 42,
    type: 'TEXT',
    createdAt: 1700000000,
    likeCount: 15,
    replyCount: 3,
    textHtml: '<p>Testing feed activity text</p>',
    user: dummyAuthor,
  );

  group('UserActivityCard interaction and layout tests', () {
    testWidgets('calls onOpenPost when content is tapped in feed mode', (
      tester,
    ) async {
      var postOpened = false;
      var likeToggled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UserActivityCard(
              activity: dummyTextActivity,
              onToggleLike: () => likeToggled = true,
              onOpenPost: () => postOpened = true,
            ),
          ),
        ),
      );

      expect(find.text('Testing feed activity text'), findsOneWidget);

      await tester.tap(find.text('Testing feed activity text'));
      await tester.pump();

      expect(postOpened, isTrue);
      expect(likeToggled, isFalse);
    });

    testWidgets('omits footer actions when showFooterActions is false', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UserActivityCard(
              activity: dummyTextActivity,
              isFeedMode: false,
              showFooterActions: false,
              onToggleLike: () {},
            ),
          ),
        ),
      );

      expect(find.byKey(const ValueKey('activity-like-42')), findsNothing);
      expect(find.byKey(const ValueKey('activity-comment-42')), findsNothing);
    });
  });

  group('ActivityPage layout and FAB tests', () {
    testWidgets('renders dedicated activity page with custom FAB stats', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: ActivityPage(initialActivity: dummyTextActivity)),
      );
      await tester.pumpAndSettle();

      expect(find.text('Activity'), findsOneWidget);
      expect(find.text('Testing feed activity text'), findsOneWidget);

      expect(find.byKey(const ValueKey('activity-like-42')), findsNothing);
      expect(find.byKey(const ValueKey('activity-comment-42')), findsNothing);

      expect(find.byType(AppFab), findsNWidgets(2));
      expect(find.text('15'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
    });
  });
}
