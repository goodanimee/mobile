// This is a generated file - do not edit.
//
// Generated from media_review.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pb.dart' as $1;
import 'media_review.pbenum.dart';
import 'viewer.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'media_review.pbenum.dart';

class ReviewNode extends $pb.GeneratedMessage {
  factory ReviewNode({
    $core.int? id,
    $core.int? score,
    $core.int? rating,
    $core.int? ratingAmount,
    $core.String? summary,
    ReviewUserRating? userRating,
    $0.Viewer? user,
    $core.String? body,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (score != null) result.score = score;
    if (rating != null) result.rating = rating;
    if (ratingAmount != null) result.ratingAmount = ratingAmount;
    if (summary != null) result.summary = summary;
    if (userRating != null) result.userRating = userRating;
    if (user != null) result.user = user;
    if (body != null) result.body = body;
    return result;
  }

  ReviewNode._();

  factory ReviewNode.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReviewNode.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReviewNode',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..aI(2, _omitFieldNames ? '' : 'score')
    ..aI(3, _omitFieldNames ? '' : 'rating')
    ..aI(4, _omitFieldNames ? '' : 'ratingAmount')
    ..aOS(5, _omitFieldNames ? '' : 'summary')
    ..aE<ReviewUserRating>(6, _omitFieldNames ? '' : 'userRating',
        enumValues: ReviewUserRating.values)
    ..aOM<$0.Viewer>(7, _omitFieldNames ? '' : 'user',
        subBuilder: $0.Viewer.create)
    ..aOS(8, _omitFieldNames ? '' : 'body')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReviewNode clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReviewNode copyWith(void Function(ReviewNode) updates) =>
      super.copyWith((message) => updates(message as ReviewNode)) as ReviewNode;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReviewNode create() => ReviewNode._();
  @$core.override
  ReviewNode createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ReviewNode getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReviewNode>(create);
  static ReviewNode? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get score => $_getIZ(1);
  @$pb.TagNumber(2)
  set score($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasScore() => $_has(1);
  @$pb.TagNumber(2)
  void clearScore() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get rating => $_getIZ(2);
  @$pb.TagNumber(3)
  set rating($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRating() => $_has(2);
  @$pb.TagNumber(3)
  void clearRating() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get ratingAmount => $_getIZ(3);
  @$pb.TagNumber(4)
  set ratingAmount($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRatingAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearRatingAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get summary => $_getSZ(4);
  @$pb.TagNumber(5)
  set summary($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSummary() => $_has(4);
  @$pb.TagNumber(5)
  void clearSummary() => $_clearField(5);

  @$pb.TagNumber(6)
  ReviewUserRating get userRating => $_getN(5);
  @$pb.TagNumber(6)
  set userRating(ReviewUserRating value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasUserRating() => $_has(5);
  @$pb.TagNumber(6)
  void clearUserRating() => $_clearField(6);

  @$pb.TagNumber(7)
  $0.Viewer get user => $_getN(6);
  @$pb.TagNumber(7)
  set user($0.Viewer value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasUser() => $_has(6);
  @$pb.TagNumber(7)
  void clearUser() => $_clearField(7);
  @$pb.TagNumber(7)
  $0.Viewer ensureUser() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.String get body => $_getSZ(7);
  @$pb.TagNumber(8)
  set body($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasBody() => $_has(7);
  @$pb.TagNumber(8)
  void clearBody() => $_clearField(8);
}

class ReviewConnection extends $pb.GeneratedMessage {
  factory ReviewConnection({
    $1.PageInfo? pageInfo,
    $core.Iterable<ReviewNode>? nodes,
  }) {
    final result = create();
    if (pageInfo != null) result.pageInfo = pageInfo;
    if (nodes != null) result.nodes.addAll(nodes);
    return result;
  }

  ReviewConnection._();

  factory ReviewConnection.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReviewConnection.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReviewConnection',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aOM<$1.PageInfo>(1, _omitFieldNames ? '' : 'pageInfo',
        subBuilder: $1.PageInfo.create)
    ..pPM<ReviewNode>(2, _omitFieldNames ? '' : 'nodes',
        subBuilder: ReviewNode.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReviewConnection clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReviewConnection copyWith(void Function(ReviewConnection) updates) =>
      super.copyWith((message) => updates(message as ReviewConnection))
          as ReviewConnection;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReviewConnection create() => ReviewConnection._();
  @$core.override
  ReviewConnection createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ReviewConnection getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReviewConnection>(create);
  static ReviewConnection? _defaultInstance;

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
  $pb.PbList<ReviewNode> get nodes => $_getList(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
