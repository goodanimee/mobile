import '../proto/media_activity.pb.dart' as pb;
import 'common.dart';
import 'viewer.dart';

/// Represents a list activity update.
class ListActivity {
  /// The ID of the activity.
  final int id;

  /// The time the activity was created.
  final int createdAt;

  /// Whether the current user liked the activity.
  final bool isLiked;

  /// The number of likes.
  final int likeCount;

  /// The progress made.
  final String progress;

  /// The list item's textual status.
  final String status;

  /// The owner of the activity.
  final Viewer? user;

  /// Creates a list activity node.
  const ListActivity({
    required this.id,
    required this.createdAt,
    required this.isLiked,
    required this.likeCount,
    required this.progress,
    required this.status,
    this.user,
  });

  /// Creates a ListActivity from a protobuf object.
  factory ListActivity.fromProto(pb.ListActivity pbObj) {
    return ListActivity(
      id: pbObj.id,
      createdAt: pbObj.createdAt,
      isLiked: pbObj.isLiked,
      likeCount: pbObj.likeCount,
      progress: pbObj.progress,
      status: pbObj.status,
      user: pbObj.hasUser() ? Viewer.fromProto(pbObj.user) : null,
    );
  }

  /// Creates a copy of this activity with replaced fields.
  ListActivity copyWith({
    int? id,
    int? createdAt,
    bool? isLiked,
    int? likeCount,
    String? progress,
    String? status,
    Viewer? user,
  }) {
    return ListActivity(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      isLiked: isLiked ?? this.isLiked,
      likeCount: likeCount ?? this.likeCount,
      progress: progress ?? this.progress,
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }

  /// Converts this ListActivity to a protobuf object.
  pb.ListActivity toProto() {
    final pbObj = pb.ListActivity(
      id: id,
      createdAt: createdAt,
      isLiked: isLiked,
      likeCount: likeCount,
      progress: progress,
      status: status,
    );
    if (user != null) pbObj.user = user!.toProto();
    return pbObj;
  }
}

/// Represents a paginated list of list activities.
class ListActivityConnection {
  /// Pagination info.
  final PageInfo pageInfo;

  /// List of activities.
  final List<ListActivity> nodes;

  /// Creates a list activity connection.
  const ListActivityConnection({
    required this.pageInfo,
    required this.nodes,
  });
}
