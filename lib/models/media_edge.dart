import 'media_min.dart';

/// Represents a link between two media
class MediaEdge {
  /// Relation type
  final String relationType;

  /// The related media
  final MediaMin? node;

  /// Creates a media edge
  const MediaEdge({required this.relationType, this.node});

  /// Creates a media edge from a JSON map
  factory MediaEdge.fromJson(Map<String, dynamic> json) {
    final nodeData = json['node'] as Map?;
    return MediaEdge(
      relationType: json['relationType']?.toString() ?? '',
      node: nodeData != null
          ? MediaMin.fromJson(Map<String, dynamic>.from(nodeData))
          : null,
    );
  }

  /// Converts the media edge to a JSON map
  Map<String, dynamic> toJson() {
    return {'relationType': relationType, 'node': node?.toJson()};
  }
}

/// Represents a paginated list of media relations
class MediaConnection {
  /// Relation edges
  final List<MediaEdge> edges;

  /// Creates a media connection
  const MediaConnection({required this.edges});

  /// Creates a media connection from a JSON map
  factory MediaConnection.fromJson(Map<String, dynamic> json) {
    final edgesList = json['edges'] as List?;
    return MediaConnection(
      edges: edgesList != null
          ? List<MediaEdge>.from(
              edgesList.map(
                (e) => MediaEdge.fromJson(Map<String, dynamic>.from(e as Map)),
              ),
            )
          : const [],
    );
  }

  /// Converts the media connection to a JSON map
  Map<String, dynamic> toJson() {
    return {'edges': edges.map((e) => e.toJson()).toList()};
  }
}
