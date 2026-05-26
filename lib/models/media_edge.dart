import '../proto/media_edge.pb.dart' as pb;
import '../proto/media_min.pb.dart' as pbm;
import 'media_min.dart';

/// Represents a link between two media
class MediaEdge {
  /// Relation type
  final String relationType;

  /// The related media
  final MediaMin? node;

  /// Creates a media edge
  const MediaEdge({required this.relationType, this.node});

  /// Creates a media edge from a protobuf object
  factory MediaEdge.fromProto(pb.MediaEdge pbObj) {
    return MediaEdge(
      relationType: pbObj.relationType,
      node: pbObj.hasNode() ? MediaMin.fromProto(pbObj.node) : null,
    );
  }

  /// Converts the media edge to a protobuf object
  pb.MediaEdge toProto() {
    return pb.MediaEdge(
      relationType: relationType,
      node: node?.toProto() as pbm.MediaMin,
    );
  }
}

/// Represents a paginated list of media relations
class MediaConnection {
  /// Relation edges
  final List<MediaEdge> edges;

  /// Creates a media connection
  const MediaConnection({required this.edges});

  /// Creates a media connection from a protobuf object
  factory MediaConnection.fromProto(pb.MediaConnection pbObj) {
    return MediaConnection(
      edges: pbObj.edges.map(MediaEdge.fromProto).toList(),
    );
  }

  /// Converts the media connection to a protobuf object
  pb.MediaConnection toProto() {
    return pb.MediaConnection(edges: edges.map((e) => e.toProto()).toList());
  }
}
