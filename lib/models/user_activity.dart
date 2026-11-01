import '../proto/api.pb.dart' as pb_api;
import '../proto/media_min.pb.dart' as pb_media;
import '../proto/user.pb.dart' as pb;
import 'common.dart';
import 'media_min.dart';

/// Filter options for querying a user's activity stream.
enum UserActivityTypeFilter {
  /// All activity types.
  all(label: 'All', apiTypes: <String>[]),

  /// Anime and manga list updates.
  listUpdates(label: 'Lists', apiTypes: <String>['ANIME_LIST', 'MANGA_LIST']),

  /// Text status posts.
  statusPosts(label: 'Posts', apiTypes: <String>['TEXT']),

  /// Profile wall messages.
  messages(label: 'Messages', apiTypes: <String>['MESSAGE']);

  /// Display label for the filter pill.
  final String label;

  /// AniList `ActivityType` enum strings passed to `type_in`.
  final List<String> apiTypes;

  const UserActivityTypeFilter({required this.label, required this.apiTypes});
}

/// Discriminator for rendering a [UserActivity] card.
enum UserActivityKind {
  /// Media progress or status update (`ListActivity`).
  list,

  /// Free-form text post (`TextActivity`).
  text,

  /// Wall message from a messenger to a recipient (`MessageActivity`).
  message,
}

/// Minimal user identity attached to an activity entry.
class UserActivityAuthor {
  /// Unique AniList user ID.
  final int id;

  /// Display username.
  final String name;

  /// Large avatar image URL.
  final String avatarLarge;

  /// Medium avatar image URL.
  final String avatarMedium;

  /// Creates an activity author.
  const UserActivityAuthor({
    required this.id,
    required this.name,
    this.avatarLarge = '',
    this.avatarMedium = '',
  });

  /// Preferred non-empty avatar URL.
  String get avatarUrl => avatarLarge.isNotEmpty ? avatarLarge : avatarMedium;

  /// Creates a [UserActivityAuthor] from its protobuf representation.
  factory UserActivityAuthor.fromProto(pb.UserActivityUser pbObj) {
    return UserActivityAuthor(
      id: pbObj.id,
      name: pbObj.name,
      avatarLarge: pbObj.hasAvatar() ? pbObj.avatar.large : '',
      avatarMedium: pbObj.hasAvatar() ? pbObj.avatar.medium : '',
    );
  }

  /// Converts this author to its protobuf representation.
  pb.UserActivityUser toProto() {
    final pbObj = pb.UserActivityUser(id: id, name: name);
    if (avatarLarge.isNotEmpty || avatarMedium.isNotEmpty) {
      pbObj.avatar = pb.UserAvatar(large: avatarLarge, medium: avatarMedium);
    }
    return pbObj;
  }

  /// Creates a copy with updated fields.
  UserActivityAuthor copyWith({
    int? id,
    String? name,
    String? avatarLarge,
    String? avatarMedium,
  }) {
    return UserActivityAuthor(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarLarge: avatarLarge ?? this.avatarLarge,
      avatarMedium: avatarMedium ?? this.avatarMedium,
    );
  }
}

/// Unified model representing a user's list update, status post, or message.
class UserActivity {
  /// Activity ID.
  final int id;

  /// AniList activity type (`ANIME_LIST`, `MANGA_LIST`, `TEXT`, `MESSAGE`).
  final String type;

  /// Creation timestamp in epoch seconds.
  final int createdAt;

  /// Whether the authenticated viewer liked this activity.
  final bool isLiked;

  /// Total number of likes.
  final int likeCount;

  /// Total number of replies.
  final int replyCount;

  /// List update status phrase (for `ListActivity`).
  final String status;

  /// List update progress range or number (for `ListActivity`).
  final String progress;

  /// Rendered HTML body (for `TextActivity` and `MessageActivity`).
  final String textHtml;

  /// Whether a message activity is private.
  final bool isPrivate;

  /// Author or messenger of the activity.
  final UserActivityAuthor? user;

  /// Recipient user (for `MessageActivity`).
  final UserActivityAuthor? recipient;

  /// Associated media entry (for `ListActivity`).
  final MediaMin? media;

  /// Creates a user activity.
  const UserActivity({
    required this.id,
    required this.type,
    this.createdAt = 0,
    this.isLiked = false,
    this.likeCount = 0,
    this.replyCount = 0,
    this.status = '',
    this.progress = '',
    this.textHtml = '',
    this.isPrivate = false,
    this.user,
    this.recipient,
    this.media,
  });

  /// Resolved card kind based on [type].
  UserActivityKind get kind {
    return switch (type.toUpperCase()) {
      'TEXT' => UserActivityKind.text,
      'MESSAGE' => UserActivityKind.message,
      _ => UserActivityKind.list,
    };
  }

  /// Best available display title for [media].
  String get mediaDisplayTitle {
    final title = media?.title;
    if (title == null) return '';
    if (title.userPreferred.isNotEmpty) return title.userPreferred;
    if (title.english.isNotEmpty) return title.english;
    if (title.romaji.isNotEmpty) return title.romaji;
    if (title.native.isNotEmpty) return title.native;
    return '';
  }

  /// Capitalized action prefix before the media title for list activities.
  String get formattedListPrefix {
    final trimmedStatus = status.trim();
    final trimmedProgress = progress.trim();
    if (trimmedStatus.isEmpty) {
      return trimmedProgress.isNotEmpty
          ? 'Updated $trimmedProgress of'
          : 'Updated';
    }
    final capitalized =
        '${trimmedStatus[0].toUpperCase()}${trimmedStatus.substring(1)}';
    if (trimmedProgress.isNotEmpty) {
      return '$capitalized $trimmedProgress of';
    }
    return capitalized;
  }

  /// Full single-string summary for a list activity.
  String get formattedListSummary {
    final prefix = formattedListPrefix;
    final mediaTitle = mediaDisplayTitle;
    if (mediaTitle.isEmpty) return prefix;
    return '$prefix $mediaTitle';
  }

  /// Returns a copy with [isLiked] flipped and [likeCount] adjusted safely.
  UserActivity toggleLikeOptimistic() {
    final nextLiked = !isLiked;
    final nextCount = nextLiked
        ? likeCount + 1
        : (likeCount > 0 ? likeCount - 1 : 0);
    return copyWith(isLiked: nextLiked, likeCount: nextCount);
  }

  /// Creates a [UserActivity] from its protobuf representation.
  factory UserActivity.fromProto(pb.UserActivity pbObj) {
    return UserActivity(
      id: pbObj.id,
      type: pbObj.type,
      createdAt: pbObj.createdAt,
      isLiked: pbObj.isLiked,
      likeCount: pbObj.likeCount,
      replyCount: pbObj.replyCount,
      status: pbObj.status,
      progress: pbObj.progress,
      textHtml: pbObj.textHtml,
      isPrivate: pbObj.isPrivate,
      user: pbObj.hasUser() ? UserActivityAuthor.fromProto(pbObj.user) : null,
      recipient: pbObj.hasRecipient()
          ? UserActivityAuthor.fromProto(pbObj.recipient)
          : null,
      media: pbObj.hasMedia() ? MediaMin.fromProto(pbObj.media) : null,
    );
  }

  /// Converts this activity to its protobuf representation.
  pb.UserActivity toProto() {
    final pbObj = pb.UserActivity(
      id: id,
      type: type,
      createdAt: createdAt,
      isLiked: isLiked,
      likeCount: likeCount,
      replyCount: replyCount,
      status: status,
      progress: progress,
      textHtml: textHtml,
      isPrivate: isPrivate,
    );
    if (user != null) {
      pbObj.user = user!.toProto();
    }
    if (recipient != null) {
      pbObj.recipient = recipient!.toProto();
    }
    if (media != null) {
      pbObj.media = media!.toProto() as pb_media.MediaMin;
    }
    return pbObj;
  }

  /// Creates a copy of this activity with updated fields.
  UserActivity copyWith({
    int? id,
    String? type,
    int? createdAt,
    bool? isLiked,
    int? likeCount,
    int? replyCount,
    String? status,
    String? progress,
    String? textHtml,
    bool? isPrivate,
    UserActivityAuthor? user,
    UserActivityAuthor? recipient,
    MediaMin? media,
  }) {
    return UserActivity(
      id: id ?? this.id,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      isLiked: isLiked ?? this.isLiked,
      likeCount: likeCount ?? this.likeCount,
      replyCount: replyCount ?? this.replyCount,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      textHtml: textHtml ?? this.textHtml,
      isPrivate: isPrivate ?? this.isPrivate,
      user: user ?? this.user,
      recipient: recipient ?? this.recipient,
      media: media ?? this.media,
    );
  }
}

/// Paginated response container for user activities.
class UserActivityPage {
  /// Pagination metadata.
  final PageInfo pageInfo;

  /// Chronological list of activities in this page.
  final List<UserActivity> activities;

  /// Creates a paginated user activity result.
  const UserActivityPage({required this.pageInfo, required this.activities});

  /// Creates a [UserActivityPage] from a `GetUserActivitiesResponse` protobuf.
  factory UserActivityPage.fromProto(pb_api.GetUserActivitiesResponse pbObj) {
    return UserActivityPage(
      pageInfo: pbObj.hasPageInfo()
          ? PageInfo.fromProto(pbObj.pageInfo)
          : const PageInfo(hasNextPage: false, currentPage: 1),
      activities: pbObj.activities.map(UserActivity.fromProto).toList(),
    );
  }
}
