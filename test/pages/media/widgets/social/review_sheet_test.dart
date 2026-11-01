import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:goodanime/models/media_review.dart';
import 'package:goodanime/models/viewer.dart';
import 'package:goodanime/pages/media/widgets/social/review_sheet.dart';

Widget _wrap(Widget child) {
  return MaterialApp(
    home: Scaffold(body: SizedBox(height: 1000, width: 800, child: child)),
  );
}

void main() {
  group('ReviewSheet', () {
    const testViewer = Viewer(
      id: 77,
      name: 'ReviewGuru',
      avatarMedium: 'https://example.com/avatar.jpg',
      createdAt: 1600000000,
    );

    const testReview = ReviewNode(
      id: 201,
      score: 92,
      rating: 40,
      ratingAmount: 50,
      summary: 'Remarkable storytelling and execution.',
      userRating: ReviewUserRating.noVote,
      user: testViewer,
      body: '<p>Remarkable storytelling and execution.</p>',
    );

    setUp(() {
      final binding = TestWidgetsFlutterBinding.ensureInitialized();
      binding.platformDispatcher.views.first.physicalSize = const Size(
        1080,
        1920,
      );
      binding.platformDispatcher.views.first.devicePixelRatio = 1.0;
    });

    tearDown(() {
      final binding = TestWidgetsFlutterBinding.ensureInitialized();
      binding.platformDispatcher.views.first.resetPhysicalSize();
      binding.platformDispatcher.views.first.resetDevicePixelRatio();
    });

    testWidgets('renders reviewer username and title', (tester) async {
      await tester.pumpWidget(
        _wrap(const ReviewSheet(review: testReview, mediaTitle: 'Frieren')),
      );

      expect(find.text('Frieren review'), findsOneWidget);
      expect(find.text('ReviewGuru'), findsOneWidget);
      expect(find.text('9.2'), findsOneWidget);
    });

    testWidgets(
      'tapping reviewer header calls onUserTap with user credentials',
      (tester) async {
        int? tappedId;
        String? tappedName;

        await tester.pumpWidget(
          _wrap(
            ReviewSheet(
              review: testReview,
              mediaTitle: 'Frieren',
              onUserTap: (userId, username) {
                tappedId = userId;
                tappedName = username;
              },
            ),
          ),
        );

        await tester.tap(find.text('ReviewGuru'));
        await tester.pumpAndSettle();

        expect(tappedId, equals(77));
        expect(tappedName, equals('ReviewGuru'));
      },
    );

    testWidgets('renders anonymous when review has no user', (tester) async {
      const anonReview = ReviewNode(
        id: 202,
        score: 80,
        rating: 10,
        ratingAmount: 12,
        summary: 'Anonymous review',
        userRating: ReviewUserRating.noVote,
        body: '<p>Anonymous review</p>',
      );

      var userTapped = false;

      await tester.pumpWidget(
        _wrap(
          ReviewSheet(
            review: anonReview,
            mediaTitle: 'Frieren',
            onUserTap: (userId, username) => userTapped = true,
          ),
        ),
      );

      expect(find.text('Anonymous'), findsOneWidget);

      await tester.tap(find.text('Anonymous'));
      await tester.pumpAndSettle();

      expect(userTapped, isFalse);
    });
  });
}
