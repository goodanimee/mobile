import '../proto/media_misc.pb.dart' as pb;

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

  /// Creates a trailer from a protobuf object
  factory Trailer.fromProto(pb.Trailer pbObj) {
    return Trailer(id: pbObj.id, site: pbObj.site, thumbnail: pbObj.thumbnail);
  }

  /// Converts the trailer to a protobuf object
  pb.Trailer toProto() {
    return pb.Trailer(id: id, site: site, thumbnail: thumbnail);
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

  /// Creates a media tag from a protobuf object
  factory MediaTag.fromProto(pb.MediaTag pbObj) {
    return MediaTag(
      id: pbObj.id,
      isGeneralSpoiler: pbObj.isGeneralSpoiler,
      isMediaSpoiler: pbObj.isMediaSpoiler,
      name: pbObj.name,
      rank: pbObj.rank,
    );
  }

  /// Converts the media tag to a protobuf object
  pb.MediaTag toProto() {
    return pb.MediaTag(
      id: id,
      isGeneralSpoiler: isGeneralSpoiler,
      isMediaSpoiler: isMediaSpoiler,
      name: name,
      rank: rank,
    );
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

  /// Creates an external link from a protobuf object
  factory ExternalLink.fromProto(pb.ExternalLink pbObj) {
    return ExternalLink(
      language: pbObj.language,
      site: pbObj.site,
      url: pbObj.url,
    );
  }

  /// Converts the external link to a protobuf object
  pb.ExternalLink toProto() {
    return pb.ExternalLink(language: language, site: site, url: url);
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

  /// Creates an airing schedule from a protobuf object
  factory AiringSchedule.fromProto(pb.AiringSchedule pbObj) {
    return AiringSchedule(
      airingAt: pbObj.airingAt,
      episode: pbObj.episode,
      timeUntilAiring: pbObj.timeUntilAiring,
    );
  }

  /// Converts the airing schedule to a protobuf object
  pb.AiringSchedule toProto() {
    return pb.AiringSchedule(
      airingAt: airingAt,
      episode: episode,
      timeUntilAiring: timeUntilAiring,
    );
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

  /// Creates a streaming episode from a protobuf object
  factory StreamingEpisode.fromProto(pb.StreamingEpisode pbObj) {
    return StreamingEpisode(
      thumbnail: pbObj.thumbnail,
      title: pbObj.title,
      url: pbObj.url,
    );
  }

  /// Converts the streaming episode to a protobuf object
  pb.StreamingEpisode toProto() {
    return pb.StreamingEpisode(thumbnail: thumbnail, title: title, url: url);
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

  /// Creates a media rank from a protobuf object
  factory MediaRank.fromProto(pb.MediaRank pbObj) {
    return MediaRank(
      allTime: pbObj.allTime,
      rank: pbObj.rank,
      season: pbObj.season,
      type: pbObj.type,
      year: pbObj.year,
    );
  }

  /// Converts the media rank to a protobuf object
  pb.MediaRank toProto() {
    return pb.MediaRank(
      allTime: allTime,
      rank: rank,
      season: season,
      type: type,
      year: year,
    );
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

  /// Creates a score distribution from a protobuf object
  factory ScoreDistribution.fromProto(pb.ScoreDistribution pbObj) {
    return ScoreDistribution(amount: pbObj.amount, score: pbObj.score);
  }

  /// Converts the score distribution to a protobuf object
  pb.ScoreDistribution toProto() {
    return pb.ScoreDistribution(amount: amount, score: score);
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

  /// Creates a status distribution from a protobuf object
  factory StatusDistribution.fromProto(pb.StatusDistribution pbObj) {
    return StatusDistribution(amount: pbObj.amount, status: pbObj.status);
  }

  /// Converts the status distribution to a protobuf object
  pb.StatusDistribution toProto() {
    return pb.StatusDistribution(amount: amount, status: status);
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

  /// Creates media stats from a protobuf object
  factory MediaStats.fromProto(pb.MediaStats pbObj) {
    return MediaStats(
      scoreDistribution: pbObj.scoreDistribution
          .map(ScoreDistribution.fromProto)
          .toList(),
      statusDistribution: pbObj.statusDistribution
          .map(StatusDistribution.fromProto)
          .toList(),
    );
  }

  /// Converts the media stats to a protobuf object
  pb.MediaStats toProto() {
    return pb.MediaStats(
      scoreDistribution: scoreDistribution.map((s) => s.toProto()).toList(),
      statusDistribution: statusDistribution.map((s) => s.toProto()).toList(),
    );
  }
}
