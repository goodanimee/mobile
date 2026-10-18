// This is a generated file - do not edit.
//
// Generated from api.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pb.dart' as $5;
import 'media.pb.dart' as $3;
import 'media_activity.pb.dart' as $6;
import 'media_character.pb.dart' as $11;
import 'media_list.pb.dart' as $0;
import 'media_list_entry.pb.dart' as $2;
import 'media_min.pb.dart' as $10;
import 'media_misc.pb.dart' as $9;
import 'media_review.pb.dart' as $4;
import 'media_staff.pb.dart' as $8;
import 'media_studio.pb.dart' as $7;
import 'viewer.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class FetchMediaListRequest extends $pb.GeneratedMessage {
  factory FetchMediaListRequest({
    $core.int? userId,
    $core.String? type,
    $core.Iterable<$core.String>? sort,
  }) {
    final result = FetchMediaListRequest._();
    if (userId != null) result.userId = userId;
    if (type != null) result.type = type;
    if (sort != null) result.sort.addAll(sort);
    return result;
  }

  FetchMediaListRequest._();

  factory FetchMediaListRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchMediaListRequest()..mergeFromBuffer(data, registry);
  factory FetchMediaListRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchMediaListRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchMediaListRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: FetchMediaListRequest.$_createMessage)
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
  @$core.Deprecated(
      'Use FetchMediaListRequest() / FetchMediaListRequest.new instead')
  static FetchMediaListRequest create() => FetchMediaListRequest._();
  static $pb.GeneratedMessage $_createMessage() => FetchMediaListRequest._();
  @$core.override
  FetchMediaListRequest createEmptyInstance() => FetchMediaListRequest._();
  @$core.pragma('dart2js:noInline')
  static FetchMediaListRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchMediaListRequest>(
          FetchMediaListRequest.$_createMessage);
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
    $0.MediaListCollection? collection,
    $core.String? error,
  }) {
    final result = FetchMediaListResponse._();
    if (collection != null) result.collection = collection;
    if (error != null) result.error = error;
    return result;
  }

  FetchMediaListResponse._();

  factory FetchMediaListResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchMediaListResponse()..mergeFromBuffer(data, registry);
  factory FetchMediaListResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchMediaListResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchMediaListResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: FetchMediaListResponse.$_createMessage)
    ..aOM<$0.MediaListCollection>(1, _omitFieldNames ? '' : 'collection',
        subBuilder: $0.MediaListCollection.$_createMessage)
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
  @$core.Deprecated(
      'Use FetchMediaListResponse() / FetchMediaListResponse.new instead')
  static FetchMediaListResponse create() => FetchMediaListResponse._();
  static $pb.GeneratedMessage $_createMessage() => FetchMediaListResponse._();
  @$core.override
  FetchMediaListResponse createEmptyInstance() => FetchMediaListResponse._();
  @$core.pragma('dart2js:noInline')
  static FetchMediaListResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchMediaListResponse>(
          FetchMediaListResponse.$_createMessage);
  static FetchMediaListResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $0.MediaListCollection get collection => $_getN(0);
  @$pb.TagNumber(1)
  set collection($0.MediaListCollection value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCollection() => $_has(0);
  @$pb.TagNumber(1)
  void clearCollection() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.MediaListCollection ensureCollection() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get error => $_getSZ(1);
  @$pb.TagNumber(2)
  set error($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => $_clearField(2);
}

class FetchViewerResponse extends $pb.GeneratedMessage {
  factory FetchViewerResponse({
    $1.Viewer? viewer,
    $core.String? error,
  }) {
    final result = FetchViewerResponse._();
    if (viewer != null) result.viewer = viewer;
    if (error != null) result.error = error;
    return result;
  }

  FetchViewerResponse._();

  factory FetchViewerResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchViewerResponse()..mergeFromBuffer(data, registry);
  factory FetchViewerResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchViewerResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchViewerResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: FetchViewerResponse.$_createMessage)
    ..aOM<$1.Viewer>(1, _omitFieldNames ? '' : 'viewer',
        subBuilder: $1.Viewer.$_createMessage)
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
  @$core
      .Deprecated('Use FetchViewerResponse() / FetchViewerResponse.new instead')
  static FetchViewerResponse create() => FetchViewerResponse._();
  static $pb.GeneratedMessage $_createMessage() => FetchViewerResponse._();
  @$core.override
  FetchViewerResponse createEmptyInstance() => FetchViewerResponse._();
  @$core.pragma('dart2js:noInline')
  static FetchViewerResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchViewerResponse>(
          FetchViewerResponse.$_createMessage);
  static FetchViewerResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Viewer get viewer => $_getN(0);
  @$pb.TagNumber(1)
  set viewer($1.Viewer value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasViewer() => $_has(0);
  @$pb.TagNumber(1)
  void clearViewer() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.Viewer ensureViewer() => $_ensure(0);

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
    final result = FuzzyDateInput._();
    if (year != null) result.year = year;
    if (month != null) result.month = month;
    if (day != null) result.day = day;
    return result;
  }

  FuzzyDateInput._();

  factory FuzzyDateInput.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FuzzyDateInput()..mergeFromBuffer(data, registry);
  factory FuzzyDateInput.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FuzzyDateInput()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FuzzyDateInput',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: FuzzyDateInput.$_createMessage)
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
  @$core.Deprecated('Use FuzzyDateInput() / FuzzyDateInput.new instead')
  static FuzzyDateInput create() => FuzzyDateInput._();
  static $pb.GeneratedMessage $_createMessage() => FuzzyDateInput._();
  @$core.override
  FuzzyDateInput createEmptyInstance() => FuzzyDateInput._();
  @$core.pragma('dart2js:noInline')
  static FuzzyDateInput getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FuzzyDateInput>(
          FuzzyDateInput.$_createMessage);
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

class CustomListsInput extends $pb.GeneratedMessage {
  factory CustomListsInput({
    $core.Iterable<$core.String>? customLists,
  }) {
    final result = CustomListsInput._();
    if (customLists != null) result.customLists.addAll(customLists);
    return result;
  }

  CustomListsInput._();

  factory CustomListsInput.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CustomListsInput()..mergeFromBuffer(data, registry);
  factory CustomListsInput.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CustomListsInput()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CustomListsInput',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: CustomListsInput.$_createMessage)
    ..pPS(1, _omitFieldNames ? '' : 'customLists')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CustomListsInput clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CustomListsInput copyWith(void Function(CustomListsInput) updates) =>
      super.copyWith((message) => updates(message as CustomListsInput))
          as CustomListsInput;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use CustomListsInput() / CustomListsInput.new instead')
  static CustomListsInput create() => CustomListsInput._();
  static $pb.GeneratedMessage $_createMessage() => CustomListsInput._();
  @$core.override
  CustomListsInput createEmptyInstance() => CustomListsInput._();
  @$core.pragma('dart2js:noInline')
  static CustomListsInput getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CustomListsInput>(
          CustomListsInput.$_createMessage);
  static CustomListsInput? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get customLists => $_getList(0);
}

class SaveMediaListEntryRequest extends $pb.GeneratedMessage {
  factory SaveMediaListEntryRequest({
    $core.int? mediaId,
    $core.int? progress,
    $core.String? status,
    $core.double? score,
    FuzzyDateInput? startedAt,
    FuzzyDateInput? completedAt,
    $core.int? progressVolumes,
    $core.int? repeat,
    $core.bool? private,
    $core.bool? hiddenFromStatusLists,
    $core.String? notes,
    CustomListsInput? customLists,
  }) {
    final result = SaveMediaListEntryRequest._();
    if (mediaId != null) result.mediaId = mediaId;
    if (progress != null) result.progress = progress;
    if (status != null) result.status = status;
    if (score != null) result.score = score;
    if (startedAt != null) result.startedAt = startedAt;
    if (completedAt != null) result.completedAt = completedAt;
    if (progressVolumes != null) result.progressVolumes = progressVolumes;
    if (repeat != null) result.repeat = repeat;
    if (private != null) result.private = private;
    if (hiddenFromStatusLists != null)
      result.hiddenFromStatusLists = hiddenFromStatusLists;
    if (notes != null) result.notes = notes;
    if (customLists != null) result.customLists = customLists;
    return result;
  }

  SaveMediaListEntryRequest._();

  factory SaveMediaListEntryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SaveMediaListEntryRequest()..mergeFromBuffer(data, registry);
  factory SaveMediaListEntryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SaveMediaListEntryRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SaveMediaListEntryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: SaveMediaListEntryRequest.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'mediaId')
    ..aI(2, _omitFieldNames ? '' : 'progress')
    ..aOS(3, _omitFieldNames ? '' : 'status')
    ..aD(4, _omitFieldNames ? '' : 'score')
    ..aOM<FuzzyDateInput>(5, _omitFieldNames ? '' : 'startedAt',
        subBuilder: FuzzyDateInput.$_createMessage)
    ..aOM<FuzzyDateInput>(6, _omitFieldNames ? '' : 'completedAt',
        subBuilder: FuzzyDateInput.$_createMessage)
    ..aI(7, _omitFieldNames ? '' : 'progressVolumes')
    ..aI(8, _omitFieldNames ? '' : 'repeat')
    ..aOB(9, _omitFieldNames ? '' : 'private')
    ..aOB(10, _omitFieldNames ? '' : 'hiddenFromStatusLists')
    ..aOS(11, _omitFieldNames ? '' : 'notes')
    ..aOM<CustomListsInput>(12, _omitFieldNames ? '' : 'customLists',
        subBuilder: CustomListsInput.$_createMessage)
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
  @$core.Deprecated(
      'Use SaveMediaListEntryRequest() / SaveMediaListEntryRequest.new instead')
  static SaveMediaListEntryRequest create() => SaveMediaListEntryRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      SaveMediaListEntryRequest._();
  @$core.override
  SaveMediaListEntryRequest createEmptyInstance() =>
      SaveMediaListEntryRequest._();
  @$core.pragma('dart2js:noInline')
  static SaveMediaListEntryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SaveMediaListEntryRequest>(
          SaveMediaListEntryRequest.$_createMessage);
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

  @$pb.TagNumber(7)
  $core.int get progressVolumes => $_getIZ(6);
  @$pb.TagNumber(7)
  set progressVolumes($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasProgressVolumes() => $_has(6);
  @$pb.TagNumber(7)
  void clearProgressVolumes() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get repeat => $_getIZ(7);
  @$pb.TagNumber(8)
  set repeat($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasRepeat() => $_has(7);
  @$pb.TagNumber(8)
  void clearRepeat() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.bool get private => $_getBF(8);
  @$pb.TagNumber(9)
  set private($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasPrivate() => $_has(8);
  @$pb.TagNumber(9)
  void clearPrivate() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.bool get hiddenFromStatusLists => $_getBF(9);
  @$pb.TagNumber(10)
  set hiddenFromStatusLists($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasHiddenFromStatusLists() => $_has(9);
  @$pb.TagNumber(10)
  void clearHiddenFromStatusLists() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get notes => $_getSZ(10);
  @$pb.TagNumber(11)
  set notes($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasNotes() => $_has(10);
  @$pb.TagNumber(11)
  void clearNotes() => $_clearField(11);

  @$pb.TagNumber(12)
  CustomListsInput get customLists => $_getN(11);
  @$pb.TagNumber(12)
  set customLists(CustomListsInput value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasCustomLists() => $_has(11);
  @$pb.TagNumber(12)
  void clearCustomLists() => $_clearField(12);
  @$pb.TagNumber(12)
  CustomListsInput ensureCustomLists() => $_ensure(11);
}

class SaveMediaListEntryResponse extends $pb.GeneratedMessage {
  factory SaveMediaListEntryResponse({
    $2.MediaListEntry? entry,
    $core.String? error,
  }) {
    final result = SaveMediaListEntryResponse._();
    if (entry != null) result.entry = entry;
    if (error != null) result.error = error;
    return result;
  }

  SaveMediaListEntryResponse._();

  factory SaveMediaListEntryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SaveMediaListEntryResponse()..mergeFromBuffer(data, registry);
  factory SaveMediaListEntryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SaveMediaListEntryResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SaveMediaListEntryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: SaveMediaListEntryResponse.$_createMessage)
    ..aOM<$2.MediaListEntry>(1, _omitFieldNames ? '' : 'entry',
        subBuilder: $2.MediaListEntry.$_createMessage)
    ..aOS(2, _omitFieldNames ? '' : 'error')
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
  @$core.Deprecated(
      'Use SaveMediaListEntryResponse() / SaveMediaListEntryResponse.new instead')
  static SaveMediaListEntryResponse create() => SaveMediaListEntryResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      SaveMediaListEntryResponse._();
  @$core.override
  SaveMediaListEntryResponse createEmptyInstance() =>
      SaveMediaListEntryResponse._();
  @$core.pragma('dart2js:noInline')
  static SaveMediaListEntryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SaveMediaListEntryResponse>(
          SaveMediaListEntryResponse.$_createMessage);
  static SaveMediaListEntryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $2.MediaListEntry get entry => $_getN(0);
  @$pb.TagNumber(1)
  set entry($2.MediaListEntry value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasEntry() => $_has(0);
  @$pb.TagNumber(1)
  void clearEntry() => $_clearField(1);
  @$pb.TagNumber(1)
  $2.MediaListEntry ensureEntry() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get error => $_getSZ(1);
  @$pb.TagNumber(2)
  set error($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => $_clearField(2);
}

class FetchMediaDetailsRequest extends $pb.GeneratedMessage {
  factory FetchMediaDetailsRequest({
    $core.int? mediaId,
  }) {
    final result = FetchMediaDetailsRequest._();
    if (mediaId != null) result.mediaId = mediaId;
    return result;
  }

  FetchMediaDetailsRequest._();

  factory FetchMediaDetailsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchMediaDetailsRequest()..mergeFromBuffer(data, registry);
  factory FetchMediaDetailsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchMediaDetailsRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchMediaDetailsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: FetchMediaDetailsRequest.$_createMessage)
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
  @$core.Deprecated(
      'Use FetchMediaDetailsRequest() / FetchMediaDetailsRequest.new instead')
  static FetchMediaDetailsRequest create() => FetchMediaDetailsRequest._();
  static $pb.GeneratedMessage $_createMessage() => FetchMediaDetailsRequest._();
  @$core.override
  FetchMediaDetailsRequest createEmptyInstance() =>
      FetchMediaDetailsRequest._();
  @$core.pragma('dart2js:noInline')
  static FetchMediaDetailsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchMediaDetailsRequest>(
          FetchMediaDetailsRequest.$_createMessage);
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
    $3.Media? media,
    $core.String? error,
  }) {
    final result = FetchMediaDetailsResponse._();
    if (media != null) result.media = media;
    if (error != null) result.error = error;
    return result;
  }

  FetchMediaDetailsResponse._();

  factory FetchMediaDetailsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchMediaDetailsResponse()..mergeFromBuffer(data, registry);
  factory FetchMediaDetailsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchMediaDetailsResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchMediaDetailsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: FetchMediaDetailsResponse.$_createMessage)
    ..aOM<$3.Media>(1, _omitFieldNames ? '' : 'media',
        subBuilder: $3.Media.$_createMessage)
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
  @$core.Deprecated(
      'Use FetchMediaDetailsResponse() / FetchMediaDetailsResponse.new instead')
  static FetchMediaDetailsResponse create() => FetchMediaDetailsResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      FetchMediaDetailsResponse._();
  @$core.override
  FetchMediaDetailsResponse createEmptyInstance() =>
      FetchMediaDetailsResponse._();
  @$core.pragma('dart2js:noInline')
  static FetchMediaDetailsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchMediaDetailsResponse>(
          FetchMediaDetailsResponse.$_createMessage);
  static FetchMediaDetailsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $3.Media get media => $_getN(0);
  @$pb.TagNumber(1)
  set media($3.Media value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasMedia() => $_has(0);
  @$pb.TagNumber(1)
  void clearMedia() => $_clearField(1);
  @$pb.TagNumber(1)
  $3.Media ensureMedia() => $_ensure(0);

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
    final result = FetchMediaStaffRequest._();
    if (mediaId != null) result.mediaId = mediaId;
    if (page != null) result.page = page;
    if (perPage != null) result.perPage = perPage;
    return result;
  }

  FetchMediaStaffRequest._();

  factory FetchMediaStaffRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchMediaStaffRequest()..mergeFromBuffer(data, registry);
  factory FetchMediaStaffRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchMediaStaffRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchMediaStaffRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: FetchMediaStaffRequest.$_createMessage)
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
  @$core.Deprecated(
      'Use FetchMediaStaffRequest() / FetchMediaStaffRequest.new instead')
  static FetchMediaStaffRequest create() => FetchMediaStaffRequest._();
  static $pb.GeneratedMessage $_createMessage() => FetchMediaStaffRequest._();
  @$core.override
  FetchMediaStaffRequest createEmptyInstance() => FetchMediaStaffRequest._();
  @$core.pragma('dart2js:noInline')
  static FetchMediaStaffRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchMediaStaffRequest>(
          FetchMediaStaffRequest.$_createMessage);
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
    $3.Media? media,
    $core.String? error,
  }) {
    final result = FetchMediaStaffResponse._();
    if (media != null) result.media = media;
    if (error != null) result.error = error;
    return result;
  }

  FetchMediaStaffResponse._();

  factory FetchMediaStaffResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchMediaStaffResponse()..mergeFromBuffer(data, registry);
  factory FetchMediaStaffResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchMediaStaffResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchMediaStaffResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: FetchMediaStaffResponse.$_createMessage)
    ..aOM<$3.Media>(1, _omitFieldNames ? '' : 'media',
        subBuilder: $3.Media.$_createMessage)
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
  @$core.Deprecated(
      'Use FetchMediaStaffResponse() / FetchMediaStaffResponse.new instead')
  static FetchMediaStaffResponse create() => FetchMediaStaffResponse._();
  static $pb.GeneratedMessage $_createMessage() => FetchMediaStaffResponse._();
  @$core.override
  FetchMediaStaffResponse createEmptyInstance() => FetchMediaStaffResponse._();
  @$core.pragma('dart2js:noInline')
  static FetchMediaStaffResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchMediaStaffResponse>(
          FetchMediaStaffResponse.$_createMessage);
  static FetchMediaStaffResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $3.Media get media => $_getN(0);
  @$pb.TagNumber(1)
  set media($3.Media value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasMedia() => $_has(0);
  @$pb.TagNumber(1)
  void clearMedia() => $_clearField(1);
  @$pb.TagNumber(1)
  $3.Media ensureMedia() => $_ensure(0);

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
    final result = FetchMediaCharactersRequest._();
    if (mediaId != null) result.mediaId = mediaId;
    if (page != null) result.page = page;
    if (perPage != null) result.perPage = perPage;
    return result;
  }

  FetchMediaCharactersRequest._();

  factory FetchMediaCharactersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchMediaCharactersRequest()..mergeFromBuffer(data, registry);
  factory FetchMediaCharactersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchMediaCharactersRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchMediaCharactersRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: FetchMediaCharactersRequest.$_createMessage)
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
  @$core.Deprecated(
      'Use FetchMediaCharactersRequest() / FetchMediaCharactersRequest.new instead')
  static FetchMediaCharactersRequest create() =>
      FetchMediaCharactersRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      FetchMediaCharactersRequest._();
  @$core.override
  FetchMediaCharactersRequest createEmptyInstance() =>
      FetchMediaCharactersRequest._();
  @$core.pragma('dart2js:noInline')
  static FetchMediaCharactersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchMediaCharactersRequest>(
          FetchMediaCharactersRequest.$_createMessage);
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
    $3.Media? media,
    $core.String? error,
  }) {
    final result = FetchMediaCharactersResponse._();
    if (media != null) result.media = media;
    if (error != null) result.error = error;
    return result;
  }

  FetchMediaCharactersResponse._();

  factory FetchMediaCharactersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchMediaCharactersResponse()..mergeFromBuffer(data, registry);
  factory FetchMediaCharactersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchMediaCharactersResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchMediaCharactersResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: FetchMediaCharactersResponse.$_createMessage)
    ..aOM<$3.Media>(1, _omitFieldNames ? '' : 'media',
        subBuilder: $3.Media.$_createMessage)
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
  @$core.Deprecated(
      'Use FetchMediaCharactersResponse() / FetchMediaCharactersResponse.new instead')
  static FetchMediaCharactersResponse create() =>
      FetchMediaCharactersResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      FetchMediaCharactersResponse._();
  @$core.override
  FetchMediaCharactersResponse createEmptyInstance() =>
      FetchMediaCharactersResponse._();
  @$core.pragma('dart2js:noInline')
  static FetchMediaCharactersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchMediaCharactersResponse>(
          FetchMediaCharactersResponse.$_createMessage);
  static FetchMediaCharactersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $3.Media get media => $_getN(0);
  @$pb.TagNumber(1)
  set media($3.Media value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasMedia() => $_has(0);
  @$pb.TagNumber(1)
  void clearMedia() => $_clearField(1);
  @$pb.TagNumber(1)
  $3.Media ensureMedia() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get error => $_getSZ(1);
  @$pb.TagNumber(2)
  set error($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => $_clearField(2);
}

class FetchMediaRecommendationsRequest extends $pb.GeneratedMessage {
  factory FetchMediaRecommendationsRequest({
    $core.int? mediaId,
    $core.int? page,
    $core.int? perPage,
  }) {
    final result = FetchMediaRecommendationsRequest._();
    if (mediaId != null) result.mediaId = mediaId;
    if (page != null) result.page = page;
    if (perPage != null) result.perPage = perPage;
    return result;
  }

  FetchMediaRecommendationsRequest._();

  factory FetchMediaRecommendationsRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchMediaRecommendationsRequest()..mergeFromBuffer(data, registry);
  factory FetchMediaRecommendationsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchMediaRecommendationsRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchMediaRecommendationsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: FetchMediaRecommendationsRequest.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'mediaId')
    ..aI(2, _omitFieldNames ? '' : 'page')
    ..aI(3, _omitFieldNames ? '' : 'perPage')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchMediaRecommendationsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchMediaRecommendationsRequest copyWith(
          void Function(FetchMediaRecommendationsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as FetchMediaRecommendationsRequest))
          as FetchMediaRecommendationsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use FetchMediaRecommendationsRequest() / FetchMediaRecommendationsRequest.new instead')
  static FetchMediaRecommendationsRequest create() =>
      FetchMediaRecommendationsRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      FetchMediaRecommendationsRequest._();
  @$core.override
  FetchMediaRecommendationsRequest createEmptyInstance() =>
      FetchMediaRecommendationsRequest._();
  @$core.pragma('dart2js:noInline')
  static FetchMediaRecommendationsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchMediaRecommendationsRequest>(
          FetchMediaRecommendationsRequest.$_createMessage);
  static FetchMediaRecommendationsRequest? _defaultInstance;

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

class FetchMediaRecommendationsResponse extends $pb.GeneratedMessage {
  factory FetchMediaRecommendationsResponse({
    $3.Media? media,
    $core.String? error,
  }) {
    final result = FetchMediaRecommendationsResponse._();
    if (media != null) result.media = media;
    if (error != null) result.error = error;
    return result;
  }

  FetchMediaRecommendationsResponse._();

  factory FetchMediaRecommendationsResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchMediaRecommendationsResponse()..mergeFromBuffer(data, registry);
  factory FetchMediaRecommendationsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchMediaRecommendationsResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchMediaRecommendationsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: FetchMediaRecommendationsResponse.$_createMessage)
    ..aOM<$3.Media>(1, _omitFieldNames ? '' : 'media',
        subBuilder: $3.Media.$_createMessage)
    ..aOS(2, _omitFieldNames ? '' : 'error')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchMediaRecommendationsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchMediaRecommendationsResponse copyWith(
          void Function(FetchMediaRecommendationsResponse) updates) =>
      super.copyWith((message) =>
              updates(message as FetchMediaRecommendationsResponse))
          as FetchMediaRecommendationsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use FetchMediaRecommendationsResponse() / FetchMediaRecommendationsResponse.new instead')
  static FetchMediaRecommendationsResponse create() =>
      FetchMediaRecommendationsResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      FetchMediaRecommendationsResponse._();
  @$core.override
  FetchMediaRecommendationsResponse createEmptyInstance() =>
      FetchMediaRecommendationsResponse._();
  @$core.pragma('dart2js:noInline')
  static FetchMediaRecommendationsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchMediaRecommendationsResponse>(
          FetchMediaRecommendationsResponse.$_createMessage);
  static FetchMediaRecommendationsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $3.Media get media => $_getN(0);
  @$pb.TagNumber(1)
  set media($3.Media value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasMedia() => $_has(0);
  @$pb.TagNumber(1)
  void clearMedia() => $_clearField(1);
  @$pb.TagNumber(1)
  $3.Media ensureMedia() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get error => $_getSZ(1);
  @$pb.TagNumber(2)
  set error($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => $_clearField(2);
}

class ToggleFavouriteAnimeRequest extends $pb.GeneratedMessage {
  factory ToggleFavouriteAnimeRequest({
    $core.int? animeId,
  }) {
    final result = ToggleFavouriteAnimeRequest._();
    if (animeId != null) result.animeId = animeId;
    return result;
  }

  ToggleFavouriteAnimeRequest._();

  factory ToggleFavouriteAnimeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ToggleFavouriteAnimeRequest()..mergeFromBuffer(data, registry);
  factory ToggleFavouriteAnimeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ToggleFavouriteAnimeRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ToggleFavouriteAnimeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: ToggleFavouriteAnimeRequest.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'animeId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleFavouriteAnimeRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleFavouriteAnimeRequest copyWith(
          void Function(ToggleFavouriteAnimeRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ToggleFavouriteAnimeRequest))
          as ToggleFavouriteAnimeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ToggleFavouriteAnimeRequest() / ToggleFavouriteAnimeRequest.new instead')
  static ToggleFavouriteAnimeRequest create() =>
      ToggleFavouriteAnimeRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      ToggleFavouriteAnimeRequest._();
  @$core.override
  ToggleFavouriteAnimeRequest createEmptyInstance() =>
      ToggleFavouriteAnimeRequest._();
  @$core.pragma('dart2js:noInline')
  static ToggleFavouriteAnimeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ToggleFavouriteAnimeRequest>(
          ToggleFavouriteAnimeRequest.$_createMessage);
  static ToggleFavouriteAnimeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get animeId => $_getIZ(0);
  @$pb.TagNumber(1)
  set animeId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAnimeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAnimeId() => $_clearField(1);
}

class ToggleFavouriteAnimeResponse extends $pb.GeneratedMessage {
  factory ToggleFavouriteAnimeResponse({
    $core.int? animeId,
    $core.bool? isFavourite,
    $core.String? error,
  }) {
    final result = ToggleFavouriteAnimeResponse._();
    if (animeId != null) result.animeId = animeId;
    if (isFavourite != null) result.isFavourite = isFavourite;
    if (error != null) result.error = error;
    return result;
  }

  ToggleFavouriteAnimeResponse._();

  factory ToggleFavouriteAnimeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ToggleFavouriteAnimeResponse()..mergeFromBuffer(data, registry);
  factory ToggleFavouriteAnimeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ToggleFavouriteAnimeResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ToggleFavouriteAnimeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: ToggleFavouriteAnimeResponse.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'animeId')
    ..aOB(2, _omitFieldNames ? '' : 'isFavourite')
    ..aOS(3, _omitFieldNames ? '' : 'error')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleFavouriteAnimeResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleFavouriteAnimeResponse copyWith(
          void Function(ToggleFavouriteAnimeResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ToggleFavouriteAnimeResponse))
          as ToggleFavouriteAnimeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ToggleFavouriteAnimeResponse() / ToggleFavouriteAnimeResponse.new instead')
  static ToggleFavouriteAnimeResponse create() =>
      ToggleFavouriteAnimeResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      ToggleFavouriteAnimeResponse._();
  @$core.override
  ToggleFavouriteAnimeResponse createEmptyInstance() =>
      ToggleFavouriteAnimeResponse._();
  @$core.pragma('dart2js:noInline')
  static ToggleFavouriteAnimeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ToggleFavouriteAnimeResponse>(
          ToggleFavouriteAnimeResponse.$_createMessage);
  static ToggleFavouriteAnimeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get animeId => $_getIZ(0);
  @$pb.TagNumber(1)
  set animeId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAnimeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAnimeId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get isFavourite => $_getBF(1);
  @$pb.TagNumber(2)
  set isFavourite($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIsFavourite() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsFavourite() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get error => $_getSZ(2);
  @$pb.TagNumber(3)
  set error($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(3)
  void clearError() => $_clearField(3);
}

class ToggleFavouriteMangaRequest extends $pb.GeneratedMessage {
  factory ToggleFavouriteMangaRequest({
    $core.int? mangaId,
  }) {
    final result = ToggleFavouriteMangaRequest._();
    if (mangaId != null) result.mangaId = mangaId;
    return result;
  }

  ToggleFavouriteMangaRequest._();

  factory ToggleFavouriteMangaRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ToggleFavouriteMangaRequest()..mergeFromBuffer(data, registry);
  factory ToggleFavouriteMangaRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ToggleFavouriteMangaRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ToggleFavouriteMangaRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: ToggleFavouriteMangaRequest.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'mangaId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleFavouriteMangaRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleFavouriteMangaRequest copyWith(
          void Function(ToggleFavouriteMangaRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ToggleFavouriteMangaRequest))
          as ToggleFavouriteMangaRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ToggleFavouriteMangaRequest() / ToggleFavouriteMangaRequest.new instead')
  static ToggleFavouriteMangaRequest create() =>
      ToggleFavouriteMangaRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      ToggleFavouriteMangaRequest._();
  @$core.override
  ToggleFavouriteMangaRequest createEmptyInstance() =>
      ToggleFavouriteMangaRequest._();
  @$core.pragma('dart2js:noInline')
  static ToggleFavouriteMangaRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ToggleFavouriteMangaRequest>(
          ToggleFavouriteMangaRequest.$_createMessage);
  static ToggleFavouriteMangaRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get mangaId => $_getIZ(0);
  @$pb.TagNumber(1)
  set mangaId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMangaId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMangaId() => $_clearField(1);
}

class ToggleFavouriteMangaResponse extends $pb.GeneratedMessage {
  factory ToggleFavouriteMangaResponse({
    $core.int? mangaId,
    $core.bool? isFavourite,
    $core.String? error,
  }) {
    final result = ToggleFavouriteMangaResponse._();
    if (mangaId != null) result.mangaId = mangaId;
    if (isFavourite != null) result.isFavourite = isFavourite;
    if (error != null) result.error = error;
    return result;
  }

  ToggleFavouriteMangaResponse._();

  factory ToggleFavouriteMangaResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ToggleFavouriteMangaResponse()..mergeFromBuffer(data, registry);
  factory ToggleFavouriteMangaResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ToggleFavouriteMangaResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ToggleFavouriteMangaResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: ToggleFavouriteMangaResponse.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'mangaId')
    ..aOB(2, _omitFieldNames ? '' : 'isFavourite')
    ..aOS(3, _omitFieldNames ? '' : 'error')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleFavouriteMangaResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleFavouriteMangaResponse copyWith(
          void Function(ToggleFavouriteMangaResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ToggleFavouriteMangaResponse))
          as ToggleFavouriteMangaResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ToggleFavouriteMangaResponse() / ToggleFavouriteMangaResponse.new instead')
  static ToggleFavouriteMangaResponse create() =>
      ToggleFavouriteMangaResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      ToggleFavouriteMangaResponse._();
  @$core.override
  ToggleFavouriteMangaResponse createEmptyInstance() =>
      ToggleFavouriteMangaResponse._();
  @$core.pragma('dart2js:noInline')
  static ToggleFavouriteMangaResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ToggleFavouriteMangaResponse>(
          ToggleFavouriteMangaResponse.$_createMessage);
  static ToggleFavouriteMangaResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get mangaId => $_getIZ(0);
  @$pb.TagNumber(1)
  set mangaId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMangaId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMangaId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get isFavourite => $_getBF(1);
  @$pb.TagNumber(2)
  set isFavourite($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIsFavourite() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsFavourite() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get error => $_getSZ(2);
  @$pb.TagNumber(3)
  set error($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(3)
  void clearError() => $_clearField(3);
}

class ToggleActivityLikeRequest extends $pb.GeneratedMessage {
  factory ToggleActivityLikeRequest({
    $core.int? activityId,
  }) {
    final result = ToggleActivityLikeRequest._();
    if (activityId != null) result.activityId = activityId;
    return result;
  }

  ToggleActivityLikeRequest._();

  factory ToggleActivityLikeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ToggleActivityLikeRequest()..mergeFromBuffer(data, registry);
  factory ToggleActivityLikeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ToggleActivityLikeRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ToggleActivityLikeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: ToggleActivityLikeRequest.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'activityId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleActivityLikeRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleActivityLikeRequest copyWith(
          void Function(ToggleActivityLikeRequest) updates) =>
      super.copyWith((message) => updates(message as ToggleActivityLikeRequest))
          as ToggleActivityLikeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ToggleActivityLikeRequest() / ToggleActivityLikeRequest.new instead')
  static ToggleActivityLikeRequest create() => ToggleActivityLikeRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      ToggleActivityLikeRequest._();
  @$core.override
  ToggleActivityLikeRequest createEmptyInstance() =>
      ToggleActivityLikeRequest._();
  @$core.pragma('dart2js:noInline')
  static ToggleActivityLikeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ToggleActivityLikeRequest>(
          ToggleActivityLikeRequest.$_createMessage);
  static ToggleActivityLikeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get activityId => $_getIZ(0);
  @$pb.TagNumber(1)
  set activityId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasActivityId() => $_has(0);
  @$pb.TagNumber(1)
  void clearActivityId() => $_clearField(1);
}

class ToggleActivityLikeResponse extends $pb.GeneratedMessage {
  factory ToggleActivityLikeResponse({
    $core.int? activityId,
    $core.Iterable<$core.int>? likedUserIds,
    $core.String? error,
  }) {
    final result = ToggleActivityLikeResponse._();
    if (activityId != null) result.activityId = activityId;
    if (likedUserIds != null) result.likedUserIds.addAll(likedUserIds);
    if (error != null) result.error = error;
    return result;
  }

  ToggleActivityLikeResponse._();

  factory ToggleActivityLikeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ToggleActivityLikeResponse()..mergeFromBuffer(data, registry);
  factory ToggleActivityLikeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ToggleActivityLikeResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ToggleActivityLikeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: ToggleActivityLikeResponse.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'activityId')
    ..p<$core.int>(2, _omitFieldNames ? '' : 'likedUserIds', $pb.PbFieldType.K3)
    ..aOS(3, _omitFieldNames ? '' : 'error')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleActivityLikeResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleActivityLikeResponse copyWith(
          void Function(ToggleActivityLikeResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ToggleActivityLikeResponse))
          as ToggleActivityLikeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ToggleActivityLikeResponse() / ToggleActivityLikeResponse.new instead')
  static ToggleActivityLikeResponse create() => ToggleActivityLikeResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      ToggleActivityLikeResponse._();
  @$core.override
  ToggleActivityLikeResponse createEmptyInstance() =>
      ToggleActivityLikeResponse._();
  @$core.pragma('dart2js:noInline')
  static ToggleActivityLikeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ToggleActivityLikeResponse>(
          ToggleActivityLikeResponse.$_createMessage);
  static ToggleActivityLikeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get activityId => $_getIZ(0);
  @$pb.TagNumber(1)
  set activityId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasActivityId() => $_has(0);
  @$pb.TagNumber(1)
  void clearActivityId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.int> get likedUserIds => $_getList(1);

  @$pb.TagNumber(3)
  $core.String get error => $_getSZ(2);
  @$pb.TagNumber(3)
  set error($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(3)
  void clearError() => $_clearField(3);
}

class DeleteMediaListEntryRequest extends $pb.GeneratedMessage {
  factory DeleteMediaListEntryRequest({
    $core.int? entryId,
  }) {
    final result = DeleteMediaListEntryRequest._();
    if (entryId != null) result.entryId = entryId;
    return result;
  }

  DeleteMediaListEntryRequest._();

  factory DeleteMediaListEntryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeleteMediaListEntryRequest()..mergeFromBuffer(data, registry);
  factory DeleteMediaListEntryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeleteMediaListEntryRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteMediaListEntryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: DeleteMediaListEntryRequest.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'entryId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteMediaListEntryRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteMediaListEntryRequest copyWith(
          void Function(DeleteMediaListEntryRequest) updates) =>
      super.copyWith(
              (message) => updates(message as DeleteMediaListEntryRequest))
          as DeleteMediaListEntryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use DeleteMediaListEntryRequest() / DeleteMediaListEntryRequest.new instead')
  static DeleteMediaListEntryRequest create() =>
      DeleteMediaListEntryRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      DeleteMediaListEntryRequest._();
  @$core.override
  DeleteMediaListEntryRequest createEmptyInstance() =>
      DeleteMediaListEntryRequest._();
  @$core.pragma('dart2js:noInline')
  static DeleteMediaListEntryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteMediaListEntryRequest>(
          DeleteMediaListEntryRequest.$_createMessage);
  static DeleteMediaListEntryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get entryId => $_getIZ(0);
  @$pb.TagNumber(1)
  set entryId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEntryId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEntryId() => $_clearField(1);
}

class DeleteMediaListEntryResponse extends $pb.GeneratedMessage {
  factory DeleteMediaListEntryResponse({
    $core.int? entryId,
    $core.bool? deleted,
    $core.String? error,
  }) {
    final result = DeleteMediaListEntryResponse._();
    if (entryId != null) result.entryId = entryId;
    if (deleted != null) result.deleted = deleted;
    if (error != null) result.error = error;
    return result;
  }

  DeleteMediaListEntryResponse._();

  factory DeleteMediaListEntryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeleteMediaListEntryResponse()..mergeFromBuffer(data, registry);
  factory DeleteMediaListEntryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeleteMediaListEntryResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteMediaListEntryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: DeleteMediaListEntryResponse.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'entryId')
    ..aOB(2, _omitFieldNames ? '' : 'deleted')
    ..aOS(3, _omitFieldNames ? '' : 'error')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteMediaListEntryResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteMediaListEntryResponse copyWith(
          void Function(DeleteMediaListEntryResponse) updates) =>
      super.copyWith(
              (message) => updates(message as DeleteMediaListEntryResponse))
          as DeleteMediaListEntryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use DeleteMediaListEntryResponse() / DeleteMediaListEntryResponse.new instead')
  static DeleteMediaListEntryResponse create() =>
      DeleteMediaListEntryResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      DeleteMediaListEntryResponse._();
  @$core.override
  DeleteMediaListEntryResponse createEmptyInstance() =>
      DeleteMediaListEntryResponse._();
  @$core.pragma('dart2js:noInline')
  static DeleteMediaListEntryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteMediaListEntryResponse>(
          DeleteMediaListEntryResponse.$_createMessage);
  static DeleteMediaListEntryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get entryId => $_getIZ(0);
  @$pb.TagNumber(1)
  set entryId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEntryId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEntryId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get deleted => $_getBF(1);
  @$pb.TagNumber(2)
  set deleted($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDeleted() => $_has(1);
  @$pb.TagNumber(2)
  void clearDeleted() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get error => $_getSZ(2);
  @$pb.TagNumber(3)
  set error($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(3)
  void clearError() => $_clearField(3);
}

class FetchMediaReviewsRequest extends $pb.GeneratedMessage {
  factory FetchMediaReviewsRequest({
    $core.int? mediaId,
    $core.int? page,
    $core.int? perPage,
  }) {
    final result = FetchMediaReviewsRequest._();
    if (mediaId != null) result.mediaId = mediaId;
    if (page != null) result.page = page;
    if (perPage != null) result.perPage = perPage;
    return result;
  }

  FetchMediaReviewsRequest._();

  factory FetchMediaReviewsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchMediaReviewsRequest()..mergeFromBuffer(data, registry);
  factory FetchMediaReviewsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchMediaReviewsRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchMediaReviewsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: FetchMediaReviewsRequest.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'mediaId')
    ..aI(2, _omitFieldNames ? '' : 'page')
    ..aI(3, _omitFieldNames ? '' : 'perPage')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchMediaReviewsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchMediaReviewsRequest copyWith(
          void Function(FetchMediaReviewsRequest) updates) =>
      super.copyWith((message) => updates(message as FetchMediaReviewsRequest))
          as FetchMediaReviewsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use FetchMediaReviewsRequest() / FetchMediaReviewsRequest.new instead')
  static FetchMediaReviewsRequest create() => FetchMediaReviewsRequest._();
  static $pb.GeneratedMessage $_createMessage() => FetchMediaReviewsRequest._();
  @$core.override
  FetchMediaReviewsRequest createEmptyInstance() =>
      FetchMediaReviewsRequest._();
  @$core.pragma('dart2js:noInline')
  static FetchMediaReviewsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchMediaReviewsRequest>(
          FetchMediaReviewsRequest.$_createMessage);
  static FetchMediaReviewsRequest? _defaultInstance;

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

class FetchMediaReviewsResponse extends $pb.GeneratedMessage {
  factory FetchMediaReviewsResponse({
    $3.Media? media,
    $core.String? error,
  }) {
    final result = FetchMediaReviewsResponse._();
    if (media != null) result.media = media;
    if (error != null) result.error = error;
    return result;
  }

  FetchMediaReviewsResponse._();

  factory FetchMediaReviewsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchMediaReviewsResponse()..mergeFromBuffer(data, registry);
  factory FetchMediaReviewsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchMediaReviewsResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchMediaReviewsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: FetchMediaReviewsResponse.$_createMessage)
    ..aOM<$3.Media>(1, _omitFieldNames ? '' : 'media',
        subBuilder: $3.Media.$_createMessage)
    ..aOS(2, _omitFieldNames ? '' : 'error')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchMediaReviewsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchMediaReviewsResponse copyWith(
          void Function(FetchMediaReviewsResponse) updates) =>
      super.copyWith((message) => updates(message as FetchMediaReviewsResponse))
          as FetchMediaReviewsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use FetchMediaReviewsResponse() / FetchMediaReviewsResponse.new instead')
  static FetchMediaReviewsResponse create() => FetchMediaReviewsResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      FetchMediaReviewsResponse._();
  @$core.override
  FetchMediaReviewsResponse createEmptyInstance() =>
      FetchMediaReviewsResponse._();
  @$core.pragma('dart2js:noInline')
  static FetchMediaReviewsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchMediaReviewsResponse>(
          FetchMediaReviewsResponse.$_createMessage);
  static FetchMediaReviewsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $3.Media get media => $_getN(0);
  @$pb.TagNumber(1)
  set media($3.Media value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasMedia() => $_has(0);
  @$pb.TagNumber(1)
  void clearMedia() => $_clearField(1);
  @$pb.TagNumber(1)
  $3.Media ensureMedia() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get error => $_getSZ(1);
  @$pb.TagNumber(2)
  set error($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => $_clearField(2);
}

class RateReviewRequest extends $pb.GeneratedMessage {
  factory RateReviewRequest({
    $core.int? reviewId,
    $4.ReviewUserRating? rating,
  }) {
    final result = RateReviewRequest._();
    if (reviewId != null) result.reviewId = reviewId;
    if (rating != null) result.rating = rating;
    return result;
  }

  RateReviewRequest._();

  factory RateReviewRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RateReviewRequest()..mergeFromBuffer(data, registry);
  factory RateReviewRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RateReviewRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RateReviewRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: RateReviewRequest.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'reviewId')
    ..aE<$4.ReviewUserRating>(2, _omitFieldNames ? '' : 'rating',
        enumValues: $4.ReviewUserRating.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RateReviewRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RateReviewRequest copyWith(void Function(RateReviewRequest) updates) =>
      super.copyWith((message) => updates(message as RateReviewRequest))
          as RateReviewRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use RateReviewRequest() / RateReviewRequest.new instead')
  static RateReviewRequest create() => RateReviewRequest._();
  static $pb.GeneratedMessage $_createMessage() => RateReviewRequest._();
  @$core.override
  RateReviewRequest createEmptyInstance() => RateReviewRequest._();
  @$core.pragma('dart2js:noInline')
  static RateReviewRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RateReviewRequest>(
          RateReviewRequest.$_createMessage);
  static RateReviewRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get reviewId => $_getIZ(0);
  @$pb.TagNumber(1)
  set reviewId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasReviewId() => $_has(0);
  @$pb.TagNumber(1)
  void clearReviewId() => $_clearField(1);

  @$pb.TagNumber(2)
  $4.ReviewUserRating get rating => $_getN(1);
  @$pb.TagNumber(2)
  set rating($4.ReviewUserRating value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasRating() => $_has(1);
  @$pb.TagNumber(2)
  void clearRating() => $_clearField(2);
}

class RateReviewResponse extends $pb.GeneratedMessage {
  factory RateReviewResponse({
    $4.ReviewNode? review,
    $core.String? error,
  }) {
    final result = RateReviewResponse._();
    if (review != null) result.review = review;
    if (error != null) result.error = error;
    return result;
  }

  RateReviewResponse._();

  factory RateReviewResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RateReviewResponse()..mergeFromBuffer(data, registry);
  factory RateReviewResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RateReviewResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RateReviewResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: RateReviewResponse.$_createMessage)
    ..aOM<$4.ReviewNode>(1, _omitFieldNames ? '' : 'review',
        subBuilder: $4.ReviewNode.$_createMessage)
    ..aOS(2, _omitFieldNames ? '' : 'error')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RateReviewResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RateReviewResponse copyWith(void Function(RateReviewResponse) updates) =>
      super.copyWith((message) => updates(message as RateReviewResponse))
          as RateReviewResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use RateReviewResponse() / RateReviewResponse.new instead')
  static RateReviewResponse create() => RateReviewResponse._();
  static $pb.GeneratedMessage $_createMessage() => RateReviewResponse._();
  @$core.override
  RateReviewResponse createEmptyInstance() => RateReviewResponse._();
  @$core.pragma('dart2js:noInline')
  static RateReviewResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RateReviewResponse>(
          RateReviewResponse.$_createMessage);
  static RateReviewResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $4.ReviewNode get review => $_getN(0);
  @$pb.TagNumber(1)
  set review($4.ReviewNode value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasReview() => $_has(0);
  @$pb.TagNumber(1)
  void clearReview() => $_clearField(1);
  @$pb.TagNumber(1)
  $4.ReviewNode ensureReview() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get error => $_getSZ(1);
  @$pb.TagNumber(2)
  set error($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => $_clearField(2);
}

class FetchMediaActivitiesRequest extends $pb.GeneratedMessage {
  factory FetchMediaActivitiesRequest({
    $core.int? mediaId,
    $core.int? page,
    $core.int? perPage,
  }) {
    final result = FetchMediaActivitiesRequest._();
    if (mediaId != null) result.mediaId = mediaId;
    if (page != null) result.page = page;
    if (perPage != null) result.perPage = perPage;
    return result;
  }

  FetchMediaActivitiesRequest._();

  factory FetchMediaActivitiesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchMediaActivitiesRequest()..mergeFromBuffer(data, registry);
  factory FetchMediaActivitiesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchMediaActivitiesRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchMediaActivitiesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: FetchMediaActivitiesRequest.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'mediaId')
    ..aI(2, _omitFieldNames ? '' : 'page')
    ..aI(3, _omitFieldNames ? '' : 'perPage')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchMediaActivitiesRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchMediaActivitiesRequest copyWith(
          void Function(FetchMediaActivitiesRequest) updates) =>
      super.copyWith(
              (message) => updates(message as FetchMediaActivitiesRequest))
          as FetchMediaActivitiesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use FetchMediaActivitiesRequest() / FetchMediaActivitiesRequest.new instead')
  static FetchMediaActivitiesRequest create() =>
      FetchMediaActivitiesRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      FetchMediaActivitiesRequest._();
  @$core.override
  FetchMediaActivitiesRequest createEmptyInstance() =>
      FetchMediaActivitiesRequest._();
  @$core.pragma('dart2js:noInline')
  static FetchMediaActivitiesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchMediaActivitiesRequest>(
          FetchMediaActivitiesRequest.$_createMessage);
  static FetchMediaActivitiesRequest? _defaultInstance;

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

class FetchMediaActivitiesResponse extends $pb.GeneratedMessage {
  factory FetchMediaActivitiesResponse({
    $5.PageInfo? pageInfo,
    $core.Iterable<$6.ListActivity>? activities,
    $core.String? error,
  }) {
    final result = FetchMediaActivitiesResponse._();
    if (pageInfo != null) result.pageInfo = pageInfo;
    if (activities != null) result.activities.addAll(activities);
    if (error != null) result.error = error;
    return result;
  }

  FetchMediaActivitiesResponse._();

  factory FetchMediaActivitiesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchMediaActivitiesResponse()..mergeFromBuffer(data, registry);
  factory FetchMediaActivitiesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchMediaActivitiesResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchMediaActivitiesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: FetchMediaActivitiesResponse.$_createMessage)
    ..aOM<$5.PageInfo>(1, _omitFieldNames ? '' : 'pageInfo',
        subBuilder: $5.PageInfo.$_createMessage)
    ..pPM<$6.ListActivity>(2, _omitFieldNames ? '' : 'activities',
        subBuilder: $6.ListActivity.$_createMessage)
    ..aOS(3, _omitFieldNames ? '' : 'error')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchMediaActivitiesResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchMediaActivitiesResponse copyWith(
          void Function(FetchMediaActivitiesResponse) updates) =>
      super.copyWith(
              (message) => updates(message as FetchMediaActivitiesResponse))
          as FetchMediaActivitiesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use FetchMediaActivitiesResponse() / FetchMediaActivitiesResponse.new instead')
  static FetchMediaActivitiesResponse create() =>
      FetchMediaActivitiesResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      FetchMediaActivitiesResponse._();
  @$core.override
  FetchMediaActivitiesResponse createEmptyInstance() =>
      FetchMediaActivitiesResponse._();
  @$core.pragma('dart2js:noInline')
  static FetchMediaActivitiesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchMediaActivitiesResponse>(
          FetchMediaActivitiesResponse.$_createMessage);
  static FetchMediaActivitiesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $5.PageInfo get pageInfo => $_getN(0);
  @$pb.TagNumber(1)
  set pageInfo($5.PageInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPageInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearPageInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  $5.PageInfo ensurePageInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<$6.ListActivity> get activities => $_getList(1);

  @$pb.TagNumber(3)
  $core.String get error => $_getSZ(2);
  @$pb.TagNumber(3)
  set error($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(3)
  void clearError() => $_clearField(3);
}

class FetchStudioDetailsRequest extends $pb.GeneratedMessage {
  factory FetchStudioDetailsRequest({
    $core.int? studioId,
    $core.int? page,
  }) {
    final result = FetchStudioDetailsRequest._();
    if (studioId != null) result.studioId = studioId;
    if (page != null) result.page = page;
    return result;
  }

  FetchStudioDetailsRequest._();

  factory FetchStudioDetailsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchStudioDetailsRequest()..mergeFromBuffer(data, registry);
  factory FetchStudioDetailsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchStudioDetailsRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchStudioDetailsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: FetchStudioDetailsRequest.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'studioId')
    ..aI(2, _omitFieldNames ? '' : 'page')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchStudioDetailsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchStudioDetailsRequest copyWith(
          void Function(FetchStudioDetailsRequest) updates) =>
      super.copyWith((message) => updates(message as FetchStudioDetailsRequest))
          as FetchStudioDetailsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use FetchStudioDetailsRequest() / FetchStudioDetailsRequest.new instead')
  static FetchStudioDetailsRequest create() => FetchStudioDetailsRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      FetchStudioDetailsRequest._();
  @$core.override
  FetchStudioDetailsRequest createEmptyInstance() =>
      FetchStudioDetailsRequest._();
  @$core.pragma('dart2js:noInline')
  static FetchStudioDetailsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchStudioDetailsRequest>(
          FetchStudioDetailsRequest.$_createMessage);
  static FetchStudioDetailsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get studioId => $_getIZ(0);
  @$pb.TagNumber(1)
  set studioId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStudioId() => $_has(0);
  @$pb.TagNumber(1)
  void clearStudioId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => $_clearField(2);
}

class FetchStudioDetailsResponse extends $pb.GeneratedMessage {
  factory FetchStudioDetailsResponse({
    $7.Studio? studio,
    $core.String? error,
  }) {
    final result = FetchStudioDetailsResponse._();
    if (studio != null) result.studio = studio;
    if (error != null) result.error = error;
    return result;
  }

  FetchStudioDetailsResponse._();

  factory FetchStudioDetailsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchStudioDetailsResponse()..mergeFromBuffer(data, registry);
  factory FetchStudioDetailsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchStudioDetailsResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchStudioDetailsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: FetchStudioDetailsResponse.$_createMessage)
    ..aOM<$7.Studio>(1, _omitFieldNames ? '' : 'studio',
        subBuilder: $7.Studio.$_createMessage)
    ..aOS(2, _omitFieldNames ? '' : 'error')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchStudioDetailsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchStudioDetailsResponse copyWith(
          void Function(FetchStudioDetailsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as FetchStudioDetailsResponse))
          as FetchStudioDetailsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use FetchStudioDetailsResponse() / FetchStudioDetailsResponse.new instead')
  static FetchStudioDetailsResponse create() => FetchStudioDetailsResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      FetchStudioDetailsResponse._();
  @$core.override
  FetchStudioDetailsResponse createEmptyInstance() =>
      FetchStudioDetailsResponse._();
  @$core.pragma('dart2js:noInline')
  static FetchStudioDetailsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchStudioDetailsResponse>(
          FetchStudioDetailsResponse.$_createMessage);
  static FetchStudioDetailsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $7.Studio get studio => $_getN(0);
  @$pb.TagNumber(1)
  set studio($7.Studio value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasStudio() => $_has(0);
  @$pb.TagNumber(1)
  void clearStudio() => $_clearField(1);
  @$pb.TagNumber(1)
  $7.Studio ensureStudio() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get error => $_getSZ(1);
  @$pb.TagNumber(2)
  set error($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => $_clearField(2);
}

class ToggleFavouriteStudioRequest extends $pb.GeneratedMessage {
  factory ToggleFavouriteStudioRequest({
    $core.int? studioId,
  }) {
    final result = ToggleFavouriteStudioRequest._();
    if (studioId != null) result.studioId = studioId;
    return result;
  }

  ToggleFavouriteStudioRequest._();

  factory ToggleFavouriteStudioRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ToggleFavouriteStudioRequest()..mergeFromBuffer(data, registry);
  factory ToggleFavouriteStudioRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ToggleFavouriteStudioRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ToggleFavouriteStudioRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: ToggleFavouriteStudioRequest.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'studioId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleFavouriteStudioRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleFavouriteStudioRequest copyWith(
          void Function(ToggleFavouriteStudioRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ToggleFavouriteStudioRequest))
          as ToggleFavouriteStudioRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ToggleFavouriteStudioRequest() / ToggleFavouriteStudioRequest.new instead')
  static ToggleFavouriteStudioRequest create() =>
      ToggleFavouriteStudioRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      ToggleFavouriteStudioRequest._();
  @$core.override
  ToggleFavouriteStudioRequest createEmptyInstance() =>
      ToggleFavouriteStudioRequest._();
  @$core.pragma('dart2js:noInline')
  static ToggleFavouriteStudioRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ToggleFavouriteStudioRequest>(
          ToggleFavouriteStudioRequest.$_createMessage);
  static ToggleFavouriteStudioRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get studioId => $_getIZ(0);
  @$pb.TagNumber(1)
  set studioId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStudioId() => $_has(0);
  @$pb.TagNumber(1)
  void clearStudioId() => $_clearField(1);
}

class ToggleFavouriteStudioResponse extends $pb.GeneratedMessage {
  factory ToggleFavouriteStudioResponse({
    $core.int? studioId,
    $core.String? error,
  }) {
    final result = ToggleFavouriteStudioResponse._();
    if (studioId != null) result.studioId = studioId;
    if (error != null) result.error = error;
    return result;
  }

  ToggleFavouriteStudioResponse._();

  factory ToggleFavouriteStudioResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ToggleFavouriteStudioResponse()..mergeFromBuffer(data, registry);
  factory ToggleFavouriteStudioResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ToggleFavouriteStudioResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ToggleFavouriteStudioResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: ToggleFavouriteStudioResponse.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'studioId')
    ..aOS(2, _omitFieldNames ? '' : 'error')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleFavouriteStudioResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleFavouriteStudioResponse copyWith(
          void Function(ToggleFavouriteStudioResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ToggleFavouriteStudioResponse))
          as ToggleFavouriteStudioResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ToggleFavouriteStudioResponse() / ToggleFavouriteStudioResponse.new instead')
  static ToggleFavouriteStudioResponse create() =>
      ToggleFavouriteStudioResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      ToggleFavouriteStudioResponse._();
  @$core.override
  ToggleFavouriteStudioResponse createEmptyInstance() =>
      ToggleFavouriteStudioResponse._();
  @$core.pragma('dart2js:noInline')
  static ToggleFavouriteStudioResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ToggleFavouriteStudioResponse>(
          ToggleFavouriteStudioResponse.$_createMessage);
  static ToggleFavouriteStudioResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get studioId => $_getIZ(0);
  @$pb.TagNumber(1)
  set studioId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStudioId() => $_has(0);
  @$pb.TagNumber(1)
  void clearStudioId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get error => $_getSZ(1);
  @$pb.TagNumber(2)
  set error($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => $_clearField(2);
}

class FetchStaffDetailsRequest extends $pb.GeneratedMessage {
  factory FetchStaffDetailsRequest({
    $core.int? staffId,
    $core.int? characterMediaPage,
    $core.int? staffMediaPage,
  }) {
    final result = FetchStaffDetailsRequest._();
    if (staffId != null) result.staffId = staffId;
    if (characterMediaPage != null)
      result.characterMediaPage = characterMediaPage;
    if (staffMediaPage != null) result.staffMediaPage = staffMediaPage;
    return result;
  }

  FetchStaffDetailsRequest._();

  factory FetchStaffDetailsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchStaffDetailsRequest()..mergeFromBuffer(data, registry);
  factory FetchStaffDetailsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchStaffDetailsRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchStaffDetailsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: FetchStaffDetailsRequest.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'staffId')
    ..aI(2, _omitFieldNames ? '' : 'characterMediaPage')
    ..aI(3, _omitFieldNames ? '' : 'staffMediaPage')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchStaffDetailsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchStaffDetailsRequest copyWith(
          void Function(FetchStaffDetailsRequest) updates) =>
      super.copyWith((message) => updates(message as FetchStaffDetailsRequest))
          as FetchStaffDetailsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use FetchStaffDetailsRequest() / FetchStaffDetailsRequest.new instead')
  static FetchStaffDetailsRequest create() => FetchStaffDetailsRequest._();
  static $pb.GeneratedMessage $_createMessage() => FetchStaffDetailsRequest._();
  @$core.override
  FetchStaffDetailsRequest createEmptyInstance() =>
      FetchStaffDetailsRequest._();
  @$core.pragma('dart2js:noInline')
  static FetchStaffDetailsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchStaffDetailsRequest>(
          FetchStaffDetailsRequest.$_createMessage);
  static FetchStaffDetailsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get staffId => $_getIZ(0);
  @$pb.TagNumber(1)
  set staffId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStaffId() => $_has(0);
  @$pb.TagNumber(1)
  void clearStaffId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get characterMediaPage => $_getIZ(1);
  @$pb.TagNumber(2)
  set characterMediaPage($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCharacterMediaPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearCharacterMediaPage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get staffMediaPage => $_getIZ(2);
  @$pb.TagNumber(3)
  set staffMediaPage($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStaffMediaPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearStaffMediaPage() => $_clearField(3);
}

class FetchStaffDetailsResponse extends $pb.GeneratedMessage {
  factory FetchStaffDetailsResponse({
    $8.Staff? staff,
    $core.String? error,
  }) {
    final result = FetchStaffDetailsResponse._();
    if (staff != null) result.staff = staff;
    if (error != null) result.error = error;
    return result;
  }

  FetchStaffDetailsResponse._();

  factory FetchStaffDetailsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchStaffDetailsResponse()..mergeFromBuffer(data, registry);
  factory FetchStaffDetailsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchStaffDetailsResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchStaffDetailsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: FetchStaffDetailsResponse.$_createMessage)
    ..aOM<$8.Staff>(1, _omitFieldNames ? '' : 'staff',
        subBuilder: $8.Staff.$_createMessage)
    ..aOS(2, _omitFieldNames ? '' : 'error')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchStaffDetailsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchStaffDetailsResponse copyWith(
          void Function(FetchStaffDetailsResponse) updates) =>
      super.copyWith((message) => updates(message as FetchStaffDetailsResponse))
          as FetchStaffDetailsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use FetchStaffDetailsResponse() / FetchStaffDetailsResponse.new instead')
  static FetchStaffDetailsResponse create() => FetchStaffDetailsResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      FetchStaffDetailsResponse._();
  @$core.override
  FetchStaffDetailsResponse createEmptyInstance() =>
      FetchStaffDetailsResponse._();
  @$core.pragma('dart2js:noInline')
  static FetchStaffDetailsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchStaffDetailsResponse>(
          FetchStaffDetailsResponse.$_createMessage);
  static FetchStaffDetailsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $8.Staff get staff => $_getN(0);
  @$pb.TagNumber(1)
  set staff($8.Staff value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasStaff() => $_has(0);
  @$pb.TagNumber(1)
  void clearStaff() => $_clearField(1);
  @$pb.TagNumber(1)
  $8.Staff ensureStaff() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get error => $_getSZ(1);
  @$pb.TagNumber(2)
  set error($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => $_clearField(2);
}

class ToggleFavouriteStaffRequest extends $pb.GeneratedMessage {
  factory ToggleFavouriteStaffRequest({
    $core.int? staffId,
  }) {
    final result = ToggleFavouriteStaffRequest._();
    if (staffId != null) result.staffId = staffId;
    return result;
  }

  ToggleFavouriteStaffRequest._();

  factory ToggleFavouriteStaffRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ToggleFavouriteStaffRequest()..mergeFromBuffer(data, registry);
  factory ToggleFavouriteStaffRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ToggleFavouriteStaffRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ToggleFavouriteStaffRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: ToggleFavouriteStaffRequest.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'staffId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleFavouriteStaffRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleFavouriteStaffRequest copyWith(
          void Function(ToggleFavouriteStaffRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ToggleFavouriteStaffRequest))
          as ToggleFavouriteStaffRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ToggleFavouriteStaffRequest() / ToggleFavouriteStaffRequest.new instead')
  static ToggleFavouriteStaffRequest create() =>
      ToggleFavouriteStaffRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      ToggleFavouriteStaffRequest._();
  @$core.override
  ToggleFavouriteStaffRequest createEmptyInstance() =>
      ToggleFavouriteStaffRequest._();
  @$core.pragma('dart2js:noInline')
  static ToggleFavouriteStaffRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ToggleFavouriteStaffRequest>(
          ToggleFavouriteStaffRequest.$_createMessage);
  static ToggleFavouriteStaffRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get staffId => $_getIZ(0);
  @$pb.TagNumber(1)
  set staffId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStaffId() => $_has(0);
  @$pb.TagNumber(1)
  void clearStaffId() => $_clearField(1);
}

class ToggleFavouriteStaffResponse extends $pb.GeneratedMessage {
  factory ToggleFavouriteStaffResponse({
    $core.int? staffId,
    $core.String? error,
  }) {
    final result = ToggleFavouriteStaffResponse._();
    if (staffId != null) result.staffId = staffId;
    if (error != null) result.error = error;
    return result;
  }

  ToggleFavouriteStaffResponse._();

  factory ToggleFavouriteStaffResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ToggleFavouriteStaffResponse()..mergeFromBuffer(data, registry);
  factory ToggleFavouriteStaffResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ToggleFavouriteStaffResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ToggleFavouriteStaffResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: ToggleFavouriteStaffResponse.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'staffId')
    ..aOS(2, _omitFieldNames ? '' : 'error')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleFavouriteStaffResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleFavouriteStaffResponse copyWith(
          void Function(ToggleFavouriteStaffResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ToggleFavouriteStaffResponse))
          as ToggleFavouriteStaffResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ToggleFavouriteStaffResponse() / ToggleFavouriteStaffResponse.new instead')
  static ToggleFavouriteStaffResponse create() =>
      ToggleFavouriteStaffResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      ToggleFavouriteStaffResponse._();
  @$core.override
  ToggleFavouriteStaffResponse createEmptyInstance() =>
      ToggleFavouriteStaffResponse._();
  @$core.pragma('dart2js:noInline')
  static ToggleFavouriteStaffResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ToggleFavouriteStaffResponse>(
          ToggleFavouriteStaffResponse.$_createMessage);
  static ToggleFavouriteStaffResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get staffId => $_getIZ(0);
  @$pb.TagNumber(1)
  set staffId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStaffId() => $_has(0);
  @$pb.TagNumber(1)
  void clearStaffId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get error => $_getSZ(1);
  @$pb.TagNumber(2)
  set error($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => $_clearField(2);
}

class FetchGenresResponse extends $pb.GeneratedMessage {
  factory FetchGenresResponse({
    $core.Iterable<$core.String>? genres,
    $core.String? error,
  }) {
    final result = FetchGenresResponse._();
    if (genres != null) result.genres.addAll(genres);
    if (error != null) result.error = error;
    return result;
  }

  FetchGenresResponse._();

  factory FetchGenresResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchGenresResponse()..mergeFromBuffer(data, registry);
  factory FetchGenresResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchGenresResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchGenresResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: FetchGenresResponse.$_createMessage)
    ..pPS(1, _omitFieldNames ? '' : 'genres')
    ..aOS(2, _omitFieldNames ? '' : 'error')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchGenresResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchGenresResponse copyWith(void Function(FetchGenresResponse) updates) =>
      super.copyWith((message) => updates(message as FetchGenresResponse))
          as FetchGenresResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use FetchGenresResponse() / FetchGenresResponse.new instead')
  static FetchGenresResponse create() => FetchGenresResponse._();
  static $pb.GeneratedMessage $_createMessage() => FetchGenresResponse._();
  @$core.override
  FetchGenresResponse createEmptyInstance() => FetchGenresResponse._();
  @$core.pragma('dart2js:noInline')
  static FetchGenresResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchGenresResponse>(
          FetchGenresResponse.$_createMessage);
  static FetchGenresResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get genres => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get error => $_getSZ(1);
  @$pb.TagNumber(2)
  set error($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => $_clearField(2);
}

class FetchTagsResponse extends $pb.GeneratedMessage {
  factory FetchTagsResponse({
    $core.Iterable<$9.MediaTag>? tags,
    $core.String? error,
  }) {
    final result = FetchTagsResponse._();
    if (tags != null) result.tags.addAll(tags);
    if (error != null) result.error = error;
    return result;
  }

  FetchTagsResponse._();

  factory FetchTagsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchTagsResponse()..mergeFromBuffer(data, registry);
  factory FetchTagsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchTagsResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchTagsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: FetchTagsResponse.$_createMessage)
    ..pPM<$9.MediaTag>(1, _omitFieldNames ? '' : 'tags',
        subBuilder: $9.MediaTag.$_createMessage)
    ..aOS(2, _omitFieldNames ? '' : 'error')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchTagsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchTagsResponse copyWith(void Function(FetchTagsResponse) updates) =>
      super.copyWith((message) => updates(message as FetchTagsResponse))
          as FetchTagsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use FetchTagsResponse() / FetchTagsResponse.new instead')
  static FetchTagsResponse create() => FetchTagsResponse._();
  static $pb.GeneratedMessage $_createMessage() => FetchTagsResponse._();
  @$core.override
  FetchTagsResponse createEmptyInstance() => FetchTagsResponse._();
  @$core.pragma('dart2js:noInline')
  static FetchTagsResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FetchTagsResponse>(
          FetchTagsResponse.$_createMessage);
  static FetchTagsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$9.MediaTag> get tags => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get error => $_getSZ(1);
  @$pb.TagNumber(2)
  set error($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => $_clearField(2);
}

class FetchMediaSearchRequest extends $pb.GeneratedMessage {
  factory FetchMediaSearchRequest({
    $core.int? page,
    $core.String? query,
    $core.Iterable<$core.String>? sort,
    $core.String? type,
    $core.String? format,
    $core.String? formatNot,
    $core.Iterable<$core.String>? formatIn,
    $core.Iterable<$core.String>? formatNotIn,
    $core.String? status,
    $core.bool? onList,
    $core.int? minAverageScore,
    $core.int? maxAverageScore,
    $core.int? averageScore,
    $core.String? season,
    $core.int? startDate,
    $core.int? minStartDate,
    $core.int? maxStartDate,
    $core.int? episodes,
    $core.int? minEpisodes,
    $core.int? maxEpisodes,
    $core.int? duration,
    $core.int? minDuration,
    $core.int? maxDuration,
    $core.int? chapters,
    $core.int? minChapters,
    $core.int? maxChapters,
    $core.int? volumes,
    $core.int? minVolumes,
    $core.int? maxVolumes,
    $core.bool? isAdult,
    $core.Iterable<$core.String>? genreIn,
    $core.Iterable<$core.String>? genreNotIn,
    $core.Iterable<$core.String>? tagIn,
    $core.Iterable<$core.String>? tagNotIn,
    $core.int? minimumTagRank,
  }) {
    final result = FetchMediaSearchRequest._();
    if (page != null) result.page = page;
    if (query != null) result.query = query;
    if (sort != null) result.sort.addAll(sort);
    if (type != null) result.type = type;
    if (format != null) result.format = format;
    if (formatNot != null) result.formatNot = formatNot;
    if (formatIn != null) result.formatIn.addAll(formatIn);
    if (formatNotIn != null) result.formatNotIn.addAll(formatNotIn);
    if (status != null) result.status = status;
    if (onList != null) result.onList = onList;
    if (minAverageScore != null) result.minAverageScore = minAverageScore;
    if (maxAverageScore != null) result.maxAverageScore = maxAverageScore;
    if (averageScore != null) result.averageScore = averageScore;
    if (season != null) result.season = season;
    if (startDate != null) result.startDate = startDate;
    if (minStartDate != null) result.minStartDate = minStartDate;
    if (maxStartDate != null) result.maxStartDate = maxStartDate;
    if (episodes != null) result.episodes = episodes;
    if (minEpisodes != null) result.minEpisodes = minEpisodes;
    if (maxEpisodes != null) result.maxEpisodes = maxEpisodes;
    if (duration != null) result.duration = duration;
    if (minDuration != null) result.minDuration = minDuration;
    if (maxDuration != null) result.maxDuration = maxDuration;
    if (chapters != null) result.chapters = chapters;
    if (minChapters != null) result.minChapters = minChapters;
    if (maxChapters != null) result.maxChapters = maxChapters;
    if (volumes != null) result.volumes = volumes;
    if (minVolumes != null) result.minVolumes = minVolumes;
    if (maxVolumes != null) result.maxVolumes = maxVolumes;
    if (isAdult != null) result.isAdult = isAdult;
    if (genreIn != null) result.genreIn.addAll(genreIn);
    if (genreNotIn != null) result.genreNotIn.addAll(genreNotIn);
    if (tagIn != null) result.tagIn.addAll(tagIn);
    if (tagNotIn != null) result.tagNotIn.addAll(tagNotIn);
    if (minimumTagRank != null) result.minimumTagRank = minimumTagRank;
    return result;
  }

  FetchMediaSearchRequest._();

  factory FetchMediaSearchRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchMediaSearchRequest()..mergeFromBuffer(data, registry);
  factory FetchMediaSearchRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchMediaSearchRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchMediaSearchRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: FetchMediaSearchRequest.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'page')
    ..aOS(2, _omitFieldNames ? '' : 'query')
    ..pPS(3, _omitFieldNames ? '' : 'sort')
    ..aOS(4, _omitFieldNames ? '' : 'type')
    ..aOS(5, _omitFieldNames ? '' : 'format')
    ..aOS(6, _omitFieldNames ? '' : 'formatNot')
    ..pPS(7, _omitFieldNames ? '' : 'formatIn')
    ..pPS(8, _omitFieldNames ? '' : 'formatNotIn')
    ..aOS(9, _omitFieldNames ? '' : 'status')
    ..aOB(10, _omitFieldNames ? '' : 'onList')
    ..aI(11, _omitFieldNames ? '' : 'minAverageScore')
    ..aI(12, _omitFieldNames ? '' : 'maxAverageScore')
    ..aI(13, _omitFieldNames ? '' : 'averageScore')
    ..aOS(14, _omitFieldNames ? '' : 'season')
    ..aI(15, _omitFieldNames ? '' : 'startDate')
    ..aI(16, _omitFieldNames ? '' : 'minStartDate')
    ..aI(17, _omitFieldNames ? '' : 'maxStartDate')
    ..aI(18, _omitFieldNames ? '' : 'episodes')
    ..aI(19, _omitFieldNames ? '' : 'minEpisodes')
    ..aI(20, _omitFieldNames ? '' : 'maxEpisodes')
    ..aI(21, _omitFieldNames ? '' : 'duration')
    ..aI(22, _omitFieldNames ? '' : 'minDuration')
    ..aI(23, _omitFieldNames ? '' : 'maxDuration')
    ..aI(24, _omitFieldNames ? '' : 'chapters')
    ..aI(25, _omitFieldNames ? '' : 'minChapters')
    ..aI(26, _omitFieldNames ? '' : 'maxChapters')
    ..aI(27, _omitFieldNames ? '' : 'volumes')
    ..aI(28, _omitFieldNames ? '' : 'minVolumes')
    ..aI(29, _omitFieldNames ? '' : 'maxVolumes')
    ..aOB(30, _omitFieldNames ? '' : 'isAdult')
    ..pPS(31, _omitFieldNames ? '' : 'genreIn')
    ..pPS(32, _omitFieldNames ? '' : 'genreNotIn')
    ..pPS(33, _omitFieldNames ? '' : 'tagIn')
    ..pPS(34, _omitFieldNames ? '' : 'tagNotIn')
    ..aI(35, _omitFieldNames ? '' : 'minimumTagRank')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchMediaSearchRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchMediaSearchRequest copyWith(
          void Function(FetchMediaSearchRequest) updates) =>
      super.copyWith((message) => updates(message as FetchMediaSearchRequest))
          as FetchMediaSearchRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use FetchMediaSearchRequest() / FetchMediaSearchRequest.new instead')
  static FetchMediaSearchRequest create() => FetchMediaSearchRequest._();
  static $pb.GeneratedMessage $_createMessage() => FetchMediaSearchRequest._();
  @$core.override
  FetchMediaSearchRequest createEmptyInstance() => FetchMediaSearchRequest._();
  @$core.pragma('dart2js:noInline')
  static FetchMediaSearchRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchMediaSearchRequest>(
          FetchMediaSearchRequest.$_createMessage);
  static FetchMediaSearchRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get query => $_getSZ(1);
  @$pb.TagNumber(2)
  set query($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasQuery() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuery() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get sort => $_getList(2);

  @$pb.TagNumber(4)
  $core.String get type => $_getSZ(3);
  @$pb.TagNumber(4)
  set type($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasType() => $_has(3);
  @$pb.TagNumber(4)
  void clearType() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get format => $_getSZ(4);
  @$pb.TagNumber(5)
  set format($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFormat() => $_has(4);
  @$pb.TagNumber(5)
  void clearFormat() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get formatNot => $_getSZ(5);
  @$pb.TagNumber(6)
  set formatNot($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasFormatNot() => $_has(5);
  @$pb.TagNumber(6)
  void clearFormatNot() => $_clearField(6);

  @$pb.TagNumber(7)
  $pb.PbList<$core.String> get formatIn => $_getList(6);

  @$pb.TagNumber(8)
  $pb.PbList<$core.String> get formatNotIn => $_getList(7);

  @$pb.TagNumber(9)
  $core.String get status => $_getSZ(8);
  @$pb.TagNumber(9)
  set status($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasStatus() => $_has(8);
  @$pb.TagNumber(9)
  void clearStatus() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.bool get onList => $_getBF(9);
  @$pb.TagNumber(10)
  set onList($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasOnList() => $_has(9);
  @$pb.TagNumber(10)
  void clearOnList() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.int get minAverageScore => $_getIZ(10);
  @$pb.TagNumber(11)
  set minAverageScore($core.int value) => $_setSignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasMinAverageScore() => $_has(10);
  @$pb.TagNumber(11)
  void clearMinAverageScore() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.int get maxAverageScore => $_getIZ(11);
  @$pb.TagNumber(12)
  set maxAverageScore($core.int value) => $_setSignedInt32(11, value);
  @$pb.TagNumber(12)
  $core.bool hasMaxAverageScore() => $_has(11);
  @$pb.TagNumber(12)
  void clearMaxAverageScore() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.int get averageScore => $_getIZ(12);
  @$pb.TagNumber(13)
  set averageScore($core.int value) => $_setSignedInt32(12, value);
  @$pb.TagNumber(13)
  $core.bool hasAverageScore() => $_has(12);
  @$pb.TagNumber(13)
  void clearAverageScore() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get season => $_getSZ(13);
  @$pb.TagNumber(14)
  set season($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasSeason() => $_has(13);
  @$pb.TagNumber(14)
  void clearSeason() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.int get startDate => $_getIZ(14);
  @$pb.TagNumber(15)
  set startDate($core.int value) => $_setSignedInt32(14, value);
  @$pb.TagNumber(15)
  $core.bool hasStartDate() => $_has(14);
  @$pb.TagNumber(15)
  void clearStartDate() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.int get minStartDate => $_getIZ(15);
  @$pb.TagNumber(16)
  set minStartDate($core.int value) => $_setSignedInt32(15, value);
  @$pb.TagNumber(16)
  $core.bool hasMinStartDate() => $_has(15);
  @$pb.TagNumber(16)
  void clearMinStartDate() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.int get maxStartDate => $_getIZ(16);
  @$pb.TagNumber(17)
  set maxStartDate($core.int value) => $_setSignedInt32(16, value);
  @$pb.TagNumber(17)
  $core.bool hasMaxStartDate() => $_has(16);
  @$pb.TagNumber(17)
  void clearMaxStartDate() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.int get episodes => $_getIZ(17);
  @$pb.TagNumber(18)
  set episodes($core.int value) => $_setSignedInt32(17, value);
  @$pb.TagNumber(18)
  $core.bool hasEpisodes() => $_has(17);
  @$pb.TagNumber(18)
  void clearEpisodes() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.int get minEpisodes => $_getIZ(18);
  @$pb.TagNumber(19)
  set minEpisodes($core.int value) => $_setSignedInt32(18, value);
  @$pb.TagNumber(19)
  $core.bool hasMinEpisodes() => $_has(18);
  @$pb.TagNumber(19)
  void clearMinEpisodes() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.int get maxEpisodes => $_getIZ(19);
  @$pb.TagNumber(20)
  set maxEpisodes($core.int value) => $_setSignedInt32(19, value);
  @$pb.TagNumber(20)
  $core.bool hasMaxEpisodes() => $_has(19);
  @$pb.TagNumber(20)
  void clearMaxEpisodes() => $_clearField(20);

  @$pb.TagNumber(21)
  $core.int get duration => $_getIZ(20);
  @$pb.TagNumber(21)
  set duration($core.int value) => $_setSignedInt32(20, value);
  @$pb.TagNumber(21)
  $core.bool hasDuration() => $_has(20);
  @$pb.TagNumber(21)
  void clearDuration() => $_clearField(21);

  @$pb.TagNumber(22)
  $core.int get minDuration => $_getIZ(21);
  @$pb.TagNumber(22)
  set minDuration($core.int value) => $_setSignedInt32(21, value);
  @$pb.TagNumber(22)
  $core.bool hasMinDuration() => $_has(21);
  @$pb.TagNumber(22)
  void clearMinDuration() => $_clearField(22);

  @$pb.TagNumber(23)
  $core.int get maxDuration => $_getIZ(22);
  @$pb.TagNumber(23)
  set maxDuration($core.int value) => $_setSignedInt32(22, value);
  @$pb.TagNumber(23)
  $core.bool hasMaxDuration() => $_has(22);
  @$pb.TagNumber(23)
  void clearMaxDuration() => $_clearField(23);

  @$pb.TagNumber(24)
  $core.int get chapters => $_getIZ(23);
  @$pb.TagNumber(24)
  set chapters($core.int value) => $_setSignedInt32(23, value);
  @$pb.TagNumber(24)
  $core.bool hasChapters() => $_has(23);
  @$pb.TagNumber(24)
  void clearChapters() => $_clearField(24);

  @$pb.TagNumber(25)
  $core.int get minChapters => $_getIZ(24);
  @$pb.TagNumber(25)
  set minChapters($core.int value) => $_setSignedInt32(24, value);
  @$pb.TagNumber(25)
  $core.bool hasMinChapters() => $_has(24);
  @$pb.TagNumber(25)
  void clearMinChapters() => $_clearField(25);

  @$pb.TagNumber(26)
  $core.int get maxChapters => $_getIZ(25);
  @$pb.TagNumber(26)
  set maxChapters($core.int value) => $_setSignedInt32(25, value);
  @$pb.TagNumber(26)
  $core.bool hasMaxChapters() => $_has(25);
  @$pb.TagNumber(26)
  void clearMaxChapters() => $_clearField(26);

  @$pb.TagNumber(27)
  $core.int get volumes => $_getIZ(26);
  @$pb.TagNumber(27)
  set volumes($core.int value) => $_setSignedInt32(26, value);
  @$pb.TagNumber(27)
  $core.bool hasVolumes() => $_has(26);
  @$pb.TagNumber(27)
  void clearVolumes() => $_clearField(27);

  @$pb.TagNumber(28)
  $core.int get minVolumes => $_getIZ(27);
  @$pb.TagNumber(28)
  set minVolumes($core.int value) => $_setSignedInt32(27, value);
  @$pb.TagNumber(28)
  $core.bool hasMinVolumes() => $_has(27);
  @$pb.TagNumber(28)
  void clearMinVolumes() => $_clearField(28);

  @$pb.TagNumber(29)
  $core.int get maxVolumes => $_getIZ(28);
  @$pb.TagNumber(29)
  set maxVolumes($core.int value) => $_setSignedInt32(28, value);
  @$pb.TagNumber(29)
  $core.bool hasMaxVolumes() => $_has(28);
  @$pb.TagNumber(29)
  void clearMaxVolumes() => $_clearField(29);

  @$pb.TagNumber(30)
  $core.bool get isAdult => $_getBF(29);
  @$pb.TagNumber(30)
  set isAdult($core.bool value) => $_setBool(29, value);
  @$pb.TagNumber(30)
  $core.bool hasIsAdult() => $_has(29);
  @$pb.TagNumber(30)
  void clearIsAdult() => $_clearField(30);

  @$pb.TagNumber(31)
  $pb.PbList<$core.String> get genreIn => $_getList(30);

  @$pb.TagNumber(32)
  $pb.PbList<$core.String> get genreNotIn => $_getList(31);

  @$pb.TagNumber(33)
  $pb.PbList<$core.String> get tagIn => $_getList(32);

  @$pb.TagNumber(34)
  $pb.PbList<$core.String> get tagNotIn => $_getList(33);

  @$pb.TagNumber(35)
  $core.int get minimumTagRank => $_getIZ(34);
  @$pb.TagNumber(35)
  set minimumTagRank($core.int value) => $_setSignedInt32(34, value);
  @$pb.TagNumber(35)
  $core.bool hasMinimumTagRank() => $_has(34);
  @$pb.TagNumber(35)
  void clearMinimumTagRank() => $_clearField(35);
}

class FetchMediaSearchResponse extends $pb.GeneratedMessage {
  factory FetchMediaSearchResponse({
    $core.Iterable<$10.MediaMin>? media,
    $5.PageInfo? pageInfo,
    $core.String? error,
  }) {
    final result = FetchMediaSearchResponse._();
    if (media != null) result.media.addAll(media);
    if (pageInfo != null) result.pageInfo = pageInfo;
    if (error != null) result.error = error;
    return result;
  }

  FetchMediaSearchResponse._();

  factory FetchMediaSearchResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchMediaSearchResponse()..mergeFromBuffer(data, registry);
  factory FetchMediaSearchResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchMediaSearchResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchMediaSearchResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: FetchMediaSearchResponse.$_createMessage)
    ..pPM<$10.MediaMin>(1, _omitFieldNames ? '' : 'media',
        subBuilder: $10.MediaMin.$_createMessage)
    ..aOM<$5.PageInfo>(2, _omitFieldNames ? '' : 'pageInfo',
        subBuilder: $5.PageInfo.$_createMessage)
    ..aOS(3, _omitFieldNames ? '' : 'error')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchMediaSearchResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchMediaSearchResponse copyWith(
          void Function(FetchMediaSearchResponse) updates) =>
      super.copyWith((message) => updates(message as FetchMediaSearchResponse))
          as FetchMediaSearchResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use FetchMediaSearchResponse() / FetchMediaSearchResponse.new instead')
  static FetchMediaSearchResponse create() => FetchMediaSearchResponse._();
  static $pb.GeneratedMessage $_createMessage() => FetchMediaSearchResponse._();
  @$core.override
  FetchMediaSearchResponse createEmptyInstance() =>
      FetchMediaSearchResponse._();
  @$core.pragma('dart2js:noInline')
  static FetchMediaSearchResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchMediaSearchResponse>(
          FetchMediaSearchResponse.$_createMessage);
  static FetchMediaSearchResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$10.MediaMin> get media => $_getList(0);

  @$pb.TagNumber(2)
  $5.PageInfo get pageInfo => $_getN(1);
  @$pb.TagNumber(2)
  set pageInfo($5.PageInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPageInfo() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageInfo() => $_clearField(2);
  @$pb.TagNumber(2)
  $5.PageInfo ensurePageInfo() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get error => $_getSZ(2);
  @$pb.TagNumber(3)
  set error($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(3)
  void clearError() => $_clearField(3);
}

class FetchStudioSearchRequest extends $pb.GeneratedMessage {
  factory FetchStudioSearchRequest({
    $core.int? page,
    $core.String? query,
    $core.Iterable<$core.String>? sort,
  }) {
    final result = FetchStudioSearchRequest._();
    if (page != null) result.page = page;
    if (query != null) result.query = query;
    if (sort != null) result.sort.addAll(sort);
    return result;
  }

  FetchStudioSearchRequest._();

  factory FetchStudioSearchRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchStudioSearchRequest()..mergeFromBuffer(data, registry);
  factory FetchStudioSearchRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchStudioSearchRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchStudioSearchRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: FetchStudioSearchRequest.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'page')
    ..aOS(2, _omitFieldNames ? '' : 'query')
    ..pPS(3, _omitFieldNames ? '' : 'sort')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchStudioSearchRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchStudioSearchRequest copyWith(
          void Function(FetchStudioSearchRequest) updates) =>
      super.copyWith((message) => updates(message as FetchStudioSearchRequest))
          as FetchStudioSearchRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use FetchStudioSearchRequest() / FetchStudioSearchRequest.new instead')
  static FetchStudioSearchRequest create() => FetchStudioSearchRequest._();
  static $pb.GeneratedMessage $_createMessage() => FetchStudioSearchRequest._();
  @$core.override
  FetchStudioSearchRequest createEmptyInstance() =>
      FetchStudioSearchRequest._();
  @$core.pragma('dart2js:noInline')
  static FetchStudioSearchRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchStudioSearchRequest>(
          FetchStudioSearchRequest.$_createMessage);
  static FetchStudioSearchRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get query => $_getSZ(1);
  @$pb.TagNumber(2)
  set query($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasQuery() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuery() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get sort => $_getList(2);
}

class FetchStudioSearchResponse extends $pb.GeneratedMessage {
  factory FetchStudioSearchResponse({
    $core.Iterable<$7.Studio>? studios,
    $5.PageInfo? pageInfo,
    $core.String? error,
  }) {
    final result = FetchStudioSearchResponse._();
    if (studios != null) result.studios.addAll(studios);
    if (pageInfo != null) result.pageInfo = pageInfo;
    if (error != null) result.error = error;
    return result;
  }

  FetchStudioSearchResponse._();

  factory FetchStudioSearchResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchStudioSearchResponse()..mergeFromBuffer(data, registry);
  factory FetchStudioSearchResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchStudioSearchResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchStudioSearchResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: FetchStudioSearchResponse.$_createMessage)
    ..pPM<$7.Studio>(1, _omitFieldNames ? '' : 'studios',
        subBuilder: $7.Studio.$_createMessage)
    ..aOM<$5.PageInfo>(2, _omitFieldNames ? '' : 'pageInfo',
        subBuilder: $5.PageInfo.$_createMessage)
    ..aOS(3, _omitFieldNames ? '' : 'error')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchStudioSearchResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchStudioSearchResponse copyWith(
          void Function(FetchStudioSearchResponse) updates) =>
      super.copyWith((message) => updates(message as FetchStudioSearchResponse))
          as FetchStudioSearchResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use FetchStudioSearchResponse() / FetchStudioSearchResponse.new instead')
  static FetchStudioSearchResponse create() => FetchStudioSearchResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      FetchStudioSearchResponse._();
  @$core.override
  FetchStudioSearchResponse createEmptyInstance() =>
      FetchStudioSearchResponse._();
  @$core.pragma('dart2js:noInline')
  static FetchStudioSearchResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchStudioSearchResponse>(
          FetchStudioSearchResponse.$_createMessage);
  static FetchStudioSearchResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$7.Studio> get studios => $_getList(0);

  @$pb.TagNumber(2)
  $5.PageInfo get pageInfo => $_getN(1);
  @$pb.TagNumber(2)
  set pageInfo($5.PageInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPageInfo() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageInfo() => $_clearField(2);
  @$pb.TagNumber(2)
  $5.PageInfo ensurePageInfo() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get error => $_getSZ(2);
  @$pb.TagNumber(3)
  set error($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(3)
  void clearError() => $_clearField(3);
}

class FetchCharacterDetailsRequest extends $pb.GeneratedMessage {
  factory FetchCharacterDetailsRequest({
    $core.int? characterId,
    $core.int? page,
  }) {
    final result = FetchCharacterDetailsRequest._();
    if (characterId != null) result.characterId = characterId;
    if (page != null) result.page = page;
    return result;
  }

  FetchCharacterDetailsRequest._();

  factory FetchCharacterDetailsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchCharacterDetailsRequest()..mergeFromBuffer(data, registry);
  factory FetchCharacterDetailsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchCharacterDetailsRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchCharacterDetailsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: FetchCharacterDetailsRequest.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'characterId')
    ..aI(2, _omitFieldNames ? '' : 'page')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchCharacterDetailsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchCharacterDetailsRequest copyWith(
          void Function(FetchCharacterDetailsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as FetchCharacterDetailsRequest))
          as FetchCharacterDetailsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use FetchCharacterDetailsRequest() / FetchCharacterDetailsRequest.new instead')
  static FetchCharacterDetailsRequest create() =>
      FetchCharacterDetailsRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      FetchCharacterDetailsRequest._();
  @$core.override
  FetchCharacterDetailsRequest createEmptyInstance() =>
      FetchCharacterDetailsRequest._();
  @$core.pragma('dart2js:noInline')
  static FetchCharacterDetailsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchCharacterDetailsRequest>(
          FetchCharacterDetailsRequest.$_createMessage);
  static FetchCharacterDetailsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get characterId => $_getIZ(0);
  @$pb.TagNumber(1)
  set characterId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCharacterId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCharacterId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => $_clearField(2);
}

class FetchCharacterDetailsResponse extends $pb.GeneratedMessage {
  factory FetchCharacterDetailsResponse({
    $11.Character? character,
    $core.String? error,
  }) {
    final result = FetchCharacterDetailsResponse._();
    if (character != null) result.character = character;
    if (error != null) result.error = error;
    return result;
  }

  FetchCharacterDetailsResponse._();

  factory FetchCharacterDetailsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchCharacterDetailsResponse()..mergeFromBuffer(data, registry);
  factory FetchCharacterDetailsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchCharacterDetailsResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchCharacterDetailsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: FetchCharacterDetailsResponse.$_createMessage)
    ..aOM<$11.Character>(1, _omitFieldNames ? '' : 'character',
        subBuilder: $11.Character.$_createMessage)
    ..aOS(2, _omitFieldNames ? '' : 'error')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchCharacterDetailsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchCharacterDetailsResponse copyWith(
          void Function(FetchCharacterDetailsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as FetchCharacterDetailsResponse))
          as FetchCharacterDetailsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use FetchCharacterDetailsResponse() / FetchCharacterDetailsResponse.new instead')
  static FetchCharacterDetailsResponse create() =>
      FetchCharacterDetailsResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      FetchCharacterDetailsResponse._();
  @$core.override
  FetchCharacterDetailsResponse createEmptyInstance() =>
      FetchCharacterDetailsResponse._();
  @$core.pragma('dart2js:noInline')
  static FetchCharacterDetailsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchCharacterDetailsResponse>(
          FetchCharacterDetailsResponse.$_createMessage);
  static FetchCharacterDetailsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $11.Character get character => $_getN(0);
  @$pb.TagNumber(1)
  set character($11.Character value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCharacter() => $_has(0);
  @$pb.TagNumber(1)
  void clearCharacter() => $_clearField(1);
  @$pb.TagNumber(1)
  $11.Character ensureCharacter() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get error => $_getSZ(1);
  @$pb.TagNumber(2)
  set error($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => $_clearField(2);
}

class ToggleFavouriteCharacterRequest extends $pb.GeneratedMessage {
  factory ToggleFavouriteCharacterRequest({
    $core.int? characterId,
  }) {
    final result = ToggleFavouriteCharacterRequest._();
    if (characterId != null) result.characterId = characterId;
    return result;
  }

  ToggleFavouriteCharacterRequest._();

  factory ToggleFavouriteCharacterRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ToggleFavouriteCharacterRequest()..mergeFromBuffer(data, registry);
  factory ToggleFavouriteCharacterRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ToggleFavouriteCharacterRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ToggleFavouriteCharacterRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: ToggleFavouriteCharacterRequest.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'characterId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleFavouriteCharacterRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleFavouriteCharacterRequest copyWith(
          void Function(ToggleFavouriteCharacterRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ToggleFavouriteCharacterRequest))
          as ToggleFavouriteCharacterRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ToggleFavouriteCharacterRequest() / ToggleFavouriteCharacterRequest.new instead')
  static ToggleFavouriteCharacterRequest create() =>
      ToggleFavouriteCharacterRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      ToggleFavouriteCharacterRequest._();
  @$core.override
  ToggleFavouriteCharacterRequest createEmptyInstance() =>
      ToggleFavouriteCharacterRequest._();
  @$core.pragma('dart2js:noInline')
  static ToggleFavouriteCharacterRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ToggleFavouriteCharacterRequest>(
          ToggleFavouriteCharacterRequest.$_createMessage);
  static ToggleFavouriteCharacterRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get characterId => $_getIZ(0);
  @$pb.TagNumber(1)
  set characterId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCharacterId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCharacterId() => $_clearField(1);
}

class ToggleFavouriteCharacterResponse extends $pb.GeneratedMessage {
  factory ToggleFavouriteCharacterResponse({
    $core.int? characterId,
    $core.String? error,
  }) {
    final result = ToggleFavouriteCharacterResponse._();
    if (characterId != null) result.characterId = characterId;
    if (error != null) result.error = error;
    return result;
  }

  ToggleFavouriteCharacterResponse._();

  factory ToggleFavouriteCharacterResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ToggleFavouriteCharacterResponse()..mergeFromBuffer(data, registry);
  factory ToggleFavouriteCharacterResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ToggleFavouriteCharacterResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ToggleFavouriteCharacterResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: ToggleFavouriteCharacterResponse.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'characterId')
    ..aOS(2, _omitFieldNames ? '' : 'error')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleFavouriteCharacterResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleFavouriteCharacterResponse copyWith(
          void Function(ToggleFavouriteCharacterResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ToggleFavouriteCharacterResponse))
          as ToggleFavouriteCharacterResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ToggleFavouriteCharacterResponse() / ToggleFavouriteCharacterResponse.new instead')
  static ToggleFavouriteCharacterResponse create() =>
      ToggleFavouriteCharacterResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      ToggleFavouriteCharacterResponse._();
  @$core.override
  ToggleFavouriteCharacterResponse createEmptyInstance() =>
      ToggleFavouriteCharacterResponse._();
  @$core.pragma('dart2js:noInline')
  static ToggleFavouriteCharacterResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ToggleFavouriteCharacterResponse>(
          ToggleFavouriteCharacterResponse.$_createMessage);
  static ToggleFavouriteCharacterResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get characterId => $_getIZ(0);
  @$pb.TagNumber(1)
  set characterId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCharacterId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCharacterId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get error => $_getSZ(1);
  @$pb.TagNumber(2)
  set error($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => $_clearField(2);
}

class FetchCharacterSearchRequest extends $pb.GeneratedMessage {
  factory FetchCharacterSearchRequest({
    $core.int? page,
    $core.String? query,
    $core.Iterable<$core.String>? sort,
    $core.bool? isBirthday,
  }) {
    final result = FetchCharacterSearchRequest._();
    if (page != null) result.page = page;
    if (query != null) result.query = query;
    if (sort != null) result.sort.addAll(sort);
    if (isBirthday != null) result.isBirthday = isBirthday;
    return result;
  }

  FetchCharacterSearchRequest._();

  factory FetchCharacterSearchRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchCharacterSearchRequest()..mergeFromBuffer(data, registry);
  factory FetchCharacterSearchRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchCharacterSearchRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchCharacterSearchRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: FetchCharacterSearchRequest.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'page')
    ..aOS(2, _omitFieldNames ? '' : 'query')
    ..pPS(3, _omitFieldNames ? '' : 'sort')
    ..aOB(4, _omitFieldNames ? '' : 'isBirthday')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchCharacterSearchRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchCharacterSearchRequest copyWith(
          void Function(FetchCharacterSearchRequest) updates) =>
      super.copyWith(
              (message) => updates(message as FetchCharacterSearchRequest))
          as FetchCharacterSearchRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use FetchCharacterSearchRequest() / FetchCharacterSearchRequest.new instead')
  static FetchCharacterSearchRequest create() =>
      FetchCharacterSearchRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      FetchCharacterSearchRequest._();
  @$core.override
  FetchCharacterSearchRequest createEmptyInstance() =>
      FetchCharacterSearchRequest._();
  @$core.pragma('dart2js:noInline')
  static FetchCharacterSearchRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchCharacterSearchRequest>(
          FetchCharacterSearchRequest.$_createMessage);
  static FetchCharacterSearchRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get query => $_getSZ(1);
  @$pb.TagNumber(2)
  set query($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasQuery() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuery() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get sort => $_getList(2);

  @$pb.TagNumber(4)
  $core.bool get isBirthday => $_getBF(3);
  @$pb.TagNumber(4)
  set isBirthday($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasIsBirthday() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsBirthday() => $_clearField(4);
}

class FetchCharacterSearchResponse extends $pb.GeneratedMessage {
  factory FetchCharacterSearchResponse({
    $core.Iterable<$11.Character>? characters,
    $5.PageInfo? pageInfo,
    $core.String? error,
  }) {
    final result = FetchCharacterSearchResponse._();
    if (characters != null) result.characters.addAll(characters);
    if (pageInfo != null) result.pageInfo = pageInfo;
    if (error != null) result.error = error;
    return result;
  }

  FetchCharacterSearchResponse._();

  factory FetchCharacterSearchResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchCharacterSearchResponse()..mergeFromBuffer(data, registry);
  factory FetchCharacterSearchResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchCharacterSearchResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchCharacterSearchResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: FetchCharacterSearchResponse.$_createMessage)
    ..pPM<$11.Character>(1, _omitFieldNames ? '' : 'characters',
        subBuilder: $11.Character.$_createMessage)
    ..aOM<$5.PageInfo>(2, _omitFieldNames ? '' : 'pageInfo',
        subBuilder: $5.PageInfo.$_createMessage)
    ..aOS(3, _omitFieldNames ? '' : 'error')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchCharacterSearchResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchCharacterSearchResponse copyWith(
          void Function(FetchCharacterSearchResponse) updates) =>
      super.copyWith(
              (message) => updates(message as FetchCharacterSearchResponse))
          as FetchCharacterSearchResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use FetchCharacterSearchResponse() / FetchCharacterSearchResponse.new instead')
  static FetchCharacterSearchResponse create() =>
      FetchCharacterSearchResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      FetchCharacterSearchResponse._();
  @$core.override
  FetchCharacterSearchResponse createEmptyInstance() =>
      FetchCharacterSearchResponse._();
  @$core.pragma('dart2js:noInline')
  static FetchCharacterSearchResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchCharacterSearchResponse>(
          FetchCharacterSearchResponse.$_createMessage);
  static FetchCharacterSearchResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$11.Character> get characters => $_getList(0);

  @$pb.TagNumber(2)
  $5.PageInfo get pageInfo => $_getN(1);
  @$pb.TagNumber(2)
  set pageInfo($5.PageInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPageInfo() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageInfo() => $_clearField(2);
  @$pb.TagNumber(2)
  $5.PageInfo ensurePageInfo() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get error => $_getSZ(2);
  @$pb.TagNumber(3)
  set error($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(3)
  void clearError() => $_clearField(3);
}

class FetchStaffSearchRequest extends $pb.GeneratedMessage {
  factory FetchStaffSearchRequest({
    $core.int? page,
    $core.String? query,
    $core.Iterable<$core.String>? sort,
    $core.bool? isBirthday,
  }) {
    final result = FetchStaffSearchRequest._();
    if (page != null) result.page = page;
    if (query != null) result.query = query;
    if (sort != null) result.sort.addAll(sort);
    if (isBirthday != null) result.isBirthday = isBirthday;
    return result;
  }

  FetchStaffSearchRequest._();

  factory FetchStaffSearchRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchStaffSearchRequest()..mergeFromBuffer(data, registry);
  factory FetchStaffSearchRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchStaffSearchRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchStaffSearchRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: FetchStaffSearchRequest.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'page')
    ..aOS(2, _omitFieldNames ? '' : 'query')
    ..pPS(3, _omitFieldNames ? '' : 'sort')
    ..aOB(4, _omitFieldNames ? '' : 'isBirthday')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchStaffSearchRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchStaffSearchRequest copyWith(
          void Function(FetchStaffSearchRequest) updates) =>
      super.copyWith((message) => updates(message as FetchStaffSearchRequest))
          as FetchStaffSearchRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use FetchStaffSearchRequest() / FetchStaffSearchRequest.new instead')
  static FetchStaffSearchRequest create() => FetchStaffSearchRequest._();
  static $pb.GeneratedMessage $_createMessage() => FetchStaffSearchRequest._();
  @$core.override
  FetchStaffSearchRequest createEmptyInstance() => FetchStaffSearchRequest._();
  @$core.pragma('dart2js:noInline')
  static FetchStaffSearchRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchStaffSearchRequest>(
          FetchStaffSearchRequest.$_createMessage);
  static FetchStaffSearchRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get query => $_getSZ(1);
  @$pb.TagNumber(2)
  set query($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasQuery() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuery() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get sort => $_getList(2);

  @$pb.TagNumber(4)
  $core.bool get isBirthday => $_getBF(3);
  @$pb.TagNumber(4)
  set isBirthday($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasIsBirthday() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsBirthday() => $_clearField(4);
}

class FetchStaffSearchResponse extends $pb.GeneratedMessage {
  factory FetchStaffSearchResponse({
    $core.Iterable<$8.Staff>? staff,
    $5.PageInfo? pageInfo,
    $core.String? error,
  }) {
    final result = FetchStaffSearchResponse._();
    if (staff != null) result.staff.addAll(staff);
    if (pageInfo != null) result.pageInfo = pageInfo;
    if (error != null) result.error = error;
    return result;
  }

  FetchStaffSearchResponse._();

  factory FetchStaffSearchResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchStaffSearchResponse()..mergeFromBuffer(data, registry);
  factory FetchStaffSearchResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FetchStaffSearchResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchStaffSearchResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: FetchStaffSearchResponse.$_createMessage)
    ..pPM<$8.Staff>(1, _omitFieldNames ? '' : 'staff',
        subBuilder: $8.Staff.$_createMessage)
    ..aOM<$5.PageInfo>(2, _omitFieldNames ? '' : 'pageInfo',
        subBuilder: $5.PageInfo.$_createMessage)
    ..aOS(3, _omitFieldNames ? '' : 'error')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchStaffSearchResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FetchStaffSearchResponse copyWith(
          void Function(FetchStaffSearchResponse) updates) =>
      super.copyWith((message) => updates(message as FetchStaffSearchResponse))
          as FetchStaffSearchResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use FetchStaffSearchResponse() / FetchStaffSearchResponse.new instead')
  static FetchStaffSearchResponse create() => FetchStaffSearchResponse._();
  static $pb.GeneratedMessage $_createMessage() => FetchStaffSearchResponse._();
  @$core.override
  FetchStaffSearchResponse createEmptyInstance() =>
      FetchStaffSearchResponse._();
  @$core.pragma('dart2js:noInline')
  static FetchStaffSearchResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchStaffSearchResponse>(
          FetchStaffSearchResponse.$_createMessage);
  static FetchStaffSearchResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$8.Staff> get staff => $_getList(0);

  @$pb.TagNumber(2)
  $5.PageInfo get pageInfo => $_getN(1);
  @$pb.TagNumber(2)
  set pageInfo($5.PageInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPageInfo() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageInfo() => $_clearField(2);
  @$pb.TagNumber(2)
  $5.PageInfo ensurePageInfo() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get error => $_getSZ(2);
  @$pb.TagNumber(3)
  set error($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(3)
  void clearError() => $_clearField(3);
}

class UpdateCustomListsRequest extends $pb.GeneratedMessage {
  factory UpdateCustomListsRequest({
    $core.String? mediaType,
    $core.Iterable<$core.String>? customLists,
  }) {
    final result = UpdateCustomListsRequest._();
    if (mediaType != null) result.mediaType = mediaType;
    if (customLists != null) result.customLists.addAll(customLists);
    return result;
  }

  UpdateCustomListsRequest._();

  factory UpdateCustomListsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateCustomListsRequest()..mergeFromBuffer(data, registry);
  factory UpdateCustomListsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateCustomListsRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateCustomListsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: UpdateCustomListsRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'mediaType')
    ..pPS(2, _omitFieldNames ? '' : 'customLists')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateCustomListsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateCustomListsRequest copyWith(
          void Function(UpdateCustomListsRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateCustomListsRequest))
          as UpdateCustomListsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use UpdateCustomListsRequest() / UpdateCustomListsRequest.new instead')
  static UpdateCustomListsRequest create() => UpdateCustomListsRequest._();
  static $pb.GeneratedMessage $_createMessage() => UpdateCustomListsRequest._();
  @$core.override
  UpdateCustomListsRequest createEmptyInstance() =>
      UpdateCustomListsRequest._();
  @$core.pragma('dart2js:noInline')
  static UpdateCustomListsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateCustomListsRequest>(
          UpdateCustomListsRequest.$_createMessage);
  static UpdateCustomListsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get mediaType => $_getSZ(0);
  @$pb.TagNumber(1)
  set mediaType($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMediaType() => $_has(0);
  @$pb.TagNumber(1)
  void clearMediaType() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get customLists => $_getList(1);
}

class UpdateCustomListsResponse extends $pb.GeneratedMessage {
  factory UpdateCustomListsResponse({
    $core.String? error,
    $core.Iterable<$core.String>? animeCustomLists,
    $core.Iterable<$core.String>? mangaCustomLists,
  }) {
    final result = UpdateCustomListsResponse._();
    if (error != null) result.error = error;
    if (animeCustomLists != null)
      result.animeCustomLists.addAll(animeCustomLists);
    if (mangaCustomLists != null)
      result.mangaCustomLists.addAll(mangaCustomLists);
    return result;
  }

  UpdateCustomListsResponse._();

  factory UpdateCustomListsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateCustomListsResponse()..mergeFromBuffer(data, registry);
  factory UpdateCustomListsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateCustomListsResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateCustomListsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: UpdateCustomListsResponse.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'error')
    ..pPS(2, _omitFieldNames ? '' : 'animeCustomLists')
    ..pPS(3, _omitFieldNames ? '' : 'mangaCustomLists')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateCustomListsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateCustomListsResponse copyWith(
          void Function(UpdateCustomListsResponse) updates) =>
      super.copyWith((message) => updates(message as UpdateCustomListsResponse))
          as UpdateCustomListsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use UpdateCustomListsResponse() / UpdateCustomListsResponse.new instead')
  static UpdateCustomListsResponse create() => UpdateCustomListsResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      UpdateCustomListsResponse._();
  @$core.override
  UpdateCustomListsResponse createEmptyInstance() =>
      UpdateCustomListsResponse._();
  @$core.pragma('dart2js:noInline')
  static UpdateCustomListsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateCustomListsResponse>(
          UpdateCustomListsResponse.$_createMessage);
  static UpdateCustomListsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get error => $_getSZ(0);
  @$pb.TagNumber(1)
  set error($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasError() => $_has(0);
  @$pb.TagNumber(1)
  void clearError() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get animeCustomLists => $_getList(1);

  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get mangaCustomLists => $_getList(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
