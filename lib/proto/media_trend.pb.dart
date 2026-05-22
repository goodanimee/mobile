// This is a generated file - do not edit.
//
// Generated from media_trend.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class MediaTrend extends $pb.GeneratedMessage {
  factory MediaTrend({
    $core.int? averageScore,
    $core.int? date,
    $core.int? inProgress,
    $core.int? popularity,
  }) {
    final result = create();
    if (averageScore != null) result.averageScore = averageScore;
    if (date != null) result.date = date;
    if (inProgress != null) result.inProgress = inProgress;
    if (popularity != null) result.popularity = popularity;
    return result;
  }

  MediaTrend._();

  factory MediaTrend.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MediaTrend.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MediaTrend',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'averageScore')
    ..aI(2, _omitFieldNames ? '' : 'date')
    ..aI(3, _omitFieldNames ? '' : 'inProgress')
    ..aI(4, _omitFieldNames ? '' : 'popularity')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaTrend clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaTrend copyWith(void Function(MediaTrend) updates) =>
      super.copyWith((message) => updates(message as MediaTrend)) as MediaTrend;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MediaTrend create() => MediaTrend._();
  @$core.override
  MediaTrend createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MediaTrend getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MediaTrend>(create);
  static MediaTrend? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get averageScore => $_getIZ(0);
  @$pb.TagNumber(1)
  set averageScore($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAverageScore() => $_has(0);
  @$pb.TagNumber(1)
  void clearAverageScore() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get date => $_getIZ(1);
  @$pb.TagNumber(2)
  set date($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearDate() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get inProgress => $_getIZ(2);
  @$pb.TagNumber(3)
  set inProgress($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasInProgress() => $_has(2);
  @$pb.TagNumber(3)
  void clearInProgress() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get popularity => $_getIZ(3);
  @$pb.TagNumber(4)
  set popularity($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPopularity() => $_has(3);
  @$pb.TagNumber(4)
  void clearPopularity() => $_clearField(4);
}

class MediaTrendConnection extends $pb.GeneratedMessage {
  factory MediaTrendConnection({
    $core.Iterable<MediaTrend>? nodes,
  }) {
    final result = create();
    if (nodes != null) result.nodes.addAll(nodes);
    return result;
  }

  MediaTrendConnection._();

  factory MediaTrendConnection.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MediaTrendConnection.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MediaTrendConnection',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..pPM<MediaTrend>(1, _omitFieldNames ? '' : 'nodes',
        subBuilder: MediaTrend.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaTrendConnection clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaTrendConnection copyWith(void Function(MediaTrendConnection) updates) =>
      super.copyWith((message) => updates(message as MediaTrendConnection))
          as MediaTrendConnection;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MediaTrendConnection create() => MediaTrendConnection._();
  @$core.override
  MediaTrendConnection createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MediaTrendConnection getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MediaTrendConnection>(create);
  static MediaTrendConnection? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<MediaTrend> get nodes => $_getList(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
