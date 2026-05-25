// This is a generated file - do not edit.
//
// Generated from api.proto.

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
    {
      '1': 'entry',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.goodanime.MediaListEntry',
      '10': 'entry'
    },
    {'1': 'error', '3': 2, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `SaveMediaListEntryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveMediaListEntryResponseDescriptor =
    $convert.base64Decode(
        'ChpTYXZlTWVkaWFMaXN0RW50cnlSZXNwb25zZRIvCgVlbnRyeRgBIAEoCzIZLmdvb2RhbmltZS'
        '5NZWRpYUxpc3RFbnRyeVIFZW50cnkSFAoFZXJyb3IYAiABKAlSBWVycm9y');

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
    {
      '1': 'media',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.goodanime.Media',
      '10': 'media'
    },
    {'1': 'error', '3': 2, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `FetchMediaDetailsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fetchMediaDetailsResponseDescriptor =
    $convert.base64Decode(
        'ChlGZXRjaE1lZGlhRGV0YWlsc1Jlc3BvbnNlEiYKBW1lZGlhGAEgASgLMhAuZ29vZGFuaW1lLk'
        '1lZGlhUgVtZWRpYRIUCgVlcnJvchgCIAEoCVIFZXJyb3I=');

@$core.Deprecated('Use fetchMediaStaffRequestDescriptor instead')
const FetchMediaStaffRequest$json = {
  '1': 'FetchMediaStaffRequest',
  '2': [
    {'1': 'media_id', '3': 1, '4': 1, '5': 5, '10': 'mediaId'},
    {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    {'1': 'per_page', '3': 3, '4': 1, '5': 5, '10': 'perPage'},
  ],
};

/// Descriptor for `FetchMediaStaffRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fetchMediaStaffRequestDescriptor =
    $convert.base64Decode(
        'ChZGZXRjaE1lZGlhU3RhZmZSZXF1ZXN0EhkKCG1lZGlhX2lkGAEgASgFUgdtZWRpYUlkEhIKBH'
        'BhZ2UYAiABKAVSBHBhZ2USGQoIcGVyX3BhZ2UYAyABKAVSB3BlclBhZ2U=');

@$core.Deprecated('Use fetchMediaStaffResponseDescriptor instead')
const FetchMediaStaffResponse$json = {
  '1': 'FetchMediaStaffResponse',
  '2': [
    {
      '1': 'media',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.goodanime.Media',
      '10': 'media'
    },
    {'1': 'error', '3': 2, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `FetchMediaStaffResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fetchMediaStaffResponseDescriptor =
    $convert.base64Decode(
        'ChdGZXRjaE1lZGlhU3RhZmZSZXNwb25zZRImCgVtZWRpYRgBIAEoCzIQLmdvb2RhbmltZS5NZW'
        'RpYVIFbWVkaWESFAoFZXJyb3IYAiABKAlSBWVycm9y');

@$core.Deprecated('Use fetchMediaCharactersRequestDescriptor instead')
const FetchMediaCharactersRequest$json = {
  '1': 'FetchMediaCharactersRequest',
  '2': [
    {'1': 'media_id', '3': 1, '4': 1, '5': 5, '10': 'mediaId'},
    {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    {'1': 'per_page', '3': 3, '4': 1, '5': 5, '10': 'perPage'},
  ],
};

/// Descriptor for `FetchMediaCharactersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fetchMediaCharactersRequestDescriptor =
    $convert.base64Decode(
        'ChtGZXRjaE1lZGlhQ2hhcmFjdGVyc1JlcXVlc3QSGQoIbWVkaWFfaWQYASABKAVSB21lZGlhSW'
        'QSEgoEcGFnZRgCIAEoBVIEcGFnZRIZCghwZXJfcGFnZRgDIAEoBVIHcGVyUGFnZQ==');

@$core.Deprecated('Use fetchMediaCharactersResponseDescriptor instead')
const FetchMediaCharactersResponse$json = {
  '1': 'FetchMediaCharactersResponse',
  '2': [
    {
      '1': 'media',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.goodanime.Media',
      '10': 'media'
    },
    {'1': 'error', '3': 2, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `FetchMediaCharactersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fetchMediaCharactersResponseDescriptor =
    $convert.base64Decode(
        'ChxGZXRjaE1lZGlhQ2hhcmFjdGVyc1Jlc3BvbnNlEiYKBW1lZGlhGAEgASgLMhAuZ29vZGFuaW'
        '1lLk1lZGlhUgVtZWRpYRIUCgVlcnJvchgCIAEoCVIFZXJyb3I=');

@$core.Deprecated('Use fetchMediaRecommendationsRequestDescriptor instead')
const FetchMediaRecommendationsRequest$json = {
  '1': 'FetchMediaRecommendationsRequest',
  '2': [
    {'1': 'media_id', '3': 1, '4': 1, '5': 5, '10': 'mediaId'},
    {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    {'1': 'per_page', '3': 3, '4': 1, '5': 5, '10': 'perPage'},
  ],
};

/// Descriptor for `FetchMediaRecommendationsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fetchMediaRecommendationsRequestDescriptor =
    $convert.base64Decode(
        'CiBGZXRjaE1lZGlhUmVjb21tZW5kYXRpb25zUmVxdWVzdBIZCghtZWRpYV9pZBgBIAEoBVIHbW'
        'VkaWFJZBISCgRwYWdlGAIgASgFUgRwYWdlEhkKCHBlcl9wYWdlGAMgASgFUgdwZXJQYWdl');

@$core.Deprecated('Use fetchMediaRecommendationsResponseDescriptor instead')
const FetchMediaRecommendationsResponse$json = {
  '1': 'FetchMediaRecommendationsResponse',
  '2': [
    {
      '1': 'media',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.goodanime.Media',
      '10': 'media'
    },
    {'1': 'error', '3': 2, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `FetchMediaRecommendationsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fetchMediaRecommendationsResponseDescriptor =
    $convert.base64Decode(
        'CiFGZXRjaE1lZGlhUmVjb21tZW5kYXRpb25zUmVzcG9uc2USJgoFbWVkaWEYASABKAsyEC5nb2'
        '9kYW5pbWUuTWVkaWFSBW1lZGlhEhQKBWVycm9yGAIgASgJUgVlcnJvcg==');

@$core.Deprecated('Use toggleFavouriteAnimeRequestDescriptor instead')
const ToggleFavouriteAnimeRequest$json = {
  '1': 'ToggleFavouriteAnimeRequest',
  '2': [
    {'1': 'anime_id', '3': 1, '4': 1, '5': 5, '10': 'animeId'},
  ],
};

/// Descriptor for `ToggleFavouriteAnimeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List toggleFavouriteAnimeRequestDescriptor =
    $convert.base64Decode(
        'ChtUb2dnbGVGYXZvdXJpdGVBbmltZVJlcXVlc3QSGQoIYW5pbWVfaWQYASABKAVSB2FuaW1lSW'
        'Q=');

@$core.Deprecated('Use toggleFavouriteAnimeResponseDescriptor instead')
const ToggleFavouriteAnimeResponse$json = {
  '1': 'ToggleFavouriteAnimeResponse',
  '2': [
    {'1': 'anime_id', '3': 1, '4': 1, '5': 5, '10': 'animeId'},
    {'1': 'is_favourite', '3': 2, '4': 1, '5': 8, '10': 'isFavourite'},
    {'1': 'error', '3': 3, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `ToggleFavouriteAnimeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List toggleFavouriteAnimeResponseDescriptor =
    $convert.base64Decode(
        'ChxUb2dnbGVGYXZvdXJpdGVBbmltZVJlc3BvbnNlEhkKCGFuaW1lX2lkGAEgASgFUgdhbmltZU'
        'lkEiEKDGlzX2Zhdm91cml0ZRgCIAEoCFILaXNGYXZvdXJpdGUSFAoFZXJyb3IYAyABKAlSBWVy'
        'cm9y');

@$core.Deprecated('Use deleteMediaListEntryRequestDescriptor instead')
const DeleteMediaListEntryRequest$json = {
  '1': 'DeleteMediaListEntryRequest',
  '2': [
    {'1': 'entry_id', '3': 1, '4': 1, '5': 5, '10': 'entryId'},
  ],
};

/// Descriptor for `DeleteMediaListEntryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteMediaListEntryRequestDescriptor =
    $convert.base64Decode(
        'ChtEZWxldGVNZWRpYUxpc3RFbnRyeVJlcXVlc3QSGQoIZW50cnlfaWQYASABKAVSB2VudHJ5SW'
        'Q=');

@$core.Deprecated('Use deleteMediaListEntryResponseDescriptor instead')
const DeleteMediaListEntryResponse$json = {
  '1': 'DeleteMediaListEntryResponse',
  '2': [
    {'1': 'entry_id', '3': 1, '4': 1, '5': 5, '10': 'entryId'},
    {'1': 'deleted', '3': 2, '4': 1, '5': 8, '10': 'deleted'},
    {'1': 'error', '3': 3, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `DeleteMediaListEntryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteMediaListEntryResponseDescriptor =
    $convert.base64Decode(
        'ChxEZWxldGVNZWRpYUxpc3RFbnRyeVJlc3BvbnNlEhkKCGVudHJ5X2lkGAEgASgFUgdlbnRyeU'
        'lkEhgKB2RlbGV0ZWQYAiABKAhSB2RlbGV0ZWQSFAoFZXJyb3IYAyABKAlSBWVycm9y');

@$core.Deprecated('Use fetchMediaReviewsRequestDescriptor instead')
const FetchMediaReviewsRequest$json = {
  '1': 'FetchMediaReviewsRequest',
  '2': [
    {'1': 'media_id', '3': 1, '4': 1, '5': 5, '10': 'mediaId'},
    {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    {'1': 'per_page', '3': 3, '4': 1, '5': 5, '10': 'perPage'},
  ],
};

/// Descriptor for `FetchMediaReviewsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fetchMediaReviewsRequestDescriptor =
    $convert.base64Decode(
        'ChhGZXRjaE1lZGlhUmV2aWV3c1JlcXVlc3QSGQoIbWVkaWFfaWQYASABKAVSB21lZGlhSWQSEg'
        'oEcGFnZRgCIAEoBVIEcGFnZRIZCghwZXJfcGFnZRgDIAEoBVIHcGVyUGFnZQ==');

@$core.Deprecated('Use fetchMediaReviewsResponseDescriptor instead')
const FetchMediaReviewsResponse$json = {
  '1': 'FetchMediaReviewsResponse',
  '2': [
    {
      '1': 'media',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.goodanime.Media',
      '10': 'media'
    },
    {'1': 'error', '3': 2, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `FetchMediaReviewsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fetchMediaReviewsResponseDescriptor =
    $convert.base64Decode(
        'ChlGZXRjaE1lZGlhUmV2aWV3c1Jlc3BvbnNlEiYKBW1lZGlhGAEgASgLMhAuZ29vZGFuaW1lLk'
        '1lZGlhUgVtZWRpYRIUCgVlcnJvchgCIAEoCVIFZXJyb3I=');
