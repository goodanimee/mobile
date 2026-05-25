import '../proto/media_staff.pb.dart' as pb;
import 'common.dart';

/// Represents the names of a staff member
class StaffName {
  /// Full name
  final String full;

  /// Native name
  final String? native;

  /// User preferred name
  final String? userPreferred;

  /// Creates a staff name
  const StaffName({required this.full, this.native, this.userPreferred});

  /// Creates a staff name from a protobuf object
  factory StaffName.fromProto(pb.StaffName pbObj) {
    return StaffName(
      full: pbObj.full,
      native: pbObj.hasNative() ? pbObj.native : null,
      userPreferred: pbObj.hasUserPreferred() ? pbObj.userPreferred : null,
    );
  }

  /// Converts the staff name to a protobuf object
  pb.StaffName toProto() {
    final pbObj = pb.StaffName(full: full);
    if (native != null) pbObj.native = native!;
    if (userPreferred != null) pbObj.userPreferred = userPreferred!;
    return pbObj;
  }
}

/// Represents the images of a staff member
class StaffImage {
  /// Large image URL
  final String? large;

  /// Medium image URL
  final String? medium;

  /// Creates a staff image
  const StaffImage({this.large, this.medium});

  /// Creates a staff image from a protobuf object
  factory StaffImage.fromProto(pb.StaffImage pbObj) {
    return StaffImage(
      large: pbObj.hasLarge() ? pbObj.large : null,
      medium: pbObj.hasMedium() ? pbObj.medium : null,
    );
  }

  /// Converts the staff image to a protobuf object
  pb.StaffImage toProto() {
    final pbObj = pb.StaffImage();
    if (large != null) pbObj.large = large!;
    if (medium != null) pbObj.medium = medium!;
    return pbObj;
  }
}

/// Represents a staff member
class Staff {
  /// Staff name
  final StaffName? name;

  /// Staff image
  final StaffImage? image;

  /// Primary language
  final String? languageV2;

  /// Creates a staff member
  const Staff({this.name, this.image, this.languageV2});

  /// Creates a staff member from a protobuf object
  factory Staff.fromProto(pb.Staff pbObj) {
    return Staff(
      name: pbObj.hasName() ? StaffName.fromProto(pbObj.name) : null,
      image: pbObj.hasImage() ? StaffImage.fromProto(pbObj.image) : null,
      languageV2: pbObj.hasLanguageV2() ? pbObj.languageV2 : null,
    );
  }

  /// Converts the staff member to a protobuf object
  pb.Staff toProto() {
    final pbObj = pb.Staff();
    if (name != null) pbObj.name = name!.toProto();
    if (image != null) pbObj.image = image!.toProto();
    if (languageV2 != null) pbObj.languageV2 = languageV2!;
    return pbObj;
  }
}

/// Represents a link between a media and a staff member
class StaffEdge {
  /// Staff role
  final String role;

  /// The staff member
  final Staff? node;

  /// Creates a staff edge
  const StaffEdge({required this.role, this.node});

  /// Creates a staff edge from a protobuf object
  factory StaffEdge.fromProto(pb.StaffEdge pbObj) {
    return StaffEdge(
      role: pbObj.role,
      node: pbObj.hasNode() ? Staff.fromProto(pbObj.node) : null,
    );
  }

  /// Converts the staff edge to a protobuf object
  pb.StaffEdge toProto() {
    return pb.StaffEdge(role: role, node: node?.toProto());
  }
}

/// Represents a paginated list of staff
class StaffConnection {
  /// Staff edges
  final List<StaffEdge> edges;

  /// Pagination info
  final PageInfo pageInfo;

  /// Creates a staff connection
  const StaffConnection({required this.edges, required this.pageInfo});

  /// Creates a staff connection from a protobuf object
  factory StaffConnection.fromProto(pb.StaffConnection pbObj) {
    return StaffConnection(
      edges: pbObj.edges.map((e) => StaffEdge.fromProto(e)).toList(),
      pageInfo: PageInfo.fromProto(pbObj.pageInfo),
    );
  }

  /// Converts the staff connection to a protobuf object
  pb.StaffConnection toProto() {
    return pb.StaffConnection(
      edges: edges.map((e) => e.toProto()).toList(),
      pageInfo: pageInfo.toProto(),
    );
  }
}
