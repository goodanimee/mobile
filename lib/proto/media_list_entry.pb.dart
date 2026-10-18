// This is a generated file - do not edit.
//
// Generated from media_list_entry.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class MediaListEntry extends $pb.GeneratedMessage {
  factory MediaListEntry({
    $core.int? id,
    $0.MediaListStatus? status,
    $core.int? progress,
    $core.double? score,
    $core.int? repeat,
    $0.FuzzyDate? startedAt,
    $0.FuzzyDate? completedAt,
    $core.int? progressVolumes,
    $core.bool? private,
    $core.bool? hiddenFromStatusLists,
    $core.String? notes,
    $core.Iterable<$core.String>? customLists,
  }) {
    final result = MediaListEntry._();
    if (id != null) result.id = id;
    if (status != null) result.status = status;
    if (progress != null) result.progress = progress;
    if (score != null) result.score = score;
    if (repeat != null) result.repeat = repeat;
    if (startedAt != null) result.startedAt = startedAt;
    if (completedAt != null) result.completedAt = completedAt;
    if (progressVolumes != null) result.progressVolumes = progressVolumes;
    if (private != null) result.private = private;
    if (hiddenFromStatusLists != null)
      result.hiddenFromStatusLists = hiddenFromStatusLists;
    if (notes != null) result.notes = notes;
    if (customLists != null) result.customLists.addAll(customLists);
    return result;
  }

  MediaListEntry._();

  factory MediaListEntry.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MediaListEntry()..mergeFromBuffer(data, registry);
  factory MediaListEntry.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MediaListEntry()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MediaListEntry',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: MediaListEntry.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..aE<$0.MediaListStatus>(2, _omitFieldNames ? '' : 'status',
        enumValues: $0.MediaListStatus.values)
    ..aI(3, _omitFieldNames ? '' : 'progress')
    ..aD(4, _omitFieldNames ? '' : 'score')
    ..aI(5, _omitFieldNames ? '' : 'repeat')
    ..aOM<$0.FuzzyDate>(6, _omitFieldNames ? '' : 'startedAt',
        subBuilder: $0.FuzzyDate.$_createMessage)
    ..aOM<$0.FuzzyDate>(7, _omitFieldNames ? '' : 'completedAt',
        subBuilder: $0.FuzzyDate.$_createMessage)
    ..aI(8, _omitFieldNames ? '' : 'progressVolumes')
    ..aOB(9, _omitFieldNames ? '' : 'private')
    ..aOB(10, _omitFieldNames ? '' : 'hiddenFromStatusLists')
    ..aOS(11, _omitFieldNames ? '' : 'notes')
    ..pPS(12, _omitFieldNames ? '' : 'customLists')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaListEntry clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaListEntry copyWith(void Function(MediaListEntry) updates) =>
      super.copyWith((message) => updates(message as MediaListEntry))
          as MediaListEntry;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use MediaListEntry() / MediaListEntry.new instead')
  static MediaListEntry create() => MediaListEntry._();
  static $pb.GeneratedMessage $_createMessage() => MediaListEntry._();
  @$core.override
  MediaListEntry createEmptyInstance() => MediaListEntry._();
  @$core.pragma('dart2js:noInline')
  static MediaListEntry getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MediaListEntry>(
          MediaListEntry.$_createMessage);
  static MediaListEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $0.MediaListStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status($0.MediaListStatus value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get progress => $_getIZ(2);
  @$pb.TagNumber(3)
  set progress($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasProgress() => $_has(2);
  @$pb.TagNumber(3)
  void clearProgress() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get score => $_getN(3);
  @$pb.TagNumber(4)
  set score($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasScore() => $_has(3);
  @$pb.TagNumber(4)
  void clearScore() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get repeat => $_getIZ(4);
  @$pb.TagNumber(5)
  set repeat($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasRepeat() => $_has(4);
  @$pb.TagNumber(5)
  void clearRepeat() => $_clearField(5);

  @$pb.TagNumber(6)
  $0.FuzzyDate get startedAt => $_getN(5);
  @$pb.TagNumber(6)
  set startedAt($0.FuzzyDate value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasStartedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearStartedAt() => $_clearField(6);
  @$pb.TagNumber(6)
  $0.FuzzyDate ensureStartedAt() => $_ensure(5);

  @$pb.TagNumber(7)
  $0.FuzzyDate get completedAt => $_getN(6);
  @$pb.TagNumber(7)
  set completedAt($0.FuzzyDate value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasCompletedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearCompletedAt() => $_clearField(7);
  @$pb.TagNumber(7)
  $0.FuzzyDate ensureCompletedAt() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.int get progressVolumes => $_getIZ(7);
  @$pb.TagNumber(8)
  set progressVolumes($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasProgressVolumes() => $_has(7);
  @$pb.TagNumber(8)
  void clearProgressVolumes() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.bool get private => $_getBF(8);
  @$pb.TagNumber(9)
  set private($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasPrivate() => $_has(8);
  @$pb.TagNumber(9)
  void clearPrivate() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.bool get hiddenFromStatusLists => $_getBF(9);
  @$pb.TagNumber(10)
  set hiddenFromStatusLists($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasHiddenFromStatusLists() => $_has(9);
  @$pb.TagNumber(10)
  void clearHiddenFromStatusLists() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get notes => $_getSZ(10);
  @$pb.TagNumber(11)
  set notes($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasNotes() => $_has(10);
  @$pb.TagNumber(11)
  void clearNotes() => $_clearField(11);

  @$pb.TagNumber(12)
  $pb.PbList<$core.String> get customLists => $_getList(11);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
