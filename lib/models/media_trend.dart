/// Represents a trend data point
class MediaTrend {
  /// Average score at this point
  final int averageScore;

  /// Date timestamp
  final int date;

  /// Number of users with in-progress status
  final int inProgress;

  /// Popularity at this point
  final int popularity;

  /// Creates a media trend
  const MediaTrend({
    required this.averageScore,
    required this.date,
    required this.inProgress,
    required this.popularity,
  });

  /// Creates a media trend from a JSON map
  factory MediaTrend.fromJson(Map<String, dynamic> json) {
    return MediaTrend(
      averageScore: json['averageScore'] as int? ?? 0,
      date: json['date'] as int? ?? 0,
      inProgress: json['inProgress'] as int? ?? 0,
      popularity: json['popularity'] as int? ?? 0,
    );
  }

  /// Converts the media trend to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'averageScore': averageScore,
      'date': date,
      'inProgress': inProgress,
      'popularity': popularity,
    };
  }
}

/// Represents a list of trends
class MediaTrendConnection {
  /// Trend data points
  final List<MediaTrend> nodes;

  /// Creates a media trend connection
  const MediaTrendConnection({required this.nodes});

  /// Creates a media trend connection from a JSON map
  factory MediaTrendConnection.fromJson(Map<String, dynamic> json) {
    final nodesList = json['nodes'] as List?;
    return MediaTrendConnection(
      nodes: nodesList != null
          ? List<MediaTrend>.from(
              nodesList.map(
                (n) => MediaTrend.fromJson(Map<String, dynamic>.from(n as Map)),
              ),
            )
          : const [],
    );
  }

  /// Converts the media trend connection to a JSON map
  Map<String, dynamic> toJson() {
    return {'nodes': nodes.map((n) => n.toJson()).toList()};
  }
}
