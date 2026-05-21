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

  /// Converts the trailer to a JSON map
  Map<String, dynamic> toJson() {
    return {'id': id, 'site': site, 'thumbnail': thumbnail};
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
      id: json['id'] as int? ?? 0,
      isGeneralSpoiler: json['isGeneralSpoiler'] as bool? ?? false,
      isMediaSpoiler: json['isMediaSpoiler'] as bool? ?? false,
      name: json['name']?.toString() ?? '',
      rank: json['rank'] as int? ?? 0,
    );
  }

  /// Converts the media tag to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isGeneralSpoiler': isGeneralSpoiler,
      'isMediaSpoiler': isMediaSpoiler,
      'name': name,
      'rank': rank,
    };
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
      site: json['site']?.toString() ?? '',
      url: json['url']?.toString() ?? '',
    );
  }

  /// Converts the external link to a JSON map
  Map<String, dynamic> toJson() {
    return {'language': language, 'site': site, 'url': url};
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
    final nodeData = json['node'] as Map?;
    return MediaEdge(
      relationType: json['relationType']?.toString() ?? '',
      node: nodeData != null
          ? MediaMin.fromJson(Map<String, dynamic>.from(nodeData))
          : null,
    );
  }

  /// Converts the media edge to a JSON map
  Map<String, dynamic> toJson() {
    return {'relationType': relationType, 'node': node?.toJson()};
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
    final edgesList = json['edges'] as List?;
    return MediaConnection(
      edges: edgesList != null
          ? List<MediaEdge>.from(
              edgesList.map(
                (e) => MediaEdge.fromJson(Map<String, dynamic>.from(e as Map)),
              ),
            )
          : const [],
    );
  }

  /// Converts the media connection to a JSON map
  Map<String, dynamic> toJson() {
    return {'edges': edges.map((e) => e.toJson()).toList()};
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
    final mediaRecData = json['mediaRecommendation'] as Map?;
    return Recommendation(
      rating: json['rating'] as int? ?? 0,
      mediaRecommendation: mediaRecData != null
          ? MediaMin.fromJson(Map<String, dynamic>.from(mediaRecData))
          : null,
    );
  }

  /// Converts the recommendation to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'mediaRecommendation': mediaRecommendation?.toJson(),
    };
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
    final nodeData = json['node'] as Map?;
    return RecommendationEdge(
      node: Recommendation.fromJson(
        nodeData != null ? Map<String, dynamic>.from(nodeData) : const {},
      ),
    );
  }

  /// Converts the recommendation edge to a JSON map
  Map<String, dynamic> toJson() {
    return {'node': node.toJson()};
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
    final pageInfoData = json['pageInfo'] as Map?;
    final edgesList = json['edges'] as List?;
    return RecommendationConnection(
      pageInfo: PageInfo.fromJson(
        pageInfoData != null
            ? Map<String, dynamic>.from(pageInfoData)
            : const {},
      ),
      edges: edgesList != null
          ? List<RecommendationEdge>.from(
              edgesList.map(
                (e) => RecommendationEdge.fromJson(
                  Map<String, dynamic>.from(e as Map),
                ),
              ),
            )
          : const [],
    );
  }

  /// Converts the recommendation connection to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'pageInfo': pageInfo.toJson(),
      'edges': edges.map((e) => e.toJson()).toList(),
    };
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

  /// Converts the airing schedule to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'airingAt': airingAt,
      'episode': episode,
      'timeUntilAiring': timeUntilAiring,
    };
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

  /// Converts the streaming episode to a JSON map
  Map<String, dynamic> toJson() {
    return {'thumbnail': thumbnail, 'title': title, 'url': url};
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

  /// Converts the media rank to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'allTime': allTime,
      'rank': rank,
      'season': season,
      'type': type,
      'year': year,
    };
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

  /// Converts the score distribution to a JSON map
  Map<String, dynamic> toJson() {
    return {'amount': amount, 'score': score};
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

  /// Converts the status distribution to a JSON map
  Map<String, dynamic> toJson() {
    return {'amount': amount, 'status': status};
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
    final scoreList = json['scoreDistribution'] as List?;
    final statusList = json['statusDistribution'] as List?;
    return MediaStats(
      scoreDistribution: scoreList != null
          ? List<ScoreDistribution>.from(
              scoreList.map(
                (s) => ScoreDistribution.fromJson(
                  Map<String, dynamic>.from(s as Map),
                ),
              ),
            )
          : const [],
      statusDistribution: statusList != null
          ? List<StatusDistribution>.from(
              statusList.map(
                (s) => StatusDistribution.fromJson(
                  Map<String, dynamic>.from(s as Map),
                ),
              ),
            )
          : const [],
    );
  }

  /// Converts the media stats to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'scoreDistribution': scoreDistribution.map((s) => s.toJson()).toList(),
      'statusDistribution': statusDistribution.map((s) => s.toJson()).toList(),
    };
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

  /// Converts the media trend to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'averageScore': averageScore,
      'date': date,
      'inProgress': inProgress,
      'popularity': popularity,
    };
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
    final nodesList = json['nodes'] as List?;
    return MediaTrendConnection(
      nodes: nodesList != null
          ? List<MediaTrend>.from(
              nodesList.map(
                (n) => MediaTrend.fromJson(Map<String, dynamic>.from(n as Map)),
              ),
            )
          : const [],
    );
  }

  /// Converts the media trend connection to a JSON map
  Map<String, dynamic> toJson() {
    return {'nodes': nodes.map((n) => n.toJson()).toList()};
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
    final titleData = json['title'] as Map?;
    final coverImageData = json['coverImage'] as Map?;
    final studiosData = json['studios'] as Map?;
    final staffData = json['staff'] as Map?;
    final charactersData = json['characters'] as Map?;
    final relationsData = json['relations'] as Map?;
    final recommendationsData = json['recommendations'] as Map?;
    final trailerData = json['trailer'] as Map?;
    final entryData = json['mediaListEntry'] as Map?;
    final nextAiringData = json['nextAiringEpisode'] as Map?;
    final statsData = json['stats'] as Map?;
    final trendsData = json['trends'] as Map?;

    final studiosList = studiosData != null
        ? studiosData['edges'] as List?
        : null;
    final tagsList = json['tags'] as List?;
    final externalLinksList = json['externalLinks'] as List?;
    final streamingEpisodesList = json['streamingEpisodes'] as List?;
    final rankingsList = json['rankings'] as List?;

    return Media(
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
      trailer: trailerData != null
          ? Trailer.fromJson(Map<String, dynamic>.from(trailerData))
          : null,
      studios: studiosList != null
          ? List<StudioEdge>.from(
              studiosList.map(
                (e) => StudioEdge.fromJson(Map<String, dynamic>.from(e as Map)),
              ),
            )
          : const [],
      tags: tagsList != null
          ? List<MediaTag>.from(
              tagsList.map(
                (t) => MediaTag.fromJson(Map<String, dynamic>.from(t as Map)),
              ),
            )
          : const [],
      externalLinks: externalLinksList != null
          ? List<ExternalLink>.from(
              externalLinksList.map(
                (e) =>
                    ExternalLink.fromJson(Map<String, dynamic>.from(e as Map)),
              ),
            )
          : const [],
      mediaListEntry: entryData != null
          ? MediaListEntry.fromJson(Map<String, dynamic>.from(entryData))
          : null,
      streamingEpisodes: streamingEpisodesList != null
          ? List<StreamingEpisode>.from(
              streamingEpisodesList.map(
                (s) => StreamingEpisode.fromJson(
                  Map<String, dynamic>.from(s as Map),
                ),
              ),
            )
          : const [],
      staff: staffData != null
          ? StaffConnection.fromJson(Map<String, dynamic>.from(staffData))
          : null,
      nextAiringEpisode: nextAiringData != null
          ? AiringSchedule.fromJson(Map<String, dynamic>.from(nextAiringData))
          : null,
      characters: charactersData != null
          ? CharacterConnection.fromJson(
              Map<String, dynamic>.from(charactersData),
            )
          : null,
      relations: relationsData != null
          ? MediaConnection.fromJson(Map<String, dynamic>.from(relationsData))
          : null,
      recommendations: recommendationsData != null
          ? RecommendationConnection.fromJson(
              Map<String, dynamic>.from(recommendationsData),
            )
          : null,
      rankings: rankingsList != null
          ? List<MediaRank>.from(
              rankingsList.map(
                (r) => MediaRank.fromJson(Map<String, dynamic>.from(r as Map)),
              ),
            )
          : const [],
      stats: statsData != null
          ? MediaStats.fromJson(Map<String, dynamic>.from(statsData))
          : null,
      trends: trendsData != null
          ? MediaTrendConnection.fromJson(Map<String, dynamic>.from(trendsData))
          : null,
    );
  }

  /// Converts the media to a JSON map
  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'type': type,
      'bannerImage': bannerImage,
      'status': status,
      'seasonYear': seasonYear,
      'season': season,
      'meanScore': meanScore,
      'favourites': favourites,
      'popularity': popularity,
      'description': description,
      'genres': genres,
      'synonyms': synonyms,
      'trailer': trailer?.toJson(),
      'studios': {'edges': studios.map((e) => e.toJson()).toList()},
      'tags': tags.map((e) => e.toJson()).toList(),
      'externalLinks': externalLinks.map((e) => e.toJson()).toList(),
      'mediaListEntry': mediaListEntry?.toJson(),
      'streamingEpisodes': streamingEpisodes.map((e) => e.toJson()).toList(),
      'staff': staff?.toJson(),
      'nextAiringEpisode': nextAiringEpisode?.toJson(),
      'characters': characters?.toJson(),
      'relations': relations?.toJson(),
      'recommendations': recommendations?.toJson(),
      'rankings': rankings.map((e) => e.toJson()).toList(),
      'stats': stats?.toJson(),
      'trends': trends?.toJson(),
    };
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

  /// Converts the toggle favourite to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'anime': {
        'nodes': animeNodes
            .map((n) => {'id': n.id, 'isFavourite': n.isFavourite})
            .toList(),
      },
    };
  }
}
