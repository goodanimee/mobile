import 'common.dart';
import 'media_staff.dart';

/// Represents the names of a character
class CharacterName {
  /// Full name
  final String full;

  /// Native name
  final String? native;

  /// User preferred name
  final String? userPreferred;

  /// Alternative names
  final List<String> alternative;

  /// Alternative spoiler names
  final List<String> alternativeSpoiler;

  /// Creates a character name
  const CharacterName({
    required this.full,
    this.native,
    this.userPreferred,
    required this.alternative,
    required this.alternativeSpoiler,
  });

  /// Creates a character name from a JSON map
  factory CharacterName.fromJson(Map<String, dynamic> json) {
    return CharacterName(
      full: json['full']?.toString() ?? '',
      native: json['native']?.toString(),
      userPreferred: json['userPreferred']?.toString(),
      alternative: (json['alternative'] as List?)?.cast<String>() ?? [],
      alternativeSpoiler:
          (json['alternativeSpoiler'] as List?)?.cast<String>() ?? [],
    );
  }

  /// Converts the character name to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'full': full,
      'native': native,
      'userPreferred': userPreferred,
      'alternative': alternative,
      'alternativeSpoiler': alternativeSpoiler,
    };
  }
}

/// Represents the images of a character
class CharacterImage {
  /// Large image URL
  final String? large;

  /// Medium image URL
  final String? medium;

  /// Creates a character image
  const CharacterImage({this.large, this.medium});

  /// Creates a character image from a JSON map
  factory CharacterImage.fromJson(Map<String, dynamic> json) {
    return CharacterImage(
      large: json['large']?.toString(),
      medium: json['medium']?.toString(),
    );
  }

  /// Converts the character image to a JSON map
  Map<String, dynamic> toJson() {
    return {'large': large, 'medium': medium};
  }
}

/// Represents a character in a media
class Character {
  /// Character name
  final CharacterName? name;

  /// Character image
  final CharacterImage? image;

  /// Character gender
  final String? gender;

  /// Character age
  final String? age;

  /// Character date of birth
  final FuzzyDate? dateOfBirth;

  /// Character description
  final String? description;

  /// Creates a character
  const Character({
    this.name,
    this.image,
    this.gender,
    this.age,
    this.dateOfBirth,
    this.description,
  });

  /// Creates a character from a JSON map
  factory Character.fromJson(Map<String, dynamic> json) {
    final nameData = json['name'] as Map?;
    final imageData = json['image'] as Map?;
    final dobData = json['dateOfBirth'] as Map?;
    return Character(
      name: nameData != null
          ? CharacterName.fromJson(Map<String, dynamic>.from(nameData))
          : null,
      image: imageData != null
          ? CharacterImage.fromJson(Map<String, dynamic>.from(imageData))
          : null,
      gender: json['gender']?.toString(),
      age: json['age']?.toString(),
      dateOfBirth: dobData != null
          ? FuzzyDate.fromJson(Map<String, dynamic>.from(dobData))
          : null,
      description: json['description']?.toString(),
    );
  }

  /// Converts the character to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'name': name?.toJson(),
      'image': image?.toJson(),
      'gender': gender,
      'age': age,
      'dateOfBirth': dateOfBirth?.toJson(),
      'description': description,
    };
  }
}

/// Represents a link between a media and a character
class CharacterEdge {
  /// Connection ID
  final int id;

  /// Character role
  final String role;

  /// Character name
  final String name;

  /// The character
  final Character? node;

  /// The voice actors of the character
  final List<Staff> voiceActors;

  /// Creates a character edge
  const CharacterEdge({
    required this.id,
    required this.role,
    required this.name,
    this.node,
    required this.voiceActors,
  });

  /// Creates a character edge from a JSON map
  factory CharacterEdge.fromJson(Map<String, dynamic> json) {
    final nodeData = json['node'] as Map?;
    final vaList = json['voiceActors'] as List?;
    return CharacterEdge(
      id: json['id'] as int? ?? 0,
      role: json['role']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      node: nodeData != null
          ? Character.fromJson(Map<String, dynamic>.from(nodeData))
          : null,
      voiceActors: vaList != null
          ? List<Staff>.from(
              vaList.map(
                (v) => Staff.fromJson(Map<String, dynamic>.from(v as Map)),
              ),
            )
          : const [],
    );
  }

  /// Converts the character edge to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role': role,
      'name': name,
      'node': node?.toJson(),
      'voiceActors': voiceActors.map((v) => v.toJson()).toList(),
    };
  }
}

/// Represents a paginated list of characters
class CharacterConnection {
  /// Character edges
  final List<CharacterEdge> edges;

  /// Pagination info
  final PageInfo pageInfo;

  /// Creates a character connection
  const CharacterConnection({required this.edges, required this.pageInfo});

  /// Creates a character connection from a JSON map
  factory CharacterConnection.fromJson(Map<String, dynamic> json) {
    final edgesList = json['edges'] as List?;
    final pageInfoData = json['pageInfo'] as Map?;
    return CharacterConnection(
      edges: edgesList != null
          ? List<CharacterEdge>.from(
              edgesList.map(
                (e) =>
                    CharacterEdge.fromJson(Map<String, dynamic>.from(e as Map)),
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

  /// Converts the character connection to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'edges': edges.map((e) => e.toJson()).toList(),
      'pageInfo': pageInfo.toJson(),
    };
  }
}
