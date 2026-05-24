import '../proto/media_character.pb.dart' as pb;
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

  /// Creates a character name from a protobuf object
  factory CharacterName.fromProto(pb.CharacterName pbObj) {
    return CharacterName(
      full: pbObj.full,
      native: pbObj.hasNative() ? pbObj.native : null,
      userPreferred: pbObj.hasUserPreferred() ? pbObj.userPreferred : null,
      alternative: pbObj.alternative,
      alternativeSpoiler: pbObj.alternativeSpoiler,
    );
  }

  /// Converts the character name to a protobuf object
  pb.CharacterName toProto() {
    final pbObj = pb.CharacterName(
      full: full,
      alternative: alternative,
      alternativeSpoiler: alternativeSpoiler,
    );
    if (native != null) pbObj.native = native!;
    if (userPreferred != null) pbObj.userPreferred = userPreferred!;
    return pbObj;
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

  /// Creates a character image from a protobuf object
  factory CharacterImage.fromProto(pb.CharacterImage pbObj) {
    return CharacterImage(
      large: pbObj.hasLarge() ? pbObj.large : null,
      medium: pbObj.hasMedium() ? pbObj.medium : null,
    );
  }

  /// Converts the character image to a protobuf object
  pb.CharacterImage toProto() {
    final pbObj = pb.CharacterImage();
    if (large != null) pbObj.large = large!;
    if (medium != null) pbObj.medium = medium!;
    return pbObj;
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

  /// Creates a character from a protobuf object
  factory Character.fromProto(pb.Character pbObj) {
    return Character(
      name: pbObj.hasName() ? CharacterName.fromProto(pbObj.name) : null,
      image: pbObj.hasImage() ? CharacterImage.fromProto(pbObj.image) : null,
      gender: pbObj.hasGender() ? pbObj.gender : null,
      age: pbObj.hasAge() ? pbObj.age : null,
      dateOfBirth: pbObj.hasDateOfBirth()
          ? FuzzyDate.fromProto(pbObj.dateOfBirth)
          : null,
      description: pbObj.hasDescription() ? pbObj.description : null,
    );
  }

  /// Converts the character to a protobuf object
  pb.Character toProto() {
    final pbObj = pb.Character();
    if (name != null) pbObj.name = name!.toProto();
    if (image != null) pbObj.image = image!.toProto();
    if (gender != null) pbObj.gender = gender!;
    if (age != null) pbObj.age = age!;
    if (dateOfBirth != null) pbObj.dateOfBirth = dateOfBirth!.toProto();
    if (description != null) pbObj.description = description!;
    return pbObj;
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

  /// Creates a character edge from a protobuf object
  factory CharacterEdge.fromProto(pb.CharacterEdge pbObj) {
    return CharacterEdge(
      id: pbObj.id,
      role: pbObj.role,
      name: pbObj.name,
      node: pbObj.hasNode() ? Character.fromProto(pbObj.node) : null,
      voiceActors: pbObj.voiceActors.map((v) => Staff.fromProto(v)).toList(),
    );
  }

  /// Converts the character edge to a protobuf object
  pb.CharacterEdge toProto() {
    return pb.CharacterEdge(
      id: id,
      role: role,
      name: name,
      node: node?.toProto(),
      voiceActors: voiceActors.map((v) => v.toProto()).toList(),
    );
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

  /// Creates a character connection from a protobuf object
  factory CharacterConnection.fromProto(pb.CharacterConnection pbObj) {
    return CharacterConnection(
      edges: pbObj.edges.map((e) => CharacterEdge.fromProto(e)).toList(),
      pageInfo: PageInfo.fromProto(pbObj.pageInfo),
    );
  }

  /// Converts the character connection to a protobuf object
  pb.CharacterConnection toProto() {
    return pb.CharacterConnection(
      edges: edges.map((e) => e.toProto()).toList(),
      pageInfo: pageInfo.toProto(),
    );
  }
}
