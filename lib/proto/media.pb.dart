// This is a generated file - do not edit.
//
// Generated from media.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'media_character.pb.dart' as $5;
import 'media_edge.pb.dart' as $6;
import 'media_list_entry.pb.dart' as $2;
import 'media_min.pb.dart' as $0;
import 'media_misc.pb.dart' as $1;
import 'media_recommendation.pb.dart' as $7;
import 'media_review.pb.dart' as $9;
import 'media_staff.pb.dart' as $4;
import 'media_studio.pb.dart' as $3;
import 'media_trend.pb.dart' as $8;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class Media extends $pb.GeneratedMessage {
  factory Media({
    $0.MediaMin? base,
    $core.String? description,
    $core.String? bannerImage,
    $core.String? status,
    $core.Iterable<$core.String>? genres,
    $core.int? popularity,
    $core.String? season,
    $core.int? seasonYear,
    $core.String? type,
    $1.Trailer? trailer,
    $2.MediaListEntry? mediaListEntry,
    $3.StudioConnection? studios,
    $core.Iterable<$1.MediaTag>? tags,
    $core.Iterable<$1.ExternalLink>? externalLinks,
    $core.Iterable<$1.StreamingEpisode>? streamingEpisodes,
    $4.StaffConnection? staff,
    $1.AiringSchedule? nextAiringEpisode,
    $5.CharacterConnection? characters,
    $6.MediaConnection? relations,
    $7.RecommendationConnection? recommendations,
    $core.Iterable<$1.MediaRank>? rankings,
    $1.MediaStats? stats,
    $8.MediaTrendConnection? trends,
    $core.int? meanScore,
    $core.int? favourites,
    $core.Iterable<$core.String>? synonyms,
    $9.ReviewConnection? reviews,
  }) {
    final result = create();
    if (base != null) result.base = base;
    if (description != null) result.description = description;
    if (bannerImage != null) result.bannerImage = bannerImage;
    if (status != null) result.status = status;
    if (genres != null) result.genres.addAll(genres);
    if (popularity != null) result.popularity = popularity;
    if (season != null) result.season = season;
    if (seasonYear != null) result.seasonYear = seasonYear;
    if (type != null) result.type = type;
    if (trailer != null) result.trailer = trailer;
    if (mediaListEntry != null) result.mediaListEntry = mediaListEntry;
    if (studios != null) result.studios = studios;
    if (tags != null) result.tags.addAll(tags);
    if (externalLinks != null) result.externalLinks.addAll(externalLinks);
    if (streamingEpisodes != null)
      result.streamingEpisodes.addAll(streamingEpisodes);
    if (staff != null) result.staff = staff;
    if (nextAiringEpisode != null) result.nextAiringEpisode = nextAiringEpisode;
    if (characters != null) result.characters = characters;
    if (relations != null) result.relations = relations;
    if (recommendations != null) result.recommendations = recommendations;
    if (rankings != null) result.rankings.addAll(rankings);
    if (stats != null) result.stats = stats;
    if (trends != null) result.trends = trends;
    if (meanScore != null) result.meanScore = meanScore;
    if (favourites != null) result.favourites = favourites;
    if (synonyms != null) result.synonyms.addAll(synonyms);
    if (reviews != null) result.reviews = reviews;
    return result;
  }

  Media._();

  factory Media.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Media.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Media',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aOM<$0.MediaMin>(1, _omitFieldNames ? '' : 'base',
        subBuilder: $0.MediaMin.create)
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..aOS(3, _omitFieldNames ? '' : 'bannerImage')
    ..aOS(4, _omitFieldNames ? '' : 'status')
    ..pPS(5, _omitFieldNames ? '' : 'genres')
    ..aI(6, _omitFieldNames ? '' : 'popularity')
    ..aOS(7, _omitFieldNames ? '' : 'season')
    ..aI(8, _omitFieldNames ? '' : 'seasonYear')
    ..aOS(9, _omitFieldNames ? '' : 'type')
    ..aOM<$1.Trailer>(10, _omitFieldNames ? '' : 'trailer',
        subBuilder: $1.Trailer.create)
    ..aOM<$2.MediaListEntry>(11, _omitFieldNames ? '' : 'mediaListEntry',
        subBuilder: $2.MediaListEntry.create)
    ..aOM<$3.StudioConnection>(12, _omitFieldNames ? '' : 'studios',
        subBuilder: $3.StudioConnection.create)
    ..pPM<$1.MediaTag>(13, _omitFieldNames ? '' : 'tags',
        subBuilder: $1.MediaTag.create)
    ..pPM<$1.ExternalLink>(14, _omitFieldNames ? '' : 'externalLinks',
        subBuilder: $1.ExternalLink.create)
    ..pPM<$1.StreamingEpisode>(15, _omitFieldNames ? '' : 'streamingEpisodes',
        subBuilder: $1.StreamingEpisode.create)
    ..aOM<$4.StaffConnection>(16, _omitFieldNames ? '' : 'staff',
        subBuilder: $4.StaffConnection.create)
    ..aOM<$1.AiringSchedule>(17, _omitFieldNames ? '' : 'nextAiringEpisode',
        subBuilder: $1.AiringSchedule.create)
    ..aOM<$5.CharacterConnection>(18, _omitFieldNames ? '' : 'characters',
        subBuilder: $5.CharacterConnection.create)
    ..aOM<$6.MediaConnection>(19, _omitFieldNames ? '' : 'relations',
        subBuilder: $6.MediaConnection.create)
    ..aOM<$7.RecommendationConnection>(
        20, _omitFieldNames ? '' : 'recommendations',
        subBuilder: $7.RecommendationConnection.create)
    ..pPM<$1.MediaRank>(21, _omitFieldNames ? '' : 'rankings',
        subBuilder: $1.MediaRank.create)
    ..aOM<$1.MediaStats>(22, _omitFieldNames ? '' : 'stats',
        subBuilder: $1.MediaStats.create)
    ..aOM<$8.MediaTrendConnection>(23, _omitFieldNames ? '' : 'trends',
        subBuilder: $8.MediaTrendConnection.create)
    ..aI(24, _omitFieldNames ? '' : 'meanScore')
    ..aI(25, _omitFieldNames ? '' : 'favourites')
    ..pPS(26, _omitFieldNames ? '' : 'synonyms')
    ..aOM<$9.ReviewConnection>(27, _omitFieldNames ? '' : 'reviews',
        subBuilder: $9.ReviewConnection.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Media clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Media copyWith(void Function(Media) updates) =>
      super.copyWith((message) => updates(message as Media)) as Media;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Media create() => Media._();
  @$core.override
  Media createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Media getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Media>(create);
  static Media? _defaultInstance;

  @$pb.TagNumber(1)
  $0.MediaMin get base => $_getN(0);
  @$pb.TagNumber(1)
  set base($0.MediaMin value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasBase() => $_has(0);
  @$pb.TagNumber(1)
  void clearBase() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.MediaMin ensureBase() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get bannerImage => $_getSZ(2);
  @$pb.TagNumber(3)
  set bannerImage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBannerImage() => $_has(2);
  @$pb.TagNumber(3)
  void clearBannerImage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<$core.String> get genres => $_getList(4);

  @$pb.TagNumber(6)
  $core.int get popularity => $_getIZ(5);
  @$pb.TagNumber(6)
  set popularity($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPopularity() => $_has(5);
  @$pb.TagNumber(6)
  void clearPopularity() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get season => $_getSZ(6);
  @$pb.TagNumber(7)
  set season($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasSeason() => $_has(6);
  @$pb.TagNumber(7)
  void clearSeason() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get seasonYear => $_getIZ(7);
  @$pb.TagNumber(8)
  set seasonYear($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasSeasonYear() => $_has(7);
  @$pb.TagNumber(8)
  void clearSeasonYear() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get type => $_getSZ(8);
  @$pb.TagNumber(9)
  set type($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasType() => $_has(8);
  @$pb.TagNumber(9)
  void clearType() => $_clearField(9);

  @$pb.TagNumber(10)
  $1.Trailer get trailer => $_getN(9);
  @$pb.TagNumber(10)
  set trailer($1.Trailer value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasTrailer() => $_has(9);
  @$pb.TagNumber(10)
  void clearTrailer() => $_clearField(10);
  @$pb.TagNumber(10)
  $1.Trailer ensureTrailer() => $_ensure(9);

  @$pb.TagNumber(11)
  $2.MediaListEntry get mediaListEntry => $_getN(10);
  @$pb.TagNumber(11)
  set mediaListEntry($2.MediaListEntry value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasMediaListEntry() => $_has(10);
  @$pb.TagNumber(11)
  void clearMediaListEntry() => $_clearField(11);
  @$pb.TagNumber(11)
  $2.MediaListEntry ensureMediaListEntry() => $_ensure(10);

  @$pb.TagNumber(12)
  $3.StudioConnection get studios => $_getN(11);
  @$pb.TagNumber(12)
  set studios($3.StudioConnection value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasStudios() => $_has(11);
  @$pb.TagNumber(12)
  void clearStudios() => $_clearField(12);
  @$pb.TagNumber(12)
  $3.StudioConnection ensureStudios() => $_ensure(11);

  @$pb.TagNumber(13)
  $pb.PbList<$1.MediaTag> get tags => $_getList(12);

  @$pb.TagNumber(14)
  $pb.PbList<$1.ExternalLink> get externalLinks => $_getList(13);

  @$pb.TagNumber(15)
  $pb.PbList<$1.StreamingEpisode> get streamingEpisodes => $_getList(14);

  @$pb.TagNumber(16)
  $4.StaffConnection get staff => $_getN(15);
  @$pb.TagNumber(16)
  set staff($4.StaffConnection value) => $_setField(16, value);
  @$pb.TagNumber(16)
  $core.bool hasStaff() => $_has(15);
  @$pb.TagNumber(16)
  void clearStaff() => $_clearField(16);
  @$pb.TagNumber(16)
  $4.StaffConnection ensureStaff() => $_ensure(15);

  @$pb.TagNumber(17)
  $1.AiringSchedule get nextAiringEpisode => $_getN(16);
  @$pb.TagNumber(17)
  set nextAiringEpisode($1.AiringSchedule value) => $_setField(17, value);
  @$pb.TagNumber(17)
  $core.bool hasNextAiringEpisode() => $_has(16);
  @$pb.TagNumber(17)
  void clearNextAiringEpisode() => $_clearField(17);
  @$pb.TagNumber(17)
  $1.AiringSchedule ensureNextAiringEpisode() => $_ensure(16);

  @$pb.TagNumber(18)
  $5.CharacterConnection get characters => $_getN(17);
  @$pb.TagNumber(18)
  set characters($5.CharacterConnection value) => $_setField(18, value);
  @$pb.TagNumber(18)
  $core.bool hasCharacters() => $_has(17);
  @$pb.TagNumber(18)
  void clearCharacters() => $_clearField(18);
  @$pb.TagNumber(18)
  $5.CharacterConnection ensureCharacters() => $_ensure(17);

  @$pb.TagNumber(19)
  $6.MediaConnection get relations => $_getN(18);
  @$pb.TagNumber(19)
  set relations($6.MediaConnection value) => $_setField(19, value);
  @$pb.TagNumber(19)
  $core.bool hasRelations() => $_has(18);
  @$pb.TagNumber(19)
  void clearRelations() => $_clearField(19);
  @$pb.TagNumber(19)
  $6.MediaConnection ensureRelations() => $_ensure(18);

  @$pb.TagNumber(20)
  $7.RecommendationConnection get recommendations => $_getN(19);
  @$pb.TagNumber(20)
  set recommendations($7.RecommendationConnection value) =>
      $_setField(20, value);
  @$pb.TagNumber(20)
  $core.bool hasRecommendations() => $_has(19);
  @$pb.TagNumber(20)
  void clearRecommendations() => $_clearField(20);
  @$pb.TagNumber(20)
  $7.RecommendationConnection ensureRecommendations() => $_ensure(19);

  @$pb.TagNumber(21)
  $pb.PbList<$1.MediaRank> get rankings => $_getList(20);

  @$pb.TagNumber(22)
  $1.MediaStats get stats => $_getN(21);
  @$pb.TagNumber(22)
  set stats($1.MediaStats value) => $_setField(22, value);
  @$pb.TagNumber(22)
  $core.bool hasStats() => $_has(21);
  @$pb.TagNumber(22)
  void clearStats() => $_clearField(22);
  @$pb.TagNumber(22)
  $1.MediaStats ensureStats() => $_ensure(21);

  @$pb.TagNumber(23)
  $8.MediaTrendConnection get trends => $_getN(22);
  @$pb.TagNumber(23)
  set trends($8.MediaTrendConnection value) => $_setField(23, value);
  @$pb.TagNumber(23)
  $core.bool hasTrends() => $_has(22);
  @$pb.TagNumber(23)
  void clearTrends() => $_clearField(23);
  @$pb.TagNumber(23)
  $8.MediaTrendConnection ensureTrends() => $_ensure(22);

  @$pb.TagNumber(24)
  $core.int get meanScore => $_getIZ(23);
  @$pb.TagNumber(24)
  set meanScore($core.int value) => $_setSignedInt32(23, value);
  @$pb.TagNumber(24)
  $core.bool hasMeanScore() => $_has(23);
  @$pb.TagNumber(24)
  void clearMeanScore() => $_clearField(24);

  @$pb.TagNumber(25)
  $core.int get favourites => $_getIZ(24);
  @$pb.TagNumber(25)
  set favourites($core.int value) => $_setSignedInt32(24, value);
  @$pb.TagNumber(25)
  $core.bool hasFavourites() => $_has(24);
  @$pb.TagNumber(25)
  void clearFavourites() => $_clearField(25);

  @$pb.TagNumber(26)
  $pb.PbList<$core.String> get synonyms => $_getList(25);

  @$pb.TagNumber(27)
  $9.ReviewConnection get reviews => $_getN(26);
  @$pb.TagNumber(27)
  set reviews($9.ReviewConnection value) => $_setField(27, value);
  @$pb.TagNumber(27)
  $core.bool hasReviews() => $_has(26);
  @$pb.TagNumber(27)
  void clearReviews() => $_clearField(27);
  @$pb.TagNumber(27)
  $9.ReviewConnection ensureReviews() => $_ensure(26);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
