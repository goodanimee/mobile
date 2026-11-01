import '../proto/api.pb.dart' as pb_api;
import '../proto/user.pb.dart' as pb;
import 'common.dart';

/// Segment toggle between a user's following list and follower list.
enum SocialSegment {
  /// Accounts followed by the user.
  following(label: 'Following', isFollowers: false),

  /// Accounts following the user.
  followers(label: 'Followers', isFollowers: true);

  /// Display title for the segment button.
  final String label;

  /// Whether this segment queries followers instead of following.
  final bool isFollowers;

  const SocialSegment({required this.label, required this.isFollowers});
}

/// Minimal user representation in following and follower lists.
class SocialUser {
  /// Unique AniList user ID.
  final int id;

  /// Display username.
  final String name;

  /// Large avatar image URL.
  final String avatarLarge;

  /// Medium avatar image URL.
  final String avatarMedium;

  /// Whether the authenticated viewer is following this user.
  final bool isFollowing;

  /// Whether this user is following the authenticated viewer.
  final bool isFollower;

  /// Creates a social user model.
  const SocialUser({
    required this.id,
    required this.name,
    this.avatarLarge = '',
    this.avatarMedium = '',
    this.isFollowing = false,
    this.isFollower = false,
  });

  /// Best available avatar URL.
  String get avatarUrl => avatarLarge.isNotEmpty ? avatarLarge : avatarMedium;

  /// Returns a copy of this social user with specified fields updated.
  SocialUser copyWith({
    int? id,
    String? name,
    String? avatarLarge,
    String? avatarMedium,
    bool? isFollowing,
    bool? isFollower,
  }) {
    return SocialUser(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarLarge: avatarLarge ?? this.avatarLarge,
      avatarMedium: avatarMedium ?? this.avatarMedium,
      isFollowing: isFollowing ?? this.isFollowing,
      isFollower: isFollower ?? this.isFollower,
    );
  }

  /// Creates a [SocialUser] from a protobuf [pb.SocialUser] message.
  factory SocialUser.fromProto(pb.SocialUser pbObj) {
    return SocialUser(
      id: pbObj.id,
      name: pbObj.name,
      avatarLarge: pbObj.hasAvatar() ? pbObj.avatar.large : '',
      avatarMedium: pbObj.hasAvatar() ? pbObj.avatar.medium : '',
      isFollowing: pbObj.isFollowing,
      isFollower: pbObj.isFollower,
    );
  }

  /// Converts this model to a protobuf [pb.SocialUser] message.
  pb.SocialUser toProto() {
    return pb.SocialUser(
      id: id,
      name: name,
      avatar: pb.UserAvatar(large: avatarLarge, medium: avatarMedium),
      isFollowing: isFollowing,
      isFollower: isFollower,
    );
  }
}

/// Paginated page of social users.
class SocialUserPage {
  /// Pagination metadata.
  final PageInfo pageInfo;

  /// Server-reported total item count.
  final int total;

  /// Users on this page.
  final List<SocialUser> users;

  /// Creates a social user page container.
  const SocialUserPage({
    required this.pageInfo,
    this.total = 0,
    this.users = const [],
  });

  /// Creates a [SocialUserPage] from a protobuf [pb_api.GetUserSocialResponse].
  factory SocialUserPage.fromProto(pb_api.GetUserSocialResponse pbObj) {
    return SocialUserPage(
      pageInfo: PageInfo.fromProto(pbObj.pageInfo),
      total: pbObj.total,
      users: List<SocialUser>.unmodifiable(
        pbObj.users.map(SocialUser.fromProto),
      ),
    );
  }

  /// Converts this page to a protobuf [pb_api.GetUserSocialResponse].
  pb_api.GetUserSocialResponse toProto() {
    return pb_api.GetUserSocialResponse(
      pageInfo: pageInfo.toProto(),
      total: total,
      users: users.map((u) => u.toProto()),
    );
  }
}

/// Pure helper functions for social transitions, count math, and search filtering.
class SocialMathUtils {
  /// Returns a copy of [user] with toggled [isFollowing] state.
  static SocialUser applyOptimisticFollowToggle(SocialUser user) {
    return user.copyWith(isFollowing: !user.isFollowing);
  }

  /// Computes updated follower and following counts after a follow toggle.
  static ({int followersCount, int followingCount}) computeUpdatedFollowCounts({
    required int currentFollowers,
    required int currentFollowing,
    required bool nowFollowing,
    required bool isViewingOwnProfile,
  }) {
    var updatedFollowing = currentFollowing;
    if (isViewingOwnProfile) {
      updatedFollowing = nowFollowing
          ? currentFollowing + 1
          : (currentFollowing > 0 ? currentFollowing - 1 : 0);
    }
    return (
      followersCount: currentFollowers < 0 ? 0 : currentFollowers,
      followingCount: updatedFollowing < 0 ? 0 : updatedFollowing,
    );
  }

  /// Filters [users] by case-insensitive [query] substring on username.
  static List<SocialUser> filterUsersByQuery(
    List<SocialUser> users,
    String query,
  ) {
    final trimmed = query.trim().toLowerCase();
    if (trimmed.isEmpty) return users;
    return users
        .where((u) => u.name.toLowerCase().contains(trimmed))
        .toList(growable: false);
  }
}
