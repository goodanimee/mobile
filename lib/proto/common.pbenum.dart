// This is a generated file - do not edit.
//
// Generated from common.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class MediaListStatus extends $pb.ProtobufEnum {
  static const MediaListStatus MEDIA_LIST_STATUS_UNSPECIFIED =
      MediaListStatus._(
          0, _omitEnumNames ? '' : 'MEDIA_LIST_STATUS_UNSPECIFIED');
  static const MediaListStatus MEDIA_LIST_STATUS_CURRENT =
      MediaListStatus._(1, _omitEnumNames ? '' : 'MEDIA_LIST_STATUS_CURRENT');
  static const MediaListStatus MEDIA_LIST_STATUS_PLANNING =
      MediaListStatus._(2, _omitEnumNames ? '' : 'MEDIA_LIST_STATUS_PLANNING');
  static const MediaListStatus MEDIA_LIST_STATUS_COMPLETED =
      MediaListStatus._(3, _omitEnumNames ? '' : 'MEDIA_LIST_STATUS_COMPLETED');
  static const MediaListStatus MEDIA_LIST_STATUS_DROPPED =
      MediaListStatus._(4, _omitEnumNames ? '' : 'MEDIA_LIST_STATUS_DROPPED');
  static const MediaListStatus MEDIA_LIST_STATUS_PAUSED =
      MediaListStatus._(5, _omitEnumNames ? '' : 'MEDIA_LIST_STATUS_PAUSED');
  static const MediaListStatus MEDIA_LIST_STATUS_REPEATING =
      MediaListStatus._(6, _omitEnumNames ? '' : 'MEDIA_LIST_STATUS_REPEATING');

  static const $core.List<MediaListStatus> values = <MediaListStatus>[
    MEDIA_LIST_STATUS_UNSPECIFIED,
    MEDIA_LIST_STATUS_CURRENT,
    MEDIA_LIST_STATUS_PLANNING,
    MEDIA_LIST_STATUS_COMPLETED,
    MEDIA_LIST_STATUS_DROPPED,
    MEDIA_LIST_STATUS_PAUSED,
    MEDIA_LIST_STATUS_REPEATING,
  ];

  static final $core.List<MediaListStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 6);
  static MediaListStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const MediaListStatus._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
