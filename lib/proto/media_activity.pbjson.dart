// This is a generated file - do not edit.
//
// Generated from media_activity.proto.

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

@$core.Deprecated('Use listActivityDescriptor instead')
const ListActivity$json = {
  '1': 'ListActivity',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'created_at', '3': 2, '4': 1, '5': 5, '10': 'createdAt'},
    {'1': 'is_liked', '3': 3, '4': 1, '5': 8, '10': 'isLiked'},
    {'1': 'like_count', '3': 4, '4': 1, '5': 5, '10': 'likeCount'},
    {'1': 'progress', '3': 5, '4': 1, '5': 9, '10': 'progress'},
    {'1': 'status', '3': 6, '4': 1, '5': 9, '10': 'status'},
    {
      '1': 'user',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.goodanime.Viewer',
      '10': 'user'
    },
  ],
};

/// Descriptor for `ListActivity`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listActivityDescriptor = $convert.base64Decode(
    'CgxMaXN0QWN0aXZpdHkSDgoCaWQYASABKAVSAmlkEh0KCmNyZWF0ZWRfYXQYAiABKAVSCWNyZW'
    'F0ZWRBdBIZCghpc19saWtlZBgDIAEoCFIHaXNMaWtlZBIdCgpsaWtlX2NvdW50GAQgASgFUgls'
    'aWtlQ291bnQSGgoIcHJvZ3Jlc3MYBSABKAlSCHByb2dyZXNzEhYKBnN0YXR1cxgGIAEoCVIGc3'
    'RhdHVzEiUKBHVzZXIYByABKAsyES5nb29kYW5pbWUuVmlld2VyUgR1c2Vy');
