import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:goodanime/components/app_network_image.dart';
import 'package:goodanime/components/lucide_icons_helper.dart';
import 'package:goodanime/models/common.dart';
import 'package:goodanime/models/media_activity.dart';
import 'package:goodanime/models/viewer.dart';
import 'package:goodanime/pages/media/tabs/reviews_tab.dart';

Widget _wrap(Widget child) {
  return MaterialApp(
    home: Scaffold(body: SizedBox(height: 1000, width: 800, child: child)),
  );
}

void main() {
  group('MediaReviewsTab Recent Activity', () {
    const testViewer = Viewer(
      id: 88,
      name: 'AnimeVoyager',
      avatarMedium: 'https://example.com/voyager.jpg',
      createdAt: 1600000000,
    );

    const testActivity = ListActivity(
      id: 501,
      createdAt: 1600000000,
      isLiked: false,
      likeCount: 5,
      progress: '12',
      status: 'watched episode',
      user: testViewer,
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

    testWidgets('renders activity username, action text, and like count', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          MediaReviewsTab(
            mediaId: 1,
            mediaName: 'Frieren',
            mediaType: 'ANIME',
            fetchActivities: (mediaId, page) async {
              return const ListActivityConnection(
                pageInfo: PageInfo(currentPage: 1, hasNextPage: false),
                nodes: [testActivity],
              );
            },
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('AnimeVoyager'), findsOneWidget);
      expect(find.text('Watched episode 12 of Frieren'), findsOneWidget);
      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('tapping activity username calls onUserTap with credentials', (
      tester,
    ) async {
      int? tappedId;
      String? tappedUsername;

      await tester.pumpWidget(
        _wrap(
          MediaReviewsTab(
            mediaId: 1,
            mediaName: 'Frieren',
            mediaType: 'ANIME',
            onUserTap: (userId, username) {
              tappedId = userId;
              tappedUsername = username;
            },
            fetchActivities: (mediaId, page) async {
              return const ListActivityConnection(
                pageInfo: PageInfo(currentPage: 1, hasNextPage: false),
                nodes: [testActivity],
              );
            },
          ),
        ),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.text('AnimeVoyager'));
      await tester.pumpAndSettle();

      expect(tappedId, equals(88));
      expect(tappedUsername, equals('AnimeVoyager'));
    });

    testWidgets('tapping activity avatar calls onUserTap with credentials', (
      tester,
    ) async {
      int? tappedId;
      String? tappedUsername;

      await tester.pumpWidget(
        _wrap(
          MediaReviewsTab(
            mediaId: 1,
            mediaName: 'Frieren',
            mediaType: 'ANIME',
            onUserTap: (userId, username) {
              tappedId = userId;
              tappedUsername = username;
            },
            fetchActivities: (mediaId, page) async {
              return const ListActivityConnection(
                pageInfo: PageInfo(currentPage: 1, hasNextPage: false),
                nodes: [testActivity],
              );
            },
          ),
        ),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.byType(AppNetworkImage));
      await tester.pumpAndSettle();

      expect(tappedId, equals(88));
      expect(tappedUsername, equals('AnimeVoyager'));
    });

    testWidgets(
      'tapping like heart toggles like without triggering onUserTap',
      (tester) async {
        var userTapped = false;
        var toggleCalled = false;

        await tester.pumpWidget(
          _wrap(
            MediaReviewsTab(
              mediaId: 1,
              mediaName: 'Frieren',
              mediaType: 'ANIME',
              onUserTap: (userId, username) => userTapped = true,
              fetchActivities: (mediaId, page) async {
                return const ListActivityConnection(
                  pageInfo: PageInfo(currentPage: 1, hasNextPage: false),
                  nodes: [testActivity],
                );
              },
              toggleActivityLike: (activityId) async {
                toggleCalled = true;
                return true;
              },
            ),
          ),
        );

        await tester.pumpAndSettle();

        await tester.tap(find.byType(LucideHeartIcon));
        await tester.pumpAndSettle();

        expect(toggleCalled, isTrue);
        expect(userTapped, isFalse);
        expect(find.text('6'), findsOneWidget);
      },
    );

    testWidgets(
      'renders anonymous when activity has no user and tap is ignored',
      (tester) async {
        const anonActivity = ListActivity(
          id: 502,
          createdAt: 1600000000,
          isLiked: false,
          likeCount: 2,
          progress: '',
          status: 'completed',
        );

        var userTapped = false;

        await tester.pumpWidget(
          _wrap(
            MediaReviewsTab(
              mediaId: 1,
              mediaName: 'Frieren',
              mediaType: 'ANIME',
              onUserTap: (userId, username) => userTapped = true,
              fetchActivities: (mediaId, page) async {
                return const ListActivityConnection(
                  pageInfo: PageInfo(currentPage: 1, hasNextPage: false),
                  nodes: [anonActivity],
                );
              },
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.text('Anonymous'), findsOneWidget);

        await tester.tap(find.text('Anonymous'));
        await tester.pumpAndSettle();

        expect(userTapped, isFalse);
      },
    );
  });
}
