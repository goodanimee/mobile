// This is a generated file - do not edit.
//
// Generated from user.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use userAvatarDescriptor instead')
const UserAvatar$json = {
  '1': 'UserAvatar',
  '2': [
    {'1': 'large', '3': 1, '4': 1, '5': 9, '10': 'large'},
    {'1': 'medium', '3': 2, '4': 1, '5': 9, '10': 'medium'},
  ],
};

/// Descriptor for `UserAvatar`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userAvatarDescriptor = $convert.base64Decode(
    'CgpVc2VyQXZhdGFyEhQKBWxhcmdlGAEgASgJUgVsYXJnZRIWCgZtZWRpdW0YAiABKAlSBm1lZG'
    'l1bQ==');

@$core.Deprecated('Use userProfileDescriptor instead')
const UserProfile$json = {
  '1': 'UserProfile',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'about', '3': 3, '4': 1, '5': 9, '10': 'about'},
    {
      '1': 'avatar',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.goodanime.UserAvatar',
      '10': 'avatar'
    },
    {'1': 'banner_image', '3': 5, '4': 1, '5': 9, '10': 'bannerImage'},
    {'1': 'is_following', '3': 6, '4': 1, '5': 8, '10': 'isFollowing'},
    {'1': 'is_follower', '3': 7, '4': 1, '5': 8, '10': 'isFollower'},
    {'1': 'created_at', '3': 8, '4': 1, '5': 5, '10': 'createdAt'},
    {'1': 'followers_count', '3': 9, '4': 1, '5': 5, '10': 'followersCount'},
    {'1': 'following_count', '3': 10, '4': 1, '5': 5, '10': 'followingCount'},
    {'1': 'anime_count', '3': 11, '4': 1, '5': 5, '10': 'animeCount'},
    {'1': 'manga_count', '3': 12, '4': 1, '5': 5, '10': 'mangaCount'},
  ],
};

/// Descriptor for `UserProfile`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userProfileDescriptor = $convert.base64Decode(
    'CgtVc2VyUHJvZmlsZRIOCgJpZBgBIAEoBVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIUCgVhYm'
    '91dBgDIAEoCVIFYWJvdXQSLQoGYXZhdGFyGAQgASgLMhUuZ29vZGFuaW1lLlVzZXJBdmF0YXJS'
    'BmF2YXRhchIhCgxiYW5uZXJfaW1hZ2UYBSABKAlSC2Jhbm5lckltYWdlEiEKDGlzX2ZvbGxvd2'
    'luZxgGIAEoCFILaXNGb2xsb3dpbmcSHwoLaXNfZm9sbG93ZXIYByABKAhSCmlzRm9sbG93ZXIS'
    'HQoKY3JlYXRlZF9hdBgIIAEoBVIJY3JlYXRlZEF0EicKD2ZvbGxvd2Vyc19jb3VudBgJIAEoBV'
    'IOZm9sbG93ZXJzQ291bnQSJwoPZm9sbG93aW5nX2NvdW50GAogASgFUg5mb2xsb3dpbmdDb3Vu'
    'dBIfCgthbmltZV9jb3VudBgLIAEoBVIKYW5pbWVDb3VudBIfCgttYW5nYV9jb3VudBgMIAEoBV'
    'IKbWFuZ2FDb3VudA==');

@$core.Deprecated('Use userActivityUserDescriptor instead')
const UserActivityUser$json = {
  '1': 'UserActivityUser',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'avatar',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.goodanime.UserAvatar',
      '10': 'avatar'
    },
  ],
};

/// Descriptor for `UserActivityUser`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userActivityUserDescriptor = $convert.base64Decode(
    'ChBVc2VyQWN0aXZpdHlVc2VyEg4KAmlkGAEgASgFUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEi'
    '0KBmF2YXRhchgDIAEoCzIVLmdvb2RhbmltZS5Vc2VyQXZhdGFyUgZhdmF0YXI=');

@$core.Deprecated('Use userActivityDescriptor instead')
const UserActivity$json = {
  '1': 'UserActivity',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'type', '3': 2, '4': 1, '5': 9, '10': 'type'},
    {'1': 'created_at', '3': 3, '4': 1, '5': 5, '10': 'createdAt'},
    {'1': 'is_liked', '3': 4, '4': 1, '5': 8, '10': 'isLiked'},
    {'1': 'like_count', '3': 5, '4': 1, '5': 5, '10': 'likeCount'},
    {'1': 'reply_count', '3': 6, '4': 1, '5': 5, '10': 'replyCount'},
    {'1': 'status', '3': 7, '4': 1, '5': 9, '10': 'status'},
    {'1': 'progress', '3': 8, '4': 1, '5': 9, '10': 'progress'},
    {'1': 'text_html', '3': 9, '4': 1, '5': 9, '10': 'textHtml'},
    {'1': 'is_private', '3': 10, '4': 1, '5': 8, '10': 'isPrivate'},
    {
      '1': 'user',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.goodanime.UserActivityUser',
      '10': 'user'
    },
    {
      '1': 'recipient',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.goodanime.UserActivityUser',
      '10': 'recipient'
    },
    {
      '1': 'media',
      '3': 13,
      '4': 1,
      '5': 11,
      '6': '.goodanime.MediaMin',
      '10': 'media'
    },
  ],
};

/// Descriptor for `UserActivity`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userActivityDescriptor = $convert.base64Decode(
    'CgxVc2VyQWN0aXZpdHkSDgoCaWQYASABKAVSAmlkEhIKBHR5cGUYAiABKAlSBHR5cGUSHQoKY3'
    'JlYXRlZF9hdBgDIAEoBVIJY3JlYXRlZEF0EhkKCGlzX2xpa2VkGAQgASgIUgdpc0xpa2VkEh0K'
    'Cmxpa2VfY291bnQYBSABKAVSCWxpa2VDb3VudBIfCgtyZXBseV9jb3VudBgGIAEoBVIKcmVwbH'
    'lDb3VudBIWCgZzdGF0dXMYByABKAlSBnN0YXR1cxIaCghwcm9ncmVzcxgIIAEoCVIIcHJvZ3Jl'
    'c3MSGwoJdGV4dF9odG1sGAkgASgJUgh0ZXh0SHRtbBIdCgppc19wcml2YXRlGAogASgIUglpc1'
    'ByaXZhdGUSLwoEdXNlchgLIAEoCzIbLmdvb2RhbmltZS5Vc2VyQWN0aXZpdHlVc2VyUgR1c2Vy'
    'EjkKCXJlY2lwaWVudBgMIAEoCzIbLmdvb2RhbmltZS5Vc2VyQWN0aXZpdHlVc2VyUglyZWNpcG'
    'llbnQSKQoFbWVkaWEYDSABKAsyEy5nb29kYW5pbWUuTWVkaWFNaW5SBW1lZGlh');

@$core.Deprecated('Use favouriteMediaConnectionDescriptor instead')
const FavouriteMediaConnection$json = {
  '1': 'FavouriteMediaConnection',
  '2': [
    {
      '1': 'page_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.goodanime.PageInfo',
      '10': 'pageInfo'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    {
      '1': 'nodes',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.goodanime.MediaMin',
      '10': 'nodes'
    },
  ],
};

/// Descriptor for `FavouriteMediaConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List favouriteMediaConnectionDescriptor = $convert.base64Decode(
    'ChhGYXZvdXJpdGVNZWRpYUNvbm5lY3Rpb24SMAoJcGFnZV9pbmZvGAEgASgLMhMuZ29vZGFuaW'
    '1lLlBhZ2VJbmZvUghwYWdlSW5mbxIUCgV0b3RhbBgCIAEoBVIFdG90YWwSKQoFbm9kZXMYAyAD'
    'KAsyEy5nb29kYW5pbWUuTWVkaWFNaW5SBW5vZGVz');

@$core.Deprecated('Use favouriteCharacterConnectionDescriptor instead')
const FavouriteCharacterConnection$json = {
  '1': 'FavouriteCharacterConnection',
  '2': [
    {
      '1': 'page_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.goodanime.PageInfo',
      '10': 'pageInfo'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    {
      '1': 'nodes',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.goodanime.Character',
      '10': 'nodes'
    },
  ],
};

/// Descriptor for `FavouriteCharacterConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List favouriteCharacterConnectionDescriptor =
    $convert.base64Decode(
        'ChxGYXZvdXJpdGVDaGFyYWN0ZXJDb25uZWN0aW9uEjAKCXBhZ2VfaW5mbxgBIAEoCzITLmdvb2'
        'RhbmltZS5QYWdlSW5mb1IIcGFnZUluZm8SFAoFdG90YWwYAiABKAVSBXRvdGFsEioKBW5vZGVz'
        'GAMgAygLMhQuZ29vZGFuaW1lLkNoYXJhY3RlclIFbm9kZXM=');

@$core.Deprecated('Use favouriteStaffConnectionDescriptor instead')
const FavouriteStaffConnection$json = {
  '1': 'FavouriteStaffConnection',
  '2': [
    {
      '1': 'page_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.goodanime.PageInfo',
      '10': 'pageInfo'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    {
      '1': 'nodes',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.goodanime.Staff',
      '10': 'nodes'
    },
  ],
};

/// Descriptor for `FavouriteStaffConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List favouriteStaffConnectionDescriptor = $convert.base64Decode(
    'ChhGYXZvdXJpdGVTdGFmZkNvbm5lY3Rpb24SMAoJcGFnZV9pbmZvGAEgASgLMhMuZ29vZGFuaW'
    '1lLlBhZ2VJbmZvUghwYWdlSW5mbxIUCgV0b3RhbBgCIAEoBVIFdG90YWwSJgoFbm9kZXMYAyAD'
    'KAsyEC5nb29kYW5pbWUuU3RhZmZSBW5vZGVz');

@$core.Deprecated('Use favouriteStudioConnectionDescriptor instead')
const FavouriteStudioConnection$json = {
  '1': 'FavouriteStudioConnection',
  '2': [
    {
      '1': 'page_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.goodanime.PageInfo',
      '10': 'pageInfo'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    {
      '1': 'nodes',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.goodanime.Studio',
      '10': 'nodes'
    },
  ],
};

/// Descriptor for `FavouriteStudioConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List favouriteStudioConnectionDescriptor = $convert.base64Decode(
    'ChlGYXZvdXJpdGVTdHVkaW9Db25uZWN0aW9uEjAKCXBhZ2VfaW5mbxgBIAEoCzITLmdvb2Rhbm'
    'ltZS5QYWdlSW5mb1IIcGFnZUluZm8SFAoFdG90YWwYAiABKAVSBXRvdGFsEicKBW5vZGVzGAMg'
    'AygLMhEuZ29vZGFuaW1lLlN0dWRpb1IFbm9kZXM=');

@$core.Deprecated('Use userFavouritesDescriptor instead')
const UserFavourites$json = {
  '1': 'UserFavourites',
  '2': [
    {
      '1': 'anime',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.goodanime.FavouriteMediaConnection',
      '10': 'anime'
    },
    {
      '1': 'manga',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.goodanime.FavouriteMediaConnection',
      '10': 'manga'
    },
    {
      '1': 'characters',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.goodanime.FavouriteCharacterConnection',
      '10': 'characters'
    },
    {
      '1': 'staff',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.goodanime.FavouriteStaffConnection',
      '10': 'staff'
    },
    {
      '1': 'studios',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.goodanime.FavouriteStudioConnection',
      '10': 'studios'
    },
  ],
};

/// Descriptor for `UserFavourites`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userFavouritesDescriptor = $convert.base64Decode(
    'Cg5Vc2VyRmF2b3VyaXRlcxI5CgVhbmltZRgBIAEoCzIjLmdvb2RhbmltZS5GYXZvdXJpdGVNZW'
    'RpYUNvbm5lY3Rpb25SBWFuaW1lEjkKBW1hbmdhGAIgASgLMiMuZ29vZGFuaW1lLkZhdm91cml0'
    'ZU1lZGlhQ29ubmVjdGlvblIFbWFuZ2ESRwoKY2hhcmFjdGVycxgDIAEoCzInLmdvb2RhbmltZS'
    '5GYXZvdXJpdGVDaGFyYWN0ZXJDb25uZWN0aW9uUgpjaGFyYWN0ZXJzEjkKBXN0YWZmGAQgASgL'
    'MiMuZ29vZGFuaW1lLkZhdm91cml0ZVN0YWZmQ29ubmVjdGlvblIFc3RhZmYSPgoHc3R1ZGlvcx'
    'gFIAEoCzIkLmdvb2RhbmltZS5GYXZvdXJpdGVTdHVkaW9Db25uZWN0aW9uUgdzdHVkaW9z');

@$core.Deprecated('Use socialUserDescriptor instead')
const SocialUser$json = {
  '1': 'SocialUser',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'avatar',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.goodanime.UserAvatar',
      '10': 'avatar'
    },
    {'1': 'is_following', '3': 4, '4': 1, '5': 8, '10': 'isFollowing'},
    {'1': 'is_follower', '3': 5, '4': 1, '5': 8, '10': 'isFollower'},
  ],
};

/// Descriptor for `SocialUser`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List socialUserDescriptor = $convert.base64Decode(
    'CgpTb2NpYWxVc2VyEg4KAmlkGAEgASgFUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEi0KBmF2YX'
    'RhchgDIAEoCzIVLmdvb2RhbmltZS5Vc2VyQXZhdGFyUgZhdmF0YXISIQoMaXNfZm9sbG93aW5n'
    'GAQgASgIUgtpc0ZvbGxvd2luZxIfCgtpc19mb2xsb3dlchgFIAEoCFIKaXNGb2xsb3dlcg==');

@$core.Deprecated('Use userScoreStatDescriptor instead')
const UserScoreStat$json = {
  '1': 'UserScoreStat',
  '2': [
    {'1': 'score', '3': 1, '4': 1, '5': 5, '10': 'score'},
    {'1': 'count', '3': 2, '4': 1, '5': 5, '10': 'count'},
    {'1': 'mean_score', '3': 3, '4': 1, '5': 1, '10': 'meanScore'},
    {'1': 'minutes_watched', '3': 4, '4': 1, '5': 5, '10': 'minutesWatched'},
    {'1': 'chapters_read', '3': 5, '4': 1, '5': 5, '10': 'chaptersRead'},
    {'1': 'media_ids', '3': 6, '4': 3, '5': 5, '10': 'mediaIds'},
  ],
};

/// Descriptor for `UserScoreStat`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userScoreStatDescriptor = $convert.base64Decode(
    'Cg1Vc2VyU2NvcmVTdGF0EhQKBXNjb3JlGAEgASgFUgVzY29yZRIUCgVjb3VudBgCIAEoBVIFY2'
    '91bnQSHQoKbWVhbl9zY29yZRgDIAEoAVIJbWVhblNjb3JlEicKD21pbnV0ZXNfd2F0Y2hlZBgE'
    'IAEoBVIObWludXRlc1dhdGNoZWQSIwoNY2hhcHRlcnNfcmVhZBgFIAEoBVIMY2hhcHRlcnNSZW'
    'FkEhsKCW1lZGlhX2lkcxgGIAMoBVIIbWVkaWFJZHM=');

@$core.Deprecated('Use userLengthStatDescriptor instead')
const UserLengthStat$json = {
  '1': 'UserLengthStat',
  '2': [
    {'1': 'length', '3': 1, '4': 1, '5': 9, '10': 'length'},
    {'1': 'count', '3': 2, '4': 1, '5': 5, '10': 'count'},
    {'1': 'mean_score', '3': 3, '4': 1, '5': 1, '10': 'meanScore'},
    {'1': 'minutes_watched', '3': 4, '4': 1, '5': 5, '10': 'minutesWatched'},
    {'1': 'chapters_read', '3': 5, '4': 1, '5': 5, '10': 'chaptersRead'},
    {'1': 'media_ids', '3': 6, '4': 3, '5': 5, '10': 'mediaIds'},
  ],
};

/// Descriptor for `UserLengthStat`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userLengthStatDescriptor = $convert.base64Decode(
    'Cg5Vc2VyTGVuZ3RoU3RhdBIWCgZsZW5ndGgYASABKAlSBmxlbmd0aBIUCgVjb3VudBgCIAEoBV'
    'IFY291bnQSHQoKbWVhbl9zY29yZRgDIAEoAVIJbWVhblNjb3JlEicKD21pbnV0ZXNfd2F0Y2hl'
    'ZBgEIAEoBVIObWludXRlc1dhdGNoZWQSIwoNY2hhcHRlcnNfcmVhZBgFIAEoBVIMY2hhcHRlcn'
    'NSZWFkEhsKCW1lZGlhX2lkcxgGIAMoBVIIbWVkaWFJZHM=');

@$core.Deprecated('Use userStatusStatDescriptor instead')
const UserStatusStat$json = {
  '1': 'UserStatusStat',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    {'1': 'count', '3': 2, '4': 1, '5': 5, '10': 'count'},
    {'1': 'mean_score', '3': 3, '4': 1, '5': 1, '10': 'meanScore'},
    {'1': 'minutes_watched', '3': 4, '4': 1, '5': 5, '10': 'minutesWatched'},
    {'1': 'chapters_read', '3': 5, '4': 1, '5': 5, '10': 'chaptersRead'},
    {'1': 'media_ids', '3': 6, '4': 3, '5': 5, '10': 'mediaIds'},
  ],
};

/// Descriptor for `UserStatusStat`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userStatusStatDescriptor = $convert.base64Decode(
    'Cg5Vc2VyU3RhdHVzU3RhdBIWCgZzdGF0dXMYASABKAlSBnN0YXR1cxIUCgVjb3VudBgCIAEoBV'
    'IFY291bnQSHQoKbWVhbl9zY29yZRgDIAEoAVIJbWVhblNjb3JlEicKD21pbnV0ZXNfd2F0Y2hl'
    'ZBgEIAEoBVIObWludXRlc1dhdGNoZWQSIwoNY2hhcHRlcnNfcmVhZBgFIAEoBVIMY2hhcHRlcn'
    'NSZWFkEhsKCW1lZGlhX2lkcxgGIAMoBVIIbWVkaWFJZHM=');

@$core.Deprecated('Use userFormatStatDescriptor instead')
const UserFormatStat$json = {
  '1': 'UserFormatStat',
  '2': [
    {'1': 'format', '3': 1, '4': 1, '5': 9, '10': 'format'},
    {'1': 'count', '3': 2, '4': 1, '5': 5, '10': 'count'},
    {'1': 'mean_score', '3': 3, '4': 1, '5': 1, '10': 'meanScore'},
    {'1': 'minutes_watched', '3': 4, '4': 1, '5': 5, '10': 'minutesWatched'},
    {'1': 'chapters_read', '3': 5, '4': 1, '5': 5, '10': 'chaptersRead'},
    {'1': 'media_ids', '3': 6, '4': 3, '5': 5, '10': 'mediaIds'},
  ],
};

/// Descriptor for `UserFormatStat`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userFormatStatDescriptor = $convert.base64Decode(
    'Cg5Vc2VyRm9ybWF0U3RhdBIWCgZmb3JtYXQYASABKAlSBmZvcm1hdBIUCgVjb3VudBgCIAEoBV'
    'IFY291bnQSHQoKbWVhbl9zY29yZRgDIAEoAVIJbWVhblNjb3JlEicKD21pbnV0ZXNfd2F0Y2hl'
    'ZBgEIAEoBVIObWludXRlc1dhdGNoZWQSIwoNY2hhcHRlcnNfcmVhZBgFIAEoBVIMY2hhcHRlcn'
    'NSZWFkEhsKCW1lZGlhX2lkcxgGIAMoBVIIbWVkaWFJZHM=');

@$core.Deprecated('Use userReleaseYearStatDescriptor instead')
const UserReleaseYearStat$json = {
  '1': 'UserReleaseYearStat',
  '2': [
    {'1': 'release_year', '3': 1, '4': 1, '5': 5, '10': 'releaseYear'},
    {'1': 'count', '3': 2, '4': 1, '5': 5, '10': 'count'},
    {'1': 'mean_score', '3': 3, '4': 1, '5': 1, '10': 'meanScore'},
    {'1': 'minutes_watched', '3': 4, '4': 1, '5': 5, '10': 'minutesWatched'},
    {'1': 'chapters_read', '3': 5, '4': 1, '5': 5, '10': 'chaptersRead'},
    {'1': 'media_ids', '3': 6, '4': 3, '5': 5, '10': 'mediaIds'},
  ],
};

/// Descriptor for `UserReleaseYearStat`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userReleaseYearStatDescriptor = $convert.base64Decode(
    'ChNVc2VyUmVsZWFzZVllYXJTdGF0EiEKDHJlbGVhc2VfeWVhchgBIAEoBVILcmVsZWFzZVllYX'
    'ISFAoFY291bnQYAiABKAVSBWNvdW50Eh0KCm1lYW5fc2NvcmUYAyABKAFSCW1lYW5TY29yZRIn'
    'Cg9taW51dGVzX3dhdGNoZWQYBCABKAVSDm1pbnV0ZXNXYXRjaGVkEiMKDWNoYXB0ZXJzX3JlYW'
    'QYBSABKAVSDGNoYXB0ZXJzUmVhZBIbCgltZWRpYV9pZHMYBiADKAVSCG1lZGlhSWRz');

@$core.Deprecated('Use userMediaStatisticsDescriptor instead')
const UserMediaStatistics$json = {
  '1': 'UserMediaStatistics',
  '2': [
    {'1': 'count', '3': 1, '4': 1, '5': 5, '10': 'count'},
    {'1': 'mean_score', '3': 2, '4': 1, '5': 1, '10': 'meanScore'},
    {
      '1': 'standard_deviation',
      '3': 3,
      '4': 1,
      '5': 1,
      '10': 'standardDeviation'
    },
    {'1': 'minutes_watched', '3': 4, '4': 1, '5': 5, '10': 'minutesWatched'},
    {'1': 'episodes_watched', '3': 5, '4': 1, '5': 5, '10': 'episodesWatched'},
    {'1': 'chapters_read', '3': 6, '4': 1, '5': 5, '10': 'chaptersRead'},
    {'1': 'volumes_read', '3': 7, '4': 1, '5': 5, '10': 'volumesRead'},
    {
      '1': 'scores',
      '3': 8,
      '4': 3,
      '5': 11,
      '6': '.goodanime.UserScoreStat',
      '10': 'scores'
    },
    {
      '1': 'lengths',
      '3': 9,
      '4': 3,
      '5': 11,
      '6': '.goodanime.UserLengthStat',
      '10': 'lengths'
    },
    {
      '1': 'statuses',
      '3': 10,
      '4': 3,
      '5': 11,
      '6': '.goodanime.UserStatusStat',
      '10': 'statuses'
    },
    {
      '1': 'formats',
      '3': 11,
      '4': 3,
      '5': 11,
      '6': '.goodanime.UserFormatStat',
      '10': 'formats'
    },
    {
      '1': 'release_years',
      '3': 12,
      '4': 3,
      '5': 11,
      '6': '.goodanime.UserReleaseYearStat',
      '10': 'releaseYears'
    },
  ],
};

/// Descriptor for `UserMediaStatistics`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userMediaStatisticsDescriptor = $convert.base64Decode(
    'ChNVc2VyTWVkaWFTdGF0aXN0aWNzEhQKBWNvdW50GAEgASgFUgVjb3VudBIdCgptZWFuX3Njb3'
    'JlGAIgASgBUgltZWFuU2NvcmUSLQoSc3RhbmRhcmRfZGV2aWF0aW9uGAMgASgBUhFzdGFuZGFy'
    'ZERldmlhdGlvbhInCg9taW51dGVzX3dhdGNoZWQYBCABKAVSDm1pbnV0ZXNXYXRjaGVkEikKEG'
    'VwaXNvZGVzX3dhdGNoZWQYBSABKAVSD2VwaXNvZGVzV2F0Y2hlZBIjCg1jaGFwdGVyc19yZWFk'
    'GAYgASgFUgxjaGFwdGVyc1JlYWQSIQoMdm9sdW1lc19yZWFkGAcgASgFUgt2b2x1bWVzUmVhZB'
    'IwCgZzY29yZXMYCCADKAsyGC5nb29kYW5pbWUuVXNlclNjb3JlU3RhdFIGc2NvcmVzEjMKB2xl'
    'bmd0aHMYCSADKAsyGS5nb29kYW5pbWUuVXNlckxlbmd0aFN0YXRSB2xlbmd0aHMSNQoIc3RhdH'
    'VzZXMYCiADKAsyGS5nb29kYW5pbWUuVXNlclN0YXR1c1N0YXRSCHN0YXR1c2VzEjMKB2Zvcm1h'
    'dHMYCyADKAsyGS5nb29kYW5pbWUuVXNlckZvcm1hdFN0YXRSB2Zvcm1hdHMSQwoNcmVsZWFzZV'
    '95ZWFycxgMIAMoCzIeLmdvb2RhbmltZS5Vc2VyUmVsZWFzZVllYXJTdGF0UgxyZWxlYXNlWWVh'
    'cnM=');

@$core.Deprecated('Use userStatisticsDescriptor instead')
const UserStatistics$json = {
  '1': 'UserStatistics',
  '2': [
    {
      '1': 'anime',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.goodanime.UserMediaStatistics',
      '10': 'anime'
    },
    {
      '1': 'manga',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.goodanime.UserMediaStatistics',
      '10': 'manga'
    },
  ],
};

/// Descriptor for `UserStatistics`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userStatisticsDescriptor = $convert.base64Decode(
    'Cg5Vc2VyU3RhdGlzdGljcxI0CgVhbmltZRgBIAEoCzIeLmdvb2RhbmltZS5Vc2VyTWVkaWFTdG'
    'F0aXN0aWNzUgVhbmltZRI0CgVtYW5nYRgCIAEoCzIeLmdvb2RhbmltZS5Vc2VyTWVkaWFTdGF0'
    'aXN0aWNzUgVtYW5nYQ==');
