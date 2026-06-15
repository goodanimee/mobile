// This is a generated file - do not edit.
//
// Generated from media_staff.proto.

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

@$core.Deprecated('Use staffNameDescriptor instead')
const StaffName$json = {
  '1': 'StaffName',
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
  ],
  '8': [
    {'1': '_native'},
    {'1': '_user_preferred'},
  ],
};

/// Descriptor for `StaffName`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List staffNameDescriptor = $convert.base64Decode(
    'CglTdGFmZk5hbWUSEgoEZnVsbBgBIAEoCVIEZnVsbBIbCgZuYXRpdmUYAiABKAlIAFIGbmF0aX'
    'ZliAEBEioKDnVzZXJfcHJlZmVycmVkGAMgASgJSAFSDXVzZXJQcmVmZXJyZWSIAQFCCQoHX25h'
    'dGl2ZUIRCg9fdXNlcl9wcmVmZXJyZWQ=');

@$core.Deprecated('Use staffImageDescriptor instead')
const StaffImage$json = {
  '1': 'StaffImage',
  '2': [
    {'1': 'large', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'large', '17': true},
    {'1': 'medium', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'medium', '17': true},
  ],
  '8': [
    {'1': '_large'},
    {'1': '_medium'},
  ],
};

/// Descriptor for `StaffImage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List staffImageDescriptor = $convert.base64Decode(
    'CgpTdGFmZkltYWdlEhkKBWxhcmdlGAEgASgJSABSBWxhcmdliAEBEhsKBm1lZGl1bRgCIAEoCU'
    'gBUgZtZWRpdW2IAQFCCAoGX2xhcmdlQgkKB19tZWRpdW0=');

@$core.Deprecated('Use staffMinDescriptor instead')
const StaffMin$json = {
  '1': 'StaffMin',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {
      '1': 'name',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.goodanime.StaffName',
      '10': 'name'
    },
    {
      '1': 'image',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.goodanime.StaffImage',
      '10': 'image'
    },
    {
      '1': 'language_v2',
      '3': 4,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'languageV2',
      '17': true
    },
  ],
  '8': [
    {'1': '_language_v2'},
  ],
};

/// Descriptor for `StaffMin`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List staffMinDescriptor = $convert.base64Decode(
    'CghTdGFmZk1pbhIOCgJpZBgBIAEoBVICaWQSKAoEbmFtZRgCIAEoCzIULmdvb2RhbmltZS5TdG'
    'FmZk5hbWVSBG5hbWUSKwoFaW1hZ2UYAyABKAsyFS5nb29kYW5pbWUuU3RhZmZJbWFnZVIFaW1h'
    'Z2USJAoLbGFuZ3VhZ2VfdjIYBCABKAlIAFIKbGFuZ3VhZ2VWMogBAUIOCgxfbGFuZ3VhZ2Vfdj'
    'I=');

@$core.Deprecated('Use staffEdgeDescriptor instead')
const StaffEdge$json = {
  '1': 'StaffEdge',
  '2': [
    {'1': 'role', '3': 1, '4': 1, '5': 9, '10': 'role'},
    {
      '1': 'node',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.goodanime.StaffMin',
      '10': 'node'
    },
  ],
};

/// Descriptor for `StaffEdge`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List staffEdgeDescriptor = $convert.base64Decode(
    'CglTdGFmZkVkZ2USEgoEcm9sZRgBIAEoCVIEcm9sZRInCgRub2RlGAIgASgLMhMuZ29vZGFuaW'
    '1lLlN0YWZmTWluUgRub2Rl');

@$core.Deprecated('Use staffConnectionDescriptor instead')
const StaffConnection$json = {
  '1': 'StaffConnection',
  '2': [
    {
      '1': 'edges',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.goodanime.StaffEdge',
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

/// Descriptor for `StaffConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List staffConnectionDescriptor = $convert.base64Decode(
    'Cg9TdGFmZkNvbm5lY3Rpb24SKgoFZWRnZXMYASADKAsyFC5nb29kYW5pbWUuU3RhZmZFZGdlUg'
    'VlZGdlcxIwCglwYWdlX2luZm8YAiABKAsyEy5nb29kYW5pbWUuUGFnZUluZm9SCHBhZ2VJbmZv');

@$core.Deprecated('Use staffCharacterNameDescriptor instead')
const StaffCharacterName$json = {
  '1': 'StaffCharacterName',
  '2': [
    {
      '1': 'user_preferred',
      '3': 1,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'userPreferred',
      '17': true
    },
  ],
  '8': [
    {'1': '_user_preferred'},
  ],
};

/// Descriptor for `StaffCharacterName`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List staffCharacterNameDescriptor = $convert.base64Decode(
    'ChJTdGFmZkNoYXJhY3Rlck5hbWUSKgoOdXNlcl9wcmVmZXJyZWQYASABKAlIAFINdXNlclByZW'
    'ZlcnJlZIgBAUIRCg9fdXNlcl9wcmVmZXJyZWQ=');

@$core.Deprecated('Use staffCharacterImageDescriptor instead')
const StaffCharacterImage$json = {
  '1': 'StaffCharacterImage',
  '2': [
    {'1': 'large', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'large', '17': true},
    {'1': 'medium', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'medium', '17': true},
  ],
  '8': [
    {'1': '_large'},
    {'1': '_medium'},
  ],
};

/// Descriptor for `StaffCharacterImage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List staffCharacterImageDescriptor = $convert.base64Decode(
    'ChNTdGFmZkNoYXJhY3RlckltYWdlEhkKBWxhcmdlGAEgASgJSABSBWxhcmdliAEBEhsKBm1lZG'
    'l1bRgCIAEoCUgBUgZtZWRpdW2IAQFCCAoGX2xhcmdlQgkKB19tZWRpdW0=');

@$core.Deprecated('Use staffCharacterDescriptor instead')
const StaffCharacter$json = {
  '1': 'StaffCharacter',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {
      '1': 'name',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.goodanime.StaffCharacterName',
      '9': 0,
      '10': 'name',
      '17': true
    },
    {
      '1': 'image',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.goodanime.StaffCharacterImage',
      '9': 1,
      '10': 'image',
      '17': true
    },
  ],
  '8': [
    {'1': '_name'},
    {'1': '_image'},
  ],
};

/// Descriptor for `StaffCharacter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List staffCharacterDescriptor = $convert.base64Decode(
    'Cg5TdGFmZkNoYXJhY3RlchIOCgJpZBgBIAEoBVICaWQSNgoEbmFtZRgCIAEoCzIdLmdvb2Rhbm'
    'ltZS5TdGFmZkNoYXJhY3Rlck5hbWVIAFIEbmFtZYgBARI5CgVpbWFnZRgDIAEoCzIeLmdvb2Rh'
    'bmltZS5TdGFmZkNoYXJhY3RlckltYWdlSAFSBWltYWdliAEBQgcKBV9uYW1lQggKBl9pbWFnZQ'
    '==');

@$core.Deprecated('Use staffCharacterMediaEdgeDescriptor instead')
const StaffCharacterMediaEdge$json = {
  '1': 'StaffCharacterMediaEdge',
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
      '1': 'characters',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.goodanime.StaffCharacter',
      '10': 'characters'
    },
  ],
  '8': [
    {'1': '_character_role'},
  ],
};

/// Descriptor for `StaffCharacterMediaEdge`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List staffCharacterMediaEdgeDescriptor = $convert.base64Decode(
    'ChdTdGFmZkNoYXJhY3Rlck1lZGlhRWRnZRIqCg5jaGFyYWN0ZXJfcm9sZRgBIAEoCUgAUg1jaG'
    'FyYWN0ZXJSb2xliAEBEicKBG5vZGUYAiABKAsyEy5nb29kYW5pbWUuTWVkaWFNaW5SBG5vZGUS'
    'OQoKY2hhcmFjdGVycxgDIAMoCzIZLmdvb2RhbmltZS5TdGFmZkNoYXJhY3RlclIKY2hhcmFjdG'
    'Vyc0IRCg9fY2hhcmFjdGVyX3JvbGU=');

@$core.Deprecated('Use staffCharacterMediaConnectionDescriptor instead')
const StaffCharacterMediaConnection$json = {
  '1': 'StaffCharacterMediaConnection',
  '2': [
    {
      '1': 'edges',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.goodanime.StaffCharacterMediaEdge',
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

/// Descriptor for `StaffCharacterMediaConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List staffCharacterMediaConnectionDescriptor =
    $convert.base64Decode(
        'Ch1TdGFmZkNoYXJhY3Rlck1lZGlhQ29ubmVjdGlvbhI4CgVlZGdlcxgBIAMoCzIiLmdvb2Rhbm'
        'ltZS5TdGFmZkNoYXJhY3Rlck1lZGlhRWRnZVIFZWRnZXMSMAoJcGFnZV9pbmZvGAIgASgLMhMu'
        'Z29vZGFuaW1lLlBhZ2VJbmZvUghwYWdlSW5mbw==');

@$core.Deprecated('Use staffMediaEdgeDescriptor instead')
const StaffMediaEdge$json = {
  '1': 'StaffMediaEdge',
  '2': [
    {
      '1': 'staff_role',
      '3': 1,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'staffRole',
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
  ],
  '8': [
    {'1': '_staff_role'},
  ],
};

/// Descriptor for `StaffMediaEdge`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List staffMediaEdgeDescriptor = $convert.base64Decode(
    'Cg5TdGFmZk1lZGlhRWRnZRIiCgpzdGFmZl9yb2xlGAEgASgJSABSCXN0YWZmUm9sZYgBARInCg'
    'Rub2RlGAIgASgLMhMuZ29vZGFuaW1lLk1lZGlhTWluUgRub2RlQg0KC19zdGFmZl9yb2xl');

@$core.Deprecated('Use staffMediaConnectionDescriptor instead')
const StaffMediaConnection$json = {
  '1': 'StaffMediaConnection',
  '2': [
    {
      '1': 'edges',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.goodanime.StaffMediaEdge',
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

/// Descriptor for `StaffMediaConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List staffMediaConnectionDescriptor = $convert.base64Decode(
    'ChRTdGFmZk1lZGlhQ29ubmVjdGlvbhIvCgVlZGdlcxgBIAMoCzIZLmdvb2RhbmltZS5TdGFmZk'
    '1lZGlhRWRnZVIFZWRnZXMSMAoJcGFnZV9pbmZvGAIgASgLMhMuZ29vZGFuaW1lLlBhZ2VJbmZv'
    'UghwYWdlSW5mbw==');

@$core.Deprecated('Use staffDescriptor instead')
const Staff$json = {
  '1': 'Staff',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {
      '1': 'name',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.goodanime.StaffName',
      '10': 'name'
    },
    {
      '1': 'image',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.goodanime.StaffImage',
      '10': 'image'
    },
    {
      '1': 'description',
      '3': 4,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'description',
      '17': true
    },
    {
      '1': 'favourites',
      '3': 5,
      '4': 1,
      '5': 5,
      '9': 1,
      '10': 'favourites',
      '17': true
    },
    {
      '1': 'is_favourite',
      '3': 6,
      '4': 1,
      '5': 8,
      '9': 2,
      '10': 'isFavourite',
      '17': true
    },
    {'1': 'age', '3': 7, '4': 1, '5': 5, '9': 3, '10': 'age', '17': true},
    {'1': 'gender', '3': 8, '4': 1, '5': 9, '9': 4, '10': 'gender', '17': true},
    {'1': 'years_active', '3': 9, '4': 3, '5': 5, '10': 'yearsActive'},
    {
      '1': 'home_town',
      '3': 10,
      '4': 1,
      '5': 9,
      '9': 5,
      '10': 'homeTown',
      '17': true
    },
    {
      '1': 'blood_type',
      '3': 11,
      '4': 1,
      '5': 9,
      '9': 6,
      '10': 'bloodType',
      '17': true
    },
    {
      '1': 'primary_occupations',
      '3': 12,
      '4': 3,
      '5': 9,
      '10': 'primaryOccupations'
    },
    {
      '1': 'date_of_birth',
      '3': 13,
      '4': 1,
      '5': 11,
      '6': '.goodanime.FuzzyDate',
      '9': 7,
      '10': 'dateOfBirth',
      '17': true
    },
    {
      '1': 'date_of_death',
      '3': 14,
      '4': 1,
      '5': 11,
      '6': '.goodanime.FuzzyDate',
      '9': 8,
      '10': 'dateOfDeath',
      '17': true
    },
    {
      '1': 'language',
      '3': 15,
      '4': 1,
      '5': 9,
      '9': 9,
      '10': 'language',
      '17': true
    },
    {
      '1': 'character_media',
      '3': 16,
      '4': 1,
      '5': 11,
      '6': '.goodanime.StaffCharacterMediaConnection',
      '10': 'characterMedia'
    },
    {
      '1': 'staff_media',
      '3': 17,
      '4': 1,
      '5': 11,
      '6': '.goodanime.StaffMediaConnection',
      '10': 'staffMedia'
    },
  ],
  '8': [
    {'1': '_description'},
    {'1': '_favourites'},
    {'1': '_is_favourite'},
    {'1': '_age'},
    {'1': '_gender'},
    {'1': '_home_town'},
    {'1': '_blood_type'},
    {'1': '_date_of_birth'},
    {'1': '_date_of_death'},
    {'1': '_language'},
  ],
};

/// Descriptor for `Staff`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List staffDescriptor = $convert.base64Decode(
    'CgVTdGFmZhIOCgJpZBgBIAEoBVICaWQSKAoEbmFtZRgCIAEoCzIULmdvb2RhbmltZS5TdGFmZk'
    '5hbWVSBG5hbWUSKwoFaW1hZ2UYAyABKAsyFS5nb29kYW5pbWUuU3RhZmZJbWFnZVIFaW1hZ2US'
    'JQoLZGVzY3JpcHRpb24YBCABKAlIAFILZGVzY3JpcHRpb26IAQESIwoKZmF2b3VyaXRlcxgFIA'
    'EoBUgBUgpmYXZvdXJpdGVziAEBEiYKDGlzX2Zhdm91cml0ZRgGIAEoCEgCUgtpc0Zhdm91cml0'
    'ZYgBARIVCgNhZ2UYByABKAVIA1IDYWdliAEBEhsKBmdlbmRlchgIIAEoCUgEUgZnZW5kZXKIAQ'
    'ESIQoMeWVhcnNfYWN0aXZlGAkgAygFUgt5ZWFyc0FjdGl2ZRIgCglob21lX3Rvd24YCiABKAlI'
    'BVIIaG9tZVRvd26IAQESIgoKYmxvb2RfdHlwZRgLIAEoCUgGUglibG9vZFR5cGWIAQESLwoTcH'
    'JpbWFyeV9vY2N1cGF0aW9ucxgMIAMoCVIScHJpbWFyeU9jY3VwYXRpb25zEj0KDWRhdGVfb2Zf'
    'YmlydGgYDSABKAsyFC5nb29kYW5pbWUuRnV6enlEYXRlSAdSC2RhdGVPZkJpcnRoiAEBEj0KDW'
    'RhdGVfb2ZfZGVhdGgYDiABKAsyFC5nb29kYW5pbWUuRnV6enlEYXRlSAhSC2RhdGVPZkRlYXRo'
    'iAEBEh8KCGxhbmd1YWdlGA8gASgJSAlSCGxhbmd1YWdliAEBElEKD2NoYXJhY3Rlcl9tZWRpYR'
    'gQIAEoCzIoLmdvb2RhbmltZS5TdGFmZkNoYXJhY3Rlck1lZGlhQ29ubmVjdGlvblIOY2hhcmFj'
    'dGVyTWVkaWESQAoLc3RhZmZfbWVkaWEYESABKAsyHy5nb29kYW5pbWUuU3RhZmZNZWRpYUNvbm'
    '5lY3Rpb25SCnN0YWZmTWVkaWFCDgoMX2Rlc2NyaXB0aW9uQg0KC19mYXZvdXJpdGVzQg8KDV9p'
    'c19mYXZvdXJpdGVCBgoEX2FnZUIJCgdfZ2VuZGVyQgwKCl9ob21lX3Rvd25CDQoLX2Jsb29kX3'
    'R5cGVCEAoOX2RhdGVfb2ZfYmlydGhCEAoOX2RhdGVfb2ZfZGVhdGhCCwoJX2xhbmd1YWdl');
