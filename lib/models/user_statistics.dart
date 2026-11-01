import 'dart:math' as math;

import '../proto/user.pb.dart' as pb;

/// Represents user watching or reading statistics grouped by score.
class UserScoreStat {
  /// Creates a score statistic entry.
  const UserScoreStat({
    required this.score,
    required this.count,
    required this.meanScore,
    required this.minutesWatched,
    required this.chaptersRead,
  });

  /// Factory constructor to create [UserScoreStat] from protobuf.
  factory UserScoreStat.fromProto(pb.UserScoreStat stat) {
    return UserScoreStat(
      score: stat.score,
      count: stat.count,
      meanScore: stat.meanScore,
      minutesWatched: stat.minutesWatched,
      chaptersRead: stat.chaptersRead,
    );
  }

  /// Score bucket (typically 1 to 10 or 10 to 100).
  final int score;

  /// Number of entries with this score.
  final int count;

  /// Mean score for this bucket.
  final double meanScore;

  /// Total minutes watched for entries in this bucket.
  final int minutesWatched;

  /// Total chapters read for entries in this bucket.
  final int chaptersRead;
}

/// Represents user statistics grouped by episode or chapter length.
class UserLengthStat {
  /// Creates a length statistic entry.
  const UserLengthStat({
    required this.length,
    required this.count,
    required this.meanScore,
    required this.minutesWatched,
    required this.chaptersRead,
  });

  /// Factory constructor to create [UserLengthStat] from protobuf.
  factory UserLengthStat.fromProto(pb.UserLengthStat stat) {
    return UserLengthStat(
      length: stat.length,
      count: stat.count,
      meanScore: stat.meanScore,
      minutesWatched: stat.minutesWatched,
      chaptersRead: stat.chaptersRead,
    );
  }

  /// Length range label (e.g., '12', '24', '100+').
  final String length;

  /// Number of titles in this length bucket.
  final int count;

  /// Mean score for this bucket.
  final double meanScore;

  /// Minutes watched for this bucket.
  final int minutesWatched;

  /// Chapters read for this bucket.
  final int chaptersRead;
}

/// Represents user statistics grouped by list status.
class UserStatusStat {
  /// Creates a status statistic entry.
  const UserStatusStat({
    required this.status,
    required this.count,
    required this.meanScore,
    required this.minutesWatched,
    required this.chaptersRead,
  });

  /// Factory constructor to create [UserStatusStat] from protobuf.
  factory UserStatusStat.fromProto(pb.UserStatusStat stat) {
    return UserStatusStat(
      status: stat.status,
      count: stat.count,
      meanScore: stat.meanScore,
      minutesWatched: stat.minutesWatched,
      chaptersRead: stat.chaptersRead,
    );
  }

  /// List status key (e.g., 'COMPLETED', 'CURRENT', 'PLANNING').
  final String status;

  /// Count of titles in this status.
  final int count;

  /// Mean score for titles in this status.
  final double meanScore;

  /// Minutes watched for titles in this status.
  final int minutesWatched;

  /// Chapters read for titles in this status.
  final int chaptersRead;
}

/// Represents user statistics grouped by media format.
class UserFormatStat {
  /// Creates a format statistic entry.
  const UserFormatStat({
    required this.format,
    required this.count,
    required this.meanScore,
    required this.minutesWatched,
    required this.chaptersRead,
  });

  /// Factory constructor to create [UserFormatStat] from protobuf.
  factory UserFormatStat.fromProto(pb.UserFormatStat stat) {
    return UserFormatStat(
      format: stat.format,
      count: stat.count,
      meanScore: stat.meanScore,
      minutesWatched: stat.minutesWatched,
      chaptersRead: stat.chaptersRead,
    );
  }

  /// Format name (e.g., 'TV', 'MOVIE', 'MANGA').
  final String format;

  /// Count of titles in this format.
  final int count;

  /// Mean score for titles in this format.
  final double meanScore;

  /// Minutes watched for titles in this format.
  final int minutesWatched;

  /// Chapters read for titles in this format.
  final int chaptersRead;
}

/// Represents user statistics grouped by release year.
class UserReleaseYearStat {
  /// Creates a release year statistic entry.
  const UserReleaseYearStat({
    required this.releaseYear,
    required this.count,
    required this.meanScore,
    required this.minutesWatched,
    required this.chaptersRead,
  });

  /// Factory constructor to create [UserReleaseYearStat] from protobuf.
  factory UserReleaseYearStat.fromProto(pb.UserReleaseYearStat stat) {
    return UserReleaseYearStat(
      releaseYear: stat.releaseYear,
      count: stat.count,
      meanScore: stat.meanScore,
      minutesWatched: stat.minutesWatched,
      chaptersRead: stat.chaptersRead,
    );
  }

  /// Release year.
  final int releaseYear;

  /// Count of titles released in this year.
  final int count;

  /// Mean score for titles released in this year.
  final double meanScore;

  /// Minutes watched for titles released in this year.
  final int minutesWatched;

  /// Chapters read for titles released in this year.
  final int chaptersRead;
}

/// Represents statistical aggregates for a specific media type (anime or manga).
class UserMediaStatistics {
  /// Creates a media statistics aggregate.
  const UserMediaStatistics({
    this.count = 0,
    this.meanScore = 0.0,
    this.standardDeviation = 0.0,
    this.minutesWatched = 0,
    this.episodesWatched = 0,
    this.chaptersRead = 0,
    this.volumesRead = 0,
    this.scores = const [],
    this.lengths = const [],
    this.statuses = const [],
    this.formats = const [],
    this.releaseYears = const [],
  });

  /// Factory constructor to create [UserMediaStatistics] from protobuf.
  factory UserMediaStatistics.fromProto(pb.UserMediaStatistics? stat) {
    if (stat == null) {
      return const UserMediaStatistics();
    }
    return UserMediaStatistics(
      count: stat.count,
      meanScore: stat.meanScore,
      standardDeviation: stat.standardDeviation,
      minutesWatched: stat.minutesWatched,
      episodesWatched: stat.episodesWatched,
      chaptersRead: stat.chaptersRead,
      volumesRead: stat.volumesRead,
      scores: stat.scores.map(UserScoreStat.fromProto).toList(),
      lengths: stat.lengths.map(UserLengthStat.fromProto).toList(),
      statuses: stat.statuses.map(UserStatusStat.fromProto).toList(),
      formats: stat.formats.map(UserFormatStat.fromProto).toList(),
      releaseYears: stat.releaseYears
          .map(UserReleaseYearStat.fromProto)
          .toList(),
    );
  }

  /// Total count of entries.
  final int count;

  /// Mean score across entries.
  final double meanScore;

  /// Standard deviation of scores.
  final double standardDeviation;

  /// Total minutes watched.
  final int minutesWatched;

  /// Total episodes watched.
  final int episodesWatched;

  /// Total chapters read.
  final int chaptersRead;

  /// Total volumes read.
  final int volumesRead;

  /// Breakdown by score.
  final List<UserScoreStat> scores;

  /// Breakdown by length.
  final List<UserLengthStat> lengths;

  /// Breakdown by status.
  final List<UserStatusStat> statuses;

  /// Breakdown by format.
  final List<UserFormatStat> formats;

  /// Breakdown by release year.
  final List<UserReleaseYearStat> releaseYears;
}

/// Represents the top-level user statistics containing anime and manga branches.
class UserStatistics {
  /// Creates user statistics container.
  const UserStatistics({
    this.anime = const UserMediaStatistics(),
    this.manga = const UserMediaStatistics(),
  });

  /// Factory constructor to create [UserStatistics] from protobuf.
  factory UserStatistics.fromProto(pb.UserStatistics? stat) {
    if (stat == null) {
      return const UserStatistics();
    }
    return UserStatistics(
      anime: UserMediaStatistics.fromProto(stat.hasAnime() ? stat.anime : null),
      manga: UserMediaStatistics.fromProto(stat.hasManga() ? stat.manga : null),
    );
  }

  /// Anime statistics.
  final UserMediaStatistics anime;

  /// Manga statistics.
  final UserMediaStatistics manga;
}

/// Math and formatting helpers for statistics calculations.
class StatisticsMathUtils {
  /// Calculates weighted mean score excluding unrated (score == 0) entries.
  static double computeMeanScore(List<UserScoreStat> scores) {
    final valid = scores.where((s) => s.score > 0 && s.count > 0);
    final totalCount = valid.fold<int>(0, (sum, s) => sum + s.count);
    if (totalCount == 0) {
      return 0.0;
    }
    final totalScore = valid.fold<double>(
      0.0,
      (sum, s) => sum + (s.score * s.count),
    );
    return totalScore / totalCount;
  }

  /// Calculates population standard deviation for rated entries.
  static double computeStandardDeviation(
    List<UserScoreStat> scores, [
    double? precomputedMean,
  ]) {
    final valid = scores.where((s) => s.score > 0 && s.count > 0);
    final totalCount = valid.fold<int>(0, (sum, s) => sum + s.count);
    if (totalCount == 0) {
      return 0.0;
    }
    final mean = precomputedMean ?? computeMeanScore(scores);
    final varianceSum = valid.fold<double>(
      0.0,
      (sum, s) => sum + (s.count * math.pow(s.score - mean, 2)),
    );
    return math.sqrt(varianceSum / totalCount);
  }

  /// Converts minutes to days as a floating point number.
  static double minutesToDays(int minutes) {
    return minutes / 1440.0;
  }

  /// Formats minutes into days string with one decimal place.
  static String formatDays(int minutes) {
    return minutesToDays(minutes).toStringAsFixed(1);
  }

  /// Formats minutes into hours string with one decimal place.
  static String formatHours(int minutes) {
    return (minutes / 60.0).toStringAsFixed(1);
  }

  /// Ensures full 1-10 score buckets exist in ascending order for histogram rendering.
  static List<UserScoreStat> computeScoreHistogram(
    List<UserScoreStat> rawScores,
  ) {
    final map = <int, UserScoreStat>{};
    for (final s in rawScores) {
      if (s.score > 0) {
        map[s.score] = s;
      }
    }
    return List.generate(10, (index) {
      final scoreVal = index + 1;
      return map[scoreVal] ??
          UserScoreStat(
            score: scoreVal,
            count: 0,
            meanScore: 0.0,
            minutesWatched: 0,
            chaptersRead: 0,
          );
    });
  }

  /// Sorts release years chronologically in ascending order, filtering invalid years.
  static List<UserReleaseYearStat> sortChronologicalYears(
    List<UserReleaseYearStat> years,
  ) {
    final valid = years.where((y) => y.releaseYear > 0).toList();
    valid.sort((a, b) => a.releaseYear.compareTo(b.releaseYear));
    return valid;
  }

  /// Calculates percentage share of a part relative to a total.
  static double calculatePercentage(int part, int total) {
    if (total <= 0) {
      return 0.0;
    }
    return (part / total) * 100.0;
  }
}
