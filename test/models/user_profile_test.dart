import 'package:flutter_test/flutter_test.dart';
import 'package:goodanime/models/user_profile.dart';
import 'package:goodanime/proto/user.pb.dart' as pb;

void main() {
  group('UserProfile model & protobuf mapping', () {
    test('roundtrips through protobuf representation', () {
      const profile = UserProfile(
        id: 456,
        name: 'OtakuPrime',
        about: '<p>Bio text</p>',
        avatarLarge: 'https://img.com/large.jpg',
        avatarMedium: 'https://img.com/med.jpg',
        bannerImage: 'https://img.com/banner.jpg',
        isFollowing: true,
        isFollower: true,
        createdAt: 1600000000,
        followersCount: 42,
        followingCount: 15,
        animeCount: 180,
        mangaCount: 64,
      );

      final pbObj = profile.toProto();
      final restored = UserProfile.fromProto(pbObj);

      expect(restored.id, profile.id);
      expect(restored.name, profile.name);
      expect(restored.about, profile.about);
      expect(restored.avatarLarge, profile.avatarLarge);
      expect(restored.avatarMedium, profile.avatarMedium);
      expect(restored.bannerImage, profile.bannerImage);
      expect(restored.isFollowing, profile.isFollowing);
      expect(restored.isFollower, profile.isFollower);
      expect(restored.createdAt, profile.createdAt);
      expect(restored.followersCount, profile.followersCount);
      expect(restored.followingCount, profile.followingCount);
      expect(restored.animeCount, profile.animeCount);
      expect(restored.mangaCount, profile.mangaCount);
    });

    test('handles empty or missing avatar in protobuf object', () {
      final pbObj = pb.UserProfile(id: 789, name: 'NoAvatarUser');

      final profile = UserProfile.fromProto(pbObj);
      expect(profile.id, 789);
      expect(profile.name, 'NoAvatarUser');
      expect(profile.avatarLarge, isEmpty);
      expect(profile.avatarMedium, isEmpty);
    });
  });
}
