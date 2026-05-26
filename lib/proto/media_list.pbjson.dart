// This is a generated file - do not edit.
//
// Generated from media_list.proto.

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

@$core.Deprecated('Use mediaListEntryWithMediaDescriptor instead')
const MediaListEntryWithMedia$json = {
  '1': 'MediaListEntryWithMedia',
  '2': [
    {
      '1': 'entry',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.goodanime.MediaListEntry',
      '10': 'entry'
    },
    {
      '1': 'media',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.goodanime.MediaMin',
      '10': 'media'
    },
  ],
};

/// Descriptor for `MediaListEntryWithMedia`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mediaListEntryWithMediaDescriptor = $convert.base64Decode(
    'ChdNZWRpYUxpc3RFbnRyeVdpdGhNZWRpYRIvCgVlbnRyeRgBIAEoCzIZLmdvb2RhbmltZS5NZW'
    'RpYUxpc3RFbnRyeVIFZW50cnkSKQoFbWVkaWEYAiABKAsyEy5nb29kYW5pbWUuTWVkaWFNaW5S'
    'BW1lZGlh');

@$core.Deprecated('Use mediaListGroupDescriptor instead')
const MediaListGroup$json = {
  '1': 'MediaListGroup',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'status',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.goodanime.MediaListStatus',
      '9': 0,
      '10': 'status',
      '17': true
    },
    {
      '1': 'entries',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.goodanime.MediaListEntryWithMedia',
      '10': 'entries'
    },
  ],
  '8': [
    {'1': '_status'},
  ],
};

/// Descriptor for `MediaListGroup`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mediaListGroupDescriptor = $convert.base64Decode(
    'Cg5NZWRpYUxpc3RHcm91cBISCgRuYW1lGAEgASgJUgRuYW1lEjcKBnN0YXR1cxgCIAEoDjIaLm'
    'dvb2RhbmltZS5NZWRpYUxpc3RTdGF0dXNIAFIGc3RhdHVziAEBEjwKB2VudHJpZXMYAyADKAsy'
    'Ii5nb29kYW5pbWUuTWVkaWFMaXN0RW50cnlXaXRoTWVkaWFSB2VudHJpZXNCCQoHX3N0YXR1cw'
    '==');

@$core.Deprecated('Use mediaListCollectionDescriptor instead')
const MediaListCollection$json = {
  '1': 'MediaListCollection',
  '2': [
    {'1': 'has_next_chunk', '3': 1, '4': 1, '5': 8, '10': 'hasNextChunk'},
    {
      '1': 'lists',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.goodanime.MediaListGroup',
      '10': 'lists'
    },
  ],
};

/// Descriptor for `MediaListCollection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mediaListCollectionDescriptor = $convert.base64Decode(
    'ChNNZWRpYUxpc3RDb2xsZWN0aW9uEiQKDmhhc19uZXh0X2NodW5rGAEgASgIUgxoYXNOZXh0Q2'
    'h1bmsSLwoFbGlzdHMYAiADKAsyGS5nb29kYW5pbWUuTWVkaWFMaXN0R3JvdXBSBWxpc3Rz');
