// This is a generated file - do not edit.
//
// Generated from media_activity.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'viewer.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class ListActivity extends $pb.GeneratedMessage {
  factory ListActivity({
    $core.int? id,
    $core.int? createdAt,
    $core.bool? isLiked,
    $core.int? likeCount,
    $core.String? progress,
    $core.String? status,
    $0.Viewer? user,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (createdAt != null) result.createdAt = createdAt;
    if (isLiked != null) result.isLiked = isLiked;
    if (likeCount != null) result.likeCount = likeCount;
    if (progress != null) result.progress = progress;
    if (status != null) result.status = status;
    if (user != null) result.user = user;
    return result;
  }

  ListActivity._();

  factory ListActivity.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListActivity.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListActivity',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..aI(2, _omitFieldNames ? '' : 'createdAt')
    ..aOB(3, _omitFieldNames ? '' : 'isLiked')
    ..aI(4, _omitFieldNames ? '' : 'likeCount')
    ..aOS(5, _omitFieldNames ? '' : 'progress')
    ..aOS(6, _omitFieldNames ? '' : 'status')
    ..aOM<$0.Viewer>(7, _omitFieldNames ? '' : 'user',
        subBuilder: $0.Viewer.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListActivity clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListActivity copyWith(void Function(ListActivity) updates) =>
      super.copyWith((message) => updates(message as ListActivity))
          as ListActivity;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListActivity create() => ListActivity._();
  @$core.override
  ListActivity createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListActivity getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListActivity>(create);
  static ListActivity? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get createdAt => $_getIZ(1);
  @$pb.TagNumber(2)
  set createdAt($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCreatedAt() => $_has(1);
  @$pb.TagNumber(2)
  void clearCreatedAt() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get isLiked => $_getBF(2);
  @$pb.TagNumber(3)
  set isLiked($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIsLiked() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsLiked() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get likeCount => $_getIZ(3);
  @$pb.TagNumber(4)
  set likeCount($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLikeCount() => $_has(3);
  @$pb.TagNumber(4)
  void clearLikeCount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get progress => $_getSZ(4);
  @$pb.TagNumber(5)
  set progress($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasProgress() => $_has(4);
  @$pb.TagNumber(5)
  void clearProgress() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get status => $_getSZ(5);
  @$pb.TagNumber(6)
  set status($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => $_clearField(6);

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
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
