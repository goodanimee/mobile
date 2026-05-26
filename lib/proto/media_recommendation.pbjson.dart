// This is a generated file - do not edit.
//
// Generated from media_recommendation.proto.

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

@$core.Deprecated('Use recommendationDescriptor instead')
const Recommendation$json = {
  '1': 'Recommendation',
  '2': [
    {'1': 'rating', '3': 1, '4': 1, '5': 5, '10': 'rating'},
    {
      '1': 'media_recommendation',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.goodanime.MediaMin',
      '10': 'mediaRecommendation'
    },
  ],
};

/// Descriptor for `Recommendation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recommendationDescriptor = $convert.base64Decode(
    'Cg5SZWNvbW1lbmRhdGlvbhIWCgZyYXRpbmcYASABKAVSBnJhdGluZxJGChRtZWRpYV9yZWNvbW'
    '1lbmRhdGlvbhgCIAEoCzITLmdvb2RhbmltZS5NZWRpYU1pblITbWVkaWFSZWNvbW1lbmRhdGlv'
    'bg==');

@$core.Deprecated('Use recommendationEdgeDescriptor instead')
const RecommendationEdge$json = {
  '1': 'RecommendationEdge',
  '2': [
    {
      '1': 'node',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.goodanime.Recommendation',
      '10': 'node'
    },
  ],
};

/// Descriptor for `RecommendationEdge`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recommendationEdgeDescriptor = $convert.base64Decode(
    'ChJSZWNvbW1lbmRhdGlvbkVkZ2USLQoEbm9kZRgBIAEoCzIZLmdvb2RhbmltZS5SZWNvbW1lbm'
    'RhdGlvblIEbm9kZQ==');

@$core.Deprecated('Use recommendationConnectionDescriptor instead')
const RecommendationConnection$json = {
  '1': 'RecommendationConnection',
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
      '1': 'edges',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.goodanime.RecommendationEdge',
      '10': 'edges'
    },
  ],
};

/// Descriptor for `RecommendationConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recommendationConnectionDescriptor = $convert.base64Decode(
    'ChhSZWNvbW1lbmRhdGlvbkNvbm5lY3Rpb24SMAoJcGFnZV9pbmZvGAEgASgLMhMuZ29vZGFuaW'
    '1lLlBhZ2VJbmZvUghwYWdlSW5mbxIzCgVlZGdlcxgCIAMoCzIdLmdvb2RhbmltZS5SZWNvbW1l'
    'bmRhdGlvbkVkZ2VSBWVkZ2Vz');
