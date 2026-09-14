import '../proto/media_character.pb.dart' as pb;
import '../proto/media_min.pb.dart' as pbm;
import 'common.dart';
import 'media_min.dart';
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

/// Represents minimal character information
class CharacterMin {
  /// Character ID
  final int id;

  /// Character name
  final CharacterName? name;

  /// Character image
  final CharacterImage? image;

  /// Creates a minimal character
  const CharacterMin({required this.id, this.name, this.image});

  /// Creates a minimal character from a protobuf object
  factory CharacterMin.fromProto(pb.CharacterMin pbObj) {
    return CharacterMin(
      id: pbObj.id,
      name: pbObj.hasName() ? CharacterName.fromProto(pbObj.name) : null,
      image: pbObj.hasImage() ? CharacterImage.fromProto(pbObj.image) : null,
    );
  }

  /// Converts the minimal character to a protobuf object
  pb.CharacterMin toProto() {
    final pbObj = pb.CharacterMin(id: id);
    if (name != null) pbObj.name = name!.toProto();
    if (image != null) pbObj.image = image!.toProto();
    return pbObj;
  }
}

/// Represents a media appearance for a character
class CharacterMediaEdge {
  /// Character role in media
  final String? characterRole;

  /// The media item
  final MediaMin? node;

  /// Associated voice actors
  final List<StaffMin> voiceActors;

  /// Creates a character media edge
  const CharacterMediaEdge({
    this.characterRole,
    this.node,
    required this.voiceActors,
  });

  /// Creates a character media edge from a protobuf object
  factory CharacterMediaEdge.fromProto(pb.CharacterMediaEdge pbObj) {
    return CharacterMediaEdge(
      characterRole: pbObj.hasCharacterRole() ? pbObj.characterRole : null,
      node: pbObj.hasNode() ? MediaMin.fromProto(pbObj.node) : null,
      voiceActors: pbObj.voiceActors.map(StaffMin.fromProto).toList(),
    );
  }

  /// Converts the character media edge to a protobuf object
  pb.CharacterMediaEdge toProto() {
    final pbObj = pb.CharacterMediaEdge(
      voiceActors: voiceActors.map((v) => v.toProto()),
    );
    if (characterRole != null) pbObj.characterRole = characterRole!;
    if (node != null) pbObj.node = node!.toProto() as pbm.MediaMin;
    return pbObj;
  }
}

/// Represents a paginated list of media appearances for a character
class CharacterMediaConnection {
  /// Media appearance edges
  final List<CharacterMediaEdge> edges;

  /// Pagination information
  final PageInfo pageInfo;

  /// Creates a character media connection
  const CharacterMediaConnection({required this.edges, required this.pageInfo});

  /// Creates a character media connection from a protobuf object
  factory CharacterMediaConnection.fromProto(
    pb.CharacterMediaConnection pbObj,
  ) {
    return CharacterMediaConnection(
      edges: pbObj.edges.map(CharacterMediaEdge.fromProto).toList(),
      pageInfo: PageInfo.fromProto(pbObj.pageInfo),
    );
  }

  /// Converts the character media connection to a protobuf object
  pb.CharacterMediaConnection toProto() {
    return pb.CharacterMediaConnection(
      edges: edges.map((e) => e.toProto()),
      pageInfo: pageInfo.toProto(),
    );
  }
}

/// Represents detailed character information
class Character {
  /// Character ID
  final int? id;

  /// Character name
  final CharacterName? name;

  /// Character image
  final CharacterImage? image;

  /// Character gender
  final String? gender;

  /// Character age
  final String? age;

  /// Character blood type
  final String? bloodType;

  /// Character date of birth
  final FuzzyDate? dateOfBirth;

  /// Character description
  final String? description;

  /// Whether the character is a favourite
  final bool? isFavourite;

  /// Site URL
  final String? siteUrl;

  /// Number of favourites
  final int? favourites;

  /// Whether favorite toggling is blocked
  final bool? isFavouriteBlocked;

  /// Media appearances
  final CharacterMediaConnection? media;

  /// Creates a character
  const Character({
    this.id,
    this.name,
    this.image,
    this.gender,
    this.age,
    this.bloodType,
    this.dateOfBirth,
    this.description,
    this.isFavourite,
    this.siteUrl,
    this.favourites,
    this.isFavouriteBlocked,
    this.media,
  });

  /// Creates a copy of this object with the given fields replaced
  Character copyWith({
    int? id,
    CharacterName? name,
    CharacterImage? image,
    String? gender,
    String? age,
    String? bloodType,
    FuzzyDate? dateOfBirth,
    String? description,
    bool? isFavourite,
    String? siteUrl,
    int? favourites,
    bool? isFavouriteBlocked,
    CharacterMediaConnection? media,
  }) {
    return Character(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      bloodType: bloodType ?? this.bloodType,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      description: description ?? this.description,
      isFavourite: isFavourite ?? this.isFavourite,
      siteUrl: siteUrl ?? this.siteUrl,
      favourites: favourites ?? this.favourites,
      isFavouriteBlocked: isFavouriteBlocked ?? this.isFavouriteBlocked,
      media: media ?? this.media,
    );
  }

  /// Creates a character from a protobuf object
  factory Character.fromProto(pb.Character pbObj) {
    return Character(
      id: pbObj.hasId() ? pbObj.id : null,
      name: pbObj.hasName() ? CharacterName.fromProto(pbObj.name) : null,
      image: pbObj.hasImage() ? CharacterImage.fromProto(pbObj.image) : null,
      gender: pbObj.hasGender() ? pbObj.gender : null,
      age: pbObj.hasAge() ? pbObj.age : null,
      bloodType: pbObj.hasBloodType() ? pbObj.bloodType : null,
      dateOfBirth: pbObj.hasDateOfBirth()
          ? FuzzyDate.fromProto(pbObj.dateOfBirth)
          : null,
      description: pbObj.hasDescription() ? pbObj.description : null,
      isFavourite: pbObj.hasIsFavourite() ? pbObj.isFavourite : null,
      siteUrl: pbObj.hasSiteUrl() ? pbObj.siteUrl : null,
      favourites: pbObj.hasFavourites() ? pbObj.favourites : null,
      isFavouriteBlocked: pbObj.hasIsFavouriteBlocked()
          ? pbObj.isFavouriteBlocked
          : null,
      media: pbObj.hasMedia()
          ? CharacterMediaConnection.fromProto(pbObj.media)
          : null,
    );
  }

  /// Converts the character to a protobuf object
  pb.Character toProto() {
    final pbObj = pb.Character();
    if (id != null) pbObj.id = id!;
    if (name != null) pbObj.name = name!.toProto();
    if (image != null) pbObj.image = image!.toProto();
    if (gender != null) pbObj.gender = gender!;
    if (age != null) pbObj.age = age!;
    if (bloodType != null) pbObj.bloodType = bloodType!;
    if (dateOfBirth != null) pbObj.dateOfBirth = dateOfBirth!.toProto();
    if (description != null) pbObj.description = description!;
    if (isFavourite != null) pbObj.isFavourite = isFavourite!;
    if (siteUrl != null) pbObj.siteUrl = siteUrl!;
    if (favourites != null) pbObj.favourites = favourites!;
    if (isFavouriteBlocked != null) {
      pbObj.isFavouriteBlocked = isFavouriteBlocked!;
    }
    if (media != null) pbObj.media = media!.toProto();
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
  final CharacterMin? node;

  /// Creates a character edge
  const CharacterEdge({
    required this.id,
    required this.role,
    required this.name,
    this.node,
  });

  /// Creates a character edge from a protobuf object
  factory CharacterEdge.fromProto(pb.CharacterEdge pbObj) {
    return CharacterEdge(
      id: pbObj.id,
      role: pbObj.role,
      name: pbObj.name,
      node: pbObj.hasNode() ? CharacterMin.fromProto(pbObj.node) : null,
    );
  }

  /// Converts the character edge to a protobuf object
  pb.CharacterEdge toProto() {
    final pbObj = pb.CharacterEdge(id: id, role: role, name: name);
    if (node != null) pbObj.node = node!.toProto();
    return pbObj;
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
      edges: pbObj.edges.map(CharacterEdge.fromProto).toList(),
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
