import '../proto/user.pb.dart' as pb;

/// Represents a public AniList user profile.
class UserProfile {
  /// Unique user ID.
  final int id;

  /// User display name.
  final String name;

  /// User bio in HTML format.
  final String about;

  /// Large avatar image URL.
  final String avatarLarge;

  /// Medium avatar image URL.
  final String avatarMedium;

  /// Profile cover banner image URL.
  final String bannerImage;

  /// Whether the authenticated viewer follows this user.
  final bool isFollowing;

  /// Whether this user follows the authenticated viewer.
  final bool isFollower;

  /// Account creation epoch timestamp.
  final int createdAt;

  /// Total count of followers.
  final int followersCount;

  /// Total count of followed users.
  final int followingCount;

  /// Creates a user profile.
  const UserProfile({
    required this.id,
    required this.name,
    this.about = '',
    this.avatarLarge = '',
    this.avatarMedium = '',
    this.bannerImage = '',
    this.isFollowing = false,
    this.isFollower = false,
    this.createdAt = 0,
    this.followersCount = 0,
    this.followingCount = 0,
  });

  /// Creates a user profile from a protobuf object.
  factory UserProfile.fromProto(pb.UserProfile pbObj) {
    return UserProfile(
      id: pbObj.id,
      name: pbObj.name,
      about: pbObj.about,
      avatarLarge: pbObj.hasAvatar() ? pbObj.avatar.large : '',
      avatarMedium: pbObj.hasAvatar() ? pbObj.avatar.medium : '',
      bannerImage: pbObj.bannerImage,
      isFollowing: pbObj.isFollowing,
      isFollower: pbObj.isFollower,
      createdAt: pbObj.createdAt,
      followersCount: pbObj.followersCount,
      followingCount: pbObj.followingCount,
    );
  }

  /// Converts the user profile to its protobuf representation.
  pb.UserProfile toProto() {
    final pbObj = pb.UserProfile(
      id: id,
      name: name,
      about: about,
      bannerImage: bannerImage,
      isFollowing: isFollowing,
      isFollower: isFollower,
      createdAt: createdAt,
      followersCount: followersCount,
      followingCount: followingCount,
    );
    if (avatarLarge.isNotEmpty || avatarMedium.isNotEmpty) {
      pbObj.avatar = pb.UserAvatar(large: avatarLarge, medium: avatarMedium);
    }
    return pbObj;
  }

  /// Creates a copy of this profile with updated fields.
  UserProfile copyWith({
    int? id,
    String? name,
    String? about,
    String? avatarLarge,
    String? avatarMedium,
    String? bannerImage,
    bool? isFollowing,
    bool? isFollower,
    int? createdAt,
    int? followersCount,
    int? followingCount,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      about: about ?? this.about,
      avatarLarge: avatarLarge ?? this.avatarLarge,
      avatarMedium: avatarMedium ?? this.avatarMedium,
      bannerImage: bannerImage ?? this.bannerImage,
      isFollowing: isFollowing ?? this.isFollowing,
      isFollower: isFollower ?? this.isFollower,
      createdAt: createdAt ?? this.createdAt,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
    );
  }
}
