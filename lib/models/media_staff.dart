import '../proto/media_min.pb.dart' as pbm;
import '../proto/media_staff.pb.dart' as pb;
import 'common.dart';
import 'media_min.dart';

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
class StaffMin {
  /// Staff ID
  final int id;

  /// Staff name
  final StaffName? name;

  /// Staff image
  final StaffImage? image;

  /// Primary language
  final String? languageV2;

  /// Creates a staff member
  const StaffMin({required this.id, this.name, this.image, this.languageV2});

  /// Creates a staff member from a protobuf object
  factory StaffMin.fromProto(pb.StaffMin pbObj) {
    return StaffMin(
      id: pbObj.id,
      name: pbObj.hasName() ? StaffName.fromProto(pbObj.name) : null,
      image: pbObj.hasImage() ? StaffImage.fromProto(pbObj.image) : null,
      languageV2: pbObj.hasLanguageV2() ? pbObj.languageV2 : null,
    );
  }

  /// Converts the staff member to a protobuf object
  pb.StaffMin toProto() {
    final pbObj = pb.StaffMin(id: id);
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
  final StaffMin? node;

  /// Creates a staff edge
  const StaffEdge({required this.role, this.node});

  /// Creates a staff edge from a protobuf object
  factory StaffEdge.fromProto(pb.StaffEdge pbObj) {
    return StaffEdge(
      role: pbObj.role,
      node: pbObj.hasNode() ? StaffMin.fromProto(pbObj.node) : null,
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
      edges: pbObj.edges.map(StaffEdge.fromProto).toList(),
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

/// Represents a simplified character name
class StaffCharacterName {
  /// User preferred name
  final String? userPreferred;

  /// Creates a simplified character name
  const StaffCharacterName({this.userPreferred});

  /// Creates a simplified character name from a protobuf object
  factory StaffCharacterName.fromProto(pb.StaffCharacterName pbObj) {
    return StaffCharacterName(
      userPreferred: pbObj.hasUserPreferred() ? pbObj.userPreferred : null,
    );
  }

  /// Converts the simplified character name to a protobuf object
  pb.StaffCharacterName toProto() {
    final pbObj = pb.StaffCharacterName();
    if (userPreferred != null) pbObj.userPreferred = userPreferred!;
    return pbObj;
  }
}

/// Represents a simplified character image
class StaffCharacterImage {
  /// Large image URL
  final String? large;

  /// Medium image URL
  final String? medium;

  /// Creates a simplified character image
  const StaffCharacterImage({this.large, this.medium});

  /// Creates a simplified character image from a protobuf object
  factory StaffCharacterImage.fromProto(pb.StaffCharacterImage pbObj) {
    return StaffCharacterImage(
      large: pbObj.hasLarge() ? pbObj.large : null,
      medium: pbObj.hasMedium() ? pbObj.medium : null,
    );
  }

  /// Converts the simplified character image to a protobuf object
  pb.StaffCharacterImage toProto() {
    final pbObj = pb.StaffCharacterImage();
    if (large != null) pbObj.large = large!;
    if (medium != null) pbObj.medium = medium!;
    return pbObj;
  }
}

/// Represents a simplified voiced character
class StaffCharacter {
  /// Character ID
  final int id;

  /// Character name
  final StaffCharacterName? name;

  /// Character image
  final StaffCharacterImage? image;

  /// Creates a simplified voiced character
  const StaffCharacter({required this.id, this.name, this.image});

  /// Creates a simplified voiced character from a protobuf object
  factory StaffCharacter.fromProto(pb.StaffCharacter pbObj) {
    return StaffCharacter(
      id: pbObj.id,
      name: pbObj.hasName() ? StaffCharacterName.fromProto(pbObj.name) : null,
      image: pbObj.hasImage()
          ? StaffCharacterImage.fromProto(pbObj.image)
          : null,
    );
  }

  /// Converts the simplified voiced character to a protobuf object
  pb.StaffCharacter toProto() {
    final pbObj = pb.StaffCharacter(id: id);
    if (name != null) pbObj.name = name!.toProto();
    if (image != null) pbObj.image = image!.toProto();
    return pbObj;
  }
}

/// Represents the connection edge between a staff and a character/media role
class StaffCharacterMediaEdge {
  /// Character role
  final String? characterRole;

  /// Media node
  final MediaMin? node;

  /// Voiced characters
  final List<StaffCharacter> characters;

  /// Creates a character media edge
  const StaffCharacterMediaEdge({
    this.characterRole,
    this.node,
    required this.characters,
  });

  /// Creates a character media edge from a protobuf object
  factory StaffCharacterMediaEdge.fromProto(pb.StaffCharacterMediaEdge pbObj) {
    return StaffCharacterMediaEdge(
      characterRole: pbObj.hasCharacterRole() ? pbObj.characterRole : null,
      node: pbObj.hasNode() ? MediaMin.fromProto(pbObj.node) : null,
      characters: pbObj.characters.map(StaffCharacter.fromProto).toList(),
    );
  }

  /// Converts the character media edge to a protobuf object
  pb.StaffCharacterMediaEdge toProto() {
    final pbObj = pb.StaffCharacterMediaEdge();
    if (characterRole != null) pbObj.characterRole = characterRole!;
    if (node != null) pbObj.node = node!.toProto() as pbm.MediaMin;
    pbObj.characters.addAll(characters.map((c) => c.toProto()));
    return pbObj;
  }
}

/// Represents the pagination connection for character media roles
class StaffCharacterMediaConnection {
  /// Edges for character media
  final List<StaffCharacterMediaEdge> edges;

  /// Pagination info
  final PageInfo pageInfo;

  /// Creates a character media connection
  const StaffCharacterMediaConnection({
    required this.edges,
    required this.pageInfo,
  });

  /// Creates a character media connection from a protobuf object
  factory StaffCharacterMediaConnection.fromProto(
    pb.StaffCharacterMediaConnection pbObj,
  ) {
    return StaffCharacterMediaConnection(
      edges: pbObj.edges.map(StaffCharacterMediaEdge.fromProto).toList(),
      pageInfo: PageInfo.fromProto(pbObj.pageInfo),
    );
  }

  /// Converts the character media connection to a protobuf object
  pb.StaffCharacterMediaConnection toProto() {
    return pb.StaffCharacterMediaConnection(
      edges: edges.map((e) => e.toProto()).toList(),
      pageInfo: pageInfo.toProto(),
    );
  }
}

/// Represents the connection edge for media staffed by the staff member
class StaffMediaEdge {
  /// Staff role
  final String? staffRole;

  /// Media node
  final MediaMin? node;

  /// Creates a staff media edge
  const StaffMediaEdge({this.staffRole, this.node});

  /// Creates a staff media edge from a protobuf object
  factory StaffMediaEdge.fromProto(pb.StaffMediaEdge pbObj) {
    return StaffMediaEdge(
      staffRole: pbObj.hasStaffRole() ? pbObj.staffRole : null,
      node: pbObj.hasNode() ? MediaMin.fromProto(pbObj.node) : null,
    );
  }

  /// Converts the staff media edge to a protobuf object
  pb.StaffMediaEdge toProto() {
    final pbObj = pb.StaffMediaEdge();
    if (staffRole != null) pbObj.staffRole = staffRole!;
    if (node != null) pbObj.node = node!.toProto() as pbm.MediaMin;
    return pbObj;
  }
}

/// Represents the pagination connection for staffed media
class StaffMediaConnection {
  /// Edges for staffed media
  final List<StaffMediaEdge> edges;

  /// Pagination info
  final PageInfo pageInfo;

  /// Creates a staff media connection
  const StaffMediaConnection({required this.edges, required this.pageInfo});

  /// Creates a staff media connection from a protobuf object
  factory StaffMediaConnection.fromProto(pb.StaffMediaConnection pbObj) {
    return StaffMediaConnection(
      edges: pbObj.edges.map(StaffMediaEdge.fromProto).toList(),
      pageInfo: PageInfo.fromProto(pbObj.pageInfo),
    );
  }

  /// Converts the staff media connection to a protobuf object
  pb.StaffMediaConnection toProto() {
    return pb.StaffMediaConnection(
      edges: edges.map((e) => e.toProto()).toList(),
      pageInfo: pageInfo.toProto(),
    );
  }
}

/// Represents detailed information for a staff member
class Staff {
  /// Staff ID
  final int id;

  /// Staff name
  final StaffName? name;

  /// Staff image
  final StaffImage? image;

  /// Biography description
  final String? description;

  /// Favourites count
  final int? favourites;

  /// Is favourited by user
  final bool? isFavourite;

  /// Age
  final int? age;

  /// Gender
  final String? gender;

  /// Years active
  final List<int> yearsActive;

  /// Hometown
  final String? homeTown;

  /// Blood type
  final String? bloodType;

  /// Primary occupations
  final List<String> primaryOccupations;

  /// Date of birth
  final FuzzyDate? dateOfBirth;

  /// Date of death
  final FuzzyDate? dateOfDeath;

  /// Language
  final String? language;

  /// Voiced character media roles
  final StaffCharacterMediaConnection? characterMedia;

  /// Staffed media roles
  final StaffMediaConnection? staffMedia;

  /// Creates detailed staff information
  const Staff({
    required this.id,
    this.name,
    this.image,
    this.description,
    this.favourites,
    this.isFavourite,
    this.age,
    this.gender,
    required this.yearsActive,
    this.homeTown,
    this.bloodType,
    required this.primaryOccupations,
    this.dateOfBirth,
    this.dateOfDeath,
    this.language,
    this.characterMedia,
    this.staffMedia,
  });

  /// Creates detailed staff information from a protobuf object
  factory Staff.fromProto(pb.Staff pbObj) {
    return Staff(
      id: pbObj.id,
      name: pbObj.hasName() ? StaffName.fromProto(pbObj.name) : null,
      image: pbObj.hasImage() ? StaffImage.fromProto(pbObj.image) : null,
      description: pbObj.hasDescription() ? pbObj.description : null,
      favourites: pbObj.hasFavourites() ? pbObj.favourites : null,
      isFavourite: pbObj.hasIsFavourite() ? pbObj.isFavourite : null,
      age: pbObj.hasAge() ? pbObj.age : null,
      gender: pbObj.hasGender() ? pbObj.gender : null,
      yearsActive: List<int>.from(pbObj.yearsActive),
      homeTown: pbObj.hasHomeTown() ? pbObj.homeTown : null,
      bloodType: pbObj.hasBloodType() ? pbObj.bloodType : null,
      primaryOccupations: List<String>.from(pbObj.primaryOccupations),
      dateOfBirth: pbObj.hasDateOfBirth()
          ? FuzzyDate.fromProto(pbObj.dateOfBirth)
          : null,
      dateOfDeath: pbObj.hasDateOfDeath()
          ? FuzzyDate.fromProto(pbObj.dateOfDeath)
          : null,
      language: pbObj.hasLanguage() ? pbObj.language : null,
      characterMedia: pbObj.hasCharacterMedia()
          ? StaffCharacterMediaConnection.fromProto(pbObj.characterMedia)
          : null,
      staffMedia: pbObj.hasStaffMedia()
          ? StaffMediaConnection.fromProto(pbObj.staffMedia)
          : null,
    );
  }

  /// Converts the detailed staff information to a protobuf object
  pb.Staff toProto() {
    final pbObj = pb.Staff(id: id);
    if (name != null) pbObj.name = name!.toProto();
    if (image != null) pbObj.image = image!.toProto();
    if (description != null) pbObj.description = description!;
    if (favourites != null) pbObj.favourites = favourites!;
    if (isFavourite != null) pbObj.isFavourite = isFavourite!;
    if (age != null) pbObj.age = age!;
    if (gender != null) pbObj.gender = gender!;
    pbObj.yearsActive.addAll(yearsActive);
    if (homeTown != null) pbObj.homeTown = homeTown!;
    if (bloodType != null) pbObj.bloodType = bloodType!;
    pbObj.primaryOccupations.addAll(primaryOccupations);
    if (dateOfBirth != null) pbObj.dateOfBirth = dateOfBirth!.toProto();
    if (dateOfDeath != null) pbObj.dateOfDeath = dateOfDeath!.toProto();
    if (language != null) pbObj.language = language!;
    if (characterMedia != null) {
      pbObj.characterMedia = characterMedia!.toProto();
    }
    if (staffMedia != null) pbObj.staffMedia = staffMedia!.toProto();
    return pbObj;
  }

  /// Creates a copy of the staff details with updated properties
  Staff copyWith({bool? isFavourite, int? favourites}) {
    return Staff(
      id: id,
      name: name,
      image: image,
      description: description,
      favourites: favourites ?? this.favourites,
      isFavourite: isFavourite ?? this.isFavourite,
      age: age,
      gender: gender,
      yearsActive: yearsActive,
      homeTown: homeTown,
      bloodType: bloodType,
      primaryOccupations: primaryOccupations,
      dateOfBirth: dateOfBirth,
      dateOfDeath: dateOfDeath,
      language: language,
      characterMedia: characterMedia,
      staffMedia: staffMedia,
    );
  }
}
