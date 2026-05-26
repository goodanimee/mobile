import '../proto/media_review.pb.dart' as pb;
import 'common.dart';
import 'viewer.dart';

/// User rating enum for a review
enum ReviewUserRating {
  /// No vote cast
  noVote,

  /// Upvoted review
  upVote,

  /// Downvoted review
  downVote,
}

/// Represents a media review
class ReviewNode {
  /// Review ID
  final int id;

  /// Score given to the anime
  final int score;

  /// Upvote count
  final int rating;

  /// Total vote count
  final int ratingAmount;

  /// Summary of the review
  final String summary;

  /// Rating vote cast by the current user
  final ReviewUserRating userRating;

  /// Author of the review
  final Viewer? user;

  /// Body HTML text
  final String body;

  /// Creates a review node
  const ReviewNode({
    required this.id,
    required this.score,
    required this.rating,
    required this.ratingAmount,
    required this.summary,
    required this.userRating,
    this.user,
    required this.body,
  });

  /// Creates a review node from a protobuf object
  factory ReviewNode.fromProto(pb.ReviewNode pbObj) {
    return ReviewNode(
      id: pbObj.id,
      score: pbObj.score,
      rating: pbObj.rating,
      ratingAmount: pbObj.ratingAmount,
      summary: pbObj.summary,
      userRating: _mapUserRating(pbObj.userRating),
      user: pbObj.hasUser() ? Viewer.fromProto(pbObj.user) : null,
      body: pbObj.body,
    );
  }

  /// Converts the review node to a protobuf object
  pb.ReviewNode toProto() {
    final pbObj = pb.ReviewNode(
      id: id,
      score: score,
      rating: rating,
      ratingAmount: ratingAmount,
      summary: summary,
      userRating: _mapUserRatingToProto(userRating),
      body: body,
    );
    if (user != null) pbObj.user = user!.toProto();
    return pbObj;
  }

  /// Creates a copy of this review node with the given fields replaced.
  ReviewNode copyWith({
    int? id,
    int? score,
    int? rating,
    int? ratingAmount,
    String? summary,
    ReviewUserRating? userRating,
    Viewer? user,
    String? body,
  }) {
    return ReviewNode(
      id: id ?? this.id,
      score: score ?? this.score,
      rating: rating ?? this.rating,
      ratingAmount: ratingAmount ?? this.ratingAmount,
      summary: summary ?? this.summary,
      userRating: userRating ?? this.userRating,
      user: user ?? this.user,
      body: body ?? this.body,
    );
  }

  static ReviewUserRating _mapUserRating(pb.ReviewUserRating rating) {
    switch (rating) {
      case pb.ReviewUserRating.REVIEW_USER_RATING_UP_VOTE:
        return ReviewUserRating.upVote;
      case pb.ReviewUserRating.REVIEW_USER_RATING_DOWN_VOTE:
        return ReviewUserRating.downVote;
      case pb.ReviewUserRating.REVIEW_USER_RATING_NO_VOTE_UNSPECIFIED:
      default:
        return ReviewUserRating.noVote;
    }
  }

  static pb.ReviewUserRating _mapUserRatingToProto(ReviewUserRating rating) {
    switch (rating) {
      case ReviewUserRating.upVote:
        return pb.ReviewUserRating.REVIEW_USER_RATING_UP_VOTE;
      case ReviewUserRating.downVote:
        return pb.ReviewUserRating.REVIEW_USER_RATING_DOWN_VOTE;
      default:
        return pb.ReviewUserRating.REVIEW_USER_RATING_NO_VOTE_UNSPECIFIED;
    }
  }
}

/// Represents a paginated list of reviews
class ReviewConnection {
  /// Pagination info
  final PageInfo pageInfo;

  /// Review nodes
  final List<ReviewNode> nodes;

  /// Creates a review connection
  const ReviewConnection({required this.pageInfo, required this.nodes});

  /// Creates a review connection from a protobuf object
  factory ReviewConnection.fromProto(pb.ReviewConnection pbObj) {
    return ReviewConnection(
      pageInfo: PageInfo.fromProto(pbObj.pageInfo),
      nodes: pbObj.nodes.map(ReviewNode.fromProto).toList(),
    );
  }

  /// Converts the review connection to a protobuf object
  pb.ReviewConnection toProto() {
    return pb.ReviewConnection(
      pageInfo: pageInfo.toProto(),
      nodes: nodes.map((n) => n.toProto()).toList(),
    );
  }
}
