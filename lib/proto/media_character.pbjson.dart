// This is a generated file - do not edit.
//
// Generated from media_character.proto.

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

@$core.Deprecated('Use characterNameDescriptor instead')
const CharacterName$json = {
  '1': 'CharacterName',
  '2': [
    {'1': 'full', '3': 1, '4': 1, '5': 9, '10': 'full'},
    {'1': 'native', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'native', '17': true},
    {
      '1': 'user_preferred',
      '3': 3,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'userPreferred',
      '17': true
    },
    {'1': 'alternative', '3': 4, '4': 3, '5': 9, '10': 'alternative'},
    {
      '1': 'alternative_spoiler',
      '3': 5,
      '4': 3,
      '5': 9,
      '10': 'alternativeSpoiler'
    },
  ],
  '8': [
    {'1': '_native'},
    {'1': '_user_preferred'},
  ],
};

/// Descriptor for `CharacterName`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List characterNameDescriptor = $convert.base64Decode(
    'Cg1DaGFyYWN0ZXJOYW1lEhIKBGZ1bGwYASABKAlSBGZ1bGwSGwoGbmF0aXZlGAIgASgJSABSBm'
    '5hdGl2ZYgBARIqCg51c2VyX3ByZWZlcnJlZBgDIAEoCUgBUg11c2VyUHJlZmVycmVkiAEBEiAK'
    'C2FsdGVybmF0aXZlGAQgAygJUgthbHRlcm5hdGl2ZRIvChNhbHRlcm5hdGl2ZV9zcG9pbGVyGA'
    'UgAygJUhJhbHRlcm5hdGl2ZVNwb2lsZXJCCQoHX25hdGl2ZUIRCg9fdXNlcl9wcmVmZXJyZWQ=');

@$core.Deprecated('Use characterImageDescriptor instead')
const CharacterImage$json = {
  '1': 'CharacterImage',
  '2': [
    {'1': 'large', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'large', '17': true},
    {'1': 'medium', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'medium', '17': true},
  ],
  '8': [
    {'1': '_large'},
    {'1': '_medium'},
  ],
};

/// Descriptor for `CharacterImage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List characterImageDescriptor = $convert.base64Decode(
    'Cg5DaGFyYWN0ZXJJbWFnZRIZCgVsYXJnZRgBIAEoCUgAUgVsYXJnZYgBARIbCgZtZWRpdW0YAi'
    'ABKAlIAVIGbWVkaXVtiAEBQggKBl9sYXJnZUIJCgdfbWVkaXVt');

@$core.Deprecated('Use characterMinDescriptor instead')
const CharacterMin$json = {
  '1': 'CharacterMin',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {
      '1': 'name',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.goodanime.CharacterName',
      '10': 'name'
    },
    {
      '1': 'image',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.goodanime.CharacterImage',
      '10': 'image'
    },
  ],
};

/// Descriptor for `CharacterMin`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List characterMinDescriptor = $convert.base64Decode(
    'CgxDaGFyYWN0ZXJNaW4SDgoCaWQYASABKAVSAmlkEiwKBG5hbWUYAiABKAsyGC5nb29kYW5pbW'
    'UuQ2hhcmFjdGVyTmFtZVIEbmFtZRIvCgVpbWFnZRgDIAEoCzIZLmdvb2RhbmltZS5DaGFyYWN0'
    'ZXJJbWFnZVIFaW1hZ2U=');

@$core.Deprecated('Use characterMediaEdgeDescriptor instead')
const CharacterMediaEdge$json = {
  '1': 'CharacterMediaEdge',
  '2': [
    {
      '1': 'character_role',
      '3': 1,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'characterRole',
      '17': true
    },
    {
      '1': 'node',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.goodanime.MediaMin',
      '10': 'node'
    },
    {
      '1': 'voice_actors',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.goodanime.StaffMin',
      '10': 'voiceActors'
    },
  ],
  '8': [
    {'1': '_character_role'},
  ],
};

/// Descriptor for `CharacterMediaEdge`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List characterMediaEdgeDescriptor = $convert.base64Decode(
    'ChJDaGFyYWN0ZXJNZWRpYUVkZ2USKgoOY2hhcmFjdGVyX3JvbGUYASABKAlIAFINY2hhcmFjdG'
    'VyUm9sZYgBARInCgRub2RlGAIgASgLMhMuZ29vZGFuaW1lLk1lZGlhTWluUgRub2RlEjYKDHZv'
    'aWNlX2FjdG9ycxgDIAMoCzITLmdvb2RhbmltZS5TdGFmZk1pblILdm9pY2VBY3RvcnNCEQoPX2'
    'NoYXJhY3Rlcl9yb2xl');

@$core.Deprecated('Use characterMediaConnectionDescriptor instead')
const CharacterMediaConnection$json = {
  '1': 'CharacterMediaConnection',
  '2': [
    {
      '1': 'edges',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.goodanime.CharacterMediaEdge',
      '10': 'edges'
    },
    {
      '1': 'page_info',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.goodanime.PageInfo',
      '10': 'pageInfo'
    },
  ],
};

/// Descriptor for `CharacterMediaConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List characterMediaConnectionDescriptor = $convert.base64Decode(
    'ChhDaGFyYWN0ZXJNZWRpYUNvbm5lY3Rpb24SMwoFZWRnZXMYASADKAsyHS5nb29kYW5pbWUuQ2'
    'hhcmFjdGVyTWVkaWFFZGdlUgVlZGdlcxIwCglwYWdlX2luZm8YAiABKAsyEy5nb29kYW5pbWUu'
    'UGFnZUluZm9SCHBhZ2VJbmZv');

@$core.Deprecated('Use characterDescriptor instead')
const Character$json = {
  '1': 'Character',
  '2': [
    {
      '1': 'name',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.goodanime.CharacterName',
      '10': 'name'
    },
    {
      '1': 'image',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.goodanime.CharacterImage',
      '10': 'image'
    },
    {'1': 'gender', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'gender', '17': true},
    {'1': 'age', '3': 4, '4': 1, '5': 9, '9': 1, '10': 'age', '17': true},
    {
      '1': 'date_of_birth',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.goodanime.FuzzyDate',
      '10': 'dateOfBirth'
    },
    {
      '1': 'description',
      '3': 6,
      '4': 1,
      '5': 9,
      '9': 2,
      '10': 'description',
      '17': true
    },
    {'1': 'id', '3': 7, '4': 1, '5': 5, '9': 3, '10': 'id', '17': true},
    {
      '1': 'blood_type',
      '3': 8,
      '4': 1,
      '5': 9,
      '9': 4,
      '10': 'bloodType',
      '17': true
    },
    {
      '1': 'favourites',
      '3': 9,
      '4': 1,
      '5': 5,
      '9': 5,
      '10': 'favourites',
      '17': true
    },
    {
      '1': 'is_favourite',
      '3': 10,
      '4': 1,
      '5': 8,
      '9': 6,
      '10': 'isFavourite',
      '17': true
    },
    {
      '1': 'site_url',
      '3': 11,
      '4': 1,
      '5': 9,
      '9': 7,
      '10': 'siteUrl',
      '17': true
    },
    {
      '1': 'media',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.goodanime.CharacterMediaConnection',
      '10': 'media'
    },
    {
      '1': 'is_favourite_blocked',
      '3': 13,
      '4': 1,
      '5': 8,
      '9': 8,
      '10': 'isFavouriteBlocked',
      '17': true
    },
  ],
  '8': [
    {'1': '_gender'},
    {'1': '_age'},
    {'1': '_description'},
    {'1': '_id'},
    {'1': '_blood_type'},
    {'1': '_favourites'},
    {'1': '_is_favourite'},
    {'1': '_site_url'},
    {'1': '_is_favourite_blocked'},
  ],
};

/// Descriptor for `Character`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List characterDescriptor = $convert.base64Decode(
    'CglDaGFyYWN0ZXISLAoEbmFtZRgBIAEoCzIYLmdvb2RhbmltZS5DaGFyYWN0ZXJOYW1lUgRuYW'
    '1lEi8KBWltYWdlGAIgASgLMhkuZ29vZGFuaW1lLkNoYXJhY3RlckltYWdlUgVpbWFnZRIbCgZn'
    'ZW5kZXIYAyABKAlIAFIGZ2VuZGVyiAEBEhUKA2FnZRgEIAEoCUgBUgNhZ2WIAQESOAoNZGF0ZV'
    '9vZl9iaXJ0aBgFIAEoCzIULmdvb2RhbmltZS5GdXp6eURhdGVSC2RhdGVPZkJpcnRoEiUKC2Rl'
    'c2NyaXB0aW9uGAYgASgJSAJSC2Rlc2NyaXB0aW9uiAEBEhMKAmlkGAcgASgFSANSAmlkiAEBEi'
    'IKCmJsb29kX3R5cGUYCCABKAlIBFIJYmxvb2RUeXBliAEBEiMKCmZhdm91cml0ZXMYCSABKAVI'
    'BVIKZmF2b3VyaXRlc4gBARImCgxpc19mYXZvdXJpdGUYCiABKAhIBlILaXNGYXZvdXJpdGWIAQ'
    'ESHgoIc2l0ZV91cmwYCyABKAlIB1IHc2l0ZVVybIgBARI5CgVtZWRpYRgMIAEoCzIjLmdvb2Rh'
    'bmltZS5DaGFyYWN0ZXJNZWRpYUNvbm5lY3Rpb25SBW1lZGlhEjUKFGlzX2Zhdm91cml0ZV9ibG'
    '9ja2VkGA0gASgISAhSEmlzRmF2b3VyaXRlQmxvY2tlZIgBAUIJCgdfZ2VuZGVyQgYKBF9hZ2VC'
    'DgoMX2Rlc2NyaXB0aW9uQgUKA19pZEINCgtfYmxvb2RfdHlwZUINCgtfZmF2b3VyaXRlc0IPCg'
    '1faXNfZmF2b3VyaXRlQgsKCV9zaXRlX3VybEIXChVfaXNfZmF2b3VyaXRlX2Jsb2NrZWQ=');

@$core.Deprecated('Use characterEdgeDescriptor instead')
const CharacterEdge$json = {
  '1': 'CharacterEdge',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'role', '3': 2, '4': 1, '5': 9, '10': 'role'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'node',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.goodanime.CharacterMin',
      '10': 'node'
    },
  ],
};

/// Descriptor for `CharacterEdge`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List characterEdgeDescriptor = $convert.base64Decode(
    'Cg1DaGFyYWN0ZXJFZGdlEg4KAmlkGAEgASgFUgJpZBISCgRyb2xlGAIgASgJUgRyb2xlEhIKBG'
    '5hbWUYAyABKAlSBG5hbWUSKwoEbm9kZRgEIAEoCzIXLmdvb2RhbmltZS5DaGFyYWN0ZXJNaW5S'
    'BG5vZGU=');

@$core.Deprecated('Use characterConnectionDescriptor instead')
const CharacterConnection$json = {
  '1': 'CharacterConnection',
  '2': [
    {
      '1': 'edges',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.goodanime.CharacterEdge',
      '10': 'edges'
    },
    {
      '1': 'page_info',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.goodanime.PageInfo',
      '10': 'pageInfo'
    },
  ],
};

/// Descriptor for `CharacterConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List characterConnectionDescriptor = $convert.base64Decode(
    'ChNDaGFyYWN0ZXJDb25uZWN0aW9uEi4KBWVkZ2VzGAEgAygLMhguZ29vZGFuaW1lLkNoYXJhY3'
    'RlckVkZ2VSBWVkZ2VzEjAKCXBhZ2VfaW5mbxgCIAEoCzITLmdvb2RhbmltZS5QYWdlSW5mb1II'
    'cGFnZUluZm8=');
