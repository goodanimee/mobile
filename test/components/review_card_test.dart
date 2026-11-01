import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:goodanime/components/review_card.dart';
import 'package:goodanime/models/media_review.dart';
import 'package:goodanime/models/viewer.dart';

Widget _wrap(Widget child) {
  return MaterialApp(home: Scaffold(body: child));
}

void main() {
  group('ReviewCard', () {
    const testViewer = Viewer(
      id: 42,
      name: 'AnimeCritic',
      avatarMedium: 'https://example.com/avatar.jpg',
      createdAt: 1600000000,
    );

    const testReview = ReviewNode(
      id: 101,
      score: 85,
      rating: 12,
      ratingAmount: 15,
      summary: 'A breathtaking cinematic masterpiece with stunning visuals.',
      userRating: ReviewUserRating.noVote,
      user: testViewer,
      body:
          '<p>A breathtaking cinematic masterpiece with stunning visuals.</p>',
    );

    testWidgets('renders username, summary, and rating correctly', (
      tester,
    ) async {
      await tester.pumpWidget(_wrap(const ReviewCard(review: testReview)));

      expect(find.text('AnimeCritic'), findsOneWidget);
      expect(
        find.text(
          'A breathtaking cinematic masterpiece with stunning visuals.',
        ),
        findsOneWidget,
      );
      expect(find.text('8.5'), findsOneWidget);
      expect(find.text('12/15'), findsOneWidget);
    });

    testWidgets(
      'tapping username or avatar calls onUserTap without triggering card onTap',
      (tester) async {
        int? tappedUserId;
        String? tappedUsername;
        var cardTapped = false;

        await tester.pumpWidget(
          _wrap(
            ReviewCard(
              review: testReview,
              onTap: () => cardTapped = true,
              onUserTap: (userId, username) {
                tappedUserId = userId;
                tappedUsername = username;
              },
            ),
          ),
        );

        await tester.tap(find.text('AnimeCritic'));
        await tester.pumpAndSettle();

        expect(tappedUserId, equals(42));
        expect(tappedUsername, equals('AnimeCritic'));
        expect(cardTapped, isFalse);
      },
    );

    testWidgets('tapping card body calls card onTap without onUserTap', (
      tester,
    ) async {
      var userTapped = false;
      var cardTapped = false;

      await tester.pumpWidget(
        _wrap(
          ReviewCard(
            review: testReview,
            onTap: () => cardTapped = true,
            onUserTap: (userId, username) => userTapped = true,
          ),
        ),
      );

      await tester.tap(
        find.text(
          'A breathtaking cinematic masterpiece with stunning visuals.',
        ),
      );
      await tester.pumpAndSettle();

      expect(cardTapped, isTrue);
      expect(userTapped, isFalse);
    });

    testWidgets('renders anonymous fallback when user is null', (tester) async {
      const anonReview = ReviewNode(
        id: 102,
        score: 70,
        rating: 5,
        ratingAmount: 10,
        summary: 'Anonymous review summary',
        userRating: ReviewUserRating.noVote,
        body: '<p>Anonymous review summary</p>',
      );

      var userTapped = false;
      var cardTapped = false;

      await tester.pumpWidget(
        _wrap(
          ReviewCard(
            review: anonReview,
            onTap: () => cardTapped = true,
            onUserTap: (userId, username) => userTapped = true,
          ),
        ),
      );

      expect(find.text('Anonymous'), findsOneWidget);

      await tester.tap(find.text('Anonymous'));
      await tester.pumpAndSettle();

      expect(userTapped, isFalse);
      expect(cardTapped, isTrue);
    });
  });
}
