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

  /// Creates a staff name from a JSON map
  factory StaffName.fromJson(Map<String, dynamic> json) {
    return StaffName(
      full: json['full']?.toString() ?? '',
      native: json['native']?.toString(),
      userPreferred: json['userPreferred']?.toString(),
    );
  }

  /// Converts the staff name to a JSON map
  Map<String, dynamic> toJson() {
    return {'full': full, 'native': native, 'userPreferred': userPreferred};
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

  /// Creates a staff image from a JSON map
  factory StaffImage.fromJson(Map<String, dynamic> json) {
    return StaffImage(
      large: json['large']?.toString(),
      medium: json['medium']?.toString(),
    );
  }

  /// Converts the staff image to a JSON map
  Map<String, dynamic> toJson() {
    return {'large': large, 'medium': medium};
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

  /// Creates a staff member from a JSON map
  factory Staff.fromJson(Map<String, dynamic> json) {
    final nameData = json['name'] as Map?;
    final imageData = json['image'] as Map?;
    return Staff(
      name: nameData != null
          ? StaffName.fromJson(Map<String, dynamic>.from(nameData))
          : null,
      image: imageData != null
          ? StaffImage.fromJson(Map<String, dynamic>.from(imageData))
          : null,
      languageV2: json['languageV2']?.toString(),
    );
  }

  /// Converts the staff member to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'name': name?.toJson(),
      'image': image?.toJson(),
      'languageV2': languageV2,
    };
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

  /// Creates a staff edge from a JSON map
  factory StaffEdge.fromJson(Map<String, dynamic> json) {
    final nodeData = json['node'] as Map?;
    return StaffEdge(
      role: json['role']?.toString() ?? '',
      node: nodeData != null
          ? Staff.fromJson(Map<String, dynamic>.from(nodeData))
          : null,
    );
  }

  /// Converts the staff edge to a JSON map
  Map<String, dynamic> toJson() {
    return {'role': role, 'node': node?.toJson()};
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

  /// Creates a staff connection from a JSON map
  factory StaffConnection.fromJson(Map<String, dynamic> json) {
    final edgesList = json['edges'] as List?;
    final pageInfoData = json['pageInfo'] as Map?;
    return StaffConnection(
      edges: edgesList != null
          ? List<StaffEdge>.from(
              edgesList.map(
                (e) => StaffEdge.fromJson(Map<String, dynamic>.from(e as Map)),
              ),
            )
          : const [],
      pageInfo: PageInfo.fromJson(
        pageInfoData != null
            ? Map<String, dynamic>.from(pageInfoData)
            : const {},
      ),
    );
  }

  /// Converts the staff connection to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'edges': edges.map((e) => e.toJson()).toList(),
      'pageInfo': pageInfo.toJson(),
    };
  }
}
