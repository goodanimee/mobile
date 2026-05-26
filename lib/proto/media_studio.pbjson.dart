// This is a generated file - do not edit.
//
// Generated from media_studio.proto.

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

@$core.Deprecated('Use studioDescriptor instead')
const Studio$json = {
  '1': 'Studio',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `Studio`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List studioDescriptor = $convert.base64Decode(
    'CgZTdHVkaW8SDgoCaWQYASABKAVSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWU=');

@$core.Deprecated('Use studioEdgeDescriptor instead')
const StudioEdge$json = {
  '1': 'StudioEdge',
  '2': [
    {'1': 'is_main', '3': 1, '4': 1, '5': 8, '10': 'isMain'},
    {
      '1': 'node',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.goodanime.Studio',
      '10': 'node'
    },
  ],
};

/// Descriptor for `StudioEdge`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List studioEdgeDescriptor = $convert.base64Decode(
    'CgpTdHVkaW9FZGdlEhcKB2lzX21haW4YASABKAhSBmlzTWFpbhIlCgRub2RlGAIgASgLMhEuZ2'
    '9vZGFuaW1lLlN0dWRpb1IEbm9kZQ==');

@$core.Deprecated('Use studioConnectionDescriptor instead')
const StudioConnection$json = {
  '1': 'StudioConnection',
  '2': [
    {
      '1': 'edges',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.goodanime.StudioEdge',
      '10': 'edges'
    },
  ],
};

/// Descriptor for `StudioConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List studioConnectionDescriptor = $convert.base64Decode(
    'ChBTdHVkaW9Db25uZWN0aW9uEisKBWVkZ2VzGAEgAygLMhUuZ29vZGFuaW1lLlN0dWRpb0VkZ2'
    'VSBWVkZ2Vz');
