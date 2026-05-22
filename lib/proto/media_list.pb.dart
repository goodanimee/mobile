// This is a generated file - do not edit.
//
// Generated from media_list.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pbenum.dart' as $2;
import 'media_list_entry.pb.dart' as $0;
import 'media_min.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class MediaListEntryWithMedia extends $pb.GeneratedMessage {
  factory MediaListEntryWithMedia({
    $0.MediaListEntry? entry,
    $1.MediaMin? media,
  }) {
    final result = create();
    if (entry != null) result.entry = entry;
    if (media != null) result.media = media;
    return result;
  }

  MediaListEntryWithMedia._();

  factory MediaListEntryWithMedia.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MediaListEntryWithMedia.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MediaListEntryWithMedia',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aOM<$0.MediaListEntry>(1, _omitFieldNames ? '' : 'entry',
        subBuilder: $0.MediaListEntry.create)
    ..aOM<$1.MediaMin>(2, _omitFieldNames ? '' : 'media',
        subBuilder: $1.MediaMin.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaListEntryWithMedia clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaListEntryWithMedia copyWith(
          void Function(MediaListEntryWithMedia) updates) =>
      super.copyWith((message) => updates(message as MediaListEntryWithMedia))
          as MediaListEntryWithMedia;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MediaListEntryWithMedia create() => MediaListEntryWithMedia._();
  @$core.override
  MediaListEntryWithMedia createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MediaListEntryWithMedia getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MediaListEntryWithMedia>(create);
  static MediaListEntryWithMedia? _defaultInstance;

  @$pb.TagNumber(1)
  $0.MediaListEntry get entry => $_getN(0);
  @$pb.TagNumber(1)
  set entry($0.MediaListEntry value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasEntry() => $_has(0);
  @$pb.TagNumber(1)
  void clearEntry() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.MediaListEntry ensureEntry() => $_ensure(0);

  @$pb.TagNumber(2)
  $1.MediaMin get media => $_getN(1);
  @$pb.TagNumber(2)
  set media($1.MediaMin value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasMedia() => $_has(1);
  @$pb.TagNumber(2)
  void clearMedia() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.MediaMin ensureMedia() => $_ensure(1);
}

class MediaListGroup extends $pb.GeneratedMessage {
  factory MediaListGroup({
    $core.String? name,
    $2.MediaListStatus? status,
    $core.Iterable<MediaListEntryWithMedia>? entries,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (status != null) result.status = status;
    if (entries != null) result.entries.addAll(entries);
    return result;
  }

  MediaListGroup._();

  factory MediaListGroup.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MediaListGroup.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MediaListGroup',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aE<$2.MediaListStatus>(2, _omitFieldNames ? '' : 'status',
        enumValues: $2.MediaListStatus.values)
    ..pPM<MediaListEntryWithMedia>(3, _omitFieldNames ? '' : 'entries',
        subBuilder: MediaListEntryWithMedia.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaListGroup clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaListGroup copyWith(void Function(MediaListGroup) updates) =>
      super.copyWith((message) => updates(message as MediaListGroup))
          as MediaListGroup;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MediaListGroup create() => MediaListGroup._();
  @$core.override
  MediaListGroup createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MediaListGroup getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MediaListGroup>(create);
  static MediaListGroup? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $2.MediaListStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status($2.MediaListStatus value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<MediaListEntryWithMedia> get entries => $_getList(2);
}

class MediaListCollection extends $pb.GeneratedMessage {
  factory MediaListCollection({
    $core.bool? hasNextChunk,
    $core.Iterable<MediaListGroup>? lists,
  }) {
    final result = create();
    if (hasNextChunk != null) result.hasNextChunk = hasNextChunk;
    if (lists != null) result.lists.addAll(lists);
    return result;
  }

  MediaListCollection._();

  factory MediaListCollection.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MediaListCollection.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MediaListCollection',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'goodanime'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'hasNextChunk')
    ..pPM<MediaListGroup>(2, _omitFieldNames ? '' : 'lists',
        subBuilder: MediaListGroup.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaListCollection clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaListCollection copyWith(void Function(MediaListCollection) updates) =>
      super.copyWith((message) => updates(message as MediaListCollection))
          as MediaListCollection;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MediaListCollection create() => MediaListCollection._();
  @$core.override
  MediaListCollection createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MediaListCollection getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MediaListCollection>(create);
  static MediaListCollection? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get hasNextChunk => $_getBF(0);
  @$pb.TagNumber(1)
  set hasNextChunk($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasHasNextChunk() => $_has(0);
  @$pb.TagNumber(1)
  void clearHasNextChunk() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<MediaListGroup> get lists => $_getList(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
