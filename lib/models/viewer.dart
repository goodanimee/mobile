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

  /// Creates a viewer from a JSON map
  factory Viewer.fromJson(Map<String, dynamic> json) {
    return Viewer(
      id: json['id'] as int,
      name: json['name'] as String,
      avatarMedium:
          (json['avatar'] as Map<String, dynamic>)['medium'] as String,
      createdAt: json['createdAt'] as int,
    );
  }

  /// Converts the viewer to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatar': {
        'medium': avatarMedium,
      },
      'createdAt': createdAt,
    };
  }
}
