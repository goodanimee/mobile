// This is a generated file - do not edit.
//
// Generated from media_misc.proto.

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

@$core.Deprecated('Use mediaTagDescriptor instead')
const MediaTag$json = {
  '1': 'MediaTag',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {
      '1': 'is_general_spoiler',
      '3': 2,
      '4': 1,
      '5': 8,
      '10': 'isGeneralSpoiler'
    },
    {'1': 'is_media_spoiler', '3': 3, '4': 1, '5': 8, '10': 'isMediaSpoiler'},
    {'1': 'name', '3': 4, '4': 1, '5': 9, '10': 'name'},
    {'1': 'rank', '3': 5, '4': 1, '5': 5, '10': 'rank'},
  ],
};

/// Descriptor for `MediaTag`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mediaTagDescriptor = $convert.base64Decode(
    'CghNZWRpYVRhZxIOCgJpZBgBIAEoBVICaWQSLAoSaXNfZ2VuZXJhbF9zcG9pbGVyGAIgASgIUh'
    'Bpc0dlbmVyYWxTcG9pbGVyEigKEGlzX21lZGlhX3Nwb2lsZXIYAyABKAhSDmlzTWVkaWFTcG9p'
    'bGVyEhIKBG5hbWUYBCABKAlSBG5hbWUSEgoEcmFuaxgFIAEoBVIEcmFuaw==');

@$core.Deprecated('Use externalLinkDescriptor instead')
const ExternalLink$json = {
  '1': 'ExternalLink',
  '2': [
    {'1': 'language', '3': 1, '4': 1, '5': 9, '10': 'language'},
    {'1': 'site', '3': 2, '4': 1, '5': 9, '10': 'site'},
    {'1': 'url', '3': 3, '4': 1, '5': 9, '10': 'url'},
  ],
};

/// Descriptor for `ExternalLink`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List externalLinkDescriptor = $convert.base64Decode(
    'CgxFeHRlcm5hbExpbmsSGgoIbGFuZ3VhZ2UYASABKAlSCGxhbmd1YWdlEhIKBHNpdGUYAiABKA'
    'lSBHNpdGUSEAoDdXJsGAMgASgJUgN1cmw=');

@$core.Deprecated('Use airingScheduleDescriptor instead')
const AiringSchedule$json = {
  '1': 'AiringSchedule',
  '2': [
    {'1': 'airing_at', '3': 1, '4': 1, '5': 5, '10': 'airingAt'},
    {'1': 'episode', '3': 2, '4': 1, '5': 5, '10': 'episode'},
    {'1': 'time_until_airing', '3': 3, '4': 1, '5': 5, '10': 'timeUntilAiring'},
  ],
};

/// Descriptor for `AiringSchedule`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List airingScheduleDescriptor = $convert.base64Decode(
    'Cg5BaXJpbmdTY2hlZHVsZRIbCglhaXJpbmdfYXQYASABKAVSCGFpcmluZ0F0EhgKB2VwaXNvZG'
    'UYAiABKAVSB2VwaXNvZGUSKgoRdGltZV91bnRpbF9haXJpbmcYAyABKAVSD3RpbWVVbnRpbEFp'
    'cmluZw==');

@$core.Deprecated('Use streamingEpisodeDescriptor instead')
const StreamingEpisode$json = {
  '1': 'StreamingEpisode',
  '2': [
    {'1': 'thumbnail', '3': 1, '4': 1, '5': 9, '10': 'thumbnail'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'url', '3': 3, '4': 1, '5': 9, '10': 'url'},
  ],
};

/// Descriptor for `StreamingEpisode`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List streamingEpisodeDescriptor = $convert.base64Decode(
    'ChBTdHJlYW1pbmdFcGlzb2RlEhwKCXRodW1ibmFpbBgBIAEoCVIJdGh1bWJuYWlsEhQKBXRpdG'
    'xlGAIgASgJUgV0aXRsZRIQCgN1cmwYAyABKAlSA3VybA==');

@$core.Deprecated('Use mediaRankDescriptor instead')
const MediaRank$json = {
  '1': 'MediaRank',
  '2': [
    {'1': 'all_time', '3': 1, '4': 1, '5': 8, '10': 'allTime'},
    {'1': 'rank', '3': 2, '4': 1, '5': 5, '10': 'rank'},
    {'1': 'type', '3': 3, '4': 1, '5': 9, '10': 'type'},
    {'1': 'season', '3': 4, '4': 1, '5': 9, '10': 'season'},
    {'1': 'year', '3': 5, '4': 1, '5': 5, '10': 'year'},
  ],
};

/// Descriptor for `MediaRank`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mediaRankDescriptor = $convert.base64Decode(
    'CglNZWRpYVJhbmsSGQoIYWxsX3RpbWUYASABKAhSB2FsbFRpbWUSEgoEcmFuaxgCIAEoBVIEcm'
    'FuaxISCgR0eXBlGAMgASgJUgR0eXBlEhYKBnNlYXNvbhgEIAEoCVIGc2Vhc29uEhIKBHllYXIY'
    'BSABKAVSBHllYXI=');

@$core.Deprecated('Use scoreDistributionDescriptor instead')
const ScoreDistribution$json = {
  '1': 'ScoreDistribution',
  '2': [
    {'1': 'amount', '3': 1, '4': 1, '5': 5, '10': 'amount'},
    {'1': 'score', '3': 2, '4': 1, '5': 5, '10': 'score'},
  ],
};

/// Descriptor for `ScoreDistribution`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scoreDistributionDescriptor = $convert.base64Decode(
    'ChFTY29yZURpc3RyaWJ1dGlvbhIWCgZhbW91bnQYASABKAVSBmFtb3VudBIUCgVzY29yZRgCIA'
    'EoBVIFc2NvcmU=');

@$core.Deprecated('Use statusDistributionDescriptor instead')
const StatusDistribution$json = {
  '1': 'StatusDistribution',
  '2': [
    {'1': 'amount', '3': 1, '4': 1, '5': 5, '10': 'amount'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `StatusDistribution`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List statusDistributionDescriptor = $convert.base64Decode(
    'ChJTdGF0dXNEaXN0cmlidXRpb24SFgoGYW1vdW50GAEgASgFUgZhbW91bnQSFgoGc3RhdHVzGA'
    'IgASgJUgZzdGF0dXM=');

@$core.Deprecated('Use mediaStatsDescriptor instead')
const MediaStats$json = {
  '1': 'MediaStats',
  '2': [
    {
      '1': 'score_distribution',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.goodanime.ScoreDistribution',
      '10': 'scoreDistribution'
    },
    {
      '1': 'status_distribution',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.goodanime.StatusDistribution',
      '10': 'statusDistribution'
    },
  ],
};

/// Descriptor for `MediaStats`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mediaStatsDescriptor = $convert.base64Decode(
    'CgpNZWRpYVN0YXRzEksKEnNjb3JlX2Rpc3RyaWJ1dGlvbhgBIAMoCzIcLmdvb2RhbmltZS5TY2'
    '9yZURpc3RyaWJ1dGlvblIRc2NvcmVEaXN0cmlidXRpb24STgoTc3RhdHVzX2Rpc3RyaWJ1dGlv'
    'bhgCIAMoCzIdLmdvb2RhbmltZS5TdGF0dXNEaXN0cmlidXRpb25SEnN0YXR1c0Rpc3RyaWJ1dG'
    'lvbg==');
