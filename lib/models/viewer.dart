import '../proto/viewer.pb.dart' as pb;

/// Represents a user on the platform
class Viewer {
  /// User ID
  final int id;

  /// Display name
  final String name;

  /// Medium-sized avatar URL
  final String avatarMedium;

  /// Account creation timestamp
  final int createdAt;

  /// Creates a viewer
  const Viewer({
    required this.id,
    required this.name,
    required this.avatarMedium,
    required this.createdAt,
  });

  /// Creates a viewer from a protobuf object
  factory Viewer.fromProto(pb.Viewer pbObj) {
    return Viewer(
      id: pbObj.id,
      name: pbObj.name,
      avatarMedium: pbObj.hasAvatar() ? pbObj.avatar.medium : '',
      createdAt: pbObj.createdAt,
    );
  }

  /// Converts the viewer to a protobuf object
  pb.Viewer toProto() {
    final pbObj = pb.Viewer(id: id, name: name, createdAt: createdAt);
    if (avatarMedium.isNotEmpty) {
      final avatarPb = pb.ViewerAvatar(medium: avatarMedium);
      pbObj.avatar = avatarPb;
    }
    return pbObj;
  }
}
