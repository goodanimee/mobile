// This is a generated file - do not edit.
//
// Generated from media_misc.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class Trailer extends $pb.GeneratedMessage {
  factory Trailer({
    $core.String? id,
    $core.String? site,
    $core.String? thumbnail,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (site != null) result.site = site;
    if (thumbnail != null) result.thumbnail = thumbnail;
    return result;
  }

  Trailer._();

  factory Trailer.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Trailer.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Trailer',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'site')
    ..aOS(3, _omitFieldNames ? '' : 'thumbnail')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Trailer clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Trailer copyWith(void Function(Trailer) updates) =>
      super.copyWith((message) => updates(message as Trailer)) as Trailer;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Trailer create() => Trailer._();
  @$core.override
  Trailer createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Trailer getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Trailer>(create);
  static Trailer? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get site => $_getSZ(1);
  @$pb.TagNumber(2)
  set site($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSite() => $_has(1);
  @$pb.TagNumber(2)
  void clearSite() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get thumbnail => $_getSZ(2);
  @$pb.TagNumber(3)
  set thumbnail($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasThumbnail() => $_has(2);
  @$pb.TagNumber(3)
  void clearThumbnail() => $_clearField(3);
}

class MediaTag extends $pb.GeneratedMessage {
  factory MediaTag({
    $core.int? id,
    $core.bool? isGeneralSpoiler,
    $core.bool? isMediaSpoiler,
    $core.String? name,
    $core.int? rank,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (isGeneralSpoiler != null) result.isGeneralSpoiler = isGeneralSpoiler;
    if (isMediaSpoiler != null) result.isMediaSpoiler = isMediaSpoiler;
    if (name != null) result.name = name;
    if (rank != null) result.rank = rank;
    return result;
  }

  MediaTag._();

  factory MediaTag.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MediaTag.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MediaTag',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..aOB(2, _omitFieldNames ? '' : 'isGeneralSpoiler')
    ..aOB(3, _omitFieldNames ? '' : 'isMediaSpoiler')
    ..aOS(4, _omitFieldNames ? '' : 'name')
    ..aI(5, _omitFieldNames ? '' : 'rank')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaTag clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaTag copyWith(void Function(MediaTag) updates) =>
      super.copyWith((message) => updates(message as MediaTag)) as MediaTag;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MediaTag create() => MediaTag._();
  @$core.override
  MediaTag createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MediaTag getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MediaTag>(create);
  static MediaTag? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get isGeneralSpoiler => $_getBF(1);
  @$pb.TagNumber(2)
  set isGeneralSpoiler($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIsGeneralSpoiler() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsGeneralSpoiler() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get isMediaSpoiler => $_getBF(2);
  @$pb.TagNumber(3)
  set isMediaSpoiler($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIsMediaSpoiler() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsMediaSpoiler() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get name => $_getSZ(3);
  @$pb.TagNumber(4)
  set name($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasName() => $_has(3);
  @$pb.TagNumber(4)
  void clearName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get rank => $_getIZ(4);
  @$pb.TagNumber(5)
  set rank($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasRank() => $_has(4);
  @$pb.TagNumber(5)
  void clearRank() => $_clearField(5);
}

class ExternalLink extends $pb.GeneratedMessage {
  factory ExternalLink({
    $core.String? language,
    $core.String? site,
    $core.String? url,
  }) {
    final result = create();
    if (language != null) result.language = language;
    if (site != null) result.site = site;
    if (url != null) result.url = url;
    return result;
  }

  ExternalLink._();

  factory ExternalLink.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ExternalLink.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExternalLink',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'language')
    ..aOS(2, _omitFieldNames ? '' : 'site')
    ..aOS(3, _omitFieldNames ? '' : 'url')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExternalLink clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExternalLink copyWith(void Function(ExternalLink) updates) =>
      super.copyWith((message) => updates(message as ExternalLink))
          as ExternalLink;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExternalLink create() => ExternalLink._();
  @$core.override
  ExternalLink createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ExternalLink getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExternalLink>(create);
  static ExternalLink? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get language => $_getSZ(0);
  @$pb.TagNumber(1)
  set language($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLanguage() => $_has(0);
  @$pb.TagNumber(1)
  void clearLanguage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get site => $_getSZ(1);
  @$pb.TagNumber(2)
  set site($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSite() => $_has(1);
  @$pb.TagNumber(2)
  void clearSite() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get url => $_getSZ(2);
  @$pb.TagNumber(3)
  set url($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearUrl() => $_clearField(3);
}

class AiringSchedule extends $pb.GeneratedMessage {
  factory AiringSchedule({
    $core.int? airingAt,
    $core.int? episode,
    $core.int? timeUntilAiring,
  }) {
    final result = create();
    if (airingAt != null) result.airingAt = airingAt;
    if (episode != null) result.episode = episode;
    if (timeUntilAiring != null) result.timeUntilAiring = timeUntilAiring;
    return result;
  }

  AiringSchedule._();

  factory AiringSchedule.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AiringSchedule.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AiringSchedule',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'airingAt')
    ..aI(2, _omitFieldNames ? '' : 'episode')
    ..aI(3, _omitFieldNames ? '' : 'timeUntilAiring')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AiringSchedule clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AiringSchedule copyWith(void Function(AiringSchedule) updates) =>
      super.copyWith((message) => updates(message as AiringSchedule))
          as AiringSchedule;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AiringSchedule create() => AiringSchedule._();
  @$core.override
  AiringSchedule createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AiringSchedule getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AiringSchedule>(create);
  static AiringSchedule? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get airingAt => $_getIZ(0);
  @$pb.TagNumber(1)
  set airingAt($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAiringAt() => $_has(0);
  @$pb.TagNumber(1)
  void clearAiringAt() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get episode => $_getIZ(1);
  @$pb.TagNumber(2)
  set episode($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEpisode() => $_has(1);
  @$pb.TagNumber(2)
  void clearEpisode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get timeUntilAiring => $_getIZ(2);
  @$pb.TagNumber(3)
  set timeUntilAiring($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTimeUntilAiring() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimeUntilAiring() => $_clearField(3);
}

class StreamingEpisode extends $pb.GeneratedMessage {
  factory StreamingEpisode({
    $core.String? thumbnail,
    $core.String? title,
    $core.String? url,
  }) {
    final result = create();
    if (thumbnail != null) result.thumbnail = thumbnail;
    if (title != null) result.title = title;
    if (url != null) result.url = url;
    return result;
  }

  StreamingEpisode._();

  factory StreamingEpisode.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StreamingEpisode.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StreamingEpisode',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'thumbnail')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'url')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamingEpisode clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamingEpisode copyWith(void Function(StreamingEpisode) updates) =>
      super.copyWith((message) => updates(message as StreamingEpisode))
          as StreamingEpisode;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StreamingEpisode create() => StreamingEpisode._();
  @$core.override
  StreamingEpisode createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StreamingEpisode getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StreamingEpisode>(create);
  static StreamingEpisode? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get thumbnail => $_getSZ(0);
  @$pb.TagNumber(1)
  set thumbnail($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasThumbnail() => $_has(0);
  @$pb.TagNumber(1)
  void clearThumbnail() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get url => $_getSZ(2);
  @$pb.TagNumber(3)
  set url($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearUrl() => $_clearField(3);
}

class MediaRank extends $pb.GeneratedMessage {
  factory MediaRank({
    $core.bool? allTime,
    $core.int? rank,
    $core.String? type,
    $core.String? season,
    $core.int? year,
  }) {
    final result = create();
    if (allTime != null) result.allTime = allTime;
    if (rank != null) result.rank = rank;
    if (type != null) result.type = type;
    if (season != null) result.season = season;
    if (year != null) result.year = year;
    return result;
  }

  MediaRank._();

  factory MediaRank.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MediaRank.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MediaRank',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'allTime')
    ..aI(2, _omitFieldNames ? '' : 'rank')
    ..aOS(3, _omitFieldNames ? '' : 'type')
    ..aOS(4, _omitFieldNames ? '' : 'season')
    ..aI(5, _omitFieldNames ? '' : 'year')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaRank clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaRank copyWith(void Function(MediaRank) updates) =>
      super.copyWith((message) => updates(message as MediaRank)) as MediaRank;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MediaRank create() => MediaRank._();
  @$core.override
  MediaRank createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MediaRank getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MediaRank>(create);
  static MediaRank? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get allTime => $_getBF(0);
  @$pb.TagNumber(1)
  set allTime($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAllTime() => $_has(0);
  @$pb.TagNumber(1)
  void clearAllTime() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get rank => $_getIZ(1);
  @$pb.TagNumber(2)
  set rank($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRank() => $_has(1);
  @$pb.TagNumber(2)
  void clearRank() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get type => $_getSZ(2);
  @$pb.TagNumber(3)
  set type($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get season => $_getSZ(3);
  @$pb.TagNumber(4)
  set season($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSeason() => $_has(3);
  @$pb.TagNumber(4)
  void clearSeason() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get year => $_getIZ(4);
  @$pb.TagNumber(5)
  set year($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasYear() => $_has(4);
  @$pb.TagNumber(5)
  void clearYear() => $_clearField(5);
}

class ScoreDistribution extends $pb.GeneratedMessage {
  factory ScoreDistribution({
    $core.int? amount,
    $core.int? score,
  }) {
    final result = create();
    if (amount != null) result.amount = amount;
    if (score != null) result.score = score;
    return result;
  }

  ScoreDistribution._();

  factory ScoreDistribution.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ScoreDistribution.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ScoreDistribution',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'amount')
    ..aI(2, _omitFieldNames ? '' : 'score')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScoreDistribution clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScoreDistribution copyWith(void Function(ScoreDistribution) updates) =>
      super.copyWith((message) => updates(message as ScoreDistribution))
          as ScoreDistribution;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ScoreDistribution create() => ScoreDistribution._();
  @$core.override
  ScoreDistribution createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ScoreDistribution getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ScoreDistribution>(create);
  static ScoreDistribution? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get amount => $_getIZ(0);
  @$pb.TagNumber(1)
  set amount($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAmount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmount() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get score => $_getIZ(1);
  @$pb.TagNumber(2)
  set score($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasScore() => $_has(1);
  @$pb.TagNumber(2)
  void clearScore() => $_clearField(2);
}

class StatusDistribution extends $pb.GeneratedMessage {
  factory StatusDistribution({
    $core.int? amount,
    $core.String? status,
  }) {
    final result = create();
    if (amount != null) result.amount = amount;
    if (status != null) result.status = status;
    return result;
  }

  StatusDistribution._();

  factory StatusDistribution.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StatusDistribution.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StatusDistribution',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'amount')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StatusDistribution clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StatusDistribution copyWith(void Function(StatusDistribution) updates) =>
      super.copyWith((message) => updates(message as StatusDistribution))
          as StatusDistribution;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StatusDistribution create() => StatusDistribution._();
  @$core.override
  StatusDistribution createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StatusDistribution getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StatusDistribution>(create);
  static StatusDistribution? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get amount => $_getIZ(0);
  @$pb.TagNumber(1)
  set amount($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAmount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmount() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);
}

class MediaStats extends $pb.GeneratedMessage {
  factory MediaStats({
    $core.Iterable<ScoreDistribution>? scoreDistribution,
    $core.Iterable<StatusDistribution>? statusDistribution,
  }) {
    final result = create();
    if (scoreDistribution != null)
      result.scoreDistribution.addAll(scoreDistribution);
    if (statusDistribution != null)
      result.statusDistribution.addAll(statusDistribution);
    return result;
  }

  MediaStats._();

  factory MediaStats.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MediaStats.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MediaStats',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..pPM<ScoreDistribution>(1, _omitFieldNames ? '' : 'scoreDistribution',
        subBuilder: ScoreDistribution.create)
    ..pPM<StatusDistribution>(2, _omitFieldNames ? '' : 'statusDistribution',
        subBuilder: StatusDistribution.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaStats clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaStats copyWith(void Function(MediaStats) updates) =>
      super.copyWith((message) => updates(message as MediaStats)) as MediaStats;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MediaStats create() => MediaStats._();
  @$core.override
  MediaStats createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MediaStats getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MediaStats>(create);
  static MediaStats? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<ScoreDistribution> get scoreDistribution => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<StatusDistribution> get statusDistribution => $_getList(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
