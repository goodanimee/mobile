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
