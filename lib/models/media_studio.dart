import '../proto/media_studio.pb.dart' as pb;

/// Represents a production studio
class Studio {
  /// Studio ID
  final int id;

  /// Studio name
  final String name;

  /// Creates a studio
  const Studio({required this.id, required this.name});

  /// Creates a studio from a protobuf object
  factory Studio.fromProto(pb.Studio pbObj) {
    return Studio(id: pbObj.id, name: pbObj.name);
  }

  /// Converts the studio to a protobuf object
  pb.Studio toProto() {
    return pb.Studio(id: id, name: name);
  }
}

/// Represents a link between a media and a studio
class StudioEdge {
  /// Whether this is the main studio
  final bool isMain;

  /// The studio
  final Studio node;

  /// Creates a studio edge
  const StudioEdge({required this.isMain, required this.node});

  /// Creates a studio edge from a protobuf object
  factory StudioEdge.fromProto(pb.StudioEdge pbObj) {
    return StudioEdge(isMain: pbObj.isMain, node: Studio.fromProto(pbObj.node));
  }

  /// Converts the studio edge to a protobuf object
  pb.StudioEdge toProto() {
    return pb.StudioEdge(isMain: isMain, node: node.toProto());
  }
}
