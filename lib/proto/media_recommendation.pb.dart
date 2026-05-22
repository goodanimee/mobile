// This is a generated file - do not edit.
//
// Generated from media_recommendation.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pb.dart' as $1;
import 'media_min.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class Recommendation extends $pb.GeneratedMessage {
  factory Recommendation({
    $core.int? rating,
    $0.MediaMin? mediaRecommendation,
  }) {
    final result = create();
    if (rating != null) result.rating = rating;
    if (mediaRecommendation != null)
      result.mediaRecommendation = mediaRecommendation;
    return result;
  }

  Recommendation._();

  factory Recommendation.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Recommendation.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Recommendation',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'rating')
    ..aOM<$0.MediaMin>(2, _omitFieldNames ? '' : 'mediaRecommendation',
        subBuilder: $0.MediaMin.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Recommendation clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Recommendation copyWith(void Function(Recommendation) updates) =>
      super.copyWith((message) => updates(message as Recommendation))
          as Recommendation;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Recommendation create() => Recommendation._();
  @$core.override
  Recommendation createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Recommendation getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Recommendation>(create);
  static Recommendation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get rating => $_getIZ(0);
  @$pb.TagNumber(1)
  set rating($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRating() => $_has(0);
  @$pb.TagNumber(1)
  void clearRating() => $_clearField(1);

  @$pb.TagNumber(2)
  $0.MediaMin get mediaRecommendation => $_getN(1);
  @$pb.TagNumber(2)
  set mediaRecommendation($0.MediaMin value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasMediaRecommendation() => $_has(1);
  @$pb.TagNumber(2)
  void clearMediaRecommendation() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.MediaMin ensureMediaRecommendation() => $_ensure(1);
}

class RecommendationEdge extends $pb.GeneratedMessage {
  factory RecommendationEdge({
    Recommendation? node,
  }) {
    final result = create();
    if (node != null) result.node = node;
    return result;
  }

  RecommendationEdge._();

  factory RecommendationEdge.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RecommendationEdge.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RecommendationEdge',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aOM<Recommendation>(1, _omitFieldNames ? '' : 'node',
        subBuilder: Recommendation.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecommendationEdge clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecommendationEdge copyWith(void Function(RecommendationEdge) updates) =>
      super.copyWith((message) => updates(message as RecommendationEdge))
          as RecommendationEdge;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RecommendationEdge create() => RecommendationEdge._();
  @$core.override
  RecommendationEdge createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RecommendationEdge getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RecommendationEdge>(create);
  static RecommendationEdge? _defaultInstance;

  @$pb.TagNumber(1)
  Recommendation get node => $_getN(0);
  @$pb.TagNumber(1)
  set node(Recommendation value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasNode() => $_has(0);
  @$pb.TagNumber(1)
  void clearNode() => $_clearField(1);
  @$pb.TagNumber(1)
  Recommendation ensureNode() => $_ensure(0);
}

class RecommendationConnection extends $pb.GeneratedMessage {
  factory RecommendationConnection({
    $1.PageInfo? pageInfo,
    $core.Iterable<RecommendationEdge>? edges,
  }) {
    final result = create();
    if (pageInfo != null) result.pageInfo = pageInfo;
    if (edges != null) result.edges.addAll(edges);
    return result;
  }

  RecommendationConnection._();

  factory RecommendationConnection.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RecommendationConnection.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RecommendationConnection',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aOM<$1.PageInfo>(1, _omitFieldNames ? '' : 'pageInfo',
        subBuilder: $1.PageInfo.create)
    ..pPM<RecommendationEdge>(2, _omitFieldNames ? '' : 'edges',
        subBuilder: RecommendationEdge.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecommendationConnection clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecommendationConnection copyWith(
          void Function(RecommendationConnection) updates) =>
      super.copyWith((message) => updates(message as RecommendationConnection))
          as RecommendationConnection;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RecommendationConnection create() => RecommendationConnection._();
  @$core.override
  RecommendationConnection createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RecommendationConnection getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RecommendationConnection>(create);
  static RecommendationConnection? _defaultInstance;

  @$pb.TagNumber(1)
  $1.PageInfo get pageInfo => $_getN(0);
  @$pb.TagNumber(1)
  set pageInfo($1.PageInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPageInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearPageInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.PageInfo ensurePageInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<RecommendationEdge> get edges => $_getList(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
