import '../proto/media_min.pb.dart' as pbm;
import '../proto/media_studio.pb.dart' as pb;
import 'common.dart';
import 'media_min.dart';

/// Represents a minimal production studio
class StudioMin {
  /// Studio ID
  final int id;

  /// Studio name
  final String name;

  /// Creates a StudioMin
  const StudioMin({required this.id, required this.name});

  /// Creates a StudioMin from a protobuf object
  factory StudioMin.fromProto(pb.StudioMin pbObj) {
    return StudioMin(id: pbObj.id, name: pbObj.name);
  }

  /// Converts the studio to a protobuf object
  pb.StudioMin toProto() {
    return pb.StudioMin(id: id, name: name);
  }
}

/// Represents a link between a media and a studio
class StudioEdge {
  /// Whether this is the main studio
  final bool isMain;

  /// The studio
  final StudioMin node;

  /// Creates a studio edge
  const StudioEdge({required this.isMain, required this.node});

  /// Creates a studio edge from a protobuf object
  factory StudioEdge.fromProto(pb.StudioEdge pbObj) {
    return StudioEdge(
      isMain: pbObj.isMain,
      node: StudioMin.fromProto(pbObj.node),
    );
  }

  /// Converts the studio edge to a protobuf object
  pb.StudioEdge toProto() {
    return pb.StudioEdge(isMain: isMain, node: node.toProto());
  }
}

/// Represents a studio
class Studio {
  /// The studio's ID
  final int id;

  /// The studio's name
  final String name;

  /// The number of favourites the studio has
  final int? favourites;

  /// Whether the studio is a favourite of the user
  final bool? isFavourite;

  /// The studio's media connection
  final StudioMediaConnection? media;

  /// Creates a studio
  const Studio({
    required this.id,
    required this.name,
    required this.favourites,
    required this.isFavourite,
    required this.media,
  });

  /// Creates a studio from a protobuf object
  factory Studio.fromProto(pb.Studio pbObj) {
    return Studio(
      id: pbObj.id,
      name: pbObj.name,
      favourites: pbObj.hasFavourites() ? pbObj.favourites : null,
      isFavourite: pbObj.hasIsFavourite() ? pbObj.isFavourite : null,
      media: pbObj.hasMedia()
          ? StudioMediaConnection.fromProto(pbObj.media)
          : null,
    );
  }

  /// Converts the studio to a protobuf object
  pb.Studio toProto() {
    return pb.Studio(
      id: id,
      name: name,
      favourites: favourites,
      isFavourite: isFavourite,
      media: media?.toProto(),
    );
  }
}

/// Represents a studio's media connection
class StudioMediaConnection {
  /// The page info for the media connection
  final PageInfo pageInfo;

  /// The list of media nodes
  final List<MediaMin> nodes;

  /// Creates a studio media connection
  const StudioMediaConnection({required this.pageInfo, required this.nodes});

  /// Creates a studio media connection from a protobuf object
  factory StudioMediaConnection.fromProto(pb.StudioMediaConnection pbObj) {
    return StudioMediaConnection(
      pageInfo: PageInfo.fromProto(pbObj.pageInfo),
      nodes: pbObj.nodes.map(MediaMin.fromProto).toList(),
    );
  }

  /// Converts the studio media connection to a protobuf object
  pb.StudioMediaConnection toProto() {
    return pb.StudioMediaConnection(
      pageInfo: pageInfo.toProto(),
      nodes: nodes.map((node) => node.toProto() as pbm.MediaMin).toList(),
    );
  }
}
