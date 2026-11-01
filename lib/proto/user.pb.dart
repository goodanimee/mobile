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

import 'media_min.pb.dart' as $0;

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
    $core.int? animeCount,
    $core.int? mangaCount,
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
    if (animeCount != null) result.animeCount = animeCount;
    if (mangaCount != null) result.mangaCount = mangaCount;
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
    ..aI(11, _omitFieldNames ? '' : 'animeCount')
    ..aI(12, _omitFieldNames ? '' : 'mangaCount')
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

  @$pb.TagNumber(11)
  $core.int get animeCount => $_getIZ(10);
  @$pb.TagNumber(11)
  set animeCount($core.int value) => $_setSignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasAnimeCount() => $_has(10);
  @$pb.TagNumber(11)
  void clearAnimeCount() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.int get mangaCount => $_getIZ(11);
  @$pb.TagNumber(12)
  set mangaCount($core.int value) => $_setSignedInt32(11, value);
  @$pb.TagNumber(12)
  $core.bool hasMangaCount() => $_has(11);
  @$pb.TagNumber(12)
  void clearMangaCount() => $_clearField(12);
}

class UserActivityUser extends $pb.GeneratedMessage {
  factory UserActivityUser({
    $core.int? id,
    $core.String? name,
    UserAvatar? avatar,
  }) {
    final result = UserActivityUser._();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (avatar != null) result.avatar = avatar;
    return result;
  }

  UserActivityUser._();

  factory UserActivityUser.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserActivityUser()..mergeFromBuffer(data, registry);
  factory UserActivityUser.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserActivityUser()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserActivityUser',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: UserActivityUser.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOM<UserAvatar>(3, _omitFieldNames ? '' : 'avatar',
        subBuilder: UserAvatar.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserActivityUser clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserActivityUser copyWith(void Function(UserActivityUser) updates) =>
      super.copyWith((message) => updates(message as UserActivityUser))
          as UserActivityUser;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use UserActivityUser() / UserActivityUser.new instead')
  static UserActivityUser create() => UserActivityUser._();
  static $pb.GeneratedMessage $_createMessage() => UserActivityUser._();
  @$core.override
  UserActivityUser createEmptyInstance() => UserActivityUser._();
  @$core.pragma('dart2js:noInline')
  static UserActivityUser getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserActivityUser>(
          UserActivityUser.$_createMessage);
  static UserActivityUser? _defaultInstance;

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
  UserAvatar get avatar => $_getN(2);
  @$pb.TagNumber(3)
  set avatar(UserAvatar value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasAvatar() => $_has(2);
  @$pb.TagNumber(3)
  void clearAvatar() => $_clearField(3);
  @$pb.TagNumber(3)
  UserAvatar ensureAvatar() => $_ensure(2);
}

class UserActivity extends $pb.GeneratedMessage {
  factory UserActivity({
    $core.int? id,
    $core.String? type,
    $core.int? createdAt,
    $core.bool? isLiked,
    $core.int? likeCount,
    $core.int? replyCount,
    $core.String? status,
    $core.String? progress,
    $core.String? textHtml,
    $core.bool? isPrivate,
    UserActivityUser? user,
    UserActivityUser? recipient,
    $0.MediaMin? media,
  }) {
    final result = UserActivity._();
    if (id != null) result.id = id;
    if (type != null) result.type = type;
    if (createdAt != null) result.createdAt = createdAt;
    if (isLiked != null) result.isLiked = isLiked;
    if (likeCount != null) result.likeCount = likeCount;
    if (replyCount != null) result.replyCount = replyCount;
    if (status != null) result.status = status;
    if (progress != null) result.progress = progress;
    if (textHtml != null) result.textHtml = textHtml;
    if (isPrivate != null) result.isPrivate = isPrivate;
    if (user != null) result.user = user;
    if (recipient != null) result.recipient = recipient;
    if (media != null) result.media = media;
    return result;
  }

  UserActivity._();

  factory UserActivity.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserActivity()..mergeFromBuffer(data, registry);
  factory UserActivity.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserActivity()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserActivity',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: UserActivity.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'type')
    ..aI(3, _omitFieldNames ? '' : 'createdAt')
    ..aOB(4, _omitFieldNames ? '' : 'isLiked')
    ..aI(5, _omitFieldNames ? '' : 'likeCount')
    ..aI(6, _omitFieldNames ? '' : 'replyCount')
    ..aOS(7, _omitFieldNames ? '' : 'status')
    ..aOS(8, _omitFieldNames ? '' : 'progress')
    ..aOS(9, _omitFieldNames ? '' : 'textHtml')
    ..aOB(10, _omitFieldNames ? '' : 'isPrivate')
    ..aOM<UserActivityUser>(11, _omitFieldNames ? '' : 'user',
        subBuilder: UserActivityUser.$_createMessage)
    ..aOM<UserActivityUser>(12, _omitFieldNames ? '' : 'recipient',
        subBuilder: UserActivityUser.$_createMessage)
    ..aOM<$0.MediaMin>(13, _omitFieldNames ? '' : 'media',
        subBuilder: $0.MediaMin.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserActivity clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserActivity copyWith(void Function(UserActivity) updates) =>
      super.copyWith((message) => updates(message as UserActivity))
          as UserActivity;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use UserActivity() / UserActivity.new instead')
  static UserActivity create() => UserActivity._();
  static $pb.GeneratedMessage $_createMessage() => UserActivity._();
  @$core.override
  UserActivity createEmptyInstance() => UserActivity._();
  @$core.pragma('dart2js:noInline')
  static UserActivity getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserActivity>(
          UserActivity.$_createMessage);
  static UserActivity? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get type => $_getSZ(1);
  @$pb.TagNumber(2)
  set type($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get createdAt => $_getIZ(2);
  @$pb.TagNumber(3)
  set createdAt($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCreatedAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearCreatedAt() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get isLiked => $_getBF(3);
  @$pb.TagNumber(4)
  set isLiked($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasIsLiked() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsLiked() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get likeCount => $_getIZ(4);
  @$pb.TagNumber(5)
  set likeCount($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasLikeCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearLikeCount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get replyCount => $_getIZ(5);
  @$pb.TagNumber(6)
  set replyCount($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasReplyCount() => $_has(5);
  @$pb.TagNumber(6)
  void clearReplyCount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get status => $_getSZ(6);
  @$pb.TagNumber(7)
  set status($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearStatus() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get progress => $_getSZ(7);
  @$pb.TagNumber(8)
  set progress($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasProgress() => $_has(7);
  @$pb.TagNumber(8)
  void clearProgress() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get textHtml => $_getSZ(8);
  @$pb.TagNumber(9)
  set textHtml($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasTextHtml() => $_has(8);
  @$pb.TagNumber(9)
  void clearTextHtml() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.bool get isPrivate => $_getBF(9);
  @$pb.TagNumber(10)
  set isPrivate($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasIsPrivate() => $_has(9);
  @$pb.TagNumber(10)
  void clearIsPrivate() => $_clearField(10);

  @$pb.TagNumber(11)
  UserActivityUser get user => $_getN(10);
  @$pb.TagNumber(11)
  set user(UserActivityUser value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasUser() => $_has(10);
  @$pb.TagNumber(11)
  void clearUser() => $_clearField(11);
  @$pb.TagNumber(11)
  UserActivityUser ensureUser() => $_ensure(10);

  @$pb.TagNumber(12)
  UserActivityUser get recipient => $_getN(11);
  @$pb.TagNumber(12)
  set recipient(UserActivityUser value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasRecipient() => $_has(11);
  @$pb.TagNumber(12)
  void clearRecipient() => $_clearField(12);
  @$pb.TagNumber(12)
  UserActivityUser ensureRecipient() => $_ensure(11);

  @$pb.TagNumber(13)
  $0.MediaMin get media => $_getN(12);
  @$pb.TagNumber(13)
  set media($0.MediaMin value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasMedia() => $_has(12);
  @$pb.TagNumber(13)
  void clearMedia() => $_clearField(13);
  @$pb.TagNumber(13)
  $0.MediaMin ensureMedia() => $_ensure(12);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
