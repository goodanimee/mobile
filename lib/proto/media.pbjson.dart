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
    {'1': 'season_year', '3': 8, '4': 1, '5': 5, '10': 'seasonYear'},
    {'1': 'type', '3': 9, '4': 1, '5': 9, '10': 'type'},
    {
      '1': 'trailer',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.goodanime.Trailer',
      '10': 'trailer'
    },
    {
      '1': 'media_list_entry',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.goodanime.MediaListEntry',
      '10': 'mediaListEntry'
    },
    {
      '1': 'studios',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.goodanime.StudioConnection',
      '10': 'studios'
    },
    {
      '1': 'tags',
      '3': 13,
      '4': 3,
      '5': 11,
      '6': '.goodanime.MediaTag',
      '10': 'tags'
    },
    {
      '1': 'external_links',
      '3': 14,
      '4': 3,
      '5': 11,
      '6': '.goodanime.ExternalLink',
      '10': 'externalLinks'
    },
    {
      '1': 'streaming_episodes',
      '3': 15,
      '4': 3,
      '5': 11,
      '6': '.goodanime.StreamingEpisode',
      '10': 'streamingEpisodes'
    },
    {
      '1': 'staff',
      '3': 16,
      '4': 1,
      '5': 11,
      '6': '.goodanime.StaffConnection',
      '10': 'staff'
    },
    {
      '1': 'next_airing_episode',
      '3': 17,
      '4': 1,
      '5': 11,
      '6': '.goodanime.AiringSchedule',
      '10': 'nextAiringEpisode'
    },
    {
      '1': 'characters',
      '3': 18,
      '4': 1,
      '5': 11,
      '6': '.goodanime.CharacterConnection',
      '10': 'characters'
    },
    {
      '1': 'relations',
      '3': 19,
      '4': 1,
      '5': 11,
      '6': '.goodanime.MediaConnection',
      '10': 'relations'
    },
    {
      '1': 'recommendations',
      '3': 20,
      '4': 1,
      '5': 11,
      '6': '.goodanime.RecommendationConnection',
      '10': 'recommendations'
    },
    {
      '1': 'rankings',
      '3': 21,
      '4': 3,
      '5': 11,
      '6': '.goodanime.MediaRank',
      '10': 'rankings'
    },
    {
      '1': 'stats',
      '3': 22,
      '4': 1,
      '5': 11,
      '6': '.goodanime.MediaStats',
      '10': 'stats'
    },
    {
      '1': 'trends',
      '3': 23,
      '4': 1,
      '5': 11,
      '6': '.goodanime.MediaTrendConnection',
      '10': 'trends'
    },
    {
      '1': 'mean_score',
      '3': 24,
      '4': 1,
      '5': 5,
      '9': 0,
      '10': 'meanScore',
      '17': true
    },
    {
      '1': 'favourites',
      '3': 25,
      '4': 1,
      '5': 5,
      '9': 1,
      '10': 'favourites',
      '17': true
    },
    {'1': 'synonyms', '3': 26, '4': 3, '5': 9, '10': 'synonyms'},
    {
      '1': 'reviews',
      '3': 27,
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
    'HwoLc2Vhc29uX3llYXIYCCABKAVSCnNlYXNvblllYXISEgoEdHlwZRgJIAEoCVIEdHlwZRIsCg'
    'd0cmFpbGVyGAogASgLMhIuZ29vZGFuaW1lLlRyYWlsZXJSB3RyYWlsZXISQwoQbWVkaWFfbGlz'
    'dF9lbnRyeRgLIAEoCzIZLmdvb2RhbmltZS5NZWRpYUxpc3RFbnRyeVIObWVkaWFMaXN0RW50cn'
    'kSNQoHc3R1ZGlvcxgMIAEoCzIbLmdvb2RhbmltZS5TdHVkaW9Db25uZWN0aW9uUgdzdHVkaW9z'
    'EicKBHRhZ3MYDSADKAsyEy5nb29kYW5pbWUuTWVkaWFUYWdSBHRhZ3MSPgoOZXh0ZXJuYWxfbG'
    'lua3MYDiADKAsyFy5nb29kYW5pbWUuRXh0ZXJuYWxMaW5rUg1leHRlcm5hbExpbmtzEkoKEnN0'
    'cmVhbWluZ19lcGlzb2RlcxgPIAMoCzIbLmdvb2RhbmltZS5TdHJlYW1pbmdFcGlzb2RlUhFzdH'
    'JlYW1pbmdFcGlzb2RlcxIwCgVzdGFmZhgQIAEoCzIaLmdvb2RhbmltZS5TdGFmZkNvbm5lY3Rp'
    'b25SBXN0YWZmEkkKE25leHRfYWlyaW5nX2VwaXNvZGUYESABKAsyGS5nb29kYW5pbWUuQWlyaW'
    '5nU2NoZWR1bGVSEW5leHRBaXJpbmdFcGlzb2RlEj4KCmNoYXJhY3RlcnMYEiABKAsyHi5nb29k'
    'YW5pbWUuQ2hhcmFjdGVyQ29ubmVjdGlvblIKY2hhcmFjdGVycxI4CglyZWxhdGlvbnMYEyABKA'
    'syGi5nb29kYW5pbWUuTWVkaWFDb25uZWN0aW9uUglyZWxhdGlvbnMSTQoPcmVjb21tZW5kYXRp'
    'b25zGBQgASgLMiMuZ29vZGFuaW1lLlJlY29tbWVuZGF0aW9uQ29ubmVjdGlvblIPcmVjb21tZW'
    '5kYXRpb25zEjAKCHJhbmtpbmdzGBUgAygLMhQuZ29vZGFuaW1lLk1lZGlhUmFua1IIcmFua2lu'
    'Z3MSKwoFc3RhdHMYFiABKAsyFS5nb29kYW5pbWUuTWVkaWFTdGF0c1IFc3RhdHMSNwoGdHJlbm'
    'RzGBcgASgLMh8uZ29vZGFuaW1lLk1lZGlhVHJlbmRDb25uZWN0aW9uUgZ0cmVuZHMSIgoKbWVh'
    'bl9zY29yZRgYIAEoBUgAUgltZWFuU2NvcmWIAQESIwoKZmF2b3VyaXRlcxgZIAEoBUgBUgpmYX'
    'ZvdXJpdGVziAEBEhoKCHN5bm9ueW1zGBogAygJUghzeW5vbnltcxI1CgdyZXZpZXdzGBsgASgL'
    'MhsuZ29vZGFuaW1lLlJldmlld0Nvbm5lY3Rpb25SB3Jldmlld3NCDQoLX21lYW5fc2NvcmVCDQ'
    'oLX2Zhdm91cml0ZXM=');
