import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:goodanime/components/error_view.dart';
import 'package:goodanime/components/skeleton.dart';
import 'package:goodanime/models/social_user.dart';
import 'package:goodanime/pages/search/widgets/layout/user_results_list.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

Widget _wrap(Widget child) {
  return MaterialApp(
    home: Scaffold(body: SingleChildScrollView(child: child)),
  );
}

void main() {
  group('UserResultsList', () {
    testWidgets('renders skeleton list when isSearching is true', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          UserResultsList(
            userResults: const [],
            isSearching: true,
            isSearchingMore: false,
            searchError: null,
            onRetry: () {},
          ),
        ),
      );

      expect(find.byType(SkeletonShimmer), findsOneWidget);
    });

    testWidgets('renders AppErrorView and calls onRetry when error exists', (
      tester,
    ) async {
      var retryCalled = false;
      await tester.pumpWidget(
        _wrap(
          UserResultsList(
            userResults: const [],
            isSearching: false,
            isSearchingMore: false,
            searchError: 'Search failed',
            onRetry: () => retryCalled = true,
          ),
        ),
      );

      expect(find.byType(AppErrorView), findsOneWidget);
      expect(find.text('Search failed'), findsOneWidget);

      await tester.tap(find.text('Retry'));
      await tester.pump();
      expect(retryCalled, isTrue);
    });

    testWidgets('renders empty state text when results are empty', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          UserResultsList(
            userResults: const [],
            isSearching: false,
            isSearchingMore: false,
            searchError: null,
            onRetry: () {},
          ),
        ),
      );

      expect(find.text('No results found'), findsOneWidget);
    });

    testWidgets('renders user cards, follower badge, and respects viewerId', (
      tester,
    ) async {
      const viewerUser = SocialUser(id: 1, name: 'ViewerUser');
      const followerUser = SocialUser(
        id: 2,
        name: 'FollowerUser',
        isFollower: true,
      );
      const followingUser = SocialUser(
        id: 3,
        name: 'FollowingUser',
        isFollowing: true,
      );

      await tester.pumpWidget(
        _wrap(
          UserResultsList(
            userResults: const [viewerUser, followerUser, followingUser],
            isSearching: false,
            isSearchingMore: false,
            searchError: null,
            onRetry: () {},
            viewerId: 1,
          ),
        ),
      );

      expect(find.text('ViewerUser'), findsOneWidget);
      expect(find.text('FollowerUser'), findsOneWidget);
      expect(find.text('FollowingUser'), findsOneWidget);

      expect(find.text('Follows you'), findsOneWidget);

      expect(find.byIcon(LucideIcons.userPlus), findsOneWidget);
      expect(find.byIcon(LucideIcons.userCheck), findsOneWidget);
    });

    testWidgets('optimistically toggles follow and confirms server response', (
      tester,
    ) async {
      final completer = Completer<bool>();
      const user = SocialUser(id: 42, name: 'MakiseKurisu');

      await tester.pumpWidget(
        _wrap(
          UserResultsList(
            userResults: const [user],
            isSearching: false,
            isSearchingMore: false,
            searchError: null,
            onRetry: () {},
            toggleFollow: (id) => completer.future,
          ),
        ),
      );

      expect(find.byIcon(LucideIcons.userPlus), findsOneWidget);

      await tester.tap(find.byIcon(LucideIcons.userPlus));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      completer.complete(true);
      await tester.pumpAndSettle();

      expect(find.byIcon(LucideIcons.userCheck), findsOneWidget);
    });

    testWidgets('rolls back follow status and displays snackbar on failure', (
      tester,
    ) async {
      const user = SocialUser(id: 42, name: 'MakiseKurisu');

      await tester.pumpWidget(
        _wrap(
          UserResultsList(
            userResults: const [user],
            isSearching: false,
            isSearchingMore: false,
            searchError: null,
            onRetry: () {},
            toggleFollow: (id) => Future.error(Exception('Network timeout')),
          ),
        ),
      );

      await tester.tap(find.byIcon(LucideIcons.userPlus));
      await tester.pumpAndSettle();

      expect(find.byIcon(LucideIcons.userPlus), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
      expect(
        find.textContaining('Failed to update follow status'),
        findsOneWidget,
      );
    });

    testWidgets('triggers onUserTap callback when card is tapped', (
      tester,
    ) async {
      SocialUser? tappedUser;
      const user = SocialUser(id: 77, name: 'OkabeRintarou');

      await tester.pumpWidget(
        _wrap(
          UserResultsList(
            userResults: const [user],
            isSearching: false,
            isSearchingMore: false,
            searchError: null,
            onRetry: () {},
            onUserTap: (u) => tappedUser = u,
          ),
        ),
      );

      await tester.tap(find.text('OkabeRintarou'));
      await tester.pump();

      expect(tappedUser, isNotNull);
      expect(tappedUser!.id, 77);
      expect(tappedUser!.name, 'OkabeRintarou');
    });
  });
}
