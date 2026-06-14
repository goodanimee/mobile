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

@$core.Deprecated('Use studioMinDescriptor instead')
const StudioMin$json = {
  '1': 'StudioMin',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `StudioMin`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List studioMinDescriptor = $convert.base64Decode(
    'CglTdHVkaW9NaW4SDgoCaWQYASABKAVSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWU=');

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
      '6': '.goodanime.StudioMin',
      '10': 'node'
    },
  ],
};

/// Descriptor for `StudioEdge`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List studioEdgeDescriptor = $convert.base64Decode(
    'CgpTdHVkaW9FZGdlEhcKB2lzX21haW4YASABKAhSBmlzTWFpbhIoCgRub2RlGAIgASgLMhQuZ2'
    '9vZGFuaW1lLlN0dWRpb01pblIEbm9kZQ==');

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

@$core.Deprecated('Use studioDescriptor instead')
const Studio$json = {
  '1': 'Studio',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'favourites',
      '3': 3,
      '4': 1,
      '5': 5,
      '9': 0,
      '10': 'favourites',
      '17': true
    },
    {
      '1': 'is_favourite',
      '3': 4,
      '4': 1,
      '5': 8,
      '9': 1,
      '10': 'isFavourite',
      '17': true
    },
    {
      '1': 'media',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.goodanime.StudioMediaConnection',
      '10': 'media'
    },
  ],
  '8': [
    {'1': '_favourites'},
    {'1': '_is_favourite'},
  ],
};

/// Descriptor for `Studio`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List studioDescriptor = $convert.base64Decode(
    'CgZTdHVkaW8SDgoCaWQYASABKAVSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSIwoKZmF2b3VyaX'
    'RlcxgDIAEoBUgAUgpmYXZvdXJpdGVziAEBEiYKDGlzX2Zhdm91cml0ZRgEIAEoCEgBUgtpc0Zh'
    'dm91cml0ZYgBARI2CgVtZWRpYRgFIAEoCzIgLmdvb2RhbmltZS5TdHVkaW9NZWRpYUNvbm5lY3'
    'Rpb25SBW1lZGlhQg0KC19mYXZvdXJpdGVzQg8KDV9pc19mYXZvdXJpdGU=');

@$core.Deprecated('Use studioMediaConnectionDescriptor instead')
const StudioMediaConnection$json = {
  '1': 'StudioMediaConnection',
  '2': [
    {
      '1': 'page_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.goodanime.PageInfo',
      '10': 'pageInfo'
    },
    {
      '1': 'nodes',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.goodanime.MediaMin',
      '10': 'nodes'
    },
  ],
};

/// Descriptor for `StudioMediaConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List studioMediaConnectionDescriptor = $convert.base64Decode(
    'ChVTdHVkaW9NZWRpYUNvbm5lY3Rpb24SMAoJcGFnZV9pbmZvGAEgASgLMhMuZ29vZGFuaW1lLl'
    'BhZ2VJbmZvUghwYWdlSW5mbxIpCgVub2RlcxgCIAMoCzITLmdvb2RhbmltZS5NZWRpYU1pblIF'
    'bm9kZXM=');
