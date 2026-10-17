import 'package:protobuf/protobuf.dart';
import '../proto/media_list_entry.pb.dart' as pb;
import 'common.dart';

/// Represents a media list entry
class MediaListEntry {
  /// Entry ID
  final int id;

  /// Watch status
  final MediaListStatus? status;

  /// Number of episodes watched
  final int progress;

  /// User score
  final double score;

  /// Number of rewatches
  final int repeat;

  /// Number of volumes read
  final int progressVolumes;

  /// Date the user started watching
  final FuzzyDate? startedAt;

  /// Date the user completed watching
  final FuzzyDate? completedAt;

  /// Whether the entry is visible only to the authenticated user
  final bool private;

  /// Whether the entry is hidden from non-custom status lists
  final bool hiddenFromStatusLists;

  /// Personal user notes for the entry
  final String notes;

  /// Creates a media list entry
  const MediaListEntry({
    required this.id,
    this.status,
    required this.progress,
    required this.score,
    required this.repeat,
    required this.progressVolumes,
    this.startedAt,
    this.completedAt,
    this.private = false,
    this.hiddenFromStatusLists = false,
    this.notes = '',
  });

  /// Creates a media list entry from a protobuf object
  factory MediaListEntry.fromProto(pb.MediaListEntry pbObj) {
    return MediaListEntry(
      id: pbObj.id,
      status: pbObj.hasStatus()
          ? MediaListStatus.fromProto(pbObj.status)
          : null,
      progress: pbObj.progress,
      score: pbObj.score,
      repeat: pbObj.repeat,
      progressVolumes: pbObj.progressVolumes,
      startedAt: pbObj.hasStartedAt()
          ? FuzzyDate.fromProtoNullable(pbObj.startedAt)
          : null,
      completedAt: pbObj.hasCompletedAt()
          ? FuzzyDate.fromProtoNullable(pbObj.completedAt)
          : null,
      private: pbObj.private,
      hiddenFromStatusLists: pbObj.hiddenFromStatusLists,
      notes: pbObj.notes,
    );
  }

  /// Converts the media list entry to a protobuf object
  GeneratedMessage toProto() {
    final pbObj = pb.MediaListEntry(
      id: id,
      progress: progress,
      score: score,
      repeat: repeat,
      progressVolumes: progressVolumes,
      private: private,
      hiddenFromStatusLists: hiddenFromStatusLists,
      notes: notes,
    );
    if (status != null) pbObj.status = status!.toProto();
    if (startedAt != null) pbObj.startedAt = startedAt!.toProto();
    if (completedAt != null) pbObj.completedAt = completedAt!.toProto();
    return pbObj;
  }

  /// Creates a copy of this object with the given fields replaced
  MediaListEntry copyWith({
    int? id,
    MediaListStatus? status,
    int? progress,
    double? score,
    int? repeat,
    int? progressVolumes,
    FuzzyDate? startedAt,
    FuzzyDate? completedAt,
    bool? private,
    bool? hiddenFromStatusLists,
    String? notes,
  }) {
    return MediaListEntry(
      id: id ?? this.id,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      score: score ?? this.score,
      repeat: repeat ?? this.repeat,
      progressVolumes: progressVolumes ?? this.progressVolumes,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      private: private ?? this.private,
      hiddenFromStatusLists:
          hiddenFromStatusLists ?? this.hiddenFromStatusLists,
      notes: notes ?? this.notes,
    );
  }
}
