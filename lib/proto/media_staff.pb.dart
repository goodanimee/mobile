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
import 'media_min.pb.dart' as $1;

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

class StaffCharacterName extends $pb.GeneratedMessage {
  factory StaffCharacterName({
    $core.String? userPreferred,
  }) {
    final result = create();
    if (userPreferred != null) result.userPreferred = userPreferred;
    return result;
  }

  StaffCharacterName._();

  factory StaffCharacterName.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StaffCharacterName.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StaffCharacterName',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userPreferred')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StaffCharacterName clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StaffCharacterName copyWith(void Function(StaffCharacterName) updates) =>
      super.copyWith((message) => updates(message as StaffCharacterName))
          as StaffCharacterName;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StaffCharacterName create() => StaffCharacterName._();
  @$core.override
  StaffCharacterName createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StaffCharacterName getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StaffCharacterName>(create);
  static StaffCharacterName? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userPreferred => $_getSZ(0);
  @$pb.TagNumber(1)
  set userPreferred($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserPreferred() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserPreferred() => $_clearField(1);
}

class StaffCharacterImage extends $pb.GeneratedMessage {
  factory StaffCharacterImage({
    $core.String? large,
    $core.String? medium,
  }) {
    final result = create();
    if (large != null) result.large = large;
    if (medium != null) result.medium = medium;
    return result;
  }

  StaffCharacterImage._();

  factory StaffCharacterImage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StaffCharacterImage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StaffCharacterImage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'large')
    ..aOS(2, _omitFieldNames ? '' : 'medium')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StaffCharacterImage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StaffCharacterImage copyWith(void Function(StaffCharacterImage) updates) =>
      super.copyWith((message) => updates(message as StaffCharacterImage))
          as StaffCharacterImage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StaffCharacterImage create() => StaffCharacterImage._();
  @$core.override
  StaffCharacterImage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StaffCharacterImage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StaffCharacterImage>(create);
  static StaffCharacterImage? _defaultInstance;

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

class StaffCharacter extends $pb.GeneratedMessage {
  factory StaffCharacter({
    $core.int? id,
    StaffCharacterName? name,
    StaffCharacterImage? image,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (image != null) result.image = image;
    return result;
  }

  StaffCharacter._();

  factory StaffCharacter.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StaffCharacter.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StaffCharacter',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..aOM<StaffCharacterName>(2, _omitFieldNames ? '' : 'name',
        subBuilder: StaffCharacterName.create)
    ..aOM<StaffCharacterImage>(3, _omitFieldNames ? '' : 'image',
        subBuilder: StaffCharacterImage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StaffCharacter clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StaffCharacter copyWith(void Function(StaffCharacter) updates) =>
      super.copyWith((message) => updates(message as StaffCharacter))
          as StaffCharacter;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StaffCharacter create() => StaffCharacter._();
  @$core.override
  StaffCharacter createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StaffCharacter getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StaffCharacter>(create);
  static StaffCharacter? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  StaffCharacterName get name => $_getN(1);
  @$pb.TagNumber(2)
  set name(StaffCharacterName value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);
  @$pb.TagNumber(2)
  StaffCharacterName ensureName() => $_ensure(1);

  @$pb.TagNumber(3)
  StaffCharacterImage get image => $_getN(2);
  @$pb.TagNumber(3)
  set image(StaffCharacterImage value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasImage() => $_has(2);
  @$pb.TagNumber(3)
  void clearImage() => $_clearField(3);
  @$pb.TagNumber(3)
  StaffCharacterImage ensureImage() => $_ensure(2);
}

class StaffCharacterMediaEdge extends $pb.GeneratedMessage {
  factory StaffCharacterMediaEdge({
    $core.String? characterRole,
    $1.MediaMin? node,
    $core.Iterable<StaffCharacter>? characters,
  }) {
    final result = create();
    if (characterRole != null) result.characterRole = characterRole;
    if (node != null) result.node = node;
    if (characters != null) result.characters.addAll(characters);
    return result;
  }

  StaffCharacterMediaEdge._();

  factory StaffCharacterMediaEdge.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StaffCharacterMediaEdge.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StaffCharacterMediaEdge',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'characterRole')
    ..aOM<$1.MediaMin>(2, _omitFieldNames ? '' : 'node',
        subBuilder: $1.MediaMin.create)
    ..pPM<StaffCharacter>(3, _omitFieldNames ? '' : 'characters',
        subBuilder: StaffCharacter.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StaffCharacterMediaEdge clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StaffCharacterMediaEdge copyWith(
          void Function(StaffCharacterMediaEdge) updates) =>
      super.copyWith((message) => updates(message as StaffCharacterMediaEdge))
          as StaffCharacterMediaEdge;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StaffCharacterMediaEdge create() => StaffCharacterMediaEdge._();
  @$core.override
  StaffCharacterMediaEdge createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StaffCharacterMediaEdge getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StaffCharacterMediaEdge>(create);
  static StaffCharacterMediaEdge? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get characterRole => $_getSZ(0);
  @$pb.TagNumber(1)
  set characterRole($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCharacterRole() => $_has(0);
  @$pb.TagNumber(1)
  void clearCharacterRole() => $_clearField(1);

  @$pb.TagNumber(2)
  $1.MediaMin get node => $_getN(1);
  @$pb.TagNumber(2)
  set node($1.MediaMin value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasNode() => $_has(1);
  @$pb.TagNumber(2)
  void clearNode() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.MediaMin ensureNode() => $_ensure(1);

  @$pb.TagNumber(3)
  $pb.PbList<StaffCharacter> get characters => $_getList(2);
}

class StaffCharacterMediaConnection extends $pb.GeneratedMessage {
  factory StaffCharacterMediaConnection({
    $core.Iterable<StaffCharacterMediaEdge>? edges,
    $0.PageInfo? pageInfo,
  }) {
    final result = create();
    if (edges != null) result.edges.addAll(edges);
    if (pageInfo != null) result.pageInfo = pageInfo;
    return result;
  }

  StaffCharacterMediaConnection._();

  factory StaffCharacterMediaConnection.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StaffCharacterMediaConnection.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StaffCharacterMediaConnection',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..pPM<StaffCharacterMediaEdge>(1, _omitFieldNames ? '' : 'edges',
        subBuilder: StaffCharacterMediaEdge.create)
    ..aOM<$0.PageInfo>(2, _omitFieldNames ? '' : 'pageInfo',
        subBuilder: $0.PageInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StaffCharacterMediaConnection clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StaffCharacterMediaConnection copyWith(
          void Function(StaffCharacterMediaConnection) updates) =>
      super.copyWith(
              (message) => updates(message as StaffCharacterMediaConnection))
          as StaffCharacterMediaConnection;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StaffCharacterMediaConnection create() =>
      StaffCharacterMediaConnection._();
  @$core.override
  StaffCharacterMediaConnection createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StaffCharacterMediaConnection getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StaffCharacterMediaConnection>(create);
  static StaffCharacterMediaConnection? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<StaffCharacterMediaEdge> get edges => $_getList(0);

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

class StaffMediaEdge extends $pb.GeneratedMessage {
  factory StaffMediaEdge({
    $core.String? staffRole,
    $1.MediaMin? node,
  }) {
    final result = create();
    if (staffRole != null) result.staffRole = staffRole;
    if (node != null) result.node = node;
    return result;
  }

  StaffMediaEdge._();

  factory StaffMediaEdge.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StaffMediaEdge.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StaffMediaEdge',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'staffRole')
    ..aOM<$1.MediaMin>(2, _omitFieldNames ? '' : 'node',
        subBuilder: $1.MediaMin.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StaffMediaEdge clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StaffMediaEdge copyWith(void Function(StaffMediaEdge) updates) =>
      super.copyWith((message) => updates(message as StaffMediaEdge))
          as StaffMediaEdge;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StaffMediaEdge create() => StaffMediaEdge._();
  @$core.override
  StaffMediaEdge createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StaffMediaEdge getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StaffMediaEdge>(create);
  static StaffMediaEdge? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get staffRole => $_getSZ(0);
  @$pb.TagNumber(1)
  set staffRole($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStaffRole() => $_has(0);
  @$pb.TagNumber(1)
  void clearStaffRole() => $_clearField(1);

  @$pb.TagNumber(2)
  $1.MediaMin get node => $_getN(1);
  @$pb.TagNumber(2)
  set node($1.MediaMin value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasNode() => $_has(1);
  @$pb.TagNumber(2)
  void clearNode() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.MediaMin ensureNode() => $_ensure(1);
}

class StaffMediaConnection extends $pb.GeneratedMessage {
  factory StaffMediaConnection({
    $core.Iterable<StaffMediaEdge>? edges,
    $0.PageInfo? pageInfo,
  }) {
    final result = create();
    if (edges != null) result.edges.addAll(edges);
    if (pageInfo != null) result.pageInfo = pageInfo;
    return result;
  }

  StaffMediaConnection._();

  factory StaffMediaConnection.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StaffMediaConnection.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StaffMediaConnection',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..pPM<StaffMediaEdge>(1, _omitFieldNames ? '' : 'edges',
        subBuilder: StaffMediaEdge.create)
    ..aOM<$0.PageInfo>(2, _omitFieldNames ? '' : 'pageInfo',
        subBuilder: $0.PageInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StaffMediaConnection clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StaffMediaConnection copyWith(void Function(StaffMediaConnection) updates) =>
      super.copyWith((message) => updates(message as StaffMediaConnection))
          as StaffMediaConnection;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StaffMediaConnection create() => StaffMediaConnection._();
  @$core.override
  StaffMediaConnection createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StaffMediaConnection getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StaffMediaConnection>(create);
  static StaffMediaConnection? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<StaffMediaEdge> get edges => $_getList(0);

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

class Staff extends $pb.GeneratedMessage {
  factory Staff({
    $core.int? id,
    StaffName? name,
    StaffImage? image,
    $core.String? description,
    $core.int? favourites,
    $core.bool? isFavourite,
    $core.int? age,
    $core.String? gender,
    $core.Iterable<$core.int>? yearsActive,
    $core.String? homeTown,
    $core.String? bloodType,
    $core.Iterable<$core.String>? primaryOccupations,
    $0.FuzzyDate? dateOfBirth,
    $0.FuzzyDate? dateOfDeath,
    $core.String? language,
    StaffCharacterMediaConnection? characterMedia,
    StaffMediaConnection? staffMedia,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (image != null) result.image = image;
    if (description != null) result.description = description;
    if (favourites != null) result.favourites = favourites;
    if (isFavourite != null) result.isFavourite = isFavourite;
    if (age != null) result.age = age;
    if (gender != null) result.gender = gender;
    if (yearsActive != null) result.yearsActive.addAll(yearsActive);
    if (homeTown != null) result.homeTown = homeTown;
    if (bloodType != null) result.bloodType = bloodType;
    if (primaryOccupations != null)
      result.primaryOccupations.addAll(primaryOccupations);
    if (dateOfBirth != null) result.dateOfBirth = dateOfBirth;
    if (dateOfDeath != null) result.dateOfDeath = dateOfDeath;
    if (language != null) result.language = language;
    if (characterMedia != null) result.characterMedia = characterMedia;
    if (staffMedia != null) result.staffMedia = staffMedia;
    return result;
  }

  Staff._();

  factory Staff.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Staff.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Staff',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..aOM<StaffName>(2, _omitFieldNames ? '' : 'name',
        subBuilder: StaffName.create)
    ..aOM<StaffImage>(3, _omitFieldNames ? '' : 'image',
        subBuilder: StaffImage.create)
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..aI(5, _omitFieldNames ? '' : 'favourites')
    ..aOB(6, _omitFieldNames ? '' : 'isFavourite')
    ..aI(7, _omitFieldNames ? '' : 'age')
    ..aOS(8, _omitFieldNames ? '' : 'gender')
    ..p<$core.int>(9, _omitFieldNames ? '' : 'yearsActive', $pb.PbFieldType.K3)
    ..aOS(10, _omitFieldNames ? '' : 'homeTown')
    ..aOS(11, _omitFieldNames ? '' : 'bloodType')
    ..pPS(12, _omitFieldNames ? '' : 'primaryOccupations')
    ..aOM<$0.FuzzyDate>(13, _omitFieldNames ? '' : 'dateOfBirth',
        subBuilder: $0.FuzzyDate.create)
    ..aOM<$0.FuzzyDate>(14, _omitFieldNames ? '' : 'dateOfDeath',
        subBuilder: $0.FuzzyDate.create)
    ..aOS(15, _omitFieldNames ? '' : 'language')
    ..aOM<StaffCharacterMediaConnection>(
        16, _omitFieldNames ? '' : 'characterMedia',
        subBuilder: StaffCharacterMediaConnection.create)
    ..aOM<StaffMediaConnection>(17, _omitFieldNames ? '' : 'staffMedia',
        subBuilder: StaffMediaConnection.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Staff clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Staff copyWith(void Function(Staff) updates) =>
      super.copyWith((message) => updates(message as Staff)) as Staff;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Staff create() => Staff._();
  @$core.override
  Staff createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Staff getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Staff>(create);
  static Staff? _defaultInstance;

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
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get favourites => $_getIZ(4);
  @$pb.TagNumber(5)
  set favourites($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFavourites() => $_has(4);
  @$pb.TagNumber(5)
  void clearFavourites() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get isFavourite => $_getBF(5);
  @$pb.TagNumber(6)
  set isFavourite($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasIsFavourite() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsFavourite() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get age => $_getIZ(6);
  @$pb.TagNumber(7)
  set age($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAge() => $_has(6);
  @$pb.TagNumber(7)
  void clearAge() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get gender => $_getSZ(7);
  @$pb.TagNumber(8)
  set gender($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasGender() => $_has(7);
  @$pb.TagNumber(8)
  void clearGender() => $_clearField(8);

  @$pb.TagNumber(9)
  $pb.PbList<$core.int> get yearsActive => $_getList(8);

  @$pb.TagNumber(10)
  $core.String get homeTown => $_getSZ(9);
  @$pb.TagNumber(10)
  set homeTown($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasHomeTown() => $_has(9);
  @$pb.TagNumber(10)
  void clearHomeTown() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get bloodType => $_getSZ(10);
  @$pb.TagNumber(11)
  set bloodType($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasBloodType() => $_has(10);
  @$pb.TagNumber(11)
  void clearBloodType() => $_clearField(11);

  @$pb.TagNumber(12)
  $pb.PbList<$core.String> get primaryOccupations => $_getList(11);

  @$pb.TagNumber(13)
  $0.FuzzyDate get dateOfBirth => $_getN(12);
  @$pb.TagNumber(13)
  set dateOfBirth($0.FuzzyDate value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasDateOfBirth() => $_has(12);
  @$pb.TagNumber(13)
  void clearDateOfBirth() => $_clearField(13);
  @$pb.TagNumber(13)
  $0.FuzzyDate ensureDateOfBirth() => $_ensure(12);

  @$pb.TagNumber(14)
  $0.FuzzyDate get dateOfDeath => $_getN(13);
  @$pb.TagNumber(14)
  set dateOfDeath($0.FuzzyDate value) => $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasDateOfDeath() => $_has(13);
  @$pb.TagNumber(14)
  void clearDateOfDeath() => $_clearField(14);
  @$pb.TagNumber(14)
  $0.FuzzyDate ensureDateOfDeath() => $_ensure(13);

  @$pb.TagNumber(15)
  $core.String get language => $_getSZ(14);
  @$pb.TagNumber(15)
  set language($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasLanguage() => $_has(14);
  @$pb.TagNumber(15)
  void clearLanguage() => $_clearField(15);

  @$pb.TagNumber(16)
  StaffCharacterMediaConnection get characterMedia => $_getN(15);
  @$pb.TagNumber(16)
  set characterMedia(StaffCharacterMediaConnection value) =>
      $_setField(16, value);
  @$pb.TagNumber(16)
  $core.bool hasCharacterMedia() => $_has(15);
  @$pb.TagNumber(16)
  void clearCharacterMedia() => $_clearField(16);
  @$pb.TagNumber(16)
  StaffCharacterMediaConnection ensureCharacterMedia() => $_ensure(15);

  @$pb.TagNumber(17)
  StaffMediaConnection get staffMedia => $_getN(16);
  @$pb.TagNumber(17)
  set staffMedia(StaffMediaConnection value) => $_setField(17, value);
  @$pb.TagNumber(17)
  $core.bool hasStaffMedia() => $_has(16);
  @$pb.TagNumber(17)
  void clearStaffMedia() => $_clearField(17);
  @$pb.TagNumber(17)
  StaffMediaConnection ensureStaffMedia() => $_ensure(16);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
