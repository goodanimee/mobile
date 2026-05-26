import 'package:protobuf/protobuf.dart';
import '../proto/media_list.pb.dart' as pb;
import '../proto/media_list_entry.pb.dart' as pb_entry;
import '../proto/media_min.pb.dart' as pb_min;
import 'common.dart';
import 'media_list_entry.dart';
import 'media_min.dart';

/// Extends MediaListEntry to include the minimal media object
class MediaListEntryWithMedia extends MediaListEntry {
  /// The associated media
  final MediaMin media;

  /// Creates a media list entry with media
  const MediaListEntryWithMedia({
    required super.id,
    super.status,
    required super.progress,
    required super.score,
    required super.repeat,
    super.startedAt,
    super.completedAt,
    required this.media,
  });

  /// Creates a media list entry with media from a protobuf object
  factory MediaListEntryWithMedia.fromProto(pb.MediaListEntryWithMedia pbObj) {
    return MediaListEntryWithMedia(
      id: pbObj.entry.id,
      status: pbObj.entry.hasStatus()
          ? MediaListStatus.fromProto(pbObj.entry.status)
          : null,
      progress: pbObj.entry.progress,
      score: pbObj.entry.score,
      repeat: pbObj.entry.repeat,
      startedAt: pbObj.entry.hasStartedAt()
          ? FuzzyDate.fromProto(pbObj.entry.startedAt)
          : null,
      completedAt: pbObj.entry.hasCompletedAt()
          ? FuzzyDate.fromProto(pbObj.entry.completedAt)
          : null,
      media: MediaMin.fromProto(pbObj.media),
    );
  }

  /// Converts the entry with media to a protobuf object
  @override
  GeneratedMessage toProto() {
    final pbObj = pb.MediaListEntryWithMedia();
    pbObj.entry = super.toProto() as pb_entry.MediaListEntry;
    pbObj.media = media.toProto() as pb_min.MediaMin;
    return pbObj;
  }

  /// Creates a copy of this object with the given fields replaced
  @override
  MediaListEntryWithMedia copyWith({
    int? id,
    MediaListStatus? status,
    int? progress,
    double? score,
    int? repeat,
    FuzzyDate? startedAt,
    FuzzyDate? completedAt,
    MediaMin? media,
  }) {
    return MediaListEntryWithMedia(
      id: id ?? this.id,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      score: score ?? this.score,
      repeat: repeat ?? this.repeat,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      media: media ?? this.media,
    );
  }
}

/// Represents a single media list
class MediaList {
  /// List name
  final String name;

  /// List status
  final MediaListStatus? status;

  /// List entries
  final List<MediaListEntryWithMedia> entries;

  /// Creates a media list
  const MediaList({required this.name, this.status, required this.entries});

  /// Creates a media list from a protobuf object
  factory MediaList.fromProto(pb.MediaListGroup pbObj) {
    return MediaList(
      name: pbObj.name,
      status: pbObj.hasStatus()
          ? MediaListStatus.fromProto(pbObj.status)
          : null,
      entries: pbObj.entries.map(MediaListEntryWithMedia.fromProto).toList(),
    );
  }

  /// Converts the media list to a protobuf object
  pb.MediaListGroup toProto() {
    final pbObj = pb.MediaListGroup(
      name: name,
      entries: entries.map((e) => e.toProto() as pb.MediaListEntryWithMedia),
    );
    if (status != null) pbObj.status = status!.toProto();
    return pbObj;
  }
}

/// Represents a collection of media lists for a user
class MediaListCollection {
  /// Whether more chunks are available
  final bool hasNextChunk;

  /// The media lists
  final List<MediaList> lists;

  /// Creates a media list collection
  const MediaListCollection({required this.hasNextChunk, required this.lists});

  /// Creates a media list collection from a protobuf object
  factory MediaListCollection.fromProto(pb.MediaListCollection pbObj) {
    return MediaListCollection(
      hasNextChunk: pbObj.hasNextChunk,
      lists: pbObj.lists.map(MediaList.fromProto).toList(),
    );
  }

  /// Converts the collection to a protobuf object
  pb.MediaListCollection toProto() {
    return pb.MediaListCollection(
      hasNextChunk: hasNextChunk,
      lists: lists.map((l) => l.toProto()),
    );
  }
}
