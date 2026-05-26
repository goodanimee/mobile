// This is a generated file - do not edit.
//
// Generated from media_trend.proto.

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

@$core.Deprecated('Use mediaTrendDescriptor instead')
const MediaTrend$json = {
  '1': 'MediaTrend',
  '2': [
    {'1': 'average_score', '3': 1, '4': 1, '5': 5, '10': 'averageScore'},
    {'1': 'date', '3': 2, '4': 1, '5': 5, '10': 'date'},
    {'1': 'in_progress', '3': 3, '4': 1, '5': 5, '10': 'inProgress'},
    {'1': 'popularity', '3': 4, '4': 1, '5': 5, '10': 'popularity'},
  ],
};

/// Descriptor for `MediaTrend`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mediaTrendDescriptor = $convert.base64Decode(
    'CgpNZWRpYVRyZW5kEiMKDWF2ZXJhZ2Vfc2NvcmUYASABKAVSDGF2ZXJhZ2VTY29yZRISCgRkYX'
    'RlGAIgASgFUgRkYXRlEh8KC2luX3Byb2dyZXNzGAMgASgFUgppblByb2dyZXNzEh4KCnBvcHVs'
    'YXJpdHkYBCABKAVSCnBvcHVsYXJpdHk=');

@$core.Deprecated('Use mediaTrendConnectionDescriptor instead')
const MediaTrendConnection$json = {
  '1': 'MediaTrendConnection',
  '2': [
    {
      '1': 'nodes',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.goodanime.MediaTrend',
      '10': 'nodes'
    },
  ],
};

/// Descriptor for `MediaTrendConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mediaTrendConnectionDescriptor = $convert.base64Decode(
    'ChRNZWRpYVRyZW5kQ29ubmVjdGlvbhIrCgVub2RlcxgBIAMoCzIVLmdvb2RhbmltZS5NZWRpYV'
    'RyZW5kUgVub2Rlcw==');
