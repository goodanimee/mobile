// This is a generated file - do not edit.
//
// Generated from viewer.proto.

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

@$core.Deprecated('Use viewerAvatarDescriptor instead')
const ViewerAvatar$json = {
  '1': 'ViewerAvatar',
  '2': [
    {'1': 'medium', '3': 1, '4': 1, '5': 9, '10': 'medium'},
  ],
};

/// Descriptor for `ViewerAvatar`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List viewerAvatarDescriptor = $convert
    .base64Decode('CgxWaWV3ZXJBdmF0YXISFgoGbWVkaXVtGAEgASgJUgZtZWRpdW0=');

@$core.Deprecated('Use viewerDescriptor instead')
const Viewer$json = {
  '1': 'Viewer',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'created_at', '3': 3, '4': 1, '5': 5, '10': 'createdAt'},
    {
      '1': 'avatar',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.goodanime.ViewerAvatar',
      '10': 'avatar'
    },
  ],
};

/// Descriptor for `Viewer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List viewerDescriptor = $convert.base64Decode(
    'CgZWaWV3ZXISDgoCaWQYASABKAVSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSHQoKY3JlYXRlZF'
    '9hdBgDIAEoBVIJY3JlYXRlZEF0Ei8KBmF2YXRhchgEIAEoCzIXLmdvb2RhbmltZS5WaWV3ZXJB'
    'dmF0YXJSBmF2YXRhcg==');
