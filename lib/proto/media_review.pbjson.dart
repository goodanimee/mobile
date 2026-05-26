// This is a generated file - do not edit.
//
// Generated from media_review.proto.

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

@$core.Deprecated('Use reviewUserRatingDescriptor instead')
const ReviewUserRating$json = {
  '1': 'ReviewUserRating',
  '2': [
    {'1': 'REVIEW_USER_RATING_NO_VOTE_UNSPECIFIED', '2': 0},
    {'1': 'REVIEW_USER_RATING_UP_VOTE', '2': 1},
    {'1': 'REVIEW_USER_RATING_DOWN_VOTE', '2': 2},
  ],
};

/// Descriptor for `ReviewUserRating`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List reviewUserRatingDescriptor = $convert.base64Decode(
    'ChBSZXZpZXdVc2VyUmF0aW5nEioKJlJFVklFV19VU0VSX1JBVElOR19OT19WT1RFX1VOU1BFQ0'
    'lGSUVEEAASHgoaUkVWSUVXX1VTRVJfUkFUSU5HX1VQX1ZPVEUQARIgChxSRVZJRVdfVVNFUl9S'
    'QVRJTkdfRE9XTl9WT1RFEAI=');

@$core.Deprecated('Use reviewNodeDescriptor instead')
const ReviewNode$json = {
  '1': 'ReviewNode',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'score', '3': 2, '4': 1, '5': 5, '10': 'score'},
    {'1': 'rating', '3': 3, '4': 1, '5': 5, '10': 'rating'},
    {'1': 'rating_amount', '3': 4, '4': 1, '5': 5, '10': 'ratingAmount'},
    {'1': 'summary', '3': 5, '4': 1, '5': 9, '10': 'summary'},
    {
      '1': 'user_rating',
      '3': 6,
      '4': 1,
      '5': 14,
      '6': '.goodanime.ReviewUserRating',
      '10': 'userRating'
    },
    {
      '1': 'user',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.goodanime.Viewer',
      '10': 'user'
    },
    {'1': 'body', '3': 8, '4': 1, '5': 9, '10': 'body'},
  ],
};

/// Descriptor for `ReviewNode`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reviewNodeDescriptor = $convert.base64Decode(
    'CgpSZXZpZXdOb2RlEg4KAmlkGAEgASgFUgJpZBIUCgVzY29yZRgCIAEoBVIFc2NvcmUSFgoGcm'
    'F0aW5nGAMgASgFUgZyYXRpbmcSIwoNcmF0aW5nX2Ftb3VudBgEIAEoBVIMcmF0aW5nQW1vdW50'
    'EhgKB3N1bW1hcnkYBSABKAlSB3N1bW1hcnkSPAoLdXNlcl9yYXRpbmcYBiABKA4yGy5nb29kYW'
    '5pbWUuUmV2aWV3VXNlclJhdGluZ1IKdXNlclJhdGluZxIlCgR1c2VyGAcgASgLMhEuZ29vZGFu'
    'aW1lLlZpZXdlclIEdXNlchISCgRib2R5GAggASgJUgRib2R5');

@$core.Deprecated('Use reviewConnectionDescriptor instead')
const ReviewConnection$json = {
  '1': 'ReviewConnection',
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
      '1': 'nodes',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.goodanime.ReviewNode',
      '10': 'nodes'
    },
  ],
};

/// Descriptor for `ReviewConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reviewConnectionDescriptor = $convert.base64Decode(
    'ChBSZXZpZXdDb25uZWN0aW9uEjAKCXBhZ2VfaW5mbxgBIAEoCzITLmdvb2RhbmltZS5QYWdlSW'
    '5mb1IIcGFnZUluZm8SKwoFbm9kZXMYAiADKAsyFS5nb29kYW5pbWUuUmV2aWV3Tm9kZVIFbm9k'
    'ZXM=');
