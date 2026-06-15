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
  ],
  '8': [
    {'1': '_gender'},
    {'1': '_age'},
    {'1': '_description'},
  ],
};

/// Descriptor for `Character`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List characterDescriptor = $convert.base64Decode(
    'CglDaGFyYWN0ZXISLAoEbmFtZRgBIAEoCzIYLmdvb2RhbmltZS5DaGFyYWN0ZXJOYW1lUgRuYW'
    '1lEi8KBWltYWdlGAIgASgLMhkuZ29vZGFuaW1lLkNoYXJhY3RlckltYWdlUgVpbWFnZRIbCgZn'
    'ZW5kZXIYAyABKAlIAFIGZ2VuZGVyiAEBEhUKA2FnZRgEIAEoCUgBUgNhZ2WIAQESOAoNZGF0ZV'
    '9vZl9iaXJ0aBgFIAEoCzIULmdvb2RhbmltZS5GdXp6eURhdGVSC2RhdGVPZkJpcnRoEiUKC2Rl'
    'c2NyaXB0aW9uGAYgASgJSAJSC2Rlc2NyaXB0aW9uiAEBQgkKB19nZW5kZXJCBgoEX2FnZUIOCg'
    'xfZGVzY3JpcHRpb24=');

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
      '6': '.goodanime.Character',
      '10': 'node'
    },
    {
      '1': 'voice_actors',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.goodanime.StaffMin',
      '10': 'voiceActors'
    },
  ],
};

/// Descriptor for `CharacterEdge`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List characterEdgeDescriptor = $convert.base64Decode(
    'Cg1DaGFyYWN0ZXJFZGdlEg4KAmlkGAEgASgFUgJpZBISCgRyb2xlGAIgASgJUgRyb2xlEhIKBG'
    '5hbWUYAyABKAlSBG5hbWUSKAoEbm9kZRgEIAEoCzIULmdvb2RhbmltZS5DaGFyYWN0ZXJSBG5v'
    'ZGUSNgoMdm9pY2VfYWN0b3JzGAUgAygLMhMuZ29vZGFuaW1lLlN0YWZmTWluUgt2b2ljZUFjdG'
    '9ycw==');

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
