import 'package:flutter_test/flutter_test.dart';
import 'package:goodanime/models/common.dart';
import 'package:goodanime/models/social_user.dart';

void main() {
  group('SocialUser & SocialUserPage models (THE-182)', () {
    test('roundtrips SocialUser and SocialUserPage through protobuf', () {
      const user1 = SocialUser(
        id: 101,
        name: 'alice',
        avatarLarge: 'https://img.com/alice_lg.jpg',
        avatarMedium: 'https://img.com/alice_med.jpg',
        isFollowing: true,
      );

      const user2 = SocialUser(
        id: 102,
        name: 'bob',
        avatarMedium: 'https://img.com/bob_med.jpg',
        isFollower: true,
      );

      final restoredUser = SocialUser.fromProto(user1.toProto());
      expect(restoredUser.id, 101);
      expect(restoredUser.name, 'alice');
      expect(restoredUser.avatarUrl, 'https://img.com/alice_lg.jpg');
      expect(restoredUser.isFollowing, isTrue);
      expect(restoredUser.isFollower, isFalse);

      expect(user2.avatarUrl, 'https://img.com/bob_med.jpg');

      final page = SocialUserPage(
        pageInfo: const PageInfo(hasNextPage: true, currentPage: 1),
        total: 42,
        users: [user1, user2],
      );

      final restoredPage = SocialUserPage.fromProto(page.toProto());
      expect(restoredPage.pageInfo.hasNextPage, isTrue);
      expect(restoredPage.pageInfo.currentPage, 1);
      expect(restoredPage.total, 42);
      expect(restoredPage.users.length, 2);
      expect(restoredPage.users[1].name, 'bob');
    });

    test('applyOptimisticFollowToggle toggles following state cleanly', () {
      const unliked = SocialUser(id: 1, name: 'charlie');
      final followed = SocialMathUtils.applyOptimisticFollowToggle(unliked);
      expect(followed.isFollowing, isTrue);

      final unfollowed = SocialMathUtils.applyOptimisticFollowToggle(followed);
      expect(unfollowed.isFollowing, isFalse);
    });

    test(
      'computeUpdatedFollowCounts adjusts following on own profile and clamps at 0',
      () {
        final selfFollow = SocialMathUtils.computeUpdatedFollowCounts(
          currentFollowers: 10,
          currentFollowing: 5,
          nowFollowing: true,
          isViewingOwnProfile: true,
        );
        expect(selfFollow.followersCount, 10);
        expect(selfFollow.followingCount, 6);

        final selfUnfollow = SocialMathUtils.computeUpdatedFollowCounts(
          currentFollowers: 10,
          currentFollowing: 5,
          nowFollowing: false,
          isViewingOwnProfile: true,
        );
        expect(selfUnfollow.followersCount, 10);
        expect(selfUnfollow.followingCount, 4);

        final selfClamped = SocialMathUtils.computeUpdatedFollowCounts(
          currentFollowers: 0,
          currentFollowing: 0,
          nowFollowing: false,
          isViewingOwnProfile: true,
        );
        expect(selfClamped.followingCount, 0);

        final otherProfile = SocialMathUtils.computeUpdatedFollowCounts(
          currentFollowers: 10,
          currentFollowing: 5,
          nowFollowing: true,
          isViewingOwnProfile: false,
        );
        expect(otherProfile.followingCount, 5);
        expect(otherProfile.followersCount, 10);
      },
    );

    test(
      'filterUsersByQuery handles whitespace, case-insensitivity, and misses',
      () {
        const list = [
          SocialUser(id: 1, name: 'OnePieceFan'),
          SocialUser(id: 2, name: 'LuffyDMonkey'),
          SocialUser(id: 3, name: 'ZoroSwordsman'),
        ];

        expect(SocialMathUtils.filterUsersByQuery(list, ''), list);
        expect(SocialMathUtils.filterUsersByQuery(list, '   '), list);

        final matches = SocialMathUtils.filterUsersByQuery(list, 'piece');
        expect(matches.length, 1);
        expect(matches.single.name, 'OnePieceFan');

        final upperMatches = SocialMathUtils.filterUsersByQuery(list, 'LUFFY');
        expect(upperMatches.length, 1);
        expect(upperMatches.single.name, 'LuffyDMonkey');

        expect(
          SocialMathUtils.filterUsersByQuery(list, 'nonexistent'),
          isEmpty,
        );
      },
    );
  });
}
