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

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'common.pbenum.dart';

class FuzzyDate extends $pb.GeneratedMessage {
  factory FuzzyDate({
    $core.int? day,
    $core.int? month,
    $core.int? year,
  }) {
    final result = create();
    if (day != null) result.day = day;
    if (month != null) result.month = month;
    if (year != null) result.year = year;
    return result;
  }

  FuzzyDate._();

  factory FuzzyDate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FuzzyDate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FuzzyDate',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'day')
    ..aI(2, _omitFieldNames ? '' : 'month')
    ..aI(3, _omitFieldNames ? '' : 'year')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FuzzyDate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FuzzyDate copyWith(void Function(FuzzyDate) updates) =>
      super.copyWith((message) => updates(message as FuzzyDate)) as FuzzyDate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FuzzyDate create() => FuzzyDate._();
  @$core.override
  FuzzyDate createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FuzzyDate getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FuzzyDate>(create);
  static FuzzyDate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get day => $_getIZ(0);
  @$pb.TagNumber(1)
  set day($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDay() => $_has(0);
  @$pb.TagNumber(1)
  void clearDay() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get month => $_getIZ(1);
  @$pb.TagNumber(2)
  set month($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMonth() => $_has(1);
  @$pb.TagNumber(2)
  void clearMonth() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get year => $_getIZ(2);
  @$pb.TagNumber(3)
  set year($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasYear() => $_has(2);
  @$pb.TagNumber(3)
  void clearYear() => $_clearField(3);
}

class PageInfo extends $pb.GeneratedMessage {
  factory PageInfo({
    $core.bool? hasNextPage,
    $core.int? currentPage,
  }) {
    final result = create();
    if (hasNextPage != null) result.hasNextPage = hasNextPage;
    if (currentPage != null) result.currentPage = currentPage;
    return result;
  }

  PageInfo._();

  factory PageInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PageInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PageInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'hasNextPage')
    ..aI(2, _omitFieldNames ? '' : 'currentPage')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PageInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PageInfo copyWith(void Function(PageInfo) updates) =>
      super.copyWith((message) => updates(message as PageInfo)) as PageInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PageInfo create() => PageInfo._();
  @$core.override
  PageInfo createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PageInfo getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PageInfo>(create);
  static PageInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get hasNextPage => $_getBF(0);
  @$pb.TagNumber(1)
  set hasNextPage($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasHasNextPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearHasNextPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get currentPage => $_getIZ(1);
  @$pb.TagNumber(2)
  set currentPage($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCurrentPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrentPage() => $_clearField(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
