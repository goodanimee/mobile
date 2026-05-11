// This is a generated file - do not edit.
//
// Generated from proto/medialist.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class FuzzyDate extends $pb.GeneratedMessage {
  factory FuzzyDate({
    $core.int? day,
    $core.int? month,
    $core.int? year,
  }) {
    final result = create();
    if (day != null) result.day = day;
    if (month != null) result.month = month;
    if (year != null) result.year = year;
    return result;
  }

  FuzzyDate._();

  factory FuzzyDate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FuzzyDate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FuzzyDate',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'day')
    ..aI(2, _omitFieldNames ? '' : 'month')
    ..aI(3, _omitFieldNames ? '' : 'year')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FuzzyDate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FuzzyDate copyWith(void Function(FuzzyDate) updates) =>
      super.copyWith((message) => updates(message as FuzzyDate)) as FuzzyDate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FuzzyDate create() => FuzzyDate._();
  @$core.override
  FuzzyDate createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FuzzyDate getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FuzzyDate>(create);
  static FuzzyDate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get day => $_getIZ(0);
  @$pb.TagNumber(1)
  set day($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDay() => $_has(0);
  @$pb.TagNumber(1)
  void clearDay() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get month => $_getIZ(1);
  @$pb.TagNumber(2)
  set month($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMonth() => $_has(1);
  @$pb.TagNumber(2)
  void clearMonth() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get year => $_getIZ(2);
  @$pb.TagNumber(3)
  set year($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasYear() => $_has(2);
  @$pb.TagNumber(3)
  void clearYear() => $_clearField(3);
}

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

class Media extends $pb.GeneratedMessage {
  factory Media({
    $core.int? id,
    Title? title,
    $core.int? averageScore,
    $core.String? bannerImage,
    CoverImage? coverImage,
    $core.String? description,
    $core.int? duration,
    $core.int? episodes,
    $core.String? format,
    $core.Iterable<$core.String>? genres,
    $core.bool? isAdult,
    $core.bool? isFavourite,
    $core.int? popularity,
    $core.String? season,
    $core.int? seasonYear,
    $core.String? status,
    Trailer? trailer,
    $core.Iterable<$core.String>? synonyms,
    FuzzyDate? startDate,
    FuzzyDate? endDate,
    $core.int? meanScore,
    $core.int? favourites,
    $core.String? siteUrl,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (title != null) result.title = title;
    if (averageScore != null) result.averageScore = averageScore;
    if (bannerImage != null) result.bannerImage = bannerImage;
    if (coverImage != null) result.coverImage = coverImage;
    if (description != null) result.description = description;
    if (duration != null) result.duration = duration;
    if (episodes != null) result.episodes = episodes;
    if (format != null) result.format = format;
    if (genres != null) result.genres.addAll(genres);
    if (isAdult != null) result.isAdult = isAdult;
    if (isFavourite != null) result.isFavourite = isFavourite;
    if (popularity != null) result.popularity = popularity;
    if (season != null) result.season = season;
    if (seasonYear != null) result.seasonYear = seasonYear;
    if (status != null) result.status = status;
    if (trailer != null) result.trailer = trailer;
    if (synonyms != null) result.synonyms.addAll(synonyms);
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    if (meanScore != null) result.meanScore = meanScore;
    if (favourites != null) result.favourites = favourites;
    if (siteUrl != null) result.siteUrl = siteUrl;
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
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..aOM<Title>(2, _omitFieldNames ? '' : 'title', subBuilder: Title.create)
    ..aI(3, _omitFieldNames ? '' : 'averageScore')
    ..aOS(4, _omitFieldNames ? '' : 'bannerImage')
    ..aOM<CoverImage>(5, _omitFieldNames ? '' : 'coverImage',
        subBuilder: CoverImage.create)
    ..aOS(6, _omitFieldNames ? '' : 'description')
    ..aI(7, _omitFieldNames ? '' : 'duration')
    ..aI(8, _omitFieldNames ? '' : 'episodes')
    ..aOS(9, _omitFieldNames ? '' : 'format')
    ..pPS(10, _omitFieldNames ? '' : 'genres')
    ..aOB(11, _omitFieldNames ? '' : 'isAdult')
    ..aOB(12, _omitFieldNames ? '' : 'isFavourite')
    ..aI(13, _omitFieldNames ? '' : 'popularity')
    ..aOS(14, _omitFieldNames ? '' : 'season')
    ..aI(15, _omitFieldNames ? '' : 'seasonYear')
    ..aOS(16, _omitFieldNames ? '' : 'status')
    ..aOM<Trailer>(17, _omitFieldNames ? '' : 'trailer',
        subBuilder: Trailer.create)
    ..pPS(18, _omitFieldNames ? '' : 'synonyms')
    ..aOM<FuzzyDate>(19, _omitFieldNames ? '' : 'startDate',
        subBuilder: FuzzyDate.create)
    ..aOM<FuzzyDate>(20, _omitFieldNames ? '' : 'endDate',
        subBuilder: FuzzyDate.create)
    ..aI(21, _omitFieldNames ? '' : 'meanScore')
    ..aI(22, _omitFieldNames ? '' : 'favourites')
    ..aOS(23, _omitFieldNames ? '' : 'siteUrl')
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
  $core.String get bannerImage => $_getSZ(3);
  @$pb.TagNumber(4)
  set bannerImage($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBannerImage() => $_has(3);
  @$pb.TagNumber(4)
  void clearBannerImage() => $_clearField(4);

  @$pb.TagNumber(5)
  CoverImage get coverImage => $_getN(4);
  @$pb.TagNumber(5)
  set coverImage(CoverImage value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasCoverImage() => $_has(4);
  @$pb.TagNumber(5)
  void clearCoverImage() => $_clearField(5);
  @$pb.TagNumber(5)
  CoverImage ensureCoverImage() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.String get description => $_getSZ(5);
  @$pb.TagNumber(6)
  set description($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDescription() => $_has(5);
  @$pb.TagNumber(6)
  void clearDescription() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get duration => $_getIZ(6);
  @$pb.TagNumber(7)
  set duration($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDuration() => $_has(6);
  @$pb.TagNumber(7)
  void clearDuration() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get episodes => $_getIZ(7);
  @$pb.TagNumber(8)
  set episodes($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasEpisodes() => $_has(7);
  @$pb.TagNumber(8)
  void clearEpisodes() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get format => $_getSZ(8);
  @$pb.TagNumber(9)
  set format($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasFormat() => $_has(8);
  @$pb.TagNumber(9)
  void clearFormat() => $_clearField(9);

  @$pb.TagNumber(10)
  $pb.PbList<$core.String> get genres => $_getList(9);

  @$pb.TagNumber(11)
  $core.bool get isAdult => $_getBF(10);
  @$pb.TagNumber(11)
  set isAdult($core.bool value) => $_setBool(10, value);
  @$pb.TagNumber(11)
  $core.bool hasIsAdult() => $_has(10);
  @$pb.TagNumber(11)
  void clearIsAdult() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.bool get isFavourite => $_getBF(11);
  @$pb.TagNumber(12)
  set isFavourite($core.bool value) => $_setBool(11, value);
  @$pb.TagNumber(12)
  $core.bool hasIsFavourite() => $_has(11);
  @$pb.TagNumber(12)
  void clearIsFavourite() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.int get popularity => $_getIZ(12);
  @$pb.TagNumber(13)
  set popularity($core.int value) => $_setSignedInt32(12, value);
  @$pb.TagNumber(13)
  $core.bool hasPopularity() => $_has(12);
  @$pb.TagNumber(13)
  void clearPopularity() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get season => $_getSZ(13);
  @$pb.TagNumber(14)
  set season($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasSeason() => $_has(13);
  @$pb.TagNumber(14)
  void clearSeason() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.int get seasonYear => $_getIZ(14);
  @$pb.TagNumber(15)
  set seasonYear($core.int value) => $_setSignedInt32(14, value);
  @$pb.TagNumber(15)
  $core.bool hasSeasonYear() => $_has(14);
  @$pb.TagNumber(15)
  void clearSeasonYear() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get status => $_getSZ(15);
  @$pb.TagNumber(16)
  set status($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasStatus() => $_has(15);
  @$pb.TagNumber(16)
  void clearStatus() => $_clearField(16);

  @$pb.TagNumber(17)
  Trailer get trailer => $_getN(16);
  @$pb.TagNumber(17)
  set trailer(Trailer value) => $_setField(17, value);
  @$pb.TagNumber(17)
  $core.bool hasTrailer() => $_has(16);
  @$pb.TagNumber(17)
  void clearTrailer() => $_clearField(17);
  @$pb.TagNumber(17)
  Trailer ensureTrailer() => $_ensure(16);

  @$pb.TagNumber(18)
  $pb.PbList<$core.String> get synonyms => $_getList(17);

  @$pb.TagNumber(19)
  FuzzyDate get startDate => $_getN(18);
  @$pb.TagNumber(19)
  set startDate(FuzzyDate value) => $_setField(19, value);
  @$pb.TagNumber(19)
  $core.bool hasStartDate() => $_has(18);
  @$pb.TagNumber(19)
  void clearStartDate() => $_clearField(19);
  @$pb.TagNumber(19)
  FuzzyDate ensureStartDate() => $_ensure(18);

  @$pb.TagNumber(20)
  FuzzyDate get endDate => $_getN(19);
  @$pb.TagNumber(20)
  set endDate(FuzzyDate value) => $_setField(20, value);
  @$pb.TagNumber(20)
  $core.bool hasEndDate() => $_has(19);
  @$pb.TagNumber(20)
  void clearEndDate() => $_clearField(20);
  @$pb.TagNumber(20)
  FuzzyDate ensureEndDate() => $_ensure(19);

  @$pb.TagNumber(21)
  $core.int get meanScore => $_getIZ(20);
  @$pb.TagNumber(21)
  set meanScore($core.int value) => $_setSignedInt32(20, value);
  @$pb.TagNumber(21)
  $core.bool hasMeanScore() => $_has(20);
  @$pb.TagNumber(21)
  void clearMeanScore() => $_clearField(21);

  @$pb.TagNumber(22)
  $core.int get favourites => $_getIZ(21);
  @$pb.TagNumber(22)
  set favourites($core.int value) => $_setSignedInt32(21, value);
  @$pb.TagNumber(22)
  $core.bool hasFavourites() => $_has(21);
  @$pb.TagNumber(22)
  void clearFavourites() => $_clearField(22);

  @$pb.TagNumber(23)
  $core.String get siteUrl => $_getSZ(22);
  @$pb.TagNumber(23)
  set siteUrl($core.String value) => $_setString(22, value);
  @$pb.TagNumber(23)
  $core.bool hasSiteUrl() => $_has(22);
  @$pb.TagNumber(23)
  void clearSiteUrl() => $_clearField(23);
}

class MediaListEntry extends $pb.GeneratedMessage {
  factory MediaListEntry({
    Media? media,
    $core.int? progress,
    $core.int? repeat,
    $core.String? status,
    $core.double? score,
    FuzzyDate? startedAt,
    FuzzyDate? completedAt,
  }) {
    final result = create();
    if (media != null) result.media = media;
    if (progress != null) result.progress = progress;
    if (repeat != null) result.repeat = repeat;
    if (status != null) result.status = status;
    if (score != null) result.score = score;
    if (startedAt != null) result.startedAt = startedAt;
    if (completedAt != null) result.completedAt = completedAt;
    return result;
  }

  MediaListEntry._();

  factory MediaListEntry.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MediaListEntry.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MediaListEntry',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aOM<Media>(1, _omitFieldNames ? '' : 'media', subBuilder: Media.create)
    ..aI(2, _omitFieldNames ? '' : 'progress')
    ..aI(3, _omitFieldNames ? '' : 'repeat')
    ..aOS(4, _omitFieldNames ? '' : 'status')
    ..aD(5, _omitFieldNames ? '' : 'score')
    ..aOM<FuzzyDate>(6, _omitFieldNames ? '' : 'startedAt',
        subBuilder: FuzzyDate.create)
    ..aOM<FuzzyDate>(7, _omitFieldNames ? '' : 'completedAt',
        subBuilder: FuzzyDate.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaListEntry clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaListEntry copyWith(void Function(MediaListEntry) updates) =>
      super.copyWith((message) => updates(message as MediaListEntry))
          as MediaListEntry;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MediaListEntry create() => MediaListEntry._();
  @$core.override
  MediaListEntry createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MediaListEntry getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MediaListEntry>(create);
  static MediaListEntry? _defaultInstance;

  @$pb.TagNumber(1)
  Media get media => $_getN(0);
  @$pb.TagNumber(1)
  set media(Media value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasMedia() => $_has(0);
  @$pb.TagNumber(1)
  void clearMedia() => $_clearField(1);
  @$pb.TagNumber(1)
  Media ensureMedia() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.int get progress => $_getIZ(1);
  @$pb.TagNumber(2)
  set progress($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProgress() => $_has(1);
  @$pb.TagNumber(2)
  void clearProgress() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get repeat => $_getIZ(2);
  @$pb.TagNumber(3)
  set repeat($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRepeat() => $_has(2);
  @$pb.TagNumber(3)
  void clearRepeat() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get score => $_getN(4);
  @$pb.TagNumber(5)
  set score($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasScore() => $_has(4);
  @$pb.TagNumber(5)
  void clearScore() => $_clearField(5);

  @$pb.TagNumber(6)
  FuzzyDate get startedAt => $_getN(5);
  @$pb.TagNumber(6)
  set startedAt(FuzzyDate value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasStartedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearStartedAt() => $_clearField(6);
  @$pb.TagNumber(6)
  FuzzyDate ensureStartedAt() => $_ensure(5);

  @$pb.TagNumber(7)
  FuzzyDate get completedAt => $_getN(6);
  @$pb.TagNumber(7)
  set completedAt(FuzzyDate value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasCompletedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearCompletedAt() => $_clearField(7);
  @$pb.TagNumber(7)
  FuzzyDate ensureCompletedAt() => $_ensure(6);
}

class MediaList extends $pb.GeneratedMessage {
  factory MediaList({
    $core.String? name,
    $core.String? status,
    $core.Iterable<MediaListEntry>? entries,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (status != null) result.status = status;
    if (entries != null) result.entries.addAll(entries);
    return result;
  }

  MediaList._();

  factory MediaList.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MediaList.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MediaList',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..pPM<MediaListEntry>(3, _omitFieldNames ? '' : 'entries',
        subBuilder: MediaListEntry.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaList clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaList copyWith(void Function(MediaList) updates) =>
      super.copyWith((message) => updates(message as MediaList)) as MediaList;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MediaList create() => MediaList._();
  @$core.override
  MediaList createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MediaList getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MediaList>(create);
  static MediaList? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<MediaListEntry> get entries => $_getList(2);
}

class MediaListCollection extends $pb.GeneratedMessage {
  factory MediaListCollection({
    $core.bool? hasNextChunk,
    $core.Iterable<MediaList>? lists,
  }) {
    final result = create();
    if (hasNextChunk != null) result.hasNextChunk = hasNextChunk;
    if (lists != null) result.lists.addAll(lists);
    return result;
  }

  MediaListCollection._();

  factory MediaListCollection.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MediaListCollection.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MediaListCollection',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'hasNextChunk')
    ..pPM<MediaList>(2, _omitFieldNames ? '' : 'lists',
        subBuilder: MediaList.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaListCollection clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaListCollection copyWith(void Function(MediaListCollection) updates) =>
      super.copyWith((message) => updates(message as MediaListCollection))
          as MediaListCollection;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MediaListCollection create() => MediaListCollection._();
  @$core.override
  MediaListCollection createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MediaListCollection getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MediaListCollection>(create);
  static MediaListCollection? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get hasNextChunk => $_getBF(0);
  @$pb.TagNumber(1)
  set hasNextChunk($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasHasNextChunk() => $_has(0);
  @$pb.TagNumber(1)
  void clearHasNextChunk() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<MediaList> get lists => $_getList(1);
}

class FetchMediaListRequest extends $pb.GeneratedMessage {
  factory FetchMediaListRequest({
    $core.int? userId,
    $core.String? type,
    $core.Iterable<$core.String>? sort,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (type != null) result.type = type;
    if (sort != null) result.sort.addAll(sort);
    return result;
  }

  FetchMediaListRequest._();

  factory FetchMediaListRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FetchMediaListRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchMediaListRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'type')
    ..pPS(3, _omitFieldNames ? '' : 'sort')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchMediaListRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchMediaListRequest copyWith(
          void Function(FetchMediaListRequest) updates) =>
      super.copyWith((message) => updates(message as FetchMediaListRequest))
          as FetchMediaListRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FetchMediaListRequest create() => FetchMediaListRequest._();
  @$core.override
  FetchMediaListRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FetchMediaListRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchMediaListRequest>(create);
  static FetchMediaListRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get userId => $_getIZ(0);
  @$pb.TagNumber(1)
  set userId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get type => $_getSZ(1);
  @$pb.TagNumber(2)
  set type($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get sort => $_getList(2);
}

class FetchMediaListResponse extends $pb.GeneratedMessage {
  factory FetchMediaListResponse({
    MediaListCollection? collection,
    $core.String? error,
  }) {
    final result = create();
    if (collection != null) result.collection = collection;
    if (error != null) result.error = error;
    return result;
  }

  FetchMediaListResponse._();

  factory FetchMediaListResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FetchMediaListResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchMediaListResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aOM<MediaListCollection>(1, _omitFieldNames ? '' : 'collection',
        subBuilder: MediaListCollection.create)
    ..aOS(2, _omitFieldNames ? '' : 'error')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchMediaListResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchMediaListResponse copyWith(
          void Function(FetchMediaListResponse) updates) =>
      super.copyWith((message) => updates(message as FetchMediaListResponse))
          as FetchMediaListResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FetchMediaListResponse create() => FetchMediaListResponse._();
  @$core.override
  FetchMediaListResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FetchMediaListResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchMediaListResponse>(create);
  static FetchMediaListResponse? _defaultInstance;

  @$pb.TagNumber(1)
  MediaListCollection get collection => $_getN(0);
  @$pb.TagNumber(1)
  set collection(MediaListCollection value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCollection() => $_has(0);
  @$pb.TagNumber(1)
  void clearCollection() => $_clearField(1);
  @$pb.TagNumber(1)
  MediaListCollection ensureCollection() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get error => $_getSZ(1);
  @$pb.TagNumber(2)
  set error($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => $_clearField(2);
}

class Viewer extends $pb.GeneratedMessage {
  factory Viewer({
    $core.int? id,
    $core.String? name,
    $core.String? avatarMedium,
    $core.int? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (avatarMedium != null) result.avatarMedium = avatarMedium;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  Viewer._();

  factory Viewer.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Viewer.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Viewer',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'avatarMedium')
    ..aI(4, _omitFieldNames ? '' : 'createdAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Viewer clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Viewer copyWith(void Function(Viewer) updates) =>
      super.copyWith((message) => updates(message as Viewer)) as Viewer;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Viewer create() => Viewer._();
  @$core.override
  Viewer createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Viewer getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Viewer>(create);
  static Viewer? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get avatarMedium => $_getSZ(2);
  @$pb.TagNumber(3)
  set avatarMedium($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAvatarMedium() => $_has(2);
  @$pb.TagNumber(3)
  void clearAvatarMedium() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get createdAt => $_getIZ(3);
  @$pb.TagNumber(4)
  set createdAt($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCreatedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreatedAt() => $_clearField(4);
}

class FetchViewerResponse extends $pb.GeneratedMessage {
  factory FetchViewerResponse({
    Viewer? viewer,
    $core.String? error,
  }) {
    final result = create();
    if (viewer != null) result.viewer = viewer;
    if (error != null) result.error = error;
    return result;
  }

  FetchViewerResponse._();

  factory FetchViewerResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FetchViewerResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchViewerResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aOM<Viewer>(1, _omitFieldNames ? '' : 'viewer', subBuilder: Viewer.create)
    ..aOS(2, _omitFieldNames ? '' : 'error')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchViewerResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchViewerResponse copyWith(void Function(FetchViewerResponse) updates) =>
      super.copyWith((message) => updates(message as FetchViewerResponse))
          as FetchViewerResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FetchViewerResponse create() => FetchViewerResponse._();
  @$core.override
  FetchViewerResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FetchViewerResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchViewerResponse>(create);
  static FetchViewerResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Viewer get viewer => $_getN(0);
  @$pb.TagNumber(1)
  set viewer(Viewer value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasViewer() => $_has(0);
  @$pb.TagNumber(1)
  void clearViewer() => $_clearField(1);
  @$pb.TagNumber(1)
  Viewer ensureViewer() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get error => $_getSZ(1);
  @$pb.TagNumber(2)
  set error($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => $_clearField(2);
}

class FuzzyDateInput extends $pb.GeneratedMessage {
  factory FuzzyDateInput({
    $core.int? year,
    $core.int? month,
    $core.int? day,
  }) {
    final result = create();
    if (year != null) result.year = year;
    if (month != null) result.month = month;
    if (day != null) result.day = day;
    return result;
  }

  FuzzyDateInput._();

  factory FuzzyDateInput.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FuzzyDateInput.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FuzzyDateInput',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'year')
    ..aI(2, _omitFieldNames ? '' : 'month')
    ..aI(3, _omitFieldNames ? '' : 'day')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FuzzyDateInput clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FuzzyDateInput copyWith(void Function(FuzzyDateInput) updates) =>
      super.copyWith((message) => updates(message as FuzzyDateInput))
          as FuzzyDateInput;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FuzzyDateInput create() => FuzzyDateInput._();
  @$core.override
  FuzzyDateInput createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FuzzyDateInput getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FuzzyDateInput>(create);
  static FuzzyDateInput? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get year => $_getIZ(0);
  @$pb.TagNumber(1)
  set year($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasYear() => $_has(0);
  @$pb.TagNumber(1)
  void clearYear() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get month => $_getIZ(1);
  @$pb.TagNumber(2)
  set month($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMonth() => $_has(1);
  @$pb.TagNumber(2)
  void clearMonth() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get day => $_getIZ(2);
  @$pb.TagNumber(3)
  set day($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDay() => $_has(2);
  @$pb.TagNumber(3)
  void clearDay() => $_clearField(3);
}

class SaveMediaListEntryRequest extends $pb.GeneratedMessage {
  factory SaveMediaListEntryRequest({
    $core.int? mediaId,
    $core.int? progress,
    $core.String? status,
    $core.double? score,
    FuzzyDateInput? startedAt,
    FuzzyDateInput? completedAt,
  }) {
    final result = create();
    if (mediaId != null) result.mediaId = mediaId;
    if (progress != null) result.progress = progress;
    if (status != null) result.status = status;
    if (score != null) result.score = score;
    if (startedAt != null) result.startedAt = startedAt;
    if (completedAt != null) result.completedAt = completedAt;
    return result;
  }

  SaveMediaListEntryRequest._();

  factory SaveMediaListEntryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SaveMediaListEntryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SaveMediaListEntryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'mediaId')
    ..aI(2, _omitFieldNames ? '' : 'progress')
    ..aOS(3, _omitFieldNames ? '' : 'status')
    ..aD(4, _omitFieldNames ? '' : 'score')
    ..aOM<FuzzyDateInput>(5, _omitFieldNames ? '' : 'startedAt',
        subBuilder: FuzzyDateInput.create)
    ..aOM<FuzzyDateInput>(6, _omitFieldNames ? '' : 'completedAt',
        subBuilder: FuzzyDateInput.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SaveMediaListEntryRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SaveMediaListEntryRequest copyWith(
          void Function(SaveMediaListEntryRequest) updates) =>
      super.copyWith((message) => updates(message as SaveMediaListEntryRequest))
          as SaveMediaListEntryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SaveMediaListEntryRequest create() => SaveMediaListEntryRequest._();
  @$core.override
  SaveMediaListEntryRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SaveMediaListEntryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SaveMediaListEntryRequest>(create);
  static SaveMediaListEntryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get mediaId => $_getIZ(0);
  @$pb.TagNumber(1)
  set mediaId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMediaId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMediaId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get progress => $_getIZ(1);
  @$pb.TagNumber(2)
  set progress($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProgress() => $_has(1);
  @$pb.TagNumber(2)
  void clearProgress() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get status => $_getSZ(2);
  @$pb.TagNumber(3)
  set status($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get score => $_getN(3);
  @$pb.TagNumber(4)
  set score($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasScore() => $_has(3);
  @$pb.TagNumber(4)
  void clearScore() => $_clearField(4);

  @$pb.TagNumber(5)
  FuzzyDateInput get startedAt => $_getN(4);
  @$pb.TagNumber(5)
  set startedAt(FuzzyDateInput value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasStartedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearStartedAt() => $_clearField(5);
  @$pb.TagNumber(5)
  FuzzyDateInput ensureStartedAt() => $_ensure(4);

  @$pb.TagNumber(6)
  FuzzyDateInput get completedAt => $_getN(5);
  @$pb.TagNumber(6)
  set completedAt(FuzzyDateInput value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasCompletedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearCompletedAt() => $_clearField(6);
  @$pb.TagNumber(6)
  FuzzyDateInput ensureCompletedAt() => $_ensure(5);
}

class SaveMediaListEntryResponse extends $pb.GeneratedMessage {
  factory SaveMediaListEntryResponse({
    $core.int? id,
    $core.String? status,
    $core.int? progress,
    $core.double? score,
    $core.int? repeat,
    FuzzyDate? startedAt,
    FuzzyDate? completedAt,
    $core.String? error,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (status != null) result.status = status;
    if (progress != null) result.progress = progress;
    if (score != null) result.score = score;
    if (repeat != null) result.repeat = repeat;
    if (startedAt != null) result.startedAt = startedAt;
    if (completedAt != null) result.completedAt = completedAt;
    if (error != null) result.error = error;
    return result;
  }

  SaveMediaListEntryResponse._();

  factory SaveMediaListEntryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SaveMediaListEntryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SaveMediaListEntryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..aI(3, _omitFieldNames ? '' : 'progress')
    ..aD(4, _omitFieldNames ? '' : 'score')
    ..aI(5, _omitFieldNames ? '' : 'repeat')
    ..aOM<FuzzyDate>(6, _omitFieldNames ? '' : 'startedAt',
        subBuilder: FuzzyDate.create)
    ..aOM<FuzzyDate>(7, _omitFieldNames ? '' : 'completedAt',
        subBuilder: FuzzyDate.create)
    ..aOS(8, _omitFieldNames ? '' : 'error')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SaveMediaListEntryResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SaveMediaListEntryResponse copyWith(
          void Function(SaveMediaListEntryResponse) updates) =>
      super.copyWith(
              (message) => updates(message as SaveMediaListEntryResponse))
          as SaveMediaListEntryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SaveMediaListEntryResponse create() => SaveMediaListEntryResponse._();
  @$core.override
  SaveMediaListEntryResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SaveMediaListEntryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SaveMediaListEntryResponse>(create);
  static SaveMediaListEntryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get progress => $_getIZ(2);
  @$pb.TagNumber(3)
  set progress($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasProgress() => $_has(2);
  @$pb.TagNumber(3)
  void clearProgress() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get score => $_getN(3);
  @$pb.TagNumber(4)
  set score($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasScore() => $_has(3);
  @$pb.TagNumber(4)
  void clearScore() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get repeat => $_getIZ(4);
  @$pb.TagNumber(5)
  set repeat($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasRepeat() => $_has(4);
  @$pb.TagNumber(5)
  void clearRepeat() => $_clearField(5);

  @$pb.TagNumber(6)
  FuzzyDate get startedAt => $_getN(5);
  @$pb.TagNumber(6)
  set startedAt(FuzzyDate value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasStartedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearStartedAt() => $_clearField(6);
  @$pb.TagNumber(6)
  FuzzyDate ensureStartedAt() => $_ensure(5);

  @$pb.TagNumber(7)
  FuzzyDate get completedAt => $_getN(6);
  @$pb.TagNumber(7)
  set completedAt(FuzzyDate value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasCompletedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearCompletedAt() => $_clearField(7);
  @$pb.TagNumber(7)
  FuzzyDate ensureCompletedAt() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.String get error => $_getSZ(7);
  @$pb.TagNumber(8)
  set error($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasError() => $_has(7);
  @$pb.TagNumber(8)
  void clearError() => $_clearField(8);
}

class FetchMediaDetailsRequest extends $pb.GeneratedMessage {
  factory FetchMediaDetailsRequest({
    $core.int? mediaId,
  }) {
    final result = create();
    if (mediaId != null) result.mediaId = mediaId;
    return result;
  }

  FetchMediaDetailsRequest._();

  factory FetchMediaDetailsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FetchMediaDetailsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchMediaDetailsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'mediaId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchMediaDetailsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchMediaDetailsRequest copyWith(
          void Function(FetchMediaDetailsRequest) updates) =>
      super.copyWith((message) => updates(message as FetchMediaDetailsRequest))
          as FetchMediaDetailsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FetchMediaDetailsRequest create() => FetchMediaDetailsRequest._();
  @$core.override
  FetchMediaDetailsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FetchMediaDetailsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchMediaDetailsRequest>(create);
  static FetchMediaDetailsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get mediaId => $_getIZ(0);
  @$pb.TagNumber(1)
  set mediaId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMediaId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMediaId() => $_clearField(1);
}

class FetchMediaDetailsResponse extends $pb.GeneratedMessage {
  factory FetchMediaDetailsResponse({
    $core.String? rawJson,
    $core.String? error,
  }) {
    final result = create();
    if (rawJson != null) result.rawJson = rawJson;
    if (error != null) result.error = error;
    return result;
  }

  FetchMediaDetailsResponse._();

  factory FetchMediaDetailsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FetchMediaDetailsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchMediaDetailsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'rawJson')
    ..aOS(2, _omitFieldNames ? '' : 'error')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchMediaDetailsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchMediaDetailsResponse copyWith(
          void Function(FetchMediaDetailsResponse) updates) =>
      super.copyWith((message) => updates(message as FetchMediaDetailsResponse))
          as FetchMediaDetailsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FetchMediaDetailsResponse create() => FetchMediaDetailsResponse._();
  @$core.override
  FetchMediaDetailsResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FetchMediaDetailsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchMediaDetailsResponse>(create);
  static FetchMediaDetailsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get rawJson => $_getSZ(0);
  @$pb.TagNumber(1)
  set rawJson($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRawJson() => $_has(0);
  @$pb.TagNumber(1)
  void clearRawJson() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get error => $_getSZ(1);
  @$pb.TagNumber(2)
  set error($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => $_clearField(2);
}

class FetchMediaStaffRequest extends $pb.GeneratedMessage {
  factory FetchMediaStaffRequest({
    $core.int? mediaId,
    $core.int? page,
    $core.int? perPage,
  }) {
    final result = create();
    if (mediaId != null) result.mediaId = mediaId;
    if (page != null) result.page = page;
    if (perPage != null) result.perPage = perPage;
    return result;
  }

  FetchMediaStaffRequest._();

  factory FetchMediaStaffRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FetchMediaStaffRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchMediaStaffRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'mediaId')
    ..aI(2, _omitFieldNames ? '' : 'page')
    ..aI(3, _omitFieldNames ? '' : 'perPage')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchMediaStaffRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchMediaStaffRequest copyWith(
          void Function(FetchMediaStaffRequest) updates) =>
      super.copyWith((message) => updates(message as FetchMediaStaffRequest))
          as FetchMediaStaffRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FetchMediaStaffRequest create() => FetchMediaStaffRequest._();
  @$core.override
  FetchMediaStaffRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FetchMediaStaffRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchMediaStaffRequest>(create);
  static FetchMediaStaffRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get mediaId => $_getIZ(0);
  @$pb.TagNumber(1)
  set mediaId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMediaId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMediaId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get perPage => $_getIZ(2);
  @$pb.TagNumber(3)
  set perPage($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPerPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPerPage() => $_clearField(3);
}

class FetchMediaStaffResponse extends $pb.GeneratedMessage {
  factory FetchMediaStaffResponse({
    $core.String? rawJson,
    $core.String? error,
  }) {
    final result = create();
    if (rawJson != null) result.rawJson = rawJson;
    if (error != null) result.error = error;
    return result;
  }

  FetchMediaStaffResponse._();

  factory FetchMediaStaffResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FetchMediaStaffResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchMediaStaffResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'rawJson')
    ..aOS(2, _omitFieldNames ? '' : 'error')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchMediaStaffResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchMediaStaffResponse copyWith(
          void Function(FetchMediaStaffResponse) updates) =>
      super.copyWith((message) => updates(message as FetchMediaStaffResponse))
          as FetchMediaStaffResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FetchMediaStaffResponse create() => FetchMediaStaffResponse._();
  @$core.override
  FetchMediaStaffResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FetchMediaStaffResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchMediaStaffResponse>(create);
  static FetchMediaStaffResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get rawJson => $_getSZ(0);
  @$pb.TagNumber(1)
  set rawJson($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRawJson() => $_has(0);
  @$pb.TagNumber(1)
  void clearRawJson() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get error => $_getSZ(1);
  @$pb.TagNumber(2)
  set error($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => $_clearField(2);
}

class FetchMediaCharactersRequest extends $pb.GeneratedMessage {
  factory FetchMediaCharactersRequest({
    $core.int? mediaId,
    $core.int? page,
    $core.int? perPage,
  }) {
    final result = create();
    if (mediaId != null) result.mediaId = mediaId;
    if (page != null) result.page = page;
    if (perPage != null) result.perPage = perPage;
    return result;
  }

  FetchMediaCharactersRequest._();

  factory FetchMediaCharactersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FetchMediaCharactersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchMediaCharactersRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'mediaId')
    ..aI(2, _omitFieldNames ? '' : 'page')
    ..aI(3, _omitFieldNames ? '' : 'perPage')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchMediaCharactersRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchMediaCharactersRequest copyWith(
          void Function(FetchMediaCharactersRequest) updates) =>
      super.copyWith(
              (message) => updates(message as FetchMediaCharactersRequest))
          as FetchMediaCharactersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FetchMediaCharactersRequest create() =>
      FetchMediaCharactersRequest._();
  @$core.override
  FetchMediaCharactersRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FetchMediaCharactersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchMediaCharactersRequest>(create);
  static FetchMediaCharactersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get mediaId => $_getIZ(0);
  @$pb.TagNumber(1)
  set mediaId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMediaId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMediaId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get perPage => $_getIZ(2);
  @$pb.TagNumber(3)
  set perPage($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPerPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPerPage() => $_clearField(3);
}

class FetchMediaCharactersResponse extends $pb.GeneratedMessage {
  factory FetchMediaCharactersResponse({
    $core.String? rawJson,
    $core.String? error,
  }) {
    final result = create();
    if (rawJson != null) result.rawJson = rawJson;
    if (error != null) result.error = error;
    return result;
  }

  FetchMediaCharactersResponse._();

  factory FetchMediaCharactersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FetchMediaCharactersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchMediaCharactersResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'rawJson')
    ..aOS(2, _omitFieldNames ? '' : 'error')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchMediaCharactersResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchMediaCharactersResponse copyWith(
          void Function(FetchMediaCharactersResponse) updates) =>
      super.copyWith(
              (message) => updates(message as FetchMediaCharactersResponse))
          as FetchMediaCharactersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FetchMediaCharactersResponse create() =>
      FetchMediaCharactersResponse._();
  @$core.override
  FetchMediaCharactersResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FetchMediaCharactersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchMediaCharactersResponse>(create);
  static FetchMediaCharactersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get rawJson => $_getSZ(0);
  @$pb.TagNumber(1)
  set rawJson($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRawJson() => $_has(0);
  @$pb.TagNumber(1)
  void clearRawJson() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get error => $_getSZ(1);
  @$pb.TagNumber(2)
  set error($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => $_clearField(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
