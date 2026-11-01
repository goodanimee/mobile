import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:goodanime/models/common.dart';
import 'package:goodanime/models/social_user.dart';
import 'package:goodanime/pages/profile/tabs/social_tab.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Widget tests for [ProfileSocialTab].
void main() {
  const sampleUsers = [
    SocialUser(
      id: 101,
      name: 'luffy',
      avatarMedium: 'https://example.com/luffy.jpg',
      isFollowing: true,
      isFollower: true,
    ),
    SocialUser(
      id: 102,
      name: 'zoro',
      avatarMedium: 'https://example.com/zoro.jpg',
    ),
    SocialUser(
      id: 103,
      name: 'nami',
      avatarMedium: 'https://example.com/nami.jpg',
      isFollowing: true,
    ),
  ];

  Widget buildSocialTab({
    int userId = 42,
    int? viewerId,
    SocialSegment initialSegment = SocialSegment.following,
    FetchUserSocialCallback? fetchSocial,
    ToggleUserFollowCallback? toggleFollow,
    SocialUserTapCallback? onOpenProfile,
    ValueChanged<SocialSegment>? onSegmentChanged,
    ScrollController? scrollController,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          controller: scrollController,
          child: ProfileSocialTab(
            userId: userId,
            viewerId: viewerId,
            initialSegment: initialSegment,
            scrollController: scrollController,
            fetchSocial:
                fetchSocial ??
                ({required userId, required isFollowers, page = 1}) async {
                  return SocialUserPage(
                    pageInfo: const PageInfo(
                      hasNextPage: false,
                      currentPage: 1,
                    ),
                    total: sampleUsers.length,
                    users: sampleUsers,
                  );
                },
            toggleFollow: toggleFollow,
            onOpenProfile: onOpenProfile,
            onSegmentChanged: onSegmentChanged,
          ),
        ),
      ),
    );
  }

  testWidgets(
    'renders following list by default with avatars, names, and badges',
    (tester) async {
      await tester.pumpWidget(buildSocialTab());
      await tester.pumpAndSettle();

      expect(find.text('luffy'), findsOneWidget);
      expect(find.text('zoro'), findsOneWidget);
      expect(find.text('nami'), findsOneWidget);
      expect(find.text('Follows you'), findsOneWidget);
      expect(find.text('Following'), findsNWidgets(2));
      expect(find.text('Follow'), findsOneWidget);
    },
  );

  testWidgets('hides follow button on viewer row when viewerId matches', (
    tester,
  ) async {
    await tester.pumpWidget(buildSocialTab(viewerId: 102));
    await tester.pumpAndSettle();

    expect(find.text('zoro'), findsOneWidget);
    expect(find.text('Follow'), findsNothing);
  });

  testWidgets('switches segment when initialSegment updates', (tester) async {
    int followersFetchCount = 0;

    Widget buildWithSegment(SocialSegment segment) {
      return buildSocialTab(
        initialSegment: segment,
        fetchSocial: ({required userId, required isFollowers, page = 1}) async {
          if (isFollowers) {
            followersFetchCount++;
            return const SocialUserPage(
              pageInfo: PageInfo(hasNextPage: false, currentPage: 1),
              total: 1,
              users: [SocialUser(id: 201, name: 'sanji', isFollower: true)],
            );
          }
          return SocialUserPage(
            pageInfo: const PageInfo(hasNextPage: false, currentPage: 1),
            total: sampleUsers.length,
            users: sampleUsers,
          );
        },
      );
    }

    await tester.pumpWidget(buildWithSegment(SocialSegment.following));
    await tester.pumpAndSettle();

    expect(find.text('luffy'), findsOneWidget);

    await tester.pumpWidget(buildWithSegment(SocialSegment.followers));
    await tester.pumpAndSettle();

    expect(followersFetchCount, equals(1));
    expect(find.text('sanji'), findsOneWidget);
    expect(find.text('luffy'), findsNothing);
  });

  testWidgets('filters users via search and clears query', (tester) async {
    await tester.pumpWidget(buildSocialTab());
    await tester.pumpAndSettle();

    expect(find.text('luffy'), findsOneWidget);
    expect(find.text('zoro'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'zor');
    await tester.pumpAndSettle();

    expect(find.text('zoro'), findsOneWidget);
    expect(find.text('luffy'), findsNothing);

    await tester.enterText(find.byType(TextField), 'chopper');
    await tester.pumpAndSettle();

    expect(find.text('No users match your search.'), findsOneWidget);

    await tester.tap(find.byIcon(LucideIcons.x).first);
    await tester.pumpAndSettle();

    expect(find.text('luffy'), findsOneWidget);
    expect(find.text('zoro'), findsOneWidget);
  });

  testWidgets(
    'optimistically toggles follow status and handles error rollback',
    (tester) async {
      bool toggleCalled = false;
      bool shouldFail = false;

      await tester.pumpWidget(
        buildSocialTab(
          toggleFollow: (id) async {
            toggleCalled = true;
            if (shouldFail) {
              throw Exception('Network error');
            }
            return true;
          },
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Follow'), findsOneWidget);
      await tester.tap(find.text('Follow'));
      await tester.pump();

      expect(toggleCalled, isTrue);
      await tester.pumpAndSettle();
      expect(find.text('Follow'), findsNothing);

      shouldFail = true;
      final zoroCard = find
          .ancestor(of: find.text('zoro'), matching: find.byType(Container))
          .first;
      await tester.tap(
        find.descendant(of: zoroCard, matching: find.text('Following')),
      );
      await tester.pump();
      await tester.pumpAndSettle();

      expect(
        find.text('Failed to update follow status: Exception: Network error'),
        findsOneWidget,
      );
    },
  );

  testWidgets('renders empty state when user list is empty', (tester) async {
    await tester.pumpWidget(
      buildSocialTab(
        fetchSocial: ({required userId, required isFollowers, page = 1}) async {
          return const SocialUserPage(
            pageInfo: PageInfo(hasNextPage: false, currentPage: 1),
          );
        },
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('No following yet.'), findsOneWidget);
  });

  testWidgets('paginates and appends users on Load more', (tester) async {
    int requestedPage = 1;

    await tester.pumpWidget(
      buildSocialTab(
        fetchSocial: ({required userId, required isFollowers, page = 1}) async {
          requestedPage = page;
          if (page == 1) {
            return const SocialUserPage(
              pageInfo: PageInfo(hasNextPage: true, currentPage: 1),
              total: 2,
              users: [SocialUser(id: 1, name: 'firstUser')],
            );
          }
          return const SocialUserPage(
            pageInfo: PageInfo(hasNextPage: false, currentPage: 2),
            total: 2,
            users: [SocialUser(id: 2, name: 'secondUser')],
          );
        },
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('firstUser'), findsOneWidget);
    expect(find.text('secondUser'), findsNothing);
    expect(find.text('Load more'), findsOneWidget);

    await tester.tap(find.text('Load more'));
    await tester.pumpAndSettle();

    expect(requestedPage, equals(2));
    expect(find.text('firstUser'), findsOneWidget);
    expect(find.text('secondUser'), findsOneWidget);
  });

  testWidgets('invokes onOpenProfile when user row is tapped', (tester) async {
    int? tappedId;
    String? tappedName;

    await tester.pumpWidget(
      buildSocialTab(
        onOpenProfile: (id, name) {
          tappedId = id;
          tappedName = name;
        },
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('luffy'));
    expect(tappedId, equals(101));
    expect(tappedName, equals('luffy'));
  });

  testWidgets('renders cleanly on narrow 320px viewport without overflow', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(
          size: Size(320, 640),
          textScaler: TextScaler.linear(1.3),
        ),
        child: buildSocialTab(),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('luffy'), findsOneWidget);
    expect(find.text('Follows you'), findsOneWidget);
  });
}
