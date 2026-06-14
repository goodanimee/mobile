// This is a generated file - do not edit.
//
// Generated from media_min.proto.

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

@$core.Deprecated('Use titleDescriptor instead')
const Title$json = {
  '1': 'Title',
  '2': [
    {'1': 'english', '3': 1, '4': 1, '5': 9, '10': 'english'},
    {'1': 'native', '3': 2, '4': 1, '5': 9, '10': 'native'},
    {'1': 'romaji', '3': 3, '4': 1, '5': 9, '10': 'romaji'},
    {'1': 'user_preferred', '3': 4, '4': 1, '5': 9, '10': 'userPreferred'},
  ],
};

/// Descriptor for `Title`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List titleDescriptor = $convert.base64Decode(
    'CgVUaXRsZRIYCgdlbmdsaXNoGAEgASgJUgdlbmdsaXNoEhYKBm5hdGl2ZRgCIAEoCVIGbmF0aX'
    'ZlEhYKBnJvbWFqaRgDIAEoCVIGcm9tYWppEiUKDnVzZXJfcHJlZmVycmVkGAQgASgJUg11c2Vy'
    'UHJlZmVycmVk');

@$core.Deprecated('Use coverImageDescriptor instead')
const CoverImage$json = {
  '1': 'CoverImage',
  '2': [
    {'1': 'medium', '3': 1, '4': 1, '5': 9, '10': 'medium'},
    {'1': 'large', '3': 2, '4': 1, '5': 9, '10': 'large'},
    {'1': 'extra_large', '3': 3, '4': 1, '5': 9, '10': 'extraLarge'},
    {'1': 'color', '3': 4, '4': 1, '5': 9, '10': 'color'},
  ],
};

/// Descriptor for `CoverImage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List coverImageDescriptor = $convert.base64Decode(
    'CgpDb3ZlckltYWdlEhYKBm1lZGl1bRgBIAEoCVIGbWVkaXVtEhQKBWxhcmdlGAIgASgJUgVsYX'
    'JnZRIfCgtleHRyYV9sYXJnZRgDIAEoCVIKZXh0cmFMYXJnZRIUCgVjb2xvchgEIAEoCVIFY29s'
    'b3I=');

@$core.Deprecated('Use mediaMinDescriptor instead')
const MediaMin$json = {
  '1': 'MediaMin',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {
      '1': 'title',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.goodanime.Title',
      '10': 'title'
    },
    {'1': 'average_score', '3': 3, '4': 1, '5': 5, '10': 'averageScore'},
    {
      '1': 'cover_image',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.goodanime.CoverImage',
      '10': 'coverImage'
    },
    {'1': 'episodes', '3': 5, '4': 1, '5': 5, '10': 'episodes'},
    {'1': 'format', '3': 6, '4': 1, '5': 9, '10': 'format'},
    {'1': 'is_adult', '3': 7, '4': 1, '5': 8, '10': 'isAdult'},
    {'1': 'is_favourite', '3': 8, '4': 1, '5': 8, '10': 'isFavourite'},
    {'1': 'site_url', '3': 9, '4': 1, '5': 9, '10': 'siteUrl'},
    {'1': 'chapters', '3': 10, '4': 1, '5': 5, '10': 'chapters'},
    {'1': 'volumes', '3': 11, '4': 1, '5': 5, '10': 'volumes'},
    {'1': 'type', '3': 12, '4': 1, '5': 9, '10': 'type'},
    {
      '1': 'season_year',
      '3': 13,
      '4': 1,
      '5': 5,
      '9': 0,
      '10': 'seasonYear',
      '17': true
    },
  ],
  '8': [
    {'1': '_season_year'},
  ],
};

/// Descriptor for `MediaMin`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mediaMinDescriptor = $convert.base64Decode(
    'CghNZWRpYU1pbhIOCgJpZBgBIAEoBVICaWQSJgoFdGl0bGUYAiABKAsyEC5nb29kYW5pbWUuVG'
    'l0bGVSBXRpdGxlEiMKDWF2ZXJhZ2Vfc2NvcmUYAyABKAVSDGF2ZXJhZ2VTY29yZRI2Cgtjb3Zl'
    'cl9pbWFnZRgEIAEoCzIVLmdvb2RhbmltZS5Db3ZlckltYWdlUgpjb3ZlckltYWdlEhoKCGVwaX'
    'NvZGVzGAUgASgFUghlcGlzb2RlcxIWCgZmb3JtYXQYBiABKAlSBmZvcm1hdBIZCghpc19hZHVs'
    'dBgHIAEoCFIHaXNBZHVsdBIhCgxpc19mYXZvdXJpdGUYCCABKAhSC2lzRmF2b3VyaXRlEhkKCH'
    'NpdGVfdXJsGAkgASgJUgdzaXRlVXJsEhoKCGNoYXB0ZXJzGAogASgFUghjaGFwdGVycxIYCgd2'
    'b2x1bWVzGAsgASgFUgd2b2x1bWVzEhIKBHR5cGUYDCABKAlSBHR5cGUSJAoLc2Vhc29uX3llYX'
    'IYDSABKAVIAFIKc2Vhc29uWWVhcogBAUIOCgxfc2Vhc29uX3llYXI=');
