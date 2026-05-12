import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../components/app_section.dart';
import '../widgets/ranking_pill.dart';
import '../widgets/score_histogram.dart';
import '../widgets/status_distribution_bar.dart';
import '../widgets/trend_line_chart.dart';
import '../widgets/stat_tooltip.dart';

/// A tab displaying ranking and statistical information for an anime
class AnimeRankingsTab extends StatefulWidget {
  /// The anime media data
  final Map<String, dynamic> media;

  /// Whether this tab is nested within another scroll view
  final bool isNested;

  /// Creates an anime rankings tab
  const AnimeRankingsTab({
    super.key,
    required this.media,
    this.isNested = false,
  });

  @override
  State<AnimeRankingsTab> createState() => _AnimeRankingsTabState();
}

/// State for AnimeRankingsTab
class _AnimeRankingsTabState extends State<AnimeRankingsTab> {
  @override
  void dispose() {
    StatTooltip.hide();
    super.dispose();
  }

  @override
  /// Builds the anime rankings tab widget
  Widget build(BuildContext context) {
    final rawRankings = widget.media['rankings'] as List? ?? [];
    final rankings = _sortRankings(
      rawRankings.whereType<Map<String, dynamic>>().toList(),
    );

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
          ...rankings.map((ranking) => RankingPill(ranking: ranking)),
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
  List<Map<String, dynamic>> _sortRankings(
    List<Map<String, dynamic>> rankings,
  ) {
    rankings.sort((a, b) {
      int getWeight(Map<String, dynamic> ranking) {
        int weight = 0;
        final type = ranking['type']?.toString().toUpperCase() ?? '';

        if (type == 'RATED') {
          weight += 1000;
        } else if (type == 'POPULAR') {
          weight += 500;
        }

        if (ranking['allTime'] == true) {
          weight += 100;
        } else if (ranking['season'] == null && ranking['year'] != null) {
          weight += 50;
        } else if (ranking['season'] != null && ranking['year'] != null) {
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
    final stats = widget.media['stats'];
    return AppSection(
      title: 'Stats',
      children: [
        const SizedBox(height: 8),
        ScoreHistogram(
          distribution: stats?['scoreDistribution'] as List? ?? [],
        ),
        const SizedBox(height: 40),
        StatusDistributionBar(
          distribution: stats?['statusDistribution'] as List? ?? [],
        ),
      ],
    );
  }

  /// Builds the trend line chart section
  Widget _buildTrendsSection(BuildContext context) {
    final trendsNodes = widget.media['trends']?['nodes'] as List? ?? [];
    if (trendsNodes.isEmpty) return const SizedBox.shrink();

    return TrendLineChart(trends: trendsNodes);
  }
}
