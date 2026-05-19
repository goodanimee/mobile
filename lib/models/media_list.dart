import 'common.dart';
import 'media.dart';
import 'media_list_entry.dart';

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

  /// Creates a media list entry with media from a JSON map
  factory MediaListEntryWithMedia.fromJson(Map<String, dynamic> json) {
    final base = MediaListEntry.fromJson(json);
    final mediaData = json['media'] as Map?;
    return MediaListEntryWithMedia(
      id: base.id,
      status: base.status,
      progress: base.progress,
      score: base.score,
      repeat: base.repeat,
      startedAt: base.startedAt,
      completedAt: base.completedAt,
      media: MediaMin.fromJson(
        mediaData != null ? Map<String, dynamic>.from(mediaData) : const {},
      ),
    );
  }

  /// Converts the entry with media to a JSON map
  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'media': media.toJson(),
    };
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

  /// Creates a media list from a JSON map
  factory MediaList.fromJson(Map<String, dynamic> json) {
    final entriesList = json['entries'] as List?;
    return MediaList(
      name: json['name']?.toString() ?? '',
      status: MediaListStatus.fromJson(json['status']?.toString()),
      entries: entriesList != null
          ? List<MediaListEntryWithMedia>.from(
              entriesList.map(
                (e) => MediaListEntryWithMedia.fromJson(
                  Map<String, dynamic>.from(e as Map),
                ),
              ),
            )
          : const [],
    );
  }

  /// Converts the media list to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'status': status?.toJson(),
      'entries': entries.map((e) => e.toJson()).toList(),
    };
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

  /// Creates a media list collection from a JSON map
  factory MediaListCollection.fromJson(Map<String, dynamic> json) {
    final listsList = json['lists'] as List?;
    return MediaListCollection(
      hasNextChunk: json['hasNextChunk'] as bool? ?? false,
      lists: listsList != null
          ? List<MediaList>.from(
              listsList.map(
                (l) => MediaList.fromJson(Map<String, dynamic>.from(l as Map)),
              ),
            )
          : const [],
    );
  }

  /// Converts the collection to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'hasNextChunk': hasNextChunk,
      'lists': lists.map((l) => l.toJson()).toList(),
    };
  }
}
