import 'package:flutter_test/flutter_test.dart';
import 'package:goodanime/models/common.dart';
import 'package:goodanime/models/social_user.dart';
import 'package:goodanime/proto/api.pb.dart' as pb_api;
import 'package:goodanime/proto/common.pb.dart' as pb_common;
import 'package:goodanime/proto/user.pb.dart' as pb_user;
import 'package:goodanime/services/search_service.dart';

void main() {
  group('UserSearchResult', () {
    test('instantiates with users list and page info', () {
      const pageInfo = PageInfo(hasNextPage: true, currentPage: 1);
      const user = SocialUser(
        id: 12345,
        name: 'TheDrone7',
        avatarLarge: 'https://example.com/large.jpg',
        isFollowing: true,
      );

      const result = UserSearchResult(users: [user], pageInfo: pageInfo);

      expect(result.users.length, 1);
      expect(result.users.first.id, 12345);
      expect(result.users.first.name, 'TheDrone7');
      expect(result.users.first.avatarUrl, 'https://example.com/large.jpg');
      expect(result.pageInfo.hasNextPage, isTrue);
      expect(result.pageInfo.currentPage, 1);
    });

    test('maps from protobuf FetchUserSearchResponse correctly', () {
      final pbResponse = pb_api.FetchUserSearchResponse(
        pageInfo: pb_common.PageInfo(hasNextPage: false, currentPage: 3),
        users: [
          pb_user.SocialUser(
            id: 99,
            name: 'Kurisutina',
            avatar: pb_user.UserAvatar(
              large: 'https://example.com/k_large.png',
              medium: 'https://example.com/k_med.png',
            ),
            isFollowing: false,
            isFollower: true,
          ),
        ],
      );

      final users = pbResponse.users.map(SocialUser.fromProto).toList();
      final pageInfo = PageInfo.fromProto(pbResponse.pageInfo);
      final result = UserSearchResult(users: users, pageInfo: pageInfo);

      expect(result.users.length, 1);
      final mappedUser = result.users.first;
      expect(mappedUser.id, 99);
      expect(mappedUser.name, 'Kurisutina');
      expect(mappedUser.avatarLarge, 'https://example.com/k_large.png');
      expect(mappedUser.avatarMedium, 'https://example.com/k_med.png');
      expect(mappedUser.isFollowing, isFalse);
      expect(mappedUser.isFollower, isTrue);
      expect(result.pageInfo.hasNextPage, isFalse);
      expect(result.pageInfo.currentPage, 3);
    });
  });
}
