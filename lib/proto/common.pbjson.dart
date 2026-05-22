// This is a generated file - do not edit.
//
// Generated from common.proto.

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

@$core.Deprecated('Use mediaListStatusDescriptor instead')
const MediaListStatus$json = {
  '1': 'MediaListStatus',
  '2': [
    {'1': 'MEDIA_LIST_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'MEDIA_LIST_STATUS_CURRENT', '2': 1},
    {'1': 'MEDIA_LIST_STATUS_PLANNING', '2': 2},
    {'1': 'MEDIA_LIST_STATUS_COMPLETED', '2': 3},
    {'1': 'MEDIA_LIST_STATUS_DROPPED', '2': 4},
    {'1': 'MEDIA_LIST_STATUS_PAUSED', '2': 5},
    {'1': 'MEDIA_LIST_STATUS_REPEATING', '2': 6},
  ],
};

/// Descriptor for `MediaListStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List mediaListStatusDescriptor = $convert.base64Decode(
    'Cg9NZWRpYUxpc3RTdGF0dXMSIQodTUVESUFfTElTVF9TVEFUVVNfVU5TUEVDSUZJRUQQABIdCh'
    'lNRURJQV9MSVNUX1NUQVRVU19DVVJSRU5UEAESHgoaTUVESUFfTElTVF9TVEFUVVNfUExBTk5J'
    'TkcQAhIfChtNRURJQV9MSVNUX1NUQVRVU19DT01QTEVURUQQAxIdChlNRURJQV9MSVNUX1NUQV'
    'RVU19EUk9QUEVEEAQSHAoYTUVESUFfTElTVF9TVEFUVVNfUEFVU0VEEAUSHwobTUVESUFfTElT'
    'VF9TVEFUVVNfUkVQRUFUSU5HEAY=');

@$core.Deprecated('Use fuzzyDateDescriptor instead')
const FuzzyDate$json = {
  '1': 'FuzzyDate',
  '2': [
    {'1': 'day', '3': 1, '4': 1, '5': 5, '9': 0, '10': 'day', '17': true},
    {'1': 'month', '3': 2, '4': 1, '5': 5, '9': 1, '10': 'month', '17': true},
    {'1': 'year', '3': 3, '4': 1, '5': 5, '9': 2, '10': 'year', '17': true},
  ],
  '8': [
    {'1': '_day'},
    {'1': '_month'},
    {'1': '_year'},
  ],
};

/// Descriptor for `FuzzyDate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fuzzyDateDescriptor = $convert.base64Decode(
    'CglGdXp6eURhdGUSFQoDZGF5GAEgASgFSABSA2RheYgBARIZCgVtb250aBgCIAEoBUgBUgVtb2'
    '50aIgBARIXCgR5ZWFyGAMgASgFSAJSBHllYXKIAQFCBgoEX2RheUIICgZfbW9udGhCBwoFX3ll'
    'YXI=');

@$core.Deprecated('Use pageInfoDescriptor instead')
const PageInfo$json = {
  '1': 'PageInfo',
  '2': [
    {'1': 'has_next_page', '3': 1, '4': 1, '5': 8, '10': 'hasNextPage'},
    {'1': 'current_page', '3': 2, '4': 1, '5': 5, '10': 'currentPage'},
  ],
};

/// Descriptor for `PageInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pageInfoDescriptor = $convert.base64Decode(
    'CghQYWdlSW5mbxIiCg1oYXNfbmV4dF9wYWdlGAEgASgIUgtoYXNOZXh0UGFnZRIhCgxjdXJyZW'
    '50X3BhZ2UYAiABKAVSC2N1cnJlbnRQYWdl');
