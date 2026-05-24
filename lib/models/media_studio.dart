/// Represents a production studio
class Studio {
  /// Studio ID
  final int id;

  /// Studio name
  final String name;

  /// Creates a studio
  const Studio({required this.id, required this.name});

  /// Creates a studio from a JSON map
  factory Studio.fromJson(Map<String, dynamic> json) {
    return Studio(
      id: json['id'] as int? ?? 0,
      name: json['name']?.toString() ?? '',
    );
  }

  /// Converts the studio to a JSON map
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
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

  /// Creates a studio edge from a JSON map
  factory StudioEdge.fromJson(Map<String, dynamic> json) {
    final nodeData = json['node'] as Map?;
    return StudioEdge(
      isMain: json['isMain'] as bool? ?? false,
      node: Studio.fromJson(
        nodeData != null ? Map<String, dynamic>.from(nodeData) : const {},
      ),
    );
  }

  /// Converts the studio edge to a JSON map
  Map<String, dynamic> toJson() {
    return {'isMain': isMain, 'node': node.toJson()};
  }
}
