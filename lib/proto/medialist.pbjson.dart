// This is a generated file - do not edit.
//
// Generated from proto/medialist.proto.

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

@$core.Deprecated('Use fuzzyDateDescriptor instead')
const FuzzyDate$json = {
  '1': 'FuzzyDate',
  '2': [
    {'1': 'day', '3': 1, '4': 1, '5': 5, '10': 'day'},
    {'1': 'month', '3': 2, '4': 1, '5': 5, '10': 'month'},
    {'1': 'year', '3': 3, '4': 1, '5': 5, '10': 'year'},
  ],
};

/// Descriptor for `FuzzyDate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fuzzyDateDescriptor = $convert.base64Decode(
    'CglGdXp6eURhdGUSEAoDZGF5GAEgASgFUgNkYXkSFAoFbW9udGgYAiABKAVSBW1vbnRoEhIKBH'
    'llYXIYAyABKAVSBHllYXI=');

@$core.Deprecated('Use trailerDescriptor instead')
const Trailer$json = {
  '1': 'Trailer',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'site', '3': 2, '4': 1, '5': 9, '10': 'site'},
    {'1': 'thumbnail', '3': 3, '4': 1, '5': 9, '10': 'thumbnail'},
  ],
};

/// Descriptor for `Trailer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List trailerDescriptor = $convert.base64Decode(
    'CgdUcmFpbGVyEg4KAmlkGAEgASgJUgJpZBISCgRzaXRlGAIgASgJUgRzaXRlEhwKCXRodW1ibm'
    'FpbBgDIAEoCVIJdGh1bWJuYWls');

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

@$core.Deprecated('Use mediaDescriptor instead')
const Media$json = {
  '1': 'Media',
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
    {'1': 'banner_image', '3': 4, '4': 1, '5': 9, '10': 'bannerImage'},
    {
      '1': 'cover_image',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.goodanime.CoverImage',
      '10': 'coverImage'
    },
    {'1': 'description', '3': 6, '4': 1, '5': 9, '10': 'description'},
    {'1': 'duration', '3': 7, '4': 1, '5': 5, '10': 'duration'},
    {'1': 'episodes', '3': 8, '4': 1, '5': 5, '10': 'episodes'},
    {'1': 'format', '3': 9, '4': 1, '5': 9, '10': 'format'},
    {'1': 'genres', '3': 10, '4': 3, '5': 9, '10': 'genres'},
    {'1': 'is_adult', '3': 11, '4': 1, '5': 8, '10': 'isAdult'},
    {'1': 'is_favourite', '3': 12, '4': 1, '5': 8, '10': 'isFavourite'},
    {'1': 'popularity', '3': 13, '4': 1, '5': 5, '10': 'popularity'},
    {'1': 'season', '3': 14, '4': 1, '5': 9, '10': 'season'},
    {'1': 'season_year', '3': 15, '4': 1, '5': 5, '10': 'seasonYear'},
    {'1': 'status', '3': 16, '4': 1, '5': 9, '10': 'status'},
    {
      '1': 'trailer',
      '3': 17,
      '4': 1,
      '5': 11,
      '6': '.goodanime.Trailer',
      '10': 'trailer'
    },
  ],
};

/// Descriptor for `Media`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mediaDescriptor = $convert.base64Decode(
    'CgVNZWRpYRIOCgJpZBgBIAEoBVICaWQSJgoFdGl0bGUYAiABKAsyEC5nb29kYW5pbWUuVGl0bG'
    'VSBXRpdGxlEiMKDWF2ZXJhZ2Vfc2NvcmUYAyABKAVSDGF2ZXJhZ2VTY29yZRIhCgxiYW5uZXJf'
    'aW1hZ2UYBCABKAlSC2Jhbm5lckltYWdlEjYKC2NvdmVyX2ltYWdlGAUgASgLMhUuZ29vZGFuaW'
    '1lLkNvdmVySW1hZ2VSCmNvdmVySW1hZ2USIAoLZGVzY3JpcHRpb24YBiABKAlSC2Rlc2NyaXB0'
    'aW9uEhoKCGR1cmF0aW9uGAcgASgFUghkdXJhdGlvbhIaCghlcGlzb2RlcxgIIAEoBVIIZXBpc2'
    '9kZXMSFgoGZm9ybWF0GAkgASgJUgZmb3JtYXQSFgoGZ2VucmVzGAogAygJUgZnZW5yZXMSGQoI'
    'aXNfYWR1bHQYCyABKAhSB2lzQWR1bHQSIQoMaXNfZmF2b3VyaXRlGAwgASgIUgtpc0Zhdm91cm'
    'l0ZRIeCgpwb3B1bGFyaXR5GA0gASgFUgpwb3B1bGFyaXR5EhYKBnNlYXNvbhgOIAEoCVIGc2Vh'
    'c29uEh8KC3NlYXNvbl95ZWFyGA8gASgFUgpzZWFzb25ZZWFyEhYKBnN0YXR1cxgQIAEoCVIGc3'
    'RhdHVzEiwKB3RyYWlsZXIYESABKAsyEi5nb29kYW5pbWUuVHJhaWxlclIHdHJhaWxlcg==');

@$core.Deprecated('Use mediaListEntryDescriptor instead')
const MediaListEntry$json = {
  '1': 'MediaListEntry',
  '2': [
    {
      '1': 'media',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.goodanime.Media',
      '10': 'media'
    },
    {'1': 'progress', '3': 2, '4': 1, '5': 5, '10': 'progress'},
    {'1': 'repeat', '3': 3, '4': 1, '5': 5, '10': 'repeat'},
    {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
    {'1': 'score', '3': 5, '4': 1, '5': 1, '10': 'score'},
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
  ],
};

/// Descriptor for `MediaListEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mediaListEntryDescriptor = $convert.base64Decode(
    'Cg5NZWRpYUxpc3RFbnRyeRImCgVtZWRpYRgBIAEoCzIQLmdvb2RhbmltZS5NZWRpYVIFbWVkaW'
    'ESGgoIcHJvZ3Jlc3MYAiABKAVSCHByb2dyZXNzEhYKBnJlcGVhdBgDIAEoBVIGcmVwZWF0EhYK'
    'BnN0YXR1cxgEIAEoCVIGc3RhdHVzEhQKBXNjb3JlGAUgASgBUgVzY29yZRIzCgpzdGFydGVkX2'
    'F0GAYgASgLMhQuZ29vZGFuaW1lLkZ1enp5RGF0ZVIJc3RhcnRlZEF0EjcKDGNvbXBsZXRlZF9h'
    'dBgHIAEoCzIULmdvb2RhbmltZS5GdXp6eURhdGVSC2NvbXBsZXRlZEF0');

@$core.Deprecated('Use mediaListDescriptor instead')
const MediaList$json = {
  '1': 'MediaList',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    {
      '1': 'entries',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.goodanime.MediaListEntry',
      '10': 'entries'
    },
  ],
};

/// Descriptor for `MediaList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mediaListDescriptor = $convert.base64Decode(
    'CglNZWRpYUxpc3QSEgoEbmFtZRgBIAEoCVIEbmFtZRIWCgZzdGF0dXMYAiABKAlSBnN0YXR1cx'
    'IzCgdlbnRyaWVzGAMgAygLMhkuZ29vZGFuaW1lLk1lZGlhTGlzdEVudHJ5UgdlbnRyaWVz');

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
      '6': '.goodanime.MediaList',
      '10': 'lists'
    },
  ],
};

/// Descriptor for `MediaListCollection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mediaListCollectionDescriptor = $convert.base64Decode(
    'ChNNZWRpYUxpc3RDb2xsZWN0aW9uEiQKDmhhc19uZXh0X2NodW5rGAEgASgIUgxoYXNOZXh0Q2'
    'h1bmsSKgoFbGlzdHMYAiADKAsyFC5nb29kYW5pbWUuTWVkaWFMaXN0UgVsaXN0cw==');

@$core.Deprecated('Use fetchMediaListRequestDescriptor instead')
const FetchMediaListRequest$json = {
  '1': 'FetchMediaListRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 5, '10': 'userId'},
    {'1': 'type', '3': 2, '4': 1, '5': 9, '10': 'type'},
    {'1': 'sort', '3': 3, '4': 3, '5': 9, '10': 'sort'},
  ],
};

/// Descriptor for `FetchMediaListRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fetchMediaListRequestDescriptor = $convert.base64Decode(
    'ChVGZXRjaE1lZGlhTGlzdFJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoBVIGdXNlcklkEhIKBHR5cG'
    'UYAiABKAlSBHR5cGUSEgoEc29ydBgDIAMoCVIEc29ydA==');

@$core.Deprecated('Use fetchMediaListResponseDescriptor instead')
const FetchMediaListResponse$json = {
  '1': 'FetchMediaListResponse',
  '2': [
    {
      '1': 'collection',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.goodanime.MediaListCollection',
      '10': 'collection'
    },
    {'1': 'error', '3': 2, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `FetchMediaListResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fetchMediaListResponseDescriptor = $convert.base64Decode(
    'ChZGZXRjaE1lZGlhTGlzdFJlc3BvbnNlEj4KCmNvbGxlY3Rpb24YASABKAsyHi5nb29kYW5pbW'
    'UuTWVkaWFMaXN0Q29sbGVjdGlvblIKY29sbGVjdGlvbhIUCgVlcnJvchgCIAEoCVIFZXJyb3I=');

@$core.Deprecated('Use viewerDescriptor instead')
const Viewer$json = {
  '1': 'Viewer',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'avatar_medium', '3': 3, '4': 1, '5': 9, '10': 'avatarMedium'},
    {'1': 'created_at', '3': 4, '4': 1, '5': 5, '10': 'createdAt'},
  ],
};

/// Descriptor for `Viewer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List viewerDescriptor = $convert.base64Decode(
    'CgZWaWV3ZXISDgoCaWQYASABKAVSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSIwoNYXZhdGFyX2'
    '1lZGl1bRgDIAEoCVIMYXZhdGFyTWVkaXVtEh0KCmNyZWF0ZWRfYXQYBCABKAVSCWNyZWF0ZWRB'
    'dA==');

@$core.Deprecated('Use fetchViewerResponseDescriptor instead')
const FetchViewerResponse$json = {
  '1': 'FetchViewerResponse',
  '2': [
    {
      '1': 'viewer',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.goodanime.Viewer',
      '10': 'viewer'
    },
    {'1': 'error', '3': 2, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `FetchViewerResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fetchViewerResponseDescriptor = $convert.base64Decode(
    'ChNGZXRjaFZpZXdlclJlc3BvbnNlEikKBnZpZXdlchgBIAEoCzIRLmdvb2RhbmltZS5WaWV3ZX'
    'JSBnZpZXdlchIUCgVlcnJvchgCIAEoCVIFZXJyb3I=');

@$core.Deprecated('Use fuzzyDateInputDescriptor instead')
const FuzzyDateInput$json = {
  '1': 'FuzzyDateInput',
  '2': [
    {'1': 'year', '3': 1, '4': 1, '5': 5, '9': 0, '10': 'year', '17': true},
    {'1': 'month', '3': 2, '4': 1, '5': 5, '9': 1, '10': 'month', '17': true},
    {'1': 'day', '3': 3, '4': 1, '5': 5, '9': 2, '10': 'day', '17': true},
  ],
  '8': [
    {'1': '_year'},
    {'1': '_month'},
    {'1': '_day'},
  ],
};

/// Descriptor for `FuzzyDateInput`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fuzzyDateInputDescriptor = $convert.base64Decode(
    'Cg5GdXp6eURhdGVJbnB1dBIXCgR5ZWFyGAEgASgFSABSBHllYXKIAQESGQoFbW9udGgYAiABKA'
    'VIAVIFbW9udGiIAQESFQoDZGF5GAMgASgFSAJSA2RheYgBAUIHCgVfeWVhckIICgZfbW9udGhC'
    'BgoEX2RheQ==');

@$core.Deprecated('Use saveMediaListEntryRequestDescriptor instead')
const SaveMediaListEntryRequest$json = {
  '1': 'SaveMediaListEntryRequest',
  '2': [
    {'1': 'media_id', '3': 1, '4': 1, '5': 5, '10': 'mediaId'},
    {
      '1': 'progress',
      '3': 2,
      '4': 1,
      '5': 5,
      '9': 0,
      '10': 'progress',
      '17': true
    },
    {'1': 'status', '3': 3, '4': 1, '5': 9, '9': 1, '10': 'status', '17': true},
    {'1': 'score', '3': 4, '4': 1, '5': 1, '9': 2, '10': 'score', '17': true},
    {
      '1': 'started_at',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.goodanime.FuzzyDateInput',
      '9': 3,
      '10': 'startedAt',
      '17': true
    },
    {
      '1': 'completed_at',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.goodanime.FuzzyDateInput',
      '9': 4,
      '10': 'completedAt',
      '17': true
    },
  ],
  '8': [
    {'1': '_progress'},
    {'1': '_status'},
    {'1': '_score'},
    {'1': '_started_at'},
    {'1': '_completed_at'},
  ],
};

/// Descriptor for `SaveMediaListEntryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveMediaListEntryRequestDescriptor = $convert.base64Decode(
    'ChlTYXZlTWVkaWFMaXN0RW50cnlSZXF1ZXN0EhkKCG1lZGlhX2lkGAEgASgFUgdtZWRpYUlkEh'
    '8KCHByb2dyZXNzGAIgASgFSABSCHByb2dyZXNziAEBEhsKBnN0YXR1cxgDIAEoCUgBUgZzdGF0'
    'dXOIAQESGQoFc2NvcmUYBCABKAFIAlIFc2NvcmWIAQESPQoKc3RhcnRlZF9hdBgFIAEoCzIZLm'
    'dvb2RhbmltZS5GdXp6eURhdGVJbnB1dEgDUglzdGFydGVkQXSIAQESQQoMY29tcGxldGVkX2F0'
    'GAYgASgLMhkuZ29vZGFuaW1lLkZ1enp5RGF0ZUlucHV0SARSC2NvbXBsZXRlZEF0iAEBQgsKCV'
    '9wcm9ncmVzc0IJCgdfc3RhdHVzQggKBl9zY29yZUINCgtfc3RhcnRlZF9hdEIPCg1fY29tcGxl'
    'dGVkX2F0');

@$core.Deprecated('Use saveMediaListEntryResponseDescriptor instead')
const SaveMediaListEntryResponse$json = {
  '1': 'SaveMediaListEntryResponse',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
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
    {'1': 'error', '3': 8, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `SaveMediaListEntryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveMediaListEntryResponseDescriptor = $convert.base64Decode(
    'ChpTYXZlTWVkaWFMaXN0RW50cnlSZXNwb25zZRIOCgJpZBgBIAEoBVICaWQSFgoGc3RhdHVzGA'
    'IgASgJUgZzdGF0dXMSGgoIcHJvZ3Jlc3MYAyABKAVSCHByb2dyZXNzEhQKBXNjb3JlGAQgASgB'
    'UgVzY29yZRIWCgZyZXBlYXQYBSABKAVSBnJlcGVhdBIzCgpzdGFydGVkX2F0GAYgASgLMhQuZ2'
    '9vZGFuaW1lLkZ1enp5RGF0ZVIJc3RhcnRlZEF0EjcKDGNvbXBsZXRlZF9hdBgHIAEoCzIULmdv'
    'b2RhbmltZS5GdXp6eURhdGVSC2NvbXBsZXRlZEF0EhQKBWVycm9yGAggASgJUgVlcnJvcg==');

@$core.Deprecated('Use fetchMediaDetailsRequestDescriptor instead')
const FetchMediaDetailsRequest$json = {
  '1': 'FetchMediaDetailsRequest',
  '2': [
    {'1': 'media_id', '3': 1, '4': 1, '5': 5, '10': 'mediaId'},
  ],
};

/// Descriptor for `FetchMediaDetailsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fetchMediaDetailsRequestDescriptor =
    $convert.base64Decode(
        'ChhGZXRjaE1lZGlhRGV0YWlsc1JlcXVlc3QSGQoIbWVkaWFfaWQYASABKAVSB21lZGlhSWQ=');

@$core.Deprecated('Use fetchMediaDetailsResponseDescriptor instead')
const FetchMediaDetailsResponse$json = {
  '1': 'FetchMediaDetailsResponse',
  '2': [
    {'1': 'raw_json', '3': 1, '4': 1, '5': 9, '10': 'rawJson'},
    {'1': 'error', '3': 2, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `FetchMediaDetailsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fetchMediaDetailsResponseDescriptor =
    $convert.base64Decode(
        'ChlGZXRjaE1lZGlhRGV0YWlsc1Jlc3BvbnNlEhkKCHJhd19qc29uGAEgASgJUgdyYXdKc29uEh'
        'QKBWVycm9yGAIgASgJUgVlcnJvcg==');
