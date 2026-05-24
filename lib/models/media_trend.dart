import '../proto/media_trend.pb.dart' as pb;

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

  /// Creates a media trend from a protobuf object
  factory MediaTrend.fromProto(pb.MediaTrend pbObj) {
    return MediaTrend(
      averageScore: pbObj.averageScore,
      date: pbObj.date,
      inProgress: pbObj.inProgress,
      popularity: pbObj.popularity,
    );
  }

  /// Converts the media trend to a protobuf object
  pb.MediaTrend toProto() {
    return pb.MediaTrend(
      averageScore: averageScore,
      date: date,
      inProgress: inProgress,
      popularity: popularity,
    );
  }
}

/// Represents a list of trends
class MediaTrendConnection {
  /// Trend data points
  final List<MediaTrend> nodes;

  /// Creates a media trend connection
  const MediaTrendConnection({required this.nodes});

  /// Creates a media trend connection from a protobuf object
  factory MediaTrendConnection.fromProto(pb.MediaTrendConnection pbObj) {
    return MediaTrendConnection(
      nodes: pbObj.nodes.map((n) => MediaTrend.fromProto(n)).toList(),
    );
  }

  /// Converts the media trend connection to a protobuf object
  pb.MediaTrendConnection toProto() {
    return pb.MediaTrendConnection(
      nodes: nodes.map((n) => n.toProto()).toList(),
    );
  }
}
