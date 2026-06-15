// This is a generated file - do not edit.
//
// Generated from media_character.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pb.dart' as $0;
import 'media_staff.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class CharacterName extends $pb.GeneratedMessage {
  factory CharacterName({
    $core.String? full,
    $core.String? native,
    $core.String? userPreferred,
    $core.Iterable<$core.String>? alternative,
    $core.Iterable<$core.String>? alternativeSpoiler,
  }) {
    final result = create();
    if (full != null) result.full = full;
    if (native != null) result.native = native;
    if (userPreferred != null) result.userPreferred = userPreferred;
    if (alternative != null) result.alternative.addAll(alternative);
    if (alternativeSpoiler != null)
      result.alternativeSpoiler.addAll(alternativeSpoiler);
    return result;
  }

  CharacterName._();

  factory CharacterName.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CharacterName.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CharacterName',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'full')
    ..aOS(2, _omitFieldNames ? '' : 'native')
    ..aOS(3, _omitFieldNames ? '' : 'userPreferred')
    ..pPS(4, _omitFieldNames ? '' : 'alternative')
    ..pPS(5, _omitFieldNames ? '' : 'alternativeSpoiler')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CharacterName clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CharacterName copyWith(void Function(CharacterName) updates) =>
      super.copyWith((message) => updates(message as CharacterName))
          as CharacterName;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CharacterName create() => CharacterName._();
  @$core.override
  CharacterName createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CharacterName getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CharacterName>(create);
  static CharacterName? _defaultInstance;

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

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get alternative => $_getList(3);

  @$pb.TagNumber(5)
  $pb.PbList<$core.String> get alternativeSpoiler => $_getList(4);
}

class CharacterImage extends $pb.GeneratedMessage {
  factory CharacterImage({
    $core.String? large,
    $core.String? medium,
  }) {
    final result = create();
    if (large != null) result.large = large;
    if (medium != null) result.medium = medium;
    return result;
  }

  CharacterImage._();

  factory CharacterImage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CharacterImage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CharacterImage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'large')
    ..aOS(2, _omitFieldNames ? '' : 'medium')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CharacterImage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CharacterImage copyWith(void Function(CharacterImage) updates) =>
      super.copyWith((message) => updates(message as CharacterImage))
          as CharacterImage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CharacterImage create() => CharacterImage._();
  @$core.override
  CharacterImage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CharacterImage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CharacterImage>(create);
  static CharacterImage? _defaultInstance;

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

class Character extends $pb.GeneratedMessage {
  factory Character({
    CharacterName? name,
    CharacterImage? image,
    $core.String? gender,
    $core.String? age,
    $0.FuzzyDate? dateOfBirth,
    $core.String? description,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (image != null) result.image = image;
    if (gender != null) result.gender = gender;
    if (age != null) result.age = age;
    if (dateOfBirth != null) result.dateOfBirth = dateOfBirth;
    if (description != null) result.description = description;
    return result;
  }

  Character._();

  factory Character.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Character.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Character',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aOM<CharacterName>(1, _omitFieldNames ? '' : 'name',
        subBuilder: CharacterName.create)
    ..aOM<CharacterImage>(2, _omitFieldNames ? '' : 'image',
        subBuilder: CharacterImage.create)
    ..aOS(3, _omitFieldNames ? '' : 'gender')
    ..aOS(4, _omitFieldNames ? '' : 'age')
    ..aOM<$0.FuzzyDate>(5, _omitFieldNames ? '' : 'dateOfBirth',
        subBuilder: $0.FuzzyDate.create)
    ..aOS(6, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Character clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Character copyWith(void Function(Character) updates) =>
      super.copyWith((message) => updates(message as Character)) as Character;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Character create() => Character._();
  @$core.override
  Character createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Character getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Character>(create);
  static Character? _defaultInstance;

  @$pb.TagNumber(1)
  CharacterName get name => $_getN(0);
  @$pb.TagNumber(1)
  set name(CharacterName value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);
  @$pb.TagNumber(1)
  CharacterName ensureName() => $_ensure(0);

  @$pb.TagNumber(2)
  CharacterImage get image => $_getN(1);
  @$pb.TagNumber(2)
  set image(CharacterImage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasImage() => $_has(1);
  @$pb.TagNumber(2)
  void clearImage() => $_clearField(2);
  @$pb.TagNumber(2)
  CharacterImage ensureImage() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get gender => $_getSZ(2);
  @$pb.TagNumber(3)
  set gender($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasGender() => $_has(2);
  @$pb.TagNumber(3)
  void clearGender() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get age => $_getSZ(3);
  @$pb.TagNumber(4)
  set age($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAge() => $_has(3);
  @$pb.TagNumber(4)
  void clearAge() => $_clearField(4);

  @$pb.TagNumber(5)
  $0.FuzzyDate get dateOfBirth => $_getN(4);
  @$pb.TagNumber(5)
  set dateOfBirth($0.FuzzyDate value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasDateOfBirth() => $_has(4);
  @$pb.TagNumber(5)
  void clearDateOfBirth() => $_clearField(5);
  @$pb.TagNumber(5)
  $0.FuzzyDate ensureDateOfBirth() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.String get description => $_getSZ(5);
  @$pb.TagNumber(6)
  set description($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDescription() => $_has(5);
  @$pb.TagNumber(6)
  void clearDescription() => $_clearField(6);
}

class CharacterEdge extends $pb.GeneratedMessage {
  factory CharacterEdge({
    $core.int? id,
    $core.String? role,
    $core.String? name,
    Character? node,
    $core.Iterable<$1.StaffMin>? voiceActors,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (role != null) result.role = role;
    if (name != null) result.name = name;
    if (node != null) result.node = node;
    if (voiceActors != null) result.voiceActors.addAll(voiceActors);
    return result;
  }

  CharacterEdge._();

  factory CharacterEdge.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CharacterEdge.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CharacterEdge',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'role')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..aOM<Character>(4, _omitFieldNames ? '' : 'node',
        subBuilder: Character.create)
    ..pPM<$1.StaffMin>(5, _omitFieldNames ? '' : 'voiceActors',
        subBuilder: $1.StaffMin.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CharacterEdge clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CharacterEdge copyWith(void Function(CharacterEdge) updates) =>
      super.copyWith((message) => updates(message as CharacterEdge))
          as CharacterEdge;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CharacterEdge create() => CharacterEdge._();
  @$core.override
  CharacterEdge createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CharacterEdge getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CharacterEdge>(create);
  static CharacterEdge? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get role => $_getSZ(1);
  @$pb.TagNumber(2)
  set role($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRole() => $_has(1);
  @$pb.TagNumber(2)
  void clearRole() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);

  @$pb.TagNumber(4)
  Character get node => $_getN(3);
  @$pb.TagNumber(4)
  set node(Character value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasNode() => $_has(3);
  @$pb.TagNumber(4)
  void clearNode() => $_clearField(4);
  @$pb.TagNumber(4)
  Character ensureNode() => $_ensure(3);

  @$pb.TagNumber(5)
  $pb.PbList<$1.StaffMin> get voiceActors => $_getList(4);
}

class CharacterConnection extends $pb.GeneratedMessage {
  factory CharacterConnection({
    $core.Iterable<CharacterEdge>? edges,
    $0.PageInfo? pageInfo,
  }) {
    final result = create();
    if (edges != null) result.edges.addAll(edges);
    if (pageInfo != null) result.pageInfo = pageInfo;
    return result;
  }

  CharacterConnection._();

  factory CharacterConnection.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CharacterConnection.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CharacterConnection',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..pPM<CharacterEdge>(1, _omitFieldNames ? '' : 'edges',
        subBuilder: CharacterEdge.create)
    ..aOM<$0.PageInfo>(2, _omitFieldNames ? '' : 'pageInfo',
        subBuilder: $0.PageInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CharacterConnection clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CharacterConnection copyWith(void Function(CharacterConnection) updates) =>
      super.copyWith((message) => updates(message as CharacterConnection))
          as CharacterConnection;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CharacterConnection create() => CharacterConnection._();
  @$core.override
  CharacterConnection createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CharacterConnection getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CharacterConnection>(create);
  static CharacterConnection? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<CharacterEdge> get edges => $_getList(0);

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
