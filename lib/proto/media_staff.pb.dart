// This is a generated file - do not edit.
//
// Generated from media_staff.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class StaffName extends $pb.GeneratedMessage {
  factory StaffName({
    $core.String? full,
    $core.String? native,
    $core.String? userPreferred,
  }) {
    final result = create();
    if (full != null) result.full = full;
    if (native != null) result.native = native;
    if (userPreferred != null) result.userPreferred = userPreferred;
    return result;
  }

  StaffName._();

  factory StaffName.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StaffName.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StaffName',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'full')
    ..aOS(2, _omitFieldNames ? '' : 'native')
    ..aOS(3, _omitFieldNames ? '' : 'userPreferred')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StaffName clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StaffName copyWith(void Function(StaffName) updates) =>
      super.copyWith((message) => updates(message as StaffName)) as StaffName;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StaffName create() => StaffName._();
  @$core.override
  StaffName createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StaffName getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StaffName>(create);
  static StaffName? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get full => $_getSZ(0);
  @$pb.TagNumber(1)
  set full($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFull() => $_has(0);
  @$pb.TagNumber(1)
  void clearFull() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get native => $_getSZ(1);
  @$pb.TagNumber(2)
  set native($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNative() => $_has(1);
  @$pb.TagNumber(2)
  void clearNative() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get userPreferred => $_getSZ(2);
  @$pb.TagNumber(3)
  set userPreferred($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUserPreferred() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserPreferred() => $_clearField(3);
}

class StaffImage extends $pb.GeneratedMessage {
  factory StaffImage({
    $core.String? large,
    $core.String? medium,
  }) {
    final result = create();
    if (large != null) result.large = large;
    if (medium != null) result.medium = medium;
    return result;
  }

  StaffImage._();

  factory StaffImage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StaffImage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StaffImage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'large')
    ..aOS(2, _omitFieldNames ? '' : 'medium')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StaffImage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StaffImage copyWith(void Function(StaffImage) updates) =>
      super.copyWith((message) => updates(message as StaffImage)) as StaffImage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StaffImage create() => StaffImage._();
  @$core.override
  StaffImage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StaffImage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StaffImage>(create);
  static StaffImage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get large => $_getSZ(0);
  @$pb.TagNumber(1)
  set large($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLarge() => $_has(0);
  @$pb.TagNumber(1)
  void clearLarge() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get medium => $_getSZ(1);
  @$pb.TagNumber(2)
  set medium($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMedium() => $_has(1);
  @$pb.TagNumber(2)
  void clearMedium() => $_clearField(2);
}

class StaffMin extends $pb.GeneratedMessage {
  factory StaffMin({
    $core.int? id,
    StaffName? name,
    StaffImage? image,
    $core.String? languageV2,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (image != null) result.image = image;
    if (languageV2 != null) result.languageV2 = languageV2;
    return result;
  }

  StaffMin._();

  factory StaffMin.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StaffMin.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StaffMin',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..aOM<StaffName>(2, _omitFieldNames ? '' : 'name',
        subBuilder: StaffName.create)
    ..aOM<StaffImage>(3, _omitFieldNames ? '' : 'image',
        subBuilder: StaffImage.create)
    ..aOS(4, _omitFieldNames ? '' : 'languageV2')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StaffMin clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StaffMin copyWith(void Function(StaffMin) updates) =>
      super.copyWith((message) => updates(message as StaffMin)) as StaffMin;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StaffMin create() => StaffMin._();
  @$core.override
  StaffMin createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StaffMin getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StaffMin>(create);
  static StaffMin? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  StaffName get name => $_getN(1);
  @$pb.TagNumber(2)
  set name(StaffName value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);
  @$pb.TagNumber(2)
  StaffName ensureName() => $_ensure(1);

  @$pb.TagNumber(3)
  StaffImage get image => $_getN(2);
  @$pb.TagNumber(3)
  set image(StaffImage value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasImage() => $_has(2);
  @$pb.TagNumber(3)
  void clearImage() => $_clearField(3);
  @$pb.TagNumber(3)
  StaffImage ensureImage() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.String get languageV2 => $_getSZ(3);
  @$pb.TagNumber(4)
  set languageV2($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLanguageV2() => $_has(3);
  @$pb.TagNumber(4)
  void clearLanguageV2() => $_clearField(4);
}

class StaffEdge extends $pb.GeneratedMessage {
  factory StaffEdge({
    $core.String? role,
    StaffMin? node,
  }) {
    final result = create();
    if (role != null) result.role = role;
    if (node != null) result.node = node;
    return result;
  }

  StaffEdge._();

  factory StaffEdge.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StaffEdge.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StaffEdge',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'role')
    ..aOM<StaffMin>(2, _omitFieldNames ? '' : 'node',
        subBuilder: StaffMin.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StaffEdge clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StaffEdge copyWith(void Function(StaffEdge) updates) =>
      super.copyWith((message) => updates(message as StaffEdge)) as StaffEdge;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StaffEdge create() => StaffEdge._();
  @$core.override
  StaffEdge createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StaffEdge getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StaffEdge>(create);
  static StaffEdge? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get role => $_getSZ(0);
  @$pb.TagNumber(1)
  set role($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRole() => $_has(0);
  @$pb.TagNumber(1)
  void clearRole() => $_clearField(1);

  @$pb.TagNumber(2)
  StaffMin get node => $_getN(1);
  @$pb.TagNumber(2)
  set node(StaffMin value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasNode() => $_has(1);
  @$pb.TagNumber(2)
  void clearNode() => $_clearField(2);
  @$pb.TagNumber(2)
  StaffMin ensureNode() => $_ensure(1);
}

class StaffConnection extends $pb.GeneratedMessage {
  factory StaffConnection({
    $core.Iterable<StaffEdge>? edges,
    $0.PageInfo? pageInfo,
  }) {
    final result = create();
    if (edges != null) result.edges.addAll(edges);
    if (pageInfo != null) result.pageInfo = pageInfo;
    return result;
  }

  StaffConnection._();

  factory StaffConnection.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StaffConnection.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StaffConnection',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..pPM<StaffEdge>(1, _omitFieldNames ? '' : 'edges',
        subBuilder: StaffEdge.create)
    ..aOM<$0.PageInfo>(2, _omitFieldNames ? '' : 'pageInfo',
        subBuilder: $0.PageInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StaffConnection clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StaffConnection copyWith(void Function(StaffConnection) updates) =>
      super.copyWith((message) => updates(message as StaffConnection))
          as StaffConnection;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StaffConnection create() => StaffConnection._();
  @$core.override
  StaffConnection createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StaffConnection getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StaffConnection>(create);
  static StaffConnection? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<StaffEdge> get edges => $_getList(0);

  @$pb.TagNumber(2)
  $0.PageInfo get pageInfo => $_getN(1);
  @$pb.TagNumber(2)
  set pageInfo($0.PageInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPageInfo() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageInfo() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.PageInfo ensurePageInfo() => $_ensure(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
