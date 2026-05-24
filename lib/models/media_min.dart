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

  /// Creates a cover image from a JSON map
  factory CoverImage.fromJson(Map<String, dynamic> json) {
    return CoverImage(
      medium: json['medium']?.toString() ?? '',
      large: json['large']?.toString() ?? '',
      extraLarge: json['extraLarge']?.toString() ?? '',
      color: json['color']?.toString() ?? '',
    );
  }

  /// Converts the cover image to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'medium': medium,
      'large': large,
      'extraLarge': extraLarge,
      'color': color,
    };
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

  /// Creates a title from a JSON map
  factory Title.fromJson(Map<String, dynamic> json) {
    return Title(
      english: json['english']?.toString() ?? '',
      native: json['native']?.toString() ?? '',
      romaji: json['romaji']?.toString() ?? '',
      userPreferred: json['userPreferred']?.toString() ?? '',
    );
  }

  /// Converts the title to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'english': english,
      'native': native,
      'romaji': romaji,
      'userPreferred': userPreferred,
    };
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

  /// Creates a minimal media from a JSON map
  factory MediaMin.fromJson(Map<String, dynamic> json) {
    final titleData = json['title'] as Map?;
    final coverImageData = json['coverImage'] as Map?;
    return MediaMin(
      id: json['id'] as int? ?? 0,
      title: Title.fromJson(
        titleData != null ? Map<String, dynamic>.from(titleData) : const {},
      ),
      averageScore: json['averageScore'] as int? ?? 0,
      coverImage: CoverImage.fromJson(
        coverImageData != null
            ? Map<String, dynamic>.from(coverImageData)
            : const {},
      ),
      episodes: json['episodes'] as int? ?? 0,
      format: json['format']?.toString() ?? '',
      isAdult: json['isAdult'] as bool? ?? false,
      isFavourite: json['isFavourite'] as bool? ?? false,
      siteUrl: json['siteUrl']?.toString() ?? '',
    );
  }

  /// Converts the minimal media to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title.toJson(),
      'averageScore': averageScore,
      'coverImage': coverImage.toJson(),
      'episodes': episodes,
      'format': format,
      'isAdult': isAdult,
      'isFavourite': isFavourite,
      'siteUrl': siteUrl,
    };
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
