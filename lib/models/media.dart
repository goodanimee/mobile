import '../proto/media.pb.dart' as pb;
import '../proto/media_list_entry.pb.dart' as pb_list_entry;
import '../proto/media_min.pb.dart' as pbm;
import '../proto/media_studio.pb.dart' as pbs;
import 'media_character.dart';
import 'media_edge.dart';
import 'media_list_entry.dart';
import 'media_min.dart';
import 'media_misc.dart';
import 'media_recommendation.dart';
import 'media_review.dart';
import 'media_staff.dart';
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

  /// Number of chapters
  final int? chapters;

  /// Number of volumes
  final int? volumes;

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

  /// Paginated reviews
  final ReviewConnection? reviews;

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
    this.chapters,
    this.volumes,
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
    this.reviews,
  });

  /// Creates a media from a protobuf object
  factory Media.fromProto(pb.Media pbObj) {
    return Media(
      id: pbObj.base.id,
      title: Title.fromProto(pbObj.base.title),
      averageScore: pbObj.base.averageScore,
      coverImage: CoverImage.fromProto(pbObj.base.coverImage),
      episodes: pbObj.base.episodes,
      format: pbObj.base.format,
      isAdult: pbObj.base.isAdult,
      isFavourite: pbObj.base.isFavourite,
      siteUrl: pbObj.base.siteUrl,
      type: pbObj.type,
      bannerImage: pbObj.bannerImage,
      status: pbObj.status,
      seasonYear: pbObj.seasonYear,
      season: pbObj.season,
      meanScore: pbObj.hasMeanScore() ? pbObj.meanScore : null,
      favourites: pbObj.hasFavourites() ? pbObj.favourites : null,
      chapters: pbObj.hasChapters() ? pbObj.chapters : null,
      volumes: pbObj.hasVolumes() ? pbObj.volumes : null,
      popularity: pbObj.popularity,
      description: pbObj.description,
      genres: pbObj.genres,
      synonyms: pbObj.synonyms,
      trailer: pbObj.hasTrailer() ? Trailer.fromProto(pbObj.trailer) : null,
      studios: pbObj.studios.edges.map(StudioEdge.fromProto).toList(),
      tags: pbObj.tags.map(MediaTag.fromProto).toList(),
      externalLinks: pbObj.externalLinks.map(ExternalLink.fromProto).toList(),
      mediaListEntry: pbObj.hasMediaListEntry()
          ? MediaListEntry.fromProto(pbObj.mediaListEntry)
          : null,
      streamingEpisodes: pbObj.streamingEpisodes
          .map(StreamingEpisode.fromProto)
          .toList(),
      staff: pbObj.hasStaff() ? StaffConnection.fromProto(pbObj.staff) : null,
      nextAiringEpisode: pbObj.hasNextAiringEpisode()
          ? AiringSchedule.fromProto(pbObj.nextAiringEpisode)
          : null,
      characters: pbObj.hasCharacters()
          ? CharacterConnection.fromProto(pbObj.characters)
          : null,
      relations: pbObj.hasRelations()
          ? MediaConnection.fromProto(pbObj.relations)
          : null,
      recommendations: pbObj.hasRecommendations()
          ? RecommendationConnection.fromProto(pbObj.recommendations)
          : null,
      rankings: pbObj.rankings.map(MediaRank.fromProto).toList(),
      stats: pbObj.hasStats() ? MediaStats.fromProto(pbObj.stats) : null,
      trends: pbObj.hasTrends()
          ? MediaTrendConnection.fromProto(pbObj.trends)
          : null,
      reviews: pbObj.hasReviews()
          ? ReviewConnection.fromProto(pbObj.reviews)
          : null,
    );
  }

  /// Converts the media to a protobuf object
  @override
  pb.Media toProto() {
    final pbObj = pb.Media(
      base: super.toProto() as pbm.MediaMin,
      type: type,
      bannerImage: bannerImage,
      status: status,
      seasonYear: seasonYear,
      season: season,
      popularity: popularity,
      description: description,
      genres: genres,
      synonyms: synonyms,
      studios: pbs.StudioConnection(edges: studios.map((s) => s.toProto())),
      tags: tags.map((t) => t.toProto()),
      externalLinks: externalLinks.map((e) => e.toProto()),
      streamingEpisodes: streamingEpisodes.map((s) => s.toProto()),
      rankings: rankings.map((r) => r.toProto()),
    );

    if (meanScore != null) pbObj.meanScore = meanScore!;
    if (favourites != null) pbObj.favourites = favourites!;
    if (chapters != null) pbObj.chapters = chapters!;
    if (volumes != null) pbObj.volumes = volumes!;
    if (trailer != null) pbObj.trailer = trailer!.toProto();
    if (mediaListEntry != null) {
      pbObj.mediaListEntry =
          mediaListEntry!.toProto() as pb_list_entry.MediaListEntry;
    }
    if (staff != null) pbObj.staff = staff!.toProto();
    if (nextAiringEpisode != null) {
      pbObj.nextAiringEpisode = nextAiringEpisode!.toProto();
    }
    if (characters != null) pbObj.characters = characters!.toProto();
    if (relations != null) pbObj.relations = relations!.toProto();
    if (recommendations != null) {
      pbObj.recommendations = recommendations!.toProto();
    }
    if (stats != null) pbObj.stats = stats!.toProto();
    if (trends != null) pbObj.trends = trends!.toProto();
    if (reviews != null) pbObj.reviews = reviews!.toProto();

    return pbObj;
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
    int? chapters,
    int? volumes,
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
    ReviewConnection? reviews,
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
      chapters: chapters ?? this.chapters,
      volumes: volumes ?? this.volumes,
      popularity: popularity ?? this.popularity,
      description: description ?? this.description,
      genres: genres ?? this.genres,
      synonyms: synonyms ?? this.synonyms,
      trailer: trailer ?? this.trailer,
      studios: studios ?? this.studios,
      tags: tags ?? this.tags,
      externalLinks: externalLinks ?? this.externalLinks,
      mediaListEntry: mediaListEntry ?? this.mediaListEntry,
      streamingEpisodes: streamingEpisodes ?? this.streamingEpisodes,
      staff: staff ?? this.staff,
      nextAiringEpisode: nextAiringEpisode ?? this.nextAiringEpisode,
      characters: characters ?? this.characters,
      relations: relations ?? this.relations,
      recommendations: recommendations ?? this.recommendations,
      rankings: rankings ?? this.rankings,
      stats: stats ?? this.stats,
      trends: trends ?? this.trends,
      reviews: reviews ?? this.reviews,
    );
  }
}
