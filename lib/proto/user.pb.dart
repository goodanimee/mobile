// This is a generated file - do not edit.
//
// Generated from user.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class UserAvatar extends $pb.GeneratedMessage {
  factory UserAvatar({
    $core.String? large,
    $core.String? medium,
  }) {
    final result = UserAvatar._();
    if (large != null) result.large = large;
    if (medium != null) result.medium = medium;
    return result;
  }

  UserAvatar._();

  factory UserAvatar.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserAvatar()..mergeFromBuffer(data, registry);
  factory UserAvatar.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserAvatar()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserAvatar',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: UserAvatar.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'large')
    ..aOS(2, _omitFieldNames ? '' : 'medium')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserAvatar clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserAvatar copyWith(void Function(UserAvatar) updates) =>
      super.copyWith((message) => updates(message as UserAvatar)) as UserAvatar;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use UserAvatar() / UserAvatar.new instead')
  static UserAvatar create() => UserAvatar._();
  static $pb.GeneratedMessage $_createMessage() => UserAvatar._();
  @$core.override
  UserAvatar createEmptyInstance() => UserAvatar._();
  @$core.pragma('dart2js:noInline')
  static UserAvatar getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserAvatar>(UserAvatar.$_createMessage);
  static UserAvatar? _defaultInstance;

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

class UserProfile extends $pb.GeneratedMessage {
  factory UserProfile({
    $core.int? id,
    $core.String? name,
    $core.String? about,
    UserAvatar? avatar,
    $core.String? bannerImage,
    $core.bool? isFollowing,
    $core.bool? isFollower,
    $core.int? createdAt,
    $core.int? followersCount,
    $core.int? followingCount,
  }) {
    final result = UserProfile._();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (about != null) result.about = about;
    if (avatar != null) result.avatar = avatar;
    if (bannerImage != null) result.bannerImage = bannerImage;
    if (isFollowing != null) result.isFollowing = isFollowing;
    if (isFollower != null) result.isFollower = isFollower;
    if (createdAt != null) result.createdAt = createdAt;
    if (followersCount != null) result.followersCount = followersCount;
    if (followingCount != null) result.followingCount = followingCount;
    return result;
  }

  UserProfile._();

  factory UserProfile.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserProfile()..mergeFromBuffer(data, registry);
  factory UserProfile.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserProfile()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserProfile',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: UserProfile.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'about')
    ..aOM<UserAvatar>(4, _omitFieldNames ? '' : 'avatar',
        subBuilder: UserAvatar.$_createMessage)
    ..aOS(5, _omitFieldNames ? '' : 'bannerImage')
    ..aOB(6, _omitFieldNames ? '' : 'isFollowing')
    ..aOB(7, _omitFieldNames ? '' : 'isFollower')
    ..aI(8, _omitFieldNames ? '' : 'createdAt')
    ..aI(9, _omitFieldNames ? '' : 'followersCount')
    ..aI(10, _omitFieldNames ? '' : 'followingCount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserProfile clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserProfile copyWith(void Function(UserProfile) updates) =>
      super.copyWith((message) => updates(message as UserProfile))
          as UserProfile;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use UserProfile() / UserProfile.new instead')
  static UserProfile create() => UserProfile._();
  static $pb.GeneratedMessage $_createMessage() => UserProfile._();
  @$core.override
  UserProfile createEmptyInstance() => UserProfile._();
  @$core.pragma('dart2js:noInline')
  static UserProfile getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserProfile>(
          UserProfile.$_createMessage);
  static UserProfile? _defaultInstance;

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
  $core.String get about => $_getSZ(2);
  @$pb.TagNumber(3)
  set about($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAbout() => $_has(2);
  @$pb.TagNumber(3)
  void clearAbout() => $_clearField(3);

  @$pb.TagNumber(4)
  UserAvatar get avatar => $_getN(3);
  @$pb.TagNumber(4)
  set avatar(UserAvatar value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasAvatar() => $_has(3);
  @$pb.TagNumber(4)
  void clearAvatar() => $_clearField(4);
  @$pb.TagNumber(4)
  UserAvatar ensureAvatar() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get bannerImage => $_getSZ(4);
  @$pb.TagNumber(5)
  set bannerImage($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasBannerImage() => $_has(4);
  @$pb.TagNumber(5)
  void clearBannerImage() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get isFollowing => $_getBF(5);
  @$pb.TagNumber(6)
  set isFollowing($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasIsFollowing() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsFollowing() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.bool get isFollower => $_getBF(6);
  @$pb.TagNumber(7)
  set isFollower($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasIsFollower() => $_has(6);
  @$pb.TagNumber(7)
  void clearIsFollower() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get createdAt => $_getIZ(7);
  @$pb.TagNumber(8)
  set createdAt($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasCreatedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearCreatedAt() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get followersCount => $_getIZ(8);
  @$pb.TagNumber(9)
  set followersCount($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasFollowersCount() => $_has(8);
  @$pb.TagNumber(9)
  void clearFollowersCount() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.int get followingCount => $_getIZ(9);
  @$pb.TagNumber(10)
  set followingCount($core.int value) => $_setSignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasFollowingCount() => $_has(9);
  @$pb.TagNumber(10)
  void clearFollowingCount() => $_clearField(10);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
