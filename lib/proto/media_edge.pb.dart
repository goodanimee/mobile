// This is a generated file - do not edit.
//
// Generated from media_edge.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'media_min.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class MediaEdge extends $pb.GeneratedMessage {
  factory MediaEdge({
    $core.String? relationType,
    $0.MediaMin? node,
  }) {
    final result = create();
    if (relationType != null) result.relationType = relationType;
    if (node != null) result.node = node;
    return result;
  }

  MediaEdge._();

  factory MediaEdge.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MediaEdge.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MediaEdge',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'relationType')
    ..aOM<$0.MediaMin>(2, _omitFieldNames ? '' : 'node',
        subBuilder: $0.MediaMin.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaEdge clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaEdge copyWith(void Function(MediaEdge) updates) =>
      super.copyWith((message) => updates(message as MediaEdge)) as MediaEdge;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MediaEdge create() => MediaEdge._();
  @$core.override
  MediaEdge createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MediaEdge getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MediaEdge>(create);
  static MediaEdge? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get relationType => $_getSZ(0);
  @$pb.TagNumber(1)
  set relationType($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRelationType() => $_has(0);
  @$pb.TagNumber(1)
  void clearRelationType() => $_clearField(1);

  @$pb.TagNumber(2)
  $0.MediaMin get node => $_getN(1);
  @$pb.TagNumber(2)
  set node($0.MediaMin value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasNode() => $_has(1);
  @$pb.TagNumber(2)
  void clearNode() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.MediaMin ensureNode() => $_ensure(1);
}

class MediaConnection extends $pb.GeneratedMessage {
  factory MediaConnection({
    $core.Iterable<MediaEdge>? edges,
  }) {
    final result = create();
    if (edges != null) result.edges.addAll(edges);
    return result;
  }

  MediaConnection._();

  factory MediaConnection.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MediaConnection.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MediaConnection',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..pPM<MediaEdge>(1, _omitFieldNames ? '' : 'edges',
        subBuilder: MediaEdge.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaConnection clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaConnection copyWith(void Function(MediaConnection) updates) =>
      super.copyWith((message) => updates(message as MediaConnection))
          as MediaConnection;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MediaConnection create() => MediaConnection._();
  @$core.override
  MediaConnection createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MediaConnection getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MediaConnection>(create);
  static MediaConnection? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<MediaEdge> get edges => $_getList(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
