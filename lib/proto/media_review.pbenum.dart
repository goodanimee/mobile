// This is a generated file - do not edit.
//
// Generated from media_review.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ReviewUserRating extends $pb.ProtobufEnum {
  static const ReviewUserRating REVIEW_USER_RATING_NO_VOTE_UNSPECIFIED =
      ReviewUserRating._(
          0, _omitEnumNames ? '' : 'REVIEW_USER_RATING_NO_VOTE_UNSPECIFIED');
  static const ReviewUserRating REVIEW_USER_RATING_UP_VOTE =
      ReviewUserRating._(1, _omitEnumNames ? '' : 'REVIEW_USER_RATING_UP_VOTE');
  static const ReviewUserRating REVIEW_USER_RATING_DOWN_VOTE =
      ReviewUserRating._(
          2, _omitEnumNames ? '' : 'REVIEW_USER_RATING_DOWN_VOTE');

  static const $core.List<ReviewUserRating> values = <ReviewUserRating>[
    REVIEW_USER_RATING_NO_VOTE_UNSPECIFIED,
    REVIEW_USER_RATING_UP_VOTE,
    REVIEW_USER_RATING_DOWN_VOTE,
  ];

  static final $core.List<ReviewUserRating?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static ReviewUserRating? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ReviewUserRating._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
