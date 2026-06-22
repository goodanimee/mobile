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
    {
      '1': 'progress_volumes',
      '3': 7,
      '4': 1,
      '5': 5,
      '9': 5,
      '10': 'progressVolumes',
      '17': true
    },
    {'1': 'repeat', '3': 8, '4': 1, '5': 5, '9': 6, '10': 'repeat', '17': true},
  ],
  '8': [
    {'1': '_progress'},
    {'1': '_status'},
    {'1': '_score'},
    {'1': '_started_at'},
    {'1': '_completed_at'},
    {'1': '_progress_volumes'},
    {'1': '_repeat'},
  ],
};

/// Descriptor for `SaveMediaListEntryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveMediaListEntryRequestDescriptor = $convert.base64Decode(
    'ChlTYXZlTWVkaWFMaXN0RW50cnlSZXF1ZXN0EhkKCG1lZGlhX2lkGAEgASgFUgdtZWRpYUlkEh'
    '8KCHByb2dyZXNzGAIgASgFSABSCHByb2dyZXNziAEBEhsKBnN0YXR1cxgDIAEoCUgBUgZzdGF0'
    'dXOIAQESGQoFc2NvcmUYBCABKAFIAlIFc2NvcmWIAQESPQoKc3RhcnRlZF9hdBgFIAEoCzIZLm'
    'dvb2RhbmltZS5GdXp6eURhdGVJbnB1dEgDUglzdGFydGVkQXSIAQESQQoMY29tcGxldGVkX2F0'
    'GAYgASgLMhkuZ29vZGFuaW1lLkZ1enp5RGF0ZUlucHV0SARSC2NvbXBsZXRlZEF0iAEBEi4KEH'
    'Byb2dyZXNzX3ZvbHVtZXMYByABKAVIBVIPcHJvZ3Jlc3NWb2x1bWVziAEBEhsKBnJlcGVhdBgI'
    'IAEoBUgGUgZyZXBlYXSIAQFCCwoJX3Byb2dyZXNzQgkKB19zdGF0dXNCCAoGX3Njb3JlQg0KC1'
    '9zdGFydGVkX2F0Qg8KDV9jb21wbGV0ZWRfYXRCEwoRX3Byb2dyZXNzX3ZvbHVtZXNCCQoHX3Jl'
    'cGVhdA==');

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

@$core.Deprecated('Use toggleFavouriteMangaRequestDescriptor instead')
const ToggleFavouriteMangaRequest$json = {
  '1': 'ToggleFavouriteMangaRequest',
  '2': [
    {'1': 'manga_id', '3': 1, '4': 1, '5': 5, '10': 'mangaId'},
  ],
};

/// Descriptor for `ToggleFavouriteMangaRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List toggleFavouriteMangaRequestDescriptor =
    $convert.base64Decode(
        'ChtUb2dnbGVGYXZvdXJpdGVNYW5nYVJlcXVlc3QSGQoIbWFuZ2FfaWQYASABKAVSB21hbmdhSW'
        'Q=');

@$core.Deprecated('Use toggleFavouriteMangaResponseDescriptor instead')
const ToggleFavouriteMangaResponse$json = {
  '1': 'ToggleFavouriteMangaResponse',
  '2': [
    {'1': 'manga_id', '3': 1, '4': 1, '5': 5, '10': 'mangaId'},
    {'1': 'is_favourite', '3': 2, '4': 1, '5': 8, '10': 'isFavourite'},
    {'1': 'error', '3': 3, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `ToggleFavouriteMangaResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List toggleFavouriteMangaResponseDescriptor =
    $convert.base64Decode(
        'ChxUb2dnbGVGYXZvdXJpdGVNYW5nYVJlc3BvbnNlEhkKCG1hbmdhX2lkGAEgASgFUgdtYW5nYU'
        'lkEiEKDGlzX2Zhdm91cml0ZRgCIAEoCFILaXNGYXZvdXJpdGUSFAoFZXJyb3IYAyABKAlSBWVy'
        'cm9y');

@$core.Deprecated('Use toggleActivityLikeRequestDescriptor instead')
const ToggleActivityLikeRequest$json = {
  '1': 'ToggleActivityLikeRequest',
  '2': [
    {'1': 'activity_id', '3': 1, '4': 1, '5': 5, '10': 'activityId'},
  ],
};

/// Descriptor for `ToggleActivityLikeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List toggleActivityLikeRequestDescriptor =
    $convert.base64Decode(
        'ChlUb2dnbGVBY3Rpdml0eUxpa2VSZXF1ZXN0Eh8KC2FjdGl2aXR5X2lkGAEgASgFUgphY3Rpdm'
        'l0eUlk');

@$core.Deprecated('Use toggleActivityLikeResponseDescriptor instead')
const ToggleActivityLikeResponse$json = {
  '1': 'ToggleActivityLikeResponse',
  '2': [
    {'1': 'activity_id', '3': 1, '4': 1, '5': 5, '10': 'activityId'},
    {'1': 'liked_user_ids', '3': 2, '4': 3, '5': 5, '10': 'likedUserIds'},
    {'1': 'error', '3': 3, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `ToggleActivityLikeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List toggleActivityLikeResponseDescriptor =
    $convert.base64Decode(
        'ChpUb2dnbGVBY3Rpdml0eUxpa2VSZXNwb25zZRIfCgthY3Rpdml0eV9pZBgBIAEoBVIKYWN0aX'
        'ZpdHlJZBIkCg5saWtlZF91c2VyX2lkcxgCIAMoBVIMbGlrZWRVc2VySWRzEhQKBWVycm9yGAMg'
        'ASgJUgVlcnJvcg==');

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

@$core.Deprecated('Use rateReviewRequestDescriptor instead')
const RateReviewRequest$json = {
  '1': 'RateReviewRequest',
  '2': [
    {'1': 'review_id', '3': 1, '4': 1, '5': 5, '10': 'reviewId'},
    {
      '1': 'rating',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.goodanime.ReviewUserRating',
      '10': 'rating'
    },
  ],
};

/// Descriptor for `RateReviewRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rateReviewRequestDescriptor = $convert.base64Decode(
    'ChFSYXRlUmV2aWV3UmVxdWVzdBIbCglyZXZpZXdfaWQYASABKAVSCHJldmlld0lkEjMKBnJhdG'
    'luZxgCIAEoDjIbLmdvb2RhbmltZS5SZXZpZXdVc2VyUmF0aW5nUgZyYXRpbmc=');

@$core.Deprecated('Use rateReviewResponseDescriptor instead')
const RateReviewResponse$json = {
  '1': 'RateReviewResponse',
  '2': [
    {
      '1': 'review',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.goodanime.ReviewNode',
      '10': 'review'
    },
    {'1': 'error', '3': 2, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `RateReviewResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rateReviewResponseDescriptor = $convert.base64Decode(
    'ChJSYXRlUmV2aWV3UmVzcG9uc2USLQoGcmV2aWV3GAEgASgLMhUuZ29vZGFuaW1lLlJldmlld0'
    '5vZGVSBnJldmlldxIUCgVlcnJvchgCIAEoCVIFZXJyb3I=');

@$core.Deprecated('Use fetchMediaActivitiesRequestDescriptor instead')
const FetchMediaActivitiesRequest$json = {
  '1': 'FetchMediaActivitiesRequest',
  '2': [
    {'1': 'media_id', '3': 1, '4': 1, '5': 5, '10': 'mediaId'},
    {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    {'1': 'per_page', '3': 3, '4': 1, '5': 5, '10': 'perPage'},
  ],
};

/// Descriptor for `FetchMediaActivitiesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fetchMediaActivitiesRequestDescriptor =
    $convert.base64Decode(
        'ChtGZXRjaE1lZGlhQWN0aXZpdGllc1JlcXVlc3QSGQoIbWVkaWFfaWQYASABKAVSB21lZGlhSW'
        'QSEgoEcGFnZRgCIAEoBVIEcGFnZRIZCghwZXJfcGFnZRgDIAEoBVIHcGVyUGFnZQ==');

@$core.Deprecated('Use fetchMediaActivitiesResponseDescriptor instead')
const FetchMediaActivitiesResponse$json = {
  '1': 'FetchMediaActivitiesResponse',
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
      '1': 'activities',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.goodanime.ListActivity',
      '10': 'activities'
    },
    {'1': 'error', '3': 3, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `FetchMediaActivitiesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fetchMediaActivitiesResponseDescriptor =
    $convert.base64Decode(
        'ChxGZXRjaE1lZGlhQWN0aXZpdGllc1Jlc3BvbnNlEjAKCXBhZ2VfaW5mbxgBIAEoCzITLmdvb2'
        'RhbmltZS5QYWdlSW5mb1IIcGFnZUluZm8SNwoKYWN0aXZpdGllcxgCIAMoCzIXLmdvb2Rhbmlt'
        'ZS5MaXN0QWN0aXZpdHlSCmFjdGl2aXRpZXMSFAoFZXJyb3IYAyABKAlSBWVycm9y');

@$core.Deprecated('Use fetchStudioDetailsRequestDescriptor instead')
const FetchStudioDetailsRequest$json = {
  '1': 'FetchStudioDetailsRequest',
  '2': [
    {'1': 'studio_id', '3': 1, '4': 1, '5': 5, '10': 'studioId'},
    {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
  ],
};

/// Descriptor for `FetchStudioDetailsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fetchStudioDetailsRequestDescriptor =
    $convert.base64Decode(
        'ChlGZXRjaFN0dWRpb0RldGFpbHNSZXF1ZXN0EhsKCXN0dWRpb19pZBgBIAEoBVIIc3R1ZGlvSW'
        'QSEgoEcGFnZRgCIAEoBVIEcGFnZQ==');

@$core.Deprecated('Use fetchStudioDetailsResponseDescriptor instead')
const FetchStudioDetailsResponse$json = {
  '1': 'FetchStudioDetailsResponse',
  '2': [
    {
      '1': 'studio',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.goodanime.Studio',
      '10': 'studio'
    },
    {'1': 'error', '3': 2, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `FetchStudioDetailsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fetchStudioDetailsResponseDescriptor =
    $convert.base64Decode(
        'ChpGZXRjaFN0dWRpb0RldGFpbHNSZXNwb25zZRIpCgZzdHVkaW8YASABKAsyES5nb29kYW5pbW'
        'UuU3R1ZGlvUgZzdHVkaW8SFAoFZXJyb3IYAiABKAlSBWVycm9y');

@$core.Deprecated('Use toggleFavouriteStudioRequestDescriptor instead')
const ToggleFavouriteStudioRequest$json = {
  '1': 'ToggleFavouriteStudioRequest',
  '2': [
    {'1': 'studio_id', '3': 1, '4': 1, '5': 5, '10': 'studioId'},
  ],
};

/// Descriptor for `ToggleFavouriteStudioRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List toggleFavouriteStudioRequestDescriptor =
    $convert.base64Decode(
        'ChxUb2dnbGVGYXZvdXJpdGVTdHVkaW9SZXF1ZXN0EhsKCXN0dWRpb19pZBgBIAEoBVIIc3R1ZG'
        'lvSWQ=');

@$core.Deprecated('Use toggleFavouriteStudioResponseDescriptor instead')
const ToggleFavouriteStudioResponse$json = {
  '1': 'ToggleFavouriteStudioResponse',
  '2': [
    {'1': 'studio_id', '3': 1, '4': 1, '5': 5, '10': 'studioId'},
    {'1': 'error', '3': 2, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `ToggleFavouriteStudioResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List toggleFavouriteStudioResponseDescriptor =
    $convert.base64Decode(
        'Ch1Ub2dnbGVGYXZvdXJpdGVTdHVkaW9SZXNwb25zZRIbCglzdHVkaW9faWQYASABKAVSCHN0dW'
        'Rpb0lkEhQKBWVycm9yGAIgASgJUgVlcnJvcg==');

@$core.Deprecated('Use fetchStaffDetailsRequestDescriptor instead')
const FetchStaffDetailsRequest$json = {
  '1': 'FetchStaffDetailsRequest',
  '2': [
    {'1': 'staff_id', '3': 1, '4': 1, '5': 5, '10': 'staffId'},
    {
      '1': 'character_media_page',
      '3': 2,
      '4': 1,
      '5': 5,
      '10': 'characterMediaPage'
    },
    {'1': 'staff_media_page', '3': 3, '4': 1, '5': 5, '10': 'staffMediaPage'},
  ],
};

/// Descriptor for `FetchStaffDetailsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fetchStaffDetailsRequestDescriptor = $convert.base64Decode(
    'ChhGZXRjaFN0YWZmRGV0YWlsc1JlcXVlc3QSGQoIc3RhZmZfaWQYASABKAVSB3N0YWZmSWQSMA'
    'oUY2hhcmFjdGVyX21lZGlhX3BhZ2UYAiABKAVSEmNoYXJhY3Rlck1lZGlhUGFnZRIoChBzdGFm'
    'Zl9tZWRpYV9wYWdlGAMgASgFUg5zdGFmZk1lZGlhUGFnZQ==');

@$core.Deprecated('Use fetchStaffDetailsResponseDescriptor instead')
const FetchStaffDetailsResponse$json = {
  '1': 'FetchStaffDetailsResponse',
  '2': [
    {
      '1': 'staff',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.goodanime.Staff',
      '10': 'staff'
    },
    {'1': 'error', '3': 2, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `FetchStaffDetailsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fetchStaffDetailsResponseDescriptor =
    $convert.base64Decode(
        'ChlGZXRjaFN0YWZmRGV0YWlsc1Jlc3BvbnNlEiYKBXN0YWZmGAEgASgLMhAuZ29vZGFuaW1lLl'
        'N0YWZmUgVzdGFmZhIUCgVlcnJvchgCIAEoCVIFZXJyb3I=');

@$core.Deprecated('Use toggleFavouriteStaffRequestDescriptor instead')
const ToggleFavouriteStaffRequest$json = {
  '1': 'ToggleFavouriteStaffRequest',
  '2': [
    {'1': 'staff_id', '3': 1, '4': 1, '5': 5, '10': 'staffId'},
  ],
};

/// Descriptor for `ToggleFavouriteStaffRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List toggleFavouriteStaffRequestDescriptor =
    $convert.base64Decode(
        'ChtUb2dnbGVGYXZvdXJpdGVTdGFmZlJlcXVlc3QSGQoIc3RhZmZfaWQYASABKAVSB3N0YWZmSW'
        'Q=');

@$core.Deprecated('Use toggleFavouriteStaffResponseDescriptor instead')
const ToggleFavouriteStaffResponse$json = {
  '1': 'ToggleFavouriteStaffResponse',
  '2': [
    {'1': 'staff_id', '3': 1, '4': 1, '5': 5, '10': 'staffId'},
    {'1': 'error', '3': 2, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `ToggleFavouriteStaffResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List toggleFavouriteStaffResponseDescriptor =
    $convert.base64Decode(
        'ChxUb2dnbGVGYXZvdXJpdGVTdGFmZlJlc3BvbnNlEhkKCHN0YWZmX2lkGAEgASgFUgdzdGFmZk'
        'lkEhQKBWVycm9yGAIgASgJUgVlcnJvcg==');

@$core.Deprecated('Use fetchGenresResponseDescriptor instead')
const FetchGenresResponse$json = {
  '1': 'FetchGenresResponse',
  '2': [
    {'1': 'genres', '3': 1, '4': 3, '5': 9, '10': 'genres'},
    {'1': 'error', '3': 2, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `FetchGenresResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fetchGenresResponseDescriptor = $convert.base64Decode(
    'ChNGZXRjaEdlbnJlc1Jlc3BvbnNlEhYKBmdlbnJlcxgBIAMoCVIGZ2VucmVzEhQKBWVycm9yGA'
    'IgASgJUgVlcnJvcg==');

@$core.Deprecated('Use fetchTagsResponseDescriptor instead')
const FetchTagsResponse$json = {
  '1': 'FetchTagsResponse',
  '2': [
    {
      '1': 'tags',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.goodanime.MediaTag',
      '10': 'tags'
    },
    {'1': 'error', '3': 2, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `FetchTagsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fetchTagsResponseDescriptor = $convert.base64Decode(
    'ChFGZXRjaFRhZ3NSZXNwb25zZRInCgR0YWdzGAEgAygLMhMuZ29vZGFuaW1lLk1lZGlhVGFnUg'
    'R0YWdzEhQKBWVycm9yGAIgASgJUgVlcnJvcg==');

@$core.Deprecated('Use fetchMediaSearchRequestDescriptor instead')
const FetchMediaSearchRequest$json = {
  '1': 'FetchMediaSearchRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'query', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'query', '17': true},
    {'1': 'sort', '3': 3, '4': 3, '5': 9, '10': 'sort'},
    {'1': 'type', '3': 4, '4': 1, '5': 9, '9': 1, '10': 'type', '17': true},
    {'1': 'format', '3': 5, '4': 1, '5': 9, '9': 2, '10': 'format', '17': true},
    {
      '1': 'format_not',
      '3': 6,
      '4': 1,
      '5': 9,
      '9': 3,
      '10': 'formatNot',
      '17': true
    },
    {'1': 'format_in', '3': 7, '4': 3, '5': 9, '10': 'formatIn'},
    {'1': 'format_not_in', '3': 8, '4': 3, '5': 9, '10': 'formatNotIn'},
    {'1': 'status', '3': 9, '4': 1, '5': 9, '9': 4, '10': 'status', '17': true},
    {
      '1': 'on_list',
      '3': 10,
      '4': 1,
      '5': 8,
      '9': 5,
      '10': 'onList',
      '17': true
    },
    {
      '1': 'min_average_score',
      '3': 11,
      '4': 1,
      '5': 5,
      '9': 6,
      '10': 'minAverageScore',
      '17': true
    },
    {
      '1': 'max_average_score',
      '3': 12,
      '4': 1,
      '5': 5,
      '9': 7,
      '10': 'maxAverageScore',
      '17': true
    },
    {
      '1': 'average_score',
      '3': 13,
      '4': 1,
      '5': 5,
      '9': 8,
      '10': 'averageScore',
      '17': true
    },
    {
      '1': 'season',
      '3': 14,
      '4': 1,
      '5': 9,
      '9': 9,
      '10': 'season',
      '17': true
    },
    {
      '1': 'start_date',
      '3': 15,
      '4': 1,
      '5': 5,
      '9': 10,
      '10': 'startDate',
      '17': true
    },
    {
      '1': 'min_start_date',
      '3': 16,
      '4': 1,
      '5': 5,
      '9': 11,
      '10': 'minStartDate',
      '17': true
    },
    {
      '1': 'max_start_date',
      '3': 17,
      '4': 1,
      '5': 5,
      '9': 12,
      '10': 'maxStartDate',
      '17': true
    },
    {
      '1': 'episodes',
      '3': 18,
      '4': 1,
      '5': 5,
      '9': 13,
      '10': 'episodes',
      '17': true
    },
    {
      '1': 'min_episodes',
      '3': 19,
      '4': 1,
      '5': 5,
      '9': 14,
      '10': 'minEpisodes',
      '17': true
    },
    {
      '1': 'max_episodes',
      '3': 20,
      '4': 1,
      '5': 5,
      '9': 15,
      '10': 'maxEpisodes',
      '17': true
    },
    {
      '1': 'duration',
      '3': 21,
      '4': 1,
      '5': 5,
      '9': 16,
      '10': 'duration',
      '17': true
    },
    {
      '1': 'min_duration',
      '3': 22,
      '4': 1,
      '5': 5,
      '9': 17,
      '10': 'minDuration',
      '17': true
    },
    {
      '1': 'max_duration',
      '3': 23,
      '4': 1,
      '5': 5,
      '9': 18,
      '10': 'maxDuration',
      '17': true
    },
    {
      '1': 'chapters',
      '3': 24,
      '4': 1,
      '5': 5,
      '9': 19,
      '10': 'chapters',
      '17': true
    },
    {
      '1': 'min_chapters',
      '3': 25,
      '4': 1,
      '5': 5,
      '9': 20,
      '10': 'minChapters',
      '17': true
    },
    {
      '1': 'max_chapters',
      '3': 26,
      '4': 1,
      '5': 5,
      '9': 21,
      '10': 'maxChapters',
      '17': true
    },
    {
      '1': 'volumes',
      '3': 27,
      '4': 1,
      '5': 5,
      '9': 22,
      '10': 'volumes',
      '17': true
    },
    {
      '1': 'min_volumes',
      '3': 28,
      '4': 1,
      '5': 5,
      '9': 23,
      '10': 'minVolumes',
      '17': true
    },
    {
      '1': 'max_volumes',
      '3': 29,
      '4': 1,
      '5': 5,
      '9': 24,
      '10': 'maxVolumes',
      '17': true
    },
    {
      '1': 'is_adult',
      '3': 30,
      '4': 1,
      '5': 8,
      '9': 25,
      '10': 'isAdult',
      '17': true
    },
    {'1': 'genre_in', '3': 31, '4': 3, '5': 9, '10': 'genreIn'},
    {'1': 'genre_not_in', '3': 32, '4': 3, '5': 9, '10': 'genreNotIn'},
    {'1': 'tag_in', '3': 33, '4': 3, '5': 9, '10': 'tagIn'},
    {'1': 'tag_not_in', '3': 34, '4': 3, '5': 9, '10': 'tagNotIn'},
    {
      '1': 'minimum_tag_rank',
      '3': 35,
      '4': 1,
      '5': 5,
      '9': 26,
      '10': 'minimumTagRank',
      '17': true
    },
  ],
  '8': [
    {'1': '_query'},
    {'1': '_type'},
    {'1': '_format'},
    {'1': '_format_not'},
    {'1': '_status'},
    {'1': '_on_list'},
    {'1': '_min_average_score'},
    {'1': '_max_average_score'},
    {'1': '_average_score'},
    {'1': '_season'},
    {'1': '_start_date'},
    {'1': '_min_start_date'},
    {'1': '_max_start_date'},
    {'1': '_episodes'},
    {'1': '_min_episodes'},
    {'1': '_max_episodes'},
    {'1': '_duration'},
    {'1': '_min_duration'},
    {'1': '_max_duration'},
    {'1': '_chapters'},
    {'1': '_min_chapters'},
    {'1': '_max_chapters'},
    {'1': '_volumes'},
    {'1': '_min_volumes'},
    {'1': '_max_volumes'},
    {'1': '_is_adult'},
    {'1': '_minimum_tag_rank'},
  ],
};

/// Descriptor for `FetchMediaSearchRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fetchMediaSearchRequestDescriptor = $convert.base64Decode(
    'ChdGZXRjaE1lZGlhU2VhcmNoUmVxdWVzdBISCgRwYWdlGAEgASgFUgRwYWdlEhkKBXF1ZXJ5GA'
    'IgASgJSABSBXF1ZXJ5iAEBEhIKBHNvcnQYAyADKAlSBHNvcnQSFwoEdHlwZRgEIAEoCUgBUgR0'
    'eXBliAEBEhsKBmZvcm1hdBgFIAEoCUgCUgZmb3JtYXSIAQESIgoKZm9ybWF0X25vdBgGIAEoCU'
    'gDUglmb3JtYXROb3SIAQESGwoJZm9ybWF0X2luGAcgAygJUghmb3JtYXRJbhIiCg1mb3JtYXRf'
    'bm90X2luGAggAygJUgtmb3JtYXROb3RJbhIbCgZzdGF0dXMYCSABKAlIBFIGc3RhdHVziAEBEh'
    'wKB29uX2xpc3QYCiABKAhIBVIGb25MaXN0iAEBEi8KEW1pbl9hdmVyYWdlX3Njb3JlGAsgASgF'
    'SAZSD21pbkF2ZXJhZ2VTY29yZYgBARIvChFtYXhfYXZlcmFnZV9zY29yZRgMIAEoBUgHUg9tYX'
    'hBdmVyYWdlU2NvcmWIAQESKAoNYXZlcmFnZV9zY29yZRgNIAEoBUgIUgxhdmVyYWdlU2NvcmWI'
    'AQESGwoGc2Vhc29uGA4gASgJSAlSBnNlYXNvbogBARIiCgpzdGFydF9kYXRlGA8gASgFSApSCX'
    'N0YXJ0RGF0ZYgBARIpCg5taW5fc3RhcnRfZGF0ZRgQIAEoBUgLUgxtaW5TdGFydERhdGWIAQES'
    'KQoObWF4X3N0YXJ0X2RhdGUYESABKAVIDFIMbWF4U3RhcnREYXRliAEBEh8KCGVwaXNvZGVzGB'
    'IgASgFSA1SCGVwaXNvZGVziAEBEiYKDG1pbl9lcGlzb2RlcxgTIAEoBUgOUgttaW5FcGlzb2Rl'
    'c4gBARImCgxtYXhfZXBpc29kZXMYFCABKAVID1ILbWF4RXBpc29kZXOIAQESHwoIZHVyYXRpb2'
    '4YFSABKAVIEFIIZHVyYXRpb26IAQESJgoMbWluX2R1cmF0aW9uGBYgASgFSBFSC21pbkR1cmF0'
    'aW9uiAEBEiYKDG1heF9kdXJhdGlvbhgXIAEoBUgSUgttYXhEdXJhdGlvbogBARIfCghjaGFwdG'
    'VycxgYIAEoBUgTUghjaGFwdGVyc4gBARImCgxtaW5fY2hhcHRlcnMYGSABKAVIFFILbWluQ2hh'
    'cHRlcnOIAQESJgoMbWF4X2NoYXB0ZXJzGBogASgFSBVSC21heENoYXB0ZXJziAEBEh0KB3ZvbH'
    'VtZXMYGyABKAVIFlIHdm9sdW1lc4gBARIkCgttaW5fdm9sdW1lcxgcIAEoBUgXUgptaW5Wb2x1'
    'bWVziAEBEiQKC21heF92b2x1bWVzGB0gASgFSBhSCm1heFZvbHVtZXOIAQESHgoIaXNfYWR1bH'
    'QYHiABKAhIGVIHaXNBZHVsdIgBARIZCghnZW5yZV9pbhgfIAMoCVIHZ2VucmVJbhIgCgxnZW5y'
    'ZV9ub3RfaW4YICADKAlSCmdlbnJlTm90SW4SFQoGdGFnX2luGCEgAygJUgV0YWdJbhIcCgp0YW'
    'dfbm90X2luGCIgAygJUgh0YWdOb3RJbhItChBtaW5pbXVtX3RhZ19yYW5rGCMgASgFSBpSDm1p'
    'bmltdW1UYWdSYW5riAEBQggKBl9xdWVyeUIHCgVfdHlwZUIJCgdfZm9ybWF0Qg0KC19mb3JtYX'
    'Rfbm90QgkKB19zdGF0dXNCCgoIX29uX2xpc3RCFAoSX21pbl9hdmVyYWdlX3Njb3JlQhQKEl9t'
    'YXhfYXZlcmFnZV9zY29yZUIQCg5fYXZlcmFnZV9zY29yZUIJCgdfc2Vhc29uQg0KC19zdGFydF'
    '9kYXRlQhEKD19taW5fc3RhcnRfZGF0ZUIRCg9fbWF4X3N0YXJ0X2RhdGVCCwoJX2VwaXNvZGVz'
    'Qg8KDV9taW5fZXBpc29kZXNCDwoNX21heF9lcGlzb2Rlc0ILCglfZHVyYXRpb25CDwoNX21pbl'
    '9kdXJhdGlvbkIPCg1fbWF4X2R1cmF0aW9uQgsKCV9jaGFwdGVyc0IPCg1fbWluX2NoYXB0ZXJz'
    'Qg8KDV9tYXhfY2hhcHRlcnNCCgoIX3ZvbHVtZXNCDgoMX21pbl92b2x1bWVzQg4KDF9tYXhfdm'
    '9sdW1lc0ILCglfaXNfYWR1bHRCEwoRX21pbmltdW1fdGFnX3Jhbms=');

@$core.Deprecated('Use fetchMediaSearchResponseDescriptor instead')
const FetchMediaSearchResponse$json = {
  '1': 'FetchMediaSearchResponse',
  '2': [
    {
      '1': 'media',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.goodanime.MediaMin',
      '10': 'media'
    },
    {
      '1': 'page_info',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.goodanime.PageInfo',
      '10': 'pageInfo'
    },
    {'1': 'error', '3': 3, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `FetchMediaSearchResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fetchMediaSearchResponseDescriptor = $convert.base64Decode(
    'ChhGZXRjaE1lZGlhU2VhcmNoUmVzcG9uc2USKQoFbWVkaWEYASADKAsyEy5nb29kYW5pbWUuTW'
    'VkaWFNaW5SBW1lZGlhEjAKCXBhZ2VfaW5mbxgCIAEoCzITLmdvb2RhbmltZS5QYWdlSW5mb1II'
    'cGFnZUluZm8SFAoFZXJyb3IYAyABKAlSBWVycm9y');
