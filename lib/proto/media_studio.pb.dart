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

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class Studio extends $pb.GeneratedMessage {
  factory Studio({
    $core.int? id,
    $core.String? name,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
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
}

class StudioEdge extends $pb.GeneratedMessage {
  factory StudioEdge({
    $core.bool? isMain,
    Studio? node,
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
    ..aOM<Studio>(2, _omitFieldNames ? '' : 'node', subBuilder: Studio.create)
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
  Studio get node => $_getN(1);
  @$pb.TagNumber(2)
  set node(Studio value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasNode() => $_has(1);
  @$pb.TagNumber(2)
  void clearNode() => $_clearField(2);
  @$pb.TagNumber(2)
  Studio ensureNode() => $_ensure(1);
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

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
