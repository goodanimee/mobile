// This is a generated file - do not edit.
//
// Generated from media_studio.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pb.dart' as $0;
import 'media_min.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class StudioMin extends $pb.GeneratedMessage {
  factory StudioMin({
    $core.int? id,
    $core.String? name,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    return result;
  }

  StudioMin._();

  factory StudioMin.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StudioMin.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StudioMin',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StudioMin clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StudioMin copyWith(void Function(StudioMin) updates) =>
      super.copyWith((message) => updates(message as StudioMin)) as StudioMin;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StudioMin create() => StudioMin._();
  @$core.override
  StudioMin createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StudioMin getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StudioMin>(create);
  static StudioMin? _defaultInstance;

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
}

class StudioEdge extends $pb.GeneratedMessage {
  factory StudioEdge({
    $core.bool? isMain,
    StudioMin? node,
  }) {
    final result = create();
    if (isMain != null) result.isMain = isMain;
    if (node != null) result.node = node;
    return result;
  }

  StudioEdge._();

  factory StudioEdge.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StudioEdge.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StudioEdge',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'isMain')
    ..aOM<StudioMin>(2, _omitFieldNames ? '' : 'node',
        subBuilder: StudioMin.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StudioEdge clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StudioEdge copyWith(void Function(StudioEdge) updates) =>
      super.copyWith((message) => updates(message as StudioEdge)) as StudioEdge;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StudioEdge create() => StudioEdge._();
  @$core.override
  StudioEdge createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StudioEdge getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StudioEdge>(create);
  static StudioEdge? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get isMain => $_getBF(0);
  @$pb.TagNumber(1)
  set isMain($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIsMain() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsMain() => $_clearField(1);

  @$pb.TagNumber(2)
  StudioMin get node => $_getN(1);
  @$pb.TagNumber(2)
  set node(StudioMin value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasNode() => $_has(1);
  @$pb.TagNumber(2)
  void clearNode() => $_clearField(2);
  @$pb.TagNumber(2)
  StudioMin ensureNode() => $_ensure(1);
}

class StudioConnection extends $pb.GeneratedMessage {
  factory StudioConnection({
    $core.Iterable<StudioEdge>? edges,
  }) {
    final result = create();
    if (edges != null) result.edges.addAll(edges);
    return result;
  }

  StudioConnection._();

  factory StudioConnection.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StudioConnection.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StudioConnection',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..pPM<StudioEdge>(1, _omitFieldNames ? '' : 'edges',
        subBuilder: StudioEdge.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StudioConnection clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StudioConnection copyWith(void Function(StudioConnection) updates) =>
      super.copyWith((message) => updates(message as StudioConnection))
          as StudioConnection;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StudioConnection create() => StudioConnection._();
  @$core.override
  StudioConnection createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StudioConnection getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StudioConnection>(create);
  static StudioConnection? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<StudioEdge> get edges => $_getList(0);
}

class Studio extends $pb.GeneratedMessage {
  factory Studio({
    $core.int? id,
    $core.String? name,
    $core.int? favourites,
    $core.bool? isFavourite,
    StudioMediaConnection? media,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (favourites != null) result.favourites = favourites;
    if (isFavourite != null) result.isFavourite = isFavourite;
    if (media != null) result.media = media;
    return result;
  }

  Studio._();

  factory Studio.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Studio.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Studio',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aI(3, _omitFieldNames ? '' : 'favourites')
    ..aOB(4, _omitFieldNames ? '' : 'isFavourite')
    ..aOM<StudioMediaConnection>(5, _omitFieldNames ? '' : 'media',
        subBuilder: StudioMediaConnection.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Studio clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Studio copyWith(void Function(Studio) updates) =>
      super.copyWith((message) => updates(message as Studio)) as Studio;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Studio create() => Studio._();
  @$core.override
  Studio createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Studio getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Studio>(create);
  static Studio? _defaultInstance;

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
  $core.int get favourites => $_getIZ(2);
  @$pb.TagNumber(3)
  set favourites($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFavourites() => $_has(2);
  @$pb.TagNumber(3)
  void clearFavourites() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get isFavourite => $_getBF(3);
  @$pb.TagNumber(4)
  set isFavourite($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasIsFavourite() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsFavourite() => $_clearField(4);

  @$pb.TagNumber(5)
  StudioMediaConnection get media => $_getN(4);
  @$pb.TagNumber(5)
  set media(StudioMediaConnection value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasMedia() => $_has(4);
  @$pb.TagNumber(5)
  void clearMedia() => $_clearField(5);
  @$pb.TagNumber(5)
  StudioMediaConnection ensureMedia() => $_ensure(4);
}

class StudioMediaConnection extends $pb.GeneratedMessage {
  factory StudioMediaConnection({
    $0.PageInfo? pageInfo,
    $core.Iterable<$1.MediaMin>? nodes,
  }) {
    final result = create();
    if (pageInfo != null) result.pageInfo = pageInfo;
    if (nodes != null) result.nodes.addAll(nodes);
    return result;
  }

  StudioMediaConnection._();

  factory StudioMediaConnection.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StudioMediaConnection.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StudioMediaConnection',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aOM<$0.PageInfo>(1, _omitFieldNames ? '' : 'pageInfo',
        subBuilder: $0.PageInfo.create)
    ..pPM<$1.MediaMin>(2, _omitFieldNames ? '' : 'nodes',
        subBuilder: $1.MediaMin.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StudioMediaConnection clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StudioMediaConnection copyWith(
          void Function(StudioMediaConnection) updates) =>
      super.copyWith((message) => updates(message as StudioMediaConnection))
          as StudioMediaConnection;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StudioMediaConnection create() => StudioMediaConnection._();
  @$core.override
  StudioMediaConnection createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StudioMediaConnection getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StudioMediaConnection>(create);
  static StudioMediaConnection? _defaultInstance;

  @$pb.TagNumber(1)
  $0.PageInfo get pageInfo => $_getN(0);
  @$pb.TagNumber(1)
  set pageInfo($0.PageInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPageInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearPageInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.PageInfo ensurePageInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<$1.MediaMin> get nodes => $_getList(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
