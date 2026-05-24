import 'media_list_entry.dart';
import 'media_min.dart';
import 'media_character.dart';
import 'media_staff.dart';
import 'media_edge.dart';
import 'media_misc.dart';
import 'media_recommendation.dart';
import 'media_studio.dart';
import 'media_trend.dart';

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

  /// Creates a copy of this object with the given fields replaced
  @override
  Media copyWith({
    int? id,
    Title? title,
    int? averageScore,
    CoverImage? coverImage,
    int? episodes,
    String? format,
    bool? isAdult,
    bool? isFavourite,
    String? siteUrl,
    String? type,
    String? bannerImage,
    String? status,
    int? seasonYear,
    String? season,
    int? meanScore,
    int? favourites,
    int? popularity,
    String? description,
    List<String>? genres,
    List<String>? synonyms,
    Trailer? trailer,
    List<StudioEdge>? studios,
    List<MediaTag>? tags,
    List<ExternalLink>? externalLinks,
    MediaListEntry? mediaListEntry,
    List<StreamingEpisode>? streamingEpisodes,
    StaffConnection? staff,
    AiringSchedule? nextAiringEpisode,
    CharacterConnection? characters,
    MediaConnection? relations,
    RecommendationConnection? recommendations,
    List<MediaRank>? rankings,
    MediaStats? stats,
    MediaTrendConnection? trends,
  }) {
    return Media(
      id: id ?? this.id,
      title: title ?? this.title,
      averageScore: averageScore ?? this.averageScore,
      coverImage: coverImage ?? this.coverImage,
      episodes: episodes ?? this.episodes,
      format: format ?? this.format,
      isAdult: isAdult ?? this.isAdult,
      isFavourite: isFavourite ?? this.isFavourite,
      siteUrl: siteUrl ?? this.siteUrl,
      type: type ?? this.type,
      bannerImage: bannerImage ?? this.bannerImage,
      status: status ?? this.status,
      seasonYear: seasonYear ?? this.seasonYear,
      season: season ?? this.season,
      meanScore: meanScore ?? this.meanScore,
      favourites: favourites ?? this.favourites,
      popularity: popularity ?? this.popularity,
      description: description ?? this.description,
      genres: genres ?? this.genres,
      synonyms: synonyms ?? this.synonyms,
      trailer: trailer ?? this.trailer,
      studios: studios ?? this.studios,
      tags: tags ?? this.tags,
      externalLinks: externalLinks ?? this.externalLinks,
      mediaListEntry:
          mediaListEntry ??
          this.mediaListEntry, // Not doing a hack to clear it via copyWith for now
      streamingEpisodes: streamingEpisodes ?? this.streamingEpisodes,
      staff: staff ?? this.staff,
      nextAiringEpisode: nextAiringEpisode ?? this.nextAiringEpisode,
      characters: characters ?? this.characters,
      relations: relations ?? this.relations,
      recommendations: recommendations ?? this.recommendations,
      rankings: rankings ?? this.rankings,
      stats: stats ?? this.stats,
      trends: trends ?? this.trends,
    );
  }
}
