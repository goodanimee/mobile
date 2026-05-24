import '../proto/media_recommendation.pb.dart' as pb;
import '../proto/media_min.pb.dart' as pbm;
import 'common.dart';
import 'media_min.dart';

/// Represents a recommended media
class Recommendation {
  /// Recommendation rating
  final int rating;

  /// The recommended media
  final MediaMin? mediaRecommendation;

  /// Creates a recommendation
  const Recommendation({required this.rating, this.mediaRecommendation});

  /// Creates a recommendation from a protobuf object
  factory Recommendation.fromProto(pb.Recommendation pbObj) {
    return Recommendation(
      rating: pbObj.rating,
      mediaRecommendation: pbObj.hasMediaRecommendation()
          ? MediaMin.fromProto(pbObj.mediaRecommendation)
          : null,
    );
  }

  /// Converts the recommendation to a protobuf object
  pb.Recommendation toProto() {
    final pbObj = pb.Recommendation(rating: rating);
    if (mediaRecommendation != null) {
      pbObj.mediaRecommendation =
          mediaRecommendation!.toProto() as pbm.MediaMin;
    }
    return pbObj;
  }
}

/// Represents a recommendation edge
class RecommendationEdge {
  /// The recommendation
  final Recommendation node;

  /// Creates a recommendation edge
  const RecommendationEdge({required this.node});

  /// Creates a recommendation edge from a protobuf object
  factory RecommendationEdge.fromProto(pb.RecommendationEdge pbObj) {
    return RecommendationEdge(node: Recommendation.fromProto(pbObj.node));
  }

  /// Converts the recommendation edge to a protobuf object
  pb.RecommendationEdge toProto() {
    return pb.RecommendationEdge(node: node.toProto());
  }
}

/// Represents a paginated list of recommendations
class RecommendationConnection {
  /// Pagination info
  final PageInfo pageInfo;

  /// Recommendation edges
  final List<RecommendationEdge> edges;

  /// Creates a recommendation connection
  const RecommendationConnection({required this.pageInfo, required this.edges});

  /// Creates a recommendation connection from a protobuf object
  factory RecommendationConnection.fromProto(
    pb.RecommendationConnection pbObj,
  ) {
    return RecommendationConnection(
      pageInfo: PageInfo.fromProto(pbObj.pageInfo),
      edges: pbObj.edges.map((e) => RecommendationEdge.fromProto(e)).toList(),
    );
  }

  /// Converts the recommendation connection to a protobuf object
  pb.RecommendationConnection toProto() {
    return pb.RecommendationConnection(
      pageInfo: pageInfo.toProto(),
      edges: edges.map((e) => e.toProto()).toList(),
    );
  }
}
