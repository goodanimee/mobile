/// Represents a media trailer
class Trailer {
  /// Trailer ID
  final String id;

  /// Hosting site
  final String site;

  /// Thumbnail URL
  final String thumbnail;

  /// Creates a trailer
  const Trailer({
    required this.id,
    required this.site,
    required this.thumbnail,
  });

  /// Creates a trailer from a JSON map
  factory Trailer.fromJson(Map<String, dynamic> json) {
    return Trailer(
      id: json['id']?.toString() ?? '',
      site: json['site']?.toString() ?? '',
      thumbnail: json['thumbnail']?.toString() ?? '',
    );
  }

  /// Converts the trailer to a JSON map
  Map<String, dynamic> toJson() {
    return {'id': id, 'site': site, 'thumbnail': thumbnail};
  }
}

/// Represents a descriptive tag for a media
class MediaTag {
  /// Tag ID
  final int id;

  /// Whether this tag is a general spoiler
  final bool isGeneralSpoiler;

  /// Whether this tag is a media-specific spoiler
  final bool isMediaSpoiler;

  /// Tag name
  final String name;

  /// Tag relevance rank
  final int rank;

  /// Creates a media tag
  const MediaTag({
    required this.id,
    required this.isGeneralSpoiler,
    required this.isMediaSpoiler,
    required this.name,
    required this.rank,
  });

  /// Creates a media tag from a JSON map
  factory MediaTag.fromJson(Map<String, dynamic> json) {
    return MediaTag(
      id: json['id'] as int? ?? 0,
      isGeneralSpoiler: json['isGeneralSpoiler'] as bool? ?? false,
      isMediaSpoiler: json['isMediaSpoiler'] as bool? ?? false,
      name: json['name']?.toString() ?? '',
      rank: json['rank'] as int? ?? 0,
    );
  }

  /// Converts the media tag to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isGeneralSpoiler': isGeneralSpoiler,
      'isMediaSpoiler': isMediaSpoiler,
      'name': name,
      'rank': rank,
    };
  }
}

/// Represents a link to an external site
class ExternalLink {
  /// Language of the external content
  final String language;

  /// Site name
  final String site;

  /// Link URL
  final String url;

  /// Creates an external link
  const ExternalLink({
    required this.language,
    required this.site,
    required this.url,
  });

  /// Creates an external link from a JSON map
  factory ExternalLink.fromJson(Map<String, dynamic> json) {
    return ExternalLink(
      language: json['language']?.toString() ?? '',
      site: json['site']?.toString() ?? '',
      url: json['url']?.toString() ?? '',
    );
  }

  /// Converts the external link to a JSON map
  Map<String, dynamic> toJson() {
    return {'language': language, 'site': site, 'url': url};
  }
}

/// Represents an airing episode
class AiringSchedule {
  /// Airing timestamp
  final int airingAt;

  /// Episode number
  final int episode;

  /// Time until airing in seconds
  final int timeUntilAiring;

  /// Creates an airing schedule
  const AiringSchedule({
    required this.airingAt,
    required this.episode,
    required this.timeUntilAiring,
  });

  /// Creates an airing schedule from a JSON map
  factory AiringSchedule.fromJson(Map<String, dynamic> json) {
    return AiringSchedule(
      airingAt: json['airingAt'] as int? ?? 0,
      episode: json['episode'] as int? ?? 0,
      timeUntilAiring: json['timeUntilAiring'] as int? ?? 0,
    );
  }

  /// Converts the airing schedule to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'airingAt': airingAt,
      'episode': episode,
      'timeUntilAiring': timeUntilAiring,
    };
  }
}

/// Represents a streaming link for an episode
class StreamingEpisode {
  /// Thumbnail URL
  final String thumbnail;

  /// Episode title
  final String title;

  /// Streaming URL
  final String url;

  /// Creates a streaming episode
  const StreamingEpisode({
    required this.thumbnail,
    required this.title,
    required this.url,
  });

  /// Creates a streaming episode from a JSON map
  factory StreamingEpisode.fromJson(Map<String, dynamic> json) {
    return StreamingEpisode(
      thumbnail: json['thumbnail']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      url: json['url']?.toString() ?? '',
    );
  }

  /// Converts the streaming episode to a JSON map
  Map<String, dynamic> toJson() {
    return {'thumbnail': thumbnail, 'title': title, 'url': url};
  }
}

/// Represents a ranking for a media
class MediaRank {
  /// Whether this is an all-time ranking
  final bool allTime;

  /// Rank position
  final int rank;

  /// Ranking season
  final String season;

  /// Ranking type
  final String type;

  /// Ranking year
  final int year;

  /// Creates a media rank
  const MediaRank({
    required this.allTime,
    required this.rank,
    required this.season,
    required this.type,
    required this.year,
  });

  /// Creates a media rank from a JSON map
  factory MediaRank.fromJson(Map<String, dynamic> json) {
    return MediaRank(
      allTime: json['allTime'] as bool? ?? false,
      rank: json['rank'] as int? ?? 0,
      season: json['season']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      year: json['year'] as int? ?? 0,
    );
  }

  /// Converts the media rank to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'allTime': allTime,
      'rank': rank,
      'season': season,
      'type': type,
      'year': year,
    };
  }
}

/// Represents a score distribution entry
class ScoreDistribution {
  /// Number of users with this score
  final int amount;

  /// Score value
  final int score;

  /// Creates a score distribution
  const ScoreDistribution({required this.amount, required this.score});

  /// Creates a score distribution from a JSON map
  factory ScoreDistribution.fromJson(Map<String, dynamic> json) {
    return ScoreDistribution(
      amount: json['amount'] as int? ?? 0,
      score: json['score'] as int? ?? 0,
    );
  }

  /// Converts the score distribution to a JSON map
  Map<String, dynamic> toJson() {
    return {'amount': amount, 'score': score};
  }
}

/// Represents a status distribution entry
class StatusDistribution {
  /// Number of users with this status
  final int amount;

  /// Status value
  final String status;

  /// Creates a status distribution
  const StatusDistribution({required this.amount, required this.status});

  /// Creates a status distribution from a JSON map
  factory StatusDistribution.fromJson(Map<String, dynamic> json) {
    return StatusDistribution(
      amount: json['amount'] as int? ?? 0,
      status: json['status']?.toString() ?? '',
    );
  }

  /// Converts the status distribution to a JSON map
  Map<String, dynamic> toJson() {
    return {'amount': amount, 'status': status};
  }
}

/// Represents statistics for a media
class MediaStats {
  /// Score distribution data
  final List<ScoreDistribution> scoreDistribution;

  /// Status distribution data
  final List<StatusDistribution> statusDistribution;

  /// Creates media stats
  const MediaStats({
    required this.scoreDistribution,
    required this.statusDistribution,
  });

  /// Creates media stats from a JSON map
  factory MediaStats.fromJson(Map<String, dynamic> json) {
    final scoreList = json['scoreDistribution'] as List?;
    final statusList = json['statusDistribution'] as List?;
    return MediaStats(
      scoreDistribution: scoreList != null
          ? List<ScoreDistribution>.from(
              scoreList.map(
                (s) => ScoreDistribution.fromJson(
                  Map<String, dynamic>.from(s as Map),
                ),
              ),
            )
          : const [],
      statusDistribution: statusList != null
          ? List<StatusDistribution>.from(
              statusList.map(
                (s) => StatusDistribution.fromJson(
                  Map<String, dynamic>.from(s as Map),
                ),
              ),
            )
          : const [],
    );
  }

  /// Converts the media stats to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'scoreDistribution': scoreDistribution.map((s) => s.toJson()).toList(),
      'statusDistribution': statusDistribution.map((s) => s.toJson()).toList(),
    };
  }
}
