import 'common.dart';
import 'media_list_entry.dart';

/// Represents a media trailer
class Trailer {
  /// Trailer ID
  final String id;

  /// Hosting site
  final String site;

  /// Thumbnail URL
  final String thumbnail;

  /// Creates a trailer
  const Trailer({
    required this.id,
    required this.site,
    required this.thumbnail,
  });

  /// Creates a trailer from a JSON map
  factory Trailer.fromJson(Map<String, dynamic> json) {
    return Trailer(
      id: json['id']?.toString() ?? '',
      site: json['site']?.toString() ?? '',
      thumbnail: json['thumbnail']?.toString() ?? '',
    );
  }
}

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
}

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
    return Studio(id: json['id'] as int, name: json['name'] as String);
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
    return StudioEdge(
      isMain: json['isMain'] as bool,
      node: Studio.fromJson(json['node'] as Map<String, dynamic>),
    );
  }
}

/// Represents a descriptive tag for a media
class MediaTag {
  /// Tag ID
  final int id;

  /// Whether this tag is a general spoiler
  final bool isGeneralSpoiler;

  /// Whether this tag is a media-specific spoiler
  final bool isMediaSpoiler;

  /// Tag name
  final String name;

  /// Tag relevance rank
  final int rank;

  /// Creates a media tag
  const MediaTag({
    required this.id,
    required this.isGeneralSpoiler,
    required this.isMediaSpoiler,
    required this.name,
    required this.rank,
  });

  /// Creates a media tag from a JSON map
  factory MediaTag.fromJson(Map<String, dynamic> json) {
    return MediaTag(
      id: json['id'] as int,
      isGeneralSpoiler: json['isGeneralSpoiler'] as bool,
      isMediaSpoiler: json['isMediaSpoiler'] as bool,
      name: json['name'] as String,
      rank: json['rank'] as int,
    );
  }
}

/// Represents a link to an external site
class ExternalLink {
  /// Language of the external content
  final String language;

  /// Site name
  final String site;

  /// Link URL
  final String url;

  /// Creates an external link
  const ExternalLink({
    required this.language,
    required this.site,
    required this.url,
  });

  /// Creates an external link from a JSON map
  factory ExternalLink.fromJson(Map<String, dynamic> json) {
    return ExternalLink(
      language: json['language']?.toString() ?? '',
      site: json['site'] as String,
      url: json['url'] as String,
    );
  }
}

/// Represents a link between two media
class MediaEdge {
  /// Relation type
  final String relationType;

  /// The related media
  final MediaMin? node;

  /// Creates a media edge
  const MediaEdge({required this.relationType, this.node});

  /// Creates a media edge from a JSON map
  factory MediaEdge.fromJson(Map<String, dynamic> json) {
    return MediaEdge(
      relationType: json['relationType'] as String,
      node: json['node'] != null
          ? MediaMin.fromJson(json['node'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// Represents a paginated list of media relations
class MediaConnection {
  /// Relation edges
  final List<MediaEdge> edges;

  /// Creates a media connection
  const MediaConnection({required this.edges});

  /// Creates a media connection from a JSON map
  factory MediaConnection.fromJson(Map<String, dynamic> json) {
    return MediaConnection(
      edges:
          (json['edges'] as List?)
              ?.map((e) => MediaEdge.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

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
    return Character(
      name: json['name'] != null
          ? CharacterName.fromJson(json['name'] as Map<String, dynamic>)
          : null,
      image: json['image'] != null
          ? CharacterImage.fromJson(json['image'] as Map<String, dynamic>)
          : null,
      gender: json['gender']?.toString(),
      age: json['age']?.toString(),
      dateOfBirth: json['dateOfBirth'] != null
          ? FuzzyDate.fromJson(json['dateOfBirth'] as Map<String, dynamic>)
          : null,
      description: json['description']?.toString(),
    );
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
    return CharacterEdge(
      id: json['id'] as int? ?? 0,
      role: json['role']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      node: json['node'] != null
          ? Character.fromJson(json['node'] as Map<String, dynamic>)
          : null,
      voiceActors:
          (json['voiceActors'] as List?)
              ?.map((v) => Staff.fromJson(v as Map<String, dynamic>))
              .toList() ??
          [],
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

  /// Creates a character connection from a JSON map
  factory CharacterConnection.fromJson(Map<String, dynamic> json) {
    return CharacterConnection(
      edges:
          (json['edges'] as List?)
              ?.map((e) => CharacterEdge.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      pageInfo: PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
    );
  }
}

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
    return Staff(
      name: json['name'] != null
          ? StaffName.fromJson(json['name'] as Map<String, dynamic>)
          : null,
      image: json['image'] != null
          ? StaffImage.fromJson(json['image'] as Map<String, dynamic>)
          : null,
      languageV2: json['languageV2']?.toString(),
    );
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
    return StaffEdge(
      role: json['role']?.toString() ?? '',
      node: json['node'] != null
          ? Staff.fromJson(json['node'] as Map<String, dynamic>)
          : null,
    );
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
    return StaffConnection(
      edges:
          (json['edges'] as List?)
              ?.map((e) => StaffEdge.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      pageInfo: PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
    );
  }
}

/// Represents a recommended media
class Recommendation {
  /// Recommendation rating
  final int rating;

  /// The recommended media
  final MediaMin? mediaRecommendation;

  /// Creates a recommendation
  const Recommendation({required this.rating, this.mediaRecommendation});

  /// Creates a recommendation from a JSON map
  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(
      rating: json['rating'] as int? ?? 0,
      mediaRecommendation: json['mediaRecommendation'] != null
          ? MediaMin.fromJson(
              json['mediaRecommendation'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}

/// Represents a recommendation edge
class RecommendationEdge {
  /// The recommendation
  final Recommendation node;

  /// Creates a recommendation edge
  const RecommendationEdge({required this.node});

  /// Creates a recommendation edge from a JSON map
  factory RecommendationEdge.fromJson(Map<String, dynamic> json) {
    return RecommendationEdge(
      node: Recommendation.fromJson(json['node'] as Map<String, dynamic>),
    );
  }
}

/// Represents a paginated list of recommendations
class RecommendationConnection {
  /// Pagination info
  final PageInfo pageInfo;

  /// Recommendation edges
  final List<RecommendationEdge> edges;

  /// Creates a recommendation connection
  const RecommendationConnection({required this.pageInfo, required this.edges});

  /// Creates a recommendation connection from a JSON map
  factory RecommendationConnection.fromJson(Map<String, dynamic> json) {
    return RecommendationConnection(
      pageInfo: PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
      edges:
          (json['edges'] as List?)
              ?.map(
                (e) => RecommendationEdge.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }
}

/// Represents an airing episode
class AiringSchedule {
  /// Airing timestamp
  final int airingAt;

  /// Episode number
  final int episode;

  /// Time until airing in seconds
  final int timeUntilAiring;

  /// Creates an airing schedule
  const AiringSchedule({
    required this.airingAt,
    required this.episode,
    required this.timeUntilAiring,
  });

  /// Creates an airing schedule from a JSON map
  factory AiringSchedule.fromJson(Map<String, dynamic> json) {
    return AiringSchedule(
      airingAt: json['airingAt'] as int? ?? 0,
      episode: json['episode'] as int? ?? 0,
      timeUntilAiring: json['timeUntilAiring'] as int? ?? 0,
    );
  }
}

/// Represents a streaming link for an episode
class StreamingEpisode {
  /// Thumbnail URL
  final String thumbnail;

  /// Episode title
  final String title;

  /// Streaming URL
  final String url;

  /// Creates a streaming episode
  const StreamingEpisode({
    required this.thumbnail,
    required this.title,
    required this.url,
  });

  /// Creates a streaming episode from a JSON map
  factory StreamingEpisode.fromJson(Map<String, dynamic> json) {
    return StreamingEpisode(
      thumbnail: json['thumbnail']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      url: json['url']?.toString() ?? '',
    );
  }
}

/// Represents a ranking for a media
class MediaRank {
  /// Whether this is an all-time ranking
  final bool allTime;

  /// Rank position
  final int rank;

  /// Ranking season
  final String season;

  /// Ranking type
  final String type;

  /// Ranking year
  final int year;

  /// Creates a media rank
  const MediaRank({
    required this.allTime,
    required this.rank,
    required this.season,
    required this.type,
    required this.year,
  });

  /// Creates a media rank from a JSON map
  factory MediaRank.fromJson(Map<String, dynamic> json) {
    return MediaRank(
      allTime: json['allTime'] as bool? ?? false,
      rank: json['rank'] as int? ?? 0,
      season: json['season']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      year: json['year'] as int? ?? 0,
    );
  }
}

/// Represents a score distribution entry
class ScoreDistribution {
  /// Number of users with this score
  final int amount;

  /// Score value
  final int score;

  /// Creates a score distribution
  const ScoreDistribution({required this.amount, required this.score});

  /// Creates a score distribution from a JSON map
  factory ScoreDistribution.fromJson(Map<String, dynamic> json) {
    return ScoreDistribution(
      amount: json['amount'] as int? ?? 0,
      score: json['score'] as int? ?? 0,
    );
  }
}

/// Represents a status distribution entry
class StatusDistribution {
  /// Number of users with this status
  final int amount;

  /// Status value
  final String status;

  /// Creates a status distribution
  const StatusDistribution({required this.amount, required this.status});

  /// Creates a status distribution from a JSON map
  factory StatusDistribution.fromJson(Map<String, dynamic> json) {
    return StatusDistribution(
      amount: json['amount'] as int? ?? 0,
      status: json['status']?.toString() ?? '',
    );
  }
}

/// Represents statistics for a media
class MediaStats {
  /// Score distribution data
  final List<ScoreDistribution> scoreDistribution;

  /// Status distribution data
  final List<StatusDistribution> statusDistribution;

  /// Creates media stats
  const MediaStats({
    required this.scoreDistribution,
    required this.statusDistribution,
  });

  /// Creates media stats from a JSON map
  factory MediaStats.fromJson(Map<String, dynamic> json) {
    return MediaStats(
      scoreDistribution:
          (json['scoreDistribution'] as List?)
              ?.map(
                (s) => ScoreDistribution.fromJson(s as Map<String, dynamic>),
              )
              .toList() ??
          [],
      statusDistribution:
          (json['statusDistribution'] as List?)
              ?.map(
                (s) => StatusDistribution.fromJson(s as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }
}

/// Represents a trend data point
class MediaTrend {
  /// Average score at this point
  final int averageScore;

  /// Date timestamp
  final int date;

  /// Number of users with in-progress status
  final int inProgress;

  /// Popularity at this point
  final int popularity;

  /// Creates a media trend
  const MediaTrend({
    required this.averageScore,
    required this.date,
    required this.inProgress,
    required this.popularity,
  });

  /// Creates a media trend from a JSON map
  factory MediaTrend.fromJson(Map<String, dynamic> json) {
    return MediaTrend(
      averageScore: json['averageScore'] as int? ?? 0,
      date: json['date'] as int? ?? 0,
      inProgress: json['inProgress'] as int? ?? 0,
      popularity: json['popularity'] as int? ?? 0,
    );
  }
}

/// Represents a list of trends
class MediaTrendConnection {
  /// Trend data points
  final List<MediaTrend> nodes;

  /// Creates a media trend connection
  const MediaTrendConnection({required this.nodes});

  /// Creates a media trend connection from a JSON map
  factory MediaTrendConnection.fromJson(Map<String, dynamic> json) {
    return MediaTrendConnection(
      nodes:
          (json['nodes'] as List?)
              ?.map((n) => MediaTrend.fromJson(n as Map<String, dynamic>))
              .toList() ??
          [],
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

  /// Creates a minimal media from a JSON map
  factory MediaMin.fromJson(Map<String, dynamic> json) {
    return MediaMin(
      id: json['id'] as int? ?? 0,
      title: Title.fromJson(json['title'] as Map<String, dynamic>),
      averageScore: json['averageScore'] as int? ?? 0,
      coverImage: CoverImage.fromJson(
        json['coverImage'] as Map<String, dynamic>,
      ),
      episodes: json['episodes'] as int? ?? 0,
      format: json['format']?.toString() ?? '',
      isAdult: json['isAdult'] as bool? ?? false,
      isFavourite: json['isFavourite'] as bool? ?? false,
      siteUrl: json['siteUrl']?.toString() ?? '',
    );
  }
}

/// Represents the core media domain model
class Media extends MediaMin {
  /// Media type
  final String type;

  /// Banner image URL
  final String bannerImage;

  /// Airing status
  final String status;

  /// Season year
  final int seasonYear;

  /// Airing season
  final String season;

  /// Mean user score
  final int? meanScore;

  /// Number of favourites
  final int? favourites;

  /// Popularity score
  final int popularity;

  /// HTML description
  final String description;

  /// Genre list
  final List<String> genres;

  /// Alternative titles
  final List<String> synonyms;

  /// Media trailer
  final Trailer? trailer;

  /// Studio edges
  final List<StudioEdge> studios;

  /// Community tags
  final List<MediaTag> tags;

  /// External links
  final List<ExternalLink> externalLinks;

  /// User's list entry for this media
  final MediaListEntry? mediaListEntry;

  /// Streaming episodes
  final List<StreamingEpisode> streamingEpisodes;

  /// Staff connection
  final StaffConnection? staff;

  /// Next airing episode
  final AiringSchedule? nextAiringEpisode;

  /// Character connection
  final CharacterConnection? characters;

  /// Related media connection
  final MediaConnection? relations;

  /// Recommendation connection
  final RecommendationConnection? recommendations;

  /// Media rankings
  final List<MediaRank> rankings;

  /// Media statistics
  final MediaStats? stats;

  /// Trend data
  final MediaTrendConnection? trends;

  /// Creates a media
  const Media({
    required super.id,
    required super.title,
    required super.averageScore,
    required super.coverImage,
    required super.episodes,
    required super.format,
    required super.isAdult,
    required super.isFavourite,
    required super.siteUrl,
    required this.type,
    required this.bannerImage,
    required this.status,
    required this.seasonYear,
    required this.season,
    this.meanScore,
    this.favourites,
    required this.popularity,
    required this.description,
    required this.genres,
    required this.synonyms,
    this.trailer,
    required this.studios,
    required this.tags,
    required this.externalLinks,
    this.mediaListEntry,
    required this.streamingEpisodes,
    this.staff,
    this.nextAiringEpisode,
    this.characters,
    this.relations,
    this.recommendations,
    required this.rankings,
    this.stats,
    this.trends,
  });

  /// Creates a media from a JSON map
  factory Media.fromJson(Map<String, dynamic> json) {
    final studiosData = json['studios'] as Map<String, dynamic>?;
    final staffData = json['staff'] as Map<String, dynamic>?;
    final charactersData = json['characters'] as Map<String, dynamic>?;
    final relationsData = json['relations'] as Map<String, dynamic>?;
    final recommendationsData =
        json['recommendations'] as Map<String, dynamic>?;

    return Media(
      id: json['id'] as int? ?? 0,
      title: Title.fromJson(json['title'] as Map<String, dynamic>),
      averageScore: json['averageScore'] as int? ?? 0,
      coverImage: CoverImage.fromJson(
        json['coverImage'] as Map<String, dynamic>,
      ),
      episodes: json['episodes'] as int? ?? 0,
      format: json['format']?.toString() ?? '',
      isAdult: json['isAdult'] as bool? ?? false,
      isFavourite: json['isFavourite'] as bool? ?? false,
      siteUrl: json['siteUrl']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      bannerImage: json['bannerImage']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      seasonYear: json['seasonYear'] as int? ?? 0,
      season: json['season']?.toString() ?? '',
      meanScore: json['meanScore'] as int?,
      favourites: json['favourites'] as int?,
      popularity: json['popularity'] as int? ?? 0,
      description: json['description']?.toString() ?? '',
      genres: (json['genres'] as List?)?.cast<String>() ?? [],
      synonyms: (json['synonyms'] as List?)?.cast<String>() ?? [],
      trailer: json['trailer'] != null
          ? Trailer.fromJson(json['trailer'] as Map<String, dynamic>)
          : null,
      studios: studiosData != null
          ? (studiosData['edges'] as List?)
                    ?.map((e) => StudioEdge.fromJson(e as Map<String, dynamic>))
                    .toList() ??
                []
          : [],
      tags:
          (json['tags'] as List?)
              ?.map((t) => MediaTag.fromJson(t as Map<String, dynamic>))
              .toList() ??
          [],
      externalLinks:
          (json['externalLinks'] as List?)
              ?.map((e) => ExternalLink.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      mediaListEntry: json['mediaListEntry'] != null
          ? MediaListEntry.fromJson(
              json['mediaListEntry'] as Map<String, dynamic>,
            )
          : null,
      streamingEpisodes:
          (json['streamingEpisodes'] as List?)
              ?.map((s) => StreamingEpisode.fromJson(s as Map<String, dynamic>))
              .toList() ??
          [],
      staff: staffData != null ? StaffConnection.fromJson(staffData) : null,
      nextAiringEpisode: json['nextAiringEpisode'] != null
          ? AiringSchedule.fromJson(
              json['nextAiringEpisode'] as Map<String, dynamic>,
            )
          : null,
      characters: charactersData != null
          ? CharacterConnection.fromJson(charactersData)
          : null,
      relations: relationsData != null
          ? MediaConnection.fromJson(relationsData)
          : null,
      recommendations: recommendationsData != null
          ? RecommendationConnection.fromJson(recommendationsData)
          : null,
      rankings:
          (json['rankings'] as List?)
              ?.map((r) => MediaRank.fromJson(r as Map<String, dynamic>))
              .toList() ??
          [],
      stats: json['stats'] != null
          ? MediaStats.fromJson(json['stats'] as Map<String, dynamic>)
          : null,
      trends: json['trends'] != null
          ? MediaTrendConnection.fromJson(
              json['trends'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}

/// Represents the response for a favourite toggle
class ToggleFavourite {
  /// Updated favourite status nodes
  final List<({int id, bool isFavourite})> animeNodes;

  /// Creates a toggle favourite
  const ToggleFavourite({required this.animeNodes});

  /// Creates a toggle favourite from a JSON map
  factory ToggleFavourite.fromJson(Map<String, dynamic> json) {
    final anime = json['anime'] as Map<String, dynamic>?;
    final nodes = anime?['nodes'] as List? ?? [];
    return ToggleFavourite(
      animeNodes: nodes
          .map(
            (n) => (
              id: (n as Map<String, dynamic>)['id'] as int,
              isFavourite: n['isFavourite'] as bool,
            ),
          )
          .toList(),
    );
  }
}
