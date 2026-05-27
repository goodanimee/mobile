// This is a generated file - do not edit.
//
// Generated from media_min.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class Title extends $pb.GeneratedMessage {
  factory Title({
    $core.String? english,
    $core.String? native,
    $core.String? romaji,
    $core.String? userPreferred,
  }) {
    final result = create();
    if (english != null) result.english = english;
    if (native != null) result.native = native;
    if (romaji != null) result.romaji = romaji;
    if (userPreferred != null) result.userPreferred = userPreferred;
    return result;
  }

  Title._();

  factory Title.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Title.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Title',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'english')
    ..aOS(2, _omitFieldNames ? '' : 'native')
    ..aOS(3, _omitFieldNames ? '' : 'romaji')
    ..aOS(4, _omitFieldNames ? '' : 'userPreferred')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Title clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Title copyWith(void Function(Title) updates) =>
      super.copyWith((message) => updates(message as Title)) as Title;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Title create() => Title._();
  @$core.override
  Title createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Title getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Title>(create);
  static Title? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get english => $_getSZ(0);
  @$pb.TagNumber(1)
  set english($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEnglish() => $_has(0);
  @$pb.TagNumber(1)
  void clearEnglish() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get native => $_getSZ(1);
  @$pb.TagNumber(2)
  set native($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNative() => $_has(1);
  @$pb.TagNumber(2)
  void clearNative() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get romaji => $_getSZ(2);
  @$pb.TagNumber(3)
  set romaji($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRomaji() => $_has(2);
  @$pb.TagNumber(3)
  void clearRomaji() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get userPreferred => $_getSZ(3);
  @$pb.TagNumber(4)
  set userPreferred($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUserPreferred() => $_has(3);
  @$pb.TagNumber(4)
  void clearUserPreferred() => $_clearField(4);
}

class CoverImage extends $pb.GeneratedMessage {
  factory CoverImage({
    $core.String? medium,
    $core.String? large,
    $core.String? extraLarge,
    $core.String? color,
  }) {
    final result = create();
    if (medium != null) result.medium = medium;
    if (large != null) result.large = large;
    if (extraLarge != null) result.extraLarge = extraLarge;
    if (color != null) result.color = color;
    return result;
  }

  CoverImage._();

  factory CoverImage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CoverImage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CoverImage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'medium')
    ..aOS(2, _omitFieldNames ? '' : 'large')
    ..aOS(3, _omitFieldNames ? '' : 'extraLarge')
    ..aOS(4, _omitFieldNames ? '' : 'color')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CoverImage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CoverImage copyWith(void Function(CoverImage) updates) =>
      super.copyWith((message) => updates(message as CoverImage)) as CoverImage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CoverImage create() => CoverImage._();
  @$core.override
  CoverImage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CoverImage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CoverImage>(create);
  static CoverImage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get medium => $_getSZ(0);
  @$pb.TagNumber(1)
  set medium($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMedium() => $_has(0);
  @$pb.TagNumber(1)
  void clearMedium() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get large => $_getSZ(1);
  @$pb.TagNumber(2)
  set large($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLarge() => $_has(1);
  @$pb.TagNumber(2)
  void clearLarge() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get extraLarge => $_getSZ(2);
  @$pb.TagNumber(3)
  set extraLarge($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasExtraLarge() => $_has(2);
  @$pb.TagNumber(3)
  void clearExtraLarge() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get color => $_getSZ(3);
  @$pb.TagNumber(4)
  set color($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasColor() => $_has(3);
  @$pb.TagNumber(4)
  void clearColor() => $_clearField(4);
}

class MediaMin extends $pb.GeneratedMessage {
  factory MediaMin({
    $core.int? id,
    Title? title,
    $core.int? averageScore,
    CoverImage? coverImage,
    $core.int? episodes,
    $core.String? format,
    $core.bool? isAdult,
    $core.bool? isFavourite,
    $core.String? siteUrl,
    $core.int? chapters,
    $core.int? volumes,
    $core.String? type,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (title != null) result.title = title;
    if (averageScore != null) result.averageScore = averageScore;
    if (coverImage != null) result.coverImage = coverImage;
    if (episodes != null) result.episodes = episodes;
    if (format != null) result.format = format;
    if (isAdult != null) result.isAdult = isAdult;
    if (isFavourite != null) result.isFavourite = isFavourite;
    if (siteUrl != null) result.siteUrl = siteUrl;
    if (chapters != null) result.chapters = chapters;
    if (volumes != null) result.volumes = volumes;
    if (type != null) result.type = type;
    return result;
  }

  MediaMin._();

  factory MediaMin.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MediaMin.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MediaMin',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..aOM<Title>(2, _omitFieldNames ? '' : 'title', subBuilder: Title.create)
    ..aI(3, _omitFieldNames ? '' : 'averageScore')
    ..aOM<CoverImage>(4, _omitFieldNames ? '' : 'coverImage',
        subBuilder: CoverImage.create)
    ..aI(5, _omitFieldNames ? '' : 'episodes')
    ..aOS(6, _omitFieldNames ? '' : 'format')
    ..aOB(7, _omitFieldNames ? '' : 'isAdult')
    ..aOB(8, _omitFieldNames ? '' : 'isFavourite')
    ..aOS(9, _omitFieldNames ? '' : 'siteUrl')
    ..aI(10, _omitFieldNames ? '' : 'chapters')
    ..aI(11, _omitFieldNames ? '' : 'volumes')
    ..aOS(12, _omitFieldNames ? '' : 'type')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaMin clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaMin copyWith(void Function(MediaMin) updates) =>
      super.copyWith((message) => updates(message as MediaMin)) as MediaMin;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MediaMin create() => MediaMin._();
  @$core.override
  MediaMin createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MediaMin getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MediaMin>(create);
  static MediaMin? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  Title get title => $_getN(1);
  @$pb.TagNumber(2)
  set title(Title value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);
  @$pb.TagNumber(2)
  Title ensureTitle() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.int get averageScore => $_getIZ(2);
  @$pb.TagNumber(3)
  set averageScore($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAverageScore() => $_has(2);
  @$pb.TagNumber(3)
  void clearAverageScore() => $_clearField(3);

  @$pb.TagNumber(4)
  CoverImage get coverImage => $_getN(3);
  @$pb.TagNumber(4)
  set coverImage(CoverImage value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasCoverImage() => $_has(3);
  @$pb.TagNumber(4)
  void clearCoverImage() => $_clearField(4);
  @$pb.TagNumber(4)
  CoverImage ensureCoverImage() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.int get episodes => $_getIZ(4);
  @$pb.TagNumber(5)
  set episodes($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasEpisodes() => $_has(4);
  @$pb.TagNumber(5)
  void clearEpisodes() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get format => $_getSZ(5);
  @$pb.TagNumber(6)
  set format($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasFormat() => $_has(5);
  @$pb.TagNumber(6)
  void clearFormat() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.bool get isAdult => $_getBF(6);
  @$pb.TagNumber(7)
  set isAdult($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasIsAdult() => $_has(6);
  @$pb.TagNumber(7)
  void clearIsAdult() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.bool get isFavourite => $_getBF(7);
  @$pb.TagNumber(8)
  set isFavourite($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasIsFavourite() => $_has(7);
  @$pb.TagNumber(8)
  void clearIsFavourite() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get siteUrl => $_getSZ(8);
  @$pb.TagNumber(9)
  set siteUrl($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasSiteUrl() => $_has(8);
  @$pb.TagNumber(9)
  void clearSiteUrl() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.int get chapters => $_getIZ(9);
  @$pb.TagNumber(10)
  set chapters($core.int value) => $_setSignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasChapters() => $_has(9);
  @$pb.TagNumber(10)
  void clearChapters() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.int get volumes => $_getIZ(10);
  @$pb.TagNumber(11)
  set volumes($core.int value) => $_setSignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasVolumes() => $_has(10);
  @$pb.TagNumber(11)
  void clearVolumes() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get type => $_getSZ(11);
  @$pb.TagNumber(12)
  set type($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasType() => $_has(11);
  @$pb.TagNumber(12)
  void clearType() => $_clearField(12);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
