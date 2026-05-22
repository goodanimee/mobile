// This is a generated file - do not edit.
//
// Generated from viewer.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class ViewerAvatar extends $pb.GeneratedMessage {
  factory ViewerAvatar({
    $core.String? medium,
  }) {
    final result = create();
    if (medium != null) result.medium = medium;
    return result;
  }

  ViewerAvatar._();

  factory ViewerAvatar.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ViewerAvatar.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ViewerAvatar',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'medium')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ViewerAvatar clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ViewerAvatar copyWith(void Function(ViewerAvatar) updates) =>
      super.copyWith((message) => updates(message as ViewerAvatar))
          as ViewerAvatar;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ViewerAvatar create() => ViewerAvatar._();
  @$core.override
  ViewerAvatar createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ViewerAvatar getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ViewerAvatar>(create);
  static ViewerAvatar? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get medium => $_getSZ(0);
  @$pb.TagNumber(1)
  set medium($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMedium() => $_has(0);
  @$pb.TagNumber(1)
  void clearMedium() => $_clearField(1);
}

class Viewer extends $pb.GeneratedMessage {
  factory Viewer({
    $core.int? id,
    $core.String? name,
    $core.int? createdAt,
    ViewerAvatar? avatar,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (createdAt != null) result.createdAt = createdAt;
    if (avatar != null) result.avatar = avatar;
    return result;
  }

  Viewer._();

  factory Viewer.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Viewer.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Viewer',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aI(3, _omitFieldNames ? '' : 'createdAt')
    ..aOM<ViewerAvatar>(4, _omitFieldNames ? '' : 'avatar',
        subBuilder: ViewerAvatar.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Viewer clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Viewer copyWith(void Function(Viewer) updates) =>
      super.copyWith((message) => updates(message as Viewer)) as Viewer;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Viewer create() => Viewer._();
  @$core.override
  Viewer createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Viewer getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Viewer>(create);
  static Viewer? _defaultInstance;

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
  $core.int get createdAt => $_getIZ(2);
  @$pb.TagNumber(3)
  set createdAt($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCreatedAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearCreatedAt() => $_clearField(3);

  @$pb.TagNumber(4)
  ViewerAvatar get avatar => $_getN(3);
  @$pb.TagNumber(4)
  set avatar(ViewerAvatar value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasAvatar() => $_has(3);
  @$pb.TagNumber(4)
  void clearAvatar() => $_clearField(4);
  @$pb.TagNumber(4)
  ViewerAvatar ensureAvatar() => $_ensure(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
