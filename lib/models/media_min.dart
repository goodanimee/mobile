import 'package:protobuf/protobuf.dart';
import '../proto/media_min.pb.dart' as pb;

/// Represents a media cover image
class CoverImage {
  /// Medium-sized image URL
  final String medium;

  /// Large-sized image URL
  final String large;

  /// Extra-large-sized image URL
  final String extraLarge;

  /// Dominant color as a hex string
  final String color;

  /// Creates a cover image
  const CoverImage({
    required this.medium,
    required this.large,
    required this.extraLarge,
    required this.color,
  });

  /// Creates a cover image from a protobuf object
  factory CoverImage.fromProto(pb.CoverImage pbObj) {
    return CoverImage(
      medium: pbObj.medium,
      large: pbObj.large,
      extraLarge: pbObj.extraLarge,
      color: pbObj.color,
    );
  }

  /// Converts the cover image to a protobuf object
  pb.CoverImage toProto() {
    return pb.CoverImage(
      medium: medium,
      large: large,
      extraLarge: extraLarge,
      color: color,
    );
  }
}

/// Represents the various titles for a media
class Title {
  /// English title
  final String english;

  /// Native title
  final String native;

  /// Romaji title
  final String romaji;

  /// User-preferred title
  final String userPreferred;

  /// Creates a title
  const Title({
    required this.english,
    required this.native,
    required this.romaji,
    required this.userPreferred,
  });

  /// Creates a title from a protobuf object
  factory Title.fromProto(pb.Title pbObj) {
    return Title(
      english: pbObj.english,
      native: pbObj.native,
      romaji: pbObj.romaji,
      userPreferred: pbObj.userPreferred,
    );
  }

  /// Converts the title to a protobuf object
  pb.Title toProto() {
    return pb.Title(
      english: english,
      native: native,
      romaji: romaji,
      userPreferred: userPreferred,
    );
  }
}

/// Represents the minimal media data used in lists and relations
class MediaMin {
  /// Media ID
  final int id;

  /// Media title
  final Title title;

  /// Average user score
  final int averageScore;

  /// Cover image
  final CoverImage coverImage;

  /// Total episode count
  final int episodes;

  /// Media format
  final String format;

  /// Whether the media is adult-only
  final bool isAdult;

  /// Whether the user has favourited this media
  final bool isFavourite;

  /// AniList site URL
  final String siteUrl;

  /// Creates a minimal media
  const MediaMin({
    required this.id,
    required this.title,
    required this.averageScore,
    required this.coverImage,
    required this.episodes,
    required this.format,
    required this.isAdult,
    required this.isFavourite,
    required this.siteUrl,
  });

  /// Creates a minimal media from a protobuf object
  factory MediaMin.fromProto(pb.MediaMin pbObj) {
    return MediaMin(
      id: pbObj.id,
      title: Title.fromProto(pbObj.title),
      averageScore: pbObj.averageScore,
      coverImage: CoverImage.fromProto(pbObj.coverImage),
      episodes: pbObj.episodes,
      format: pbObj.format,
      isAdult: pbObj.isAdult,
      isFavourite: pbObj.isFavourite,
      siteUrl: pbObj.siteUrl,
    );
  }

  /// Converts the minimal media to a protobuf object
  GeneratedMessage toProto() {
    return pb.MediaMin(
      id: id,
      title: title.toProto(),
      averageScore: averageScore,
      coverImage: coverImage.toProto(),
      episodes: episodes,
      format: format,
      isAdult: isAdult,
      isFavourite: isFavourite,
      siteUrl: siteUrl,
    );
  }

  /// Creates a copy of this object with the given fields replaced
  MediaMin copyWith({
    int? id,
    Title? title,
    int? averageScore,
    CoverImage? coverImage,
    int? episodes,
    String? format,
    bool? isAdult,
    bool? isFavourite,
    String? siteUrl,
  }) {
    return MediaMin(
      id: id ?? this.id,
      title: title ?? this.title,
      averageScore: averageScore ?? this.averageScore,
      coverImage: coverImage ?? this.coverImage,
      episodes: episodes ?? this.episodes,
      format: format ?? this.format,
      isAdult: isAdult ?? this.isAdult,
      isFavourite: isFavourite ?? this.isFavourite,
      siteUrl: siteUrl ?? this.siteUrl,
    );
  }
}
