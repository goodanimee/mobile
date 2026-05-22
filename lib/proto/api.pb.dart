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

import 'common.pb.dart' as $2;
import 'media.pb.dart' as $3;
import 'media_list.pb.dart' as $0;
import 'viewer.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

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
    $0.MediaListCollection? collection,
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
    ..aOM<$0.MediaListCollection>(1, _omitFieldNames ? '' : 'collection',
        subBuilder: $0.MediaListCollection.create)
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
    ..aOM<$1.Viewer>(1, _omitFieldNames ? '' : 'viewer',
        subBuilder: $1.Viewer.create)
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
    $2.FuzzyDate? startedAt,
    $2.FuzzyDate? completedAt,
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
    ..aOM<$2.FuzzyDate>(6, _omitFieldNames ? '' : 'startedAt',
        subBuilder: $2.FuzzyDate.create)
    ..aOM<$2.FuzzyDate>(7, _omitFieldNames ? '' : 'completedAt',
        subBuilder: $2.FuzzyDate.create)
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
  $2.FuzzyDate get startedAt => $_getN(5);
  @$pb.TagNumber(6)
  set startedAt($2.FuzzyDate value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasStartedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearStartedAt() => $_clearField(6);
  @$pb.TagNumber(6)
  $2.FuzzyDate ensureStartedAt() => $_ensure(5);

  @$pb.TagNumber(7)
  $2.FuzzyDate get completedAt => $_getN(6);
  @$pb.TagNumber(7)
  set completedAt($2.FuzzyDate value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasCompletedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearCompletedAt() => $_clearField(7);
  @$pb.TagNumber(7)
  $2.FuzzyDate ensureCompletedAt() => $_ensure(6);

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
    $3.Media? media,
    $core.String? error,
  }) {
    final result = create();
    if (media != null) result.media = media;
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
    ..aOM<$3.Media>(1, _omitFieldNames ? '' : 'media',
        subBuilder: $3.Media.create)
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
    $3.Media? media,
    $core.String? error,
  }) {
    final result = create();
    if (media != null) result.media = media;
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
    ..aOM<$3.Media>(1, _omitFieldNames ? '' : 'media',
        subBuilder: $3.Media.create)
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
    $3.Media? media,
    $core.String? error,
  }) {
    final result = create();
    if (media != null) result.media = media;
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
    ..aOM<$3.Media>(1, _omitFieldNames ? '' : 'media',
        subBuilder: $3.Media.create)
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
    final result = create();
    if (mediaId != null) result.mediaId = mediaId;
    if (page != null) result.page = page;
    if (perPage != null) result.perPage = perPage;
    return result;
  }

  FetchMediaRecommendationsRequest._();

  factory FetchMediaRecommendationsRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FetchMediaRecommendationsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchMediaRecommendationsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
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
  static FetchMediaRecommendationsRequest create() =>
      FetchMediaRecommendationsRequest._();
  @$core.override
  FetchMediaRecommendationsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FetchMediaRecommendationsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchMediaRecommendationsRequest>(
          create);
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
    final result = create();
    if (media != null) result.media = media;
    if (error != null) result.error = error;
    return result;
  }

  FetchMediaRecommendationsResponse._();

  factory FetchMediaRecommendationsResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FetchMediaRecommendationsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FetchMediaRecommendationsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aOM<$3.Media>(1, _omitFieldNames ? '' : 'media',
        subBuilder: $3.Media.create)
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
  static FetchMediaRecommendationsResponse create() =>
      FetchMediaRecommendationsResponse._();
  @$core.override
  FetchMediaRecommendationsResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FetchMediaRecommendationsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FetchMediaRecommendationsResponse>(
          create);
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
    final result = create();
    if (animeId != null) result.animeId = animeId;
    return result;
  }

  ToggleFavouriteAnimeRequest._();

  factory ToggleFavouriteAnimeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ToggleFavouriteAnimeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ToggleFavouriteAnimeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
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
  static ToggleFavouriteAnimeRequest create() =>
      ToggleFavouriteAnimeRequest._();
  @$core.override
  ToggleFavouriteAnimeRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ToggleFavouriteAnimeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ToggleFavouriteAnimeRequest>(create);
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
    final result = create();
    if (animeId != null) result.animeId = animeId;
    if (isFavourite != null) result.isFavourite = isFavourite;
    if (error != null) result.error = error;
    return result;
  }

  ToggleFavouriteAnimeResponse._();

  factory ToggleFavouriteAnimeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ToggleFavouriteAnimeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ToggleFavouriteAnimeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
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
  static ToggleFavouriteAnimeResponse create() =>
      ToggleFavouriteAnimeResponse._();
  @$core.override
  ToggleFavouriteAnimeResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ToggleFavouriteAnimeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ToggleFavouriteAnimeResponse>(create);
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

class DeleteMediaListEntryRequest extends $pb.GeneratedMessage {
  factory DeleteMediaListEntryRequest({
    $core.int? entryId,
  }) {
    final result = create();
    if (entryId != null) result.entryId = entryId;
    return result;
  }

  DeleteMediaListEntryRequest._();

  factory DeleteMediaListEntryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteMediaListEntryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteMediaListEntryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
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
  static DeleteMediaListEntryRequest create() =>
      DeleteMediaListEntryRequest._();
  @$core.override
  DeleteMediaListEntryRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeleteMediaListEntryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteMediaListEntryRequest>(create);
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
    final result = create();
    if (entryId != null) result.entryId = entryId;
    if (deleted != null) result.deleted = deleted;
    if (error != null) result.error = error;
    return result;
  }

  DeleteMediaListEntryResponse._();

  factory DeleteMediaListEntryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteMediaListEntryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteMediaListEntryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
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
  static DeleteMediaListEntryResponse create() =>
      DeleteMediaListEntryResponse._();
  @$core.override
  DeleteMediaListEntryResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeleteMediaListEntryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteMediaListEntryResponse>(create);
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

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
