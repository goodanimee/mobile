import 'package:flutter/material.dart';

import '../../../components/app_section.dart';
import '../../../models/media.dart';
import '../../../models/media_misc.dart';
import '../../../theme/theme.dart';
import '../widgets/ranking_pill.dart';
import '../widgets/score_histogram.dart';
import '../widgets/stat_tooltip.dart';
import '../widgets/status_distribution_bar.dart';
import '../widgets/trend_line_chart.dart';

/// A tab displaying ranking and statistical information for an anime
class MediaRankingsTab extends StatefulWidget {
  /// The anime media data
  final Media media;

  /// Whether this tab is nested within another scroll view
  final bool isNested;

  /// Creates an anime rankings tab
  const MediaRankingsTab({
    super.key,
    required this.media,
    this.isNested = false,
  });

  @override
  State<MediaRankingsTab> createState() => _MediaRankingsTabState();
}

/// State for AnimeRankingsTab
class _MediaRankingsTabState extends State<MediaRankingsTab> {
  @override
  void dispose() {
    StatTooltip.hide();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rawRankings = widget.media.rankings;
    final rankings = _sortRankings(List<MediaRank>.from(rawRankings));

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (rankings.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(40),
              child: Text(
                'No rankings available',
                style: TextStyle(color: textMuted, fontSize: 16),
              ),
            ),
          )
        else
          ...rankings.map(
            (ranking) => RankingPill(
              ranking: {
                'type': ranking.type,
                'allTime': ranking.allTime,
                'season': ranking.season.isNotEmpty ? ranking.season : null,
                'year': ranking.year > 0 ? ranking.year : null,
                'rank': ranking.rank,
              },
            ),
          ),
        const SizedBox(height: 16),
        _buildStatsSection(context),
        const SizedBox(height: 8),
        _buildTrendsSection(context),
      ],
    );

    if (widget.isNested) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: content,
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: content,
    );
  }

  /// Sorts rankings based on type and time scope
  List<MediaRank> _sortRankings(List<MediaRank> rankings) {
    rankings.sort((a, b) {
      int getWeight(MediaRank ranking) {
        int weight = 0;
        final type = ranking.type.toUpperCase();

        if (type == 'RATED') {
          weight += 1000;
        } else if (type == 'POPULAR') {
          weight += 500;
        }

        if (ranking.allTime) {
          weight += 100;
        } else if (ranking.season.isEmpty && ranking.year > 0) {
          weight += 50;
        } else if (ranking.season.isNotEmpty && ranking.year > 0) {
          weight += 10;
        }

        return weight;
      }

      return getWeight(b).compareTo(getWeight(a));
    });
    return rankings;
  }

  /// Builds the statistical charts section
  Widget _buildStatsSection(BuildContext context) {
    final stats = widget.media.stats;
    final scoreDist =
        stats?.scoreDistribution
            .map((e) => {'amount': e.amount, 'score': e.score})
            .toList() ??
        [];
    final statusDist =
        stats?.statusDistribution
            .map((e) => {'amount': e.amount, 'status': e.status})
            .toList() ??
        [];

    return AppSection(
      title: 'Stats',
      children: [
        const SizedBox(height: 8),
        ScoreHistogram(distribution: scoreDist),
        const SizedBox(height: 40),
        StatusDistributionBar(distribution: statusDist),
      ],
    );
  }

  /// Builds the trend line chart section
  Widget _buildTrendsSection(BuildContext context) {
    final trendsNodes =
        widget.media.trends?.nodes
            .map(
              (n) => {
                'date': n.date,
                'averageScore': n.averageScore,
                'inProgress': n.inProgress,
                'popularity': n.popularity,
              },
            )
            .toList() ??
        [];

    if (trendsNodes.isEmpty) return const SizedBox.shrink();

    return TrendLineChart(trends: trendsNodes);
  }
}
