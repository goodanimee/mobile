// This is a generated file - do not edit.
//
// Generated from media.proto.

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

@$core.Deprecated('Use mediaDescriptor instead')
const Media$json = {
  '1': 'Media',
  '2': [
    {
      '1': 'base',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.goodanime.MediaMin',
      '10': 'base'
    },
    {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    {'1': 'banner_image', '3': 3, '4': 1, '5': 9, '10': 'bannerImage'},
    {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
    {'1': 'genres', '3': 5, '4': 3, '5': 9, '10': 'genres'},
    {'1': 'popularity', '3': 6, '4': 1, '5': 5, '10': 'popularity'},
    {'1': 'season', '3': 7, '4': 1, '5': 9, '10': 'season'},
    {
      '1': 'trailer',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.goodanime.Trailer',
      '10': 'trailer'
    },
    {
      '1': 'media_list_entry',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.goodanime.MediaListEntry',
      '10': 'mediaListEntry'
    },
    {
      '1': 'studios',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.goodanime.StudioConnection',
      '10': 'studios'
    },
    {
      '1': 'tags',
      '3': 12,
      '4': 3,
      '5': 11,
      '6': '.goodanime.MediaTag',
      '10': 'tags'
    },
    {
      '1': 'external_links',
      '3': 13,
      '4': 3,
      '5': 11,
      '6': '.goodanime.ExternalLink',
      '10': 'externalLinks'
    },
    {
      '1': 'streaming_episodes',
      '3': 14,
      '4': 3,
      '5': 11,
      '6': '.goodanime.StreamingEpisode',
      '10': 'streamingEpisodes'
    },
    {
      '1': 'staff',
      '3': 15,
      '4': 1,
      '5': 11,
      '6': '.goodanime.StaffConnection',
      '10': 'staff'
    },
    {
      '1': 'next_airing_episode',
      '3': 16,
      '4': 1,
      '5': 11,
      '6': '.goodanime.AiringSchedule',
      '10': 'nextAiringEpisode'
    },
    {
      '1': 'characters',
      '3': 17,
      '4': 1,
      '5': 11,
      '6': '.goodanime.CharacterConnection',
      '10': 'characters'
    },
    {
      '1': 'relations',
      '3': 18,
      '4': 1,
      '5': 11,
      '6': '.goodanime.MediaConnection',
      '10': 'relations'
    },
    {
      '1': 'recommendations',
      '3': 19,
      '4': 1,
      '5': 11,
      '6': '.goodanime.RecommendationConnection',
      '10': 'recommendations'
    },
    {
      '1': 'rankings',
      '3': 20,
      '4': 3,
      '5': 11,
      '6': '.goodanime.MediaRank',
      '10': 'rankings'
    },
    {
      '1': 'stats',
      '3': 21,
      '4': 1,
      '5': 11,
      '6': '.goodanime.MediaStats',
      '10': 'stats'
    },
    {
      '1': 'trends',
      '3': 22,
      '4': 1,
      '5': 11,
      '6': '.goodanime.MediaTrendConnection',
      '10': 'trends'
    },
    {
      '1': 'mean_score',
      '3': 23,
      '4': 1,
      '5': 5,
      '9': 0,
      '10': 'meanScore',
      '17': true
    },
    {
      '1': 'favourites',
      '3': 24,
      '4': 1,
      '5': 5,
      '9': 1,
      '10': 'favourites',
      '17': true
    },
    {'1': 'synonyms', '3': 25, '4': 3, '5': 9, '10': 'synonyms'},
    {
      '1': 'reviews',
      '3': 26,
      '4': 1,
      '5': 11,
      '6': '.goodanime.ReviewConnection',
      '10': 'reviews'
    },
  ],
  '8': [
    {'1': '_mean_score'},
    {'1': '_favourites'},
  ],
};

/// Descriptor for `Media`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mediaDescriptor = $convert.base64Decode(
    'CgVNZWRpYRInCgRiYXNlGAEgASgLMhMuZ29vZGFuaW1lLk1lZGlhTWluUgRiYXNlEiAKC2Rlc2'
    'NyaXB0aW9uGAIgASgJUgtkZXNjcmlwdGlvbhIhCgxiYW5uZXJfaW1hZ2UYAyABKAlSC2Jhbm5l'
    'ckltYWdlEhYKBnN0YXR1cxgEIAEoCVIGc3RhdHVzEhYKBmdlbnJlcxgFIAMoCVIGZ2VucmVzEh'
    '4KCnBvcHVsYXJpdHkYBiABKAVSCnBvcHVsYXJpdHkSFgoGc2Vhc29uGAcgASgJUgZzZWFzb24S'
    'LAoHdHJhaWxlchgJIAEoCzISLmdvb2RhbmltZS5UcmFpbGVyUgd0cmFpbGVyEkMKEG1lZGlhX2'
    'xpc3RfZW50cnkYCiABKAsyGS5nb29kYW5pbWUuTWVkaWFMaXN0RW50cnlSDm1lZGlhTGlzdEVu'
    'dHJ5EjUKB3N0dWRpb3MYCyABKAsyGy5nb29kYW5pbWUuU3R1ZGlvQ29ubmVjdGlvblIHc3R1ZG'
    'lvcxInCgR0YWdzGAwgAygLMhMuZ29vZGFuaW1lLk1lZGlhVGFnUgR0YWdzEj4KDmV4dGVybmFs'
    'X2xpbmtzGA0gAygLMhcuZ29vZGFuaW1lLkV4dGVybmFsTGlua1INZXh0ZXJuYWxMaW5rcxJKCh'
    'JzdHJlYW1pbmdfZXBpc29kZXMYDiADKAsyGy5nb29kYW5pbWUuU3RyZWFtaW5nRXBpc29kZVIR'
    'c3RyZWFtaW5nRXBpc29kZXMSMAoFc3RhZmYYDyABKAsyGi5nb29kYW5pbWUuU3RhZmZDb25uZW'
    'N0aW9uUgVzdGFmZhJJChNuZXh0X2FpcmluZ19lcGlzb2RlGBAgASgLMhkuZ29vZGFuaW1lLkFp'
    'cmluZ1NjaGVkdWxlUhFuZXh0QWlyaW5nRXBpc29kZRI+CgpjaGFyYWN0ZXJzGBEgASgLMh4uZ2'
    '9vZGFuaW1lLkNoYXJhY3RlckNvbm5lY3Rpb25SCmNoYXJhY3RlcnMSOAoJcmVsYXRpb25zGBIg'
    'ASgLMhouZ29vZGFuaW1lLk1lZGlhQ29ubmVjdGlvblIJcmVsYXRpb25zEk0KD3JlY29tbWVuZG'
    'F0aW9ucxgTIAEoCzIjLmdvb2RhbmltZS5SZWNvbW1lbmRhdGlvbkNvbm5lY3Rpb25SD3JlY29t'
    'bWVuZGF0aW9ucxIwCghyYW5raW5ncxgUIAMoCzIULmdvb2RhbmltZS5NZWRpYVJhbmtSCHJhbm'
    'tpbmdzEisKBXN0YXRzGBUgASgLMhUuZ29vZGFuaW1lLk1lZGlhU3RhdHNSBXN0YXRzEjcKBnRy'
    'ZW5kcxgWIAEoCzIfLmdvb2RhbmltZS5NZWRpYVRyZW5kQ29ubmVjdGlvblIGdHJlbmRzEiIKCm'
    '1lYW5fc2NvcmUYFyABKAVIAFIJbWVhblNjb3JliAEBEiMKCmZhdm91cml0ZXMYGCABKAVIAVIK'
    'ZmF2b3VyaXRlc4gBARIaCghzeW5vbnltcxgZIAMoCVIIc3lub255bXMSNQoHcmV2aWV3cxgaIA'
    'EoCzIbLmdvb2RhbmltZS5SZXZpZXdDb25uZWN0aW9uUgdyZXZpZXdzQg0KC19tZWFuX3Njb3Jl'
    'Qg0KC19mYXZvdXJpdGVz');
