import '../proto/api.pb.dart' as pb_api;
import '../proto/user.pb.dart' as pb;
import 'common.dart';
import 'user_activity.dart';

/// Represents a single reply left on an activity.
class ActivityReply {
  /// Unique ID of the reply.
  final int id;

  /// User ID of the reply author.
  final int userId;

  /// ID of the parent activity.
  final int activityId;

  /// Rendered text body (HTML format).
  final String text;

  /// Creation timestamp in epoch seconds.
  final int createdAt;

  /// Total number of likes on this reply.
  final int likeCount;

  /// Whether the current authenticated viewer liked this reply.
  final bool isLiked;

  /// Author of the reply.
  final UserActivityAuthor? user;

  /// Creates an activity reply.
  const ActivityReply({
    required this.id,
    required this.userId,
    required this.activityId,
    required this.text,
    this.createdAt = 0,
    this.likeCount = 0,
    this.isLiked = false,
    this.user,
  });

  /// Returns a copy with [isLiked] flipped and [likeCount] adjusted safely.
  ActivityReply toggleLikeOptimistic() {
    final nextLiked = !isLiked;
    final nextCount = nextLiked
        ? likeCount + 1
        : (likeCount > 0 ? likeCount - 1 : 0);
    return copyWith(isLiked: nextLiked, likeCount: nextCount);
  }

  /// Creates an [ActivityReply] from its protobuf representation.
  factory ActivityReply.fromProto(pb.ActivityReply pbObj) {
    return ActivityReply(
      id: pbObj.id,
      userId: pbObj.userId,
      activityId: pbObj.activityId,
      text: pbObj.text,
      createdAt: pbObj.createdAt,
      likeCount: pbObj.likeCount,
      isLiked: pbObj.isLiked,
      user: pbObj.hasUser() ? UserActivityAuthor.fromProto(pbObj.user) : null,
    );
  }

  /// Converts this reply to its protobuf representation.
  pb.ActivityReply toProto() {
    final pbObj = pb.ActivityReply(
      id: id,
      userId: userId,
      activityId: activityId,
      text: text,
      createdAt: createdAt,
      likeCount: likeCount,
      isLiked: isLiked,
    );
    if (user != null) {
      pbObj.user = user!.toProto();
    }
    return pbObj;
  }

  /// Creates a copy with updated fields.
  ActivityReply copyWith({
    int? id,
    int? userId,
    int? activityId,
    String? text,
    int? createdAt,
    int? likeCount,
    bool? isLiked,
    UserActivityAuthor? user,
  }) {
    return ActivityReply(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      activityId: activityId ?? this.activityId,
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
      likeCount: likeCount ?? this.likeCount,
      isLiked: isLiked ?? this.isLiked,
      user: user ?? this.user,
    );
  }
}

/// Represents a paginated list of activity replies.
class ActivityRepliesPage {
  /// Pagination metadata.
  final PageInfo pageInfo;

  /// Total count of replies available.
  final int total;

  /// Replies in the current page.
  final List<ActivityReply> replies;

  /// Creates an activity replies page.
  const ActivityRepliesPage({
    required this.pageInfo,
    required this.total,
    required this.replies,
  });

  /// Creates an [ActivityRepliesPage] from its protobuf representation.
  factory ActivityRepliesPage.fromProto(
    pb_api.GetActivityRepliesResponse pbObj,
  ) {
    return ActivityRepliesPage(
      pageInfo: pbObj.hasPageInfo()
          ? PageInfo.fromProto(pbObj.pageInfo)
          : const PageInfo(hasNextPage: false, currentPage: 1),
      total: pbObj.total,
      replies: pbObj.replies
          .map(ActivityReply.fromProto)
          .toList(growable: false),
    );
  }
}
