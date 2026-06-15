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
