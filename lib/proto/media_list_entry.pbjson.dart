// This is a generated file - do not edit.
//
// Generated from media_list_entry.proto.

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

@$core.Deprecated('Use mediaListEntryDescriptor instead')
const MediaListEntry$json = {
  '1': 'MediaListEntry',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
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
    {'1': 'progress', '3': 3, '4': 1, '5': 5, '10': 'progress'},
    {'1': 'score', '3': 4, '4': 1, '5': 1, '10': 'score'},
    {'1': 'repeat', '3': 5, '4': 1, '5': 5, '10': 'repeat'},
    {
      '1': 'started_at',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.goodanime.FuzzyDate',
      '10': 'startedAt'
    },
    {
      '1': 'completed_at',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.goodanime.FuzzyDate',
      '10': 'completedAt'
    },
    {'1': 'progress_volumes', '3': 8, '4': 1, '5': 5, '10': 'progressVolumes'},
  ],
  '8': [
    {'1': '_status'},
  ],
};

/// Descriptor for `MediaListEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mediaListEntryDescriptor = $convert.base64Decode(
    'Cg5NZWRpYUxpc3RFbnRyeRIOCgJpZBgBIAEoBVICaWQSNwoGc3RhdHVzGAIgASgOMhouZ29vZG'
    'FuaW1lLk1lZGlhTGlzdFN0YXR1c0gAUgZzdGF0dXOIAQESGgoIcHJvZ3Jlc3MYAyABKAVSCHBy'
    'b2dyZXNzEhQKBXNjb3JlGAQgASgBUgVzY29yZRIWCgZyZXBlYXQYBSABKAVSBnJlcGVhdBIzCg'
    'pzdGFydGVkX2F0GAYgASgLMhQuZ29vZGFuaW1lLkZ1enp5RGF0ZVIJc3RhcnRlZEF0EjcKDGNv'
    'bXBsZXRlZF9hdBgHIAEoCzIULmdvb2RhbmltZS5GdXp6eURhdGVSC2NvbXBsZXRlZEF0EikKEH'
    'Byb2dyZXNzX3ZvbHVtZXMYCCABKAVSD3Byb2dyZXNzVm9sdW1lc0IJCgdfc3RhdHVz');
