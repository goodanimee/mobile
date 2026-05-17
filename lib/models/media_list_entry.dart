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

  /// Date the user started watching
  final FuzzyDate? startedAt;

  /// Date the user completed watching
  final FuzzyDate? completedAt;

  /// Creates a media list entry
  const MediaListEntry({
    required this.id,
    this.status,
    required this.progress,
    required this.score,
    required this.repeat,
    this.startedAt,
    this.completedAt,
  });

  /// Creates a media list entry from a JSON map
  factory MediaListEntry.fromJson(Map<String, dynamic> json) {
    return MediaListEntry(
      id: json['id'] as int? ?? 0,
      status: MediaListStatus.fromJson(json['status'] as String?),
      progress: json['progress'] as int? ?? 0,
      score: (json['score'] as num?)?.toDouble() ?? 0.0,
      repeat: json['repeat'] as int? ?? 0,
      startedAt: json['startedAt'] != null
          ? FuzzyDate.fromJson(json['startedAt'] as Map<String, dynamic>)
          : null,
      completedAt: json['completedAt'] != null
          ? FuzzyDate.fromJson(json['completedAt'] as Map<String, dynamic>)
          : null,
    );
  }
}
