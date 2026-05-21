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
    final startedAtData = json['startedAt'] as Map?;
    final completedAtData = json['completedAt'] as Map?;
    return MediaListEntry(
      id: json['id'] as int? ?? 0,
      status: MediaListStatus.fromJson(json['status']?.toString()),
      progress: json['progress'] as int? ?? 0,
      score: (json['score'] as num?)?.toDouble() ?? 0.0,
      repeat: json['repeat'] as int? ?? 0,
      startedAt: startedAtData != null
          ? FuzzyDate.fromJson(Map<String, dynamic>.from(startedAtData))
          : null,
      completedAt: completedAtData != null
          ? FuzzyDate.fromJson(Map<String, dynamic>.from(completedAtData))
          : null,
    );
  }

  /// Converts the media list entry to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status?.toJson(),
      'progress': progress,
      'score': score,
      'repeat': repeat,
      'startedAt': startedAt?.toJson(),
      'completedAt': completedAt?.toJson(),
    };
  }

  /// Creates a copy of this object with the given fields replaced
  MediaListEntry copyWith({
    int? id,
    MediaListStatus? status,
    int? progress,
    double? score,
    int? repeat,
    FuzzyDate? startedAt,
    FuzzyDate? completedAt,
  }) {
    return MediaListEntry(
      id: id ?? this.id,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      score: score ?? this.score,
      repeat: repeat ?? this.repeat,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}
