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

  /// Creates a recommendation from a JSON map
  factory Recommendation.fromJson(Map<String, dynamic> json) {
    final mediaRecData = json['mediaRecommendation'] as Map?;
    return Recommendation(
      rating: json['rating'] as int? ?? 0,
      mediaRecommendation: mediaRecData != null
          ? MediaMin.fromJson(Map<String, dynamic>.from(mediaRecData))
          : null,
    );
  }

  /// Converts the recommendation to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'mediaRecommendation': mediaRecommendation?.toJson(),
    };
  }
}

/// Represents a recommendation edge
class RecommendationEdge {
  /// The recommendation
  final Recommendation node;

  /// Creates a recommendation edge
  const RecommendationEdge({required this.node});

  /// Creates a recommendation edge from a JSON map
  factory RecommendationEdge.fromJson(Map<String, dynamic> json) {
    final nodeData = json['node'] as Map?;
    return RecommendationEdge(
      node: Recommendation.fromJson(
        nodeData != null ? Map<String, dynamic>.from(nodeData) : const {},
      ),
    );
  }

  /// Converts the recommendation edge to a JSON map
  Map<String, dynamic> toJson() {
    return {'node': node.toJson()};
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

  /// Creates a recommendation connection from a JSON map
  factory RecommendationConnection.fromJson(Map<String, dynamic> json) {
    final pageInfoData = json['pageInfo'] as Map?;
    final edgesList = json['edges'] as List?;
    return RecommendationConnection(
      pageInfo: PageInfo.fromJson(
        pageInfoData != null
            ? Map<String, dynamic>.from(pageInfoData)
            : const {},
      ),
      edges: edgesList != null
          ? List<RecommendationEdge>.from(
              edgesList.map(
                (e) => RecommendationEdge.fromJson(
                  Map<String, dynamic>.from(e as Map),
                ),
              ),
            )
          : const [],
    );
  }

  /// Converts the recommendation connection to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'pageInfo': pageInfo.toJson(),
      'edges': edges.map((e) => e.toJson()).toList(),
    };
  }
}
