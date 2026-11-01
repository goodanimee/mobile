import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../components/section.dart';
import '../../../models/user_statistics.dart';
import '../../../theme/theme.dart';

/// Active metric for episode or chapter length distribution.
enum LengthMetricType {
  /// Title count.
  titles,

  /// Time spent in hours or chapters read.
  timeSpent,

  /// Average score.
  score,
}

/// Renders length distribution graphs with titles, time spent, and score views.
class EpisodeDistributionChart extends StatefulWidget {
  /// Length statistics entries.
  final List<UserLengthStat> lengths;

  /// Whether rendering anime (true) or manga (false).
  final bool isAnime;

  /// Creates an episode or chapter length distribution chart.
  const EpisodeDistributionChart({
    super.key,
    required this.lengths,
    required this.isAnime,
  });

  @override
  State<EpisodeDistributionChart> createState() =>
      _EpisodeDistributionChartState();
}

class _EpisodeDistributionChartState extends State<EpisodeDistributionChart> {
  LengthMetricType _activeMetric = LengthMetricType.titles;

  @override
  Widget build(BuildContext context) {
    final sortedLengths = StatisticsMathUtils.sortLengthBuckets(widget.lengths);
    final hasData =
        sortedLengths.isNotEmpty && sortedLengths.any((l) => l.count > 0);
    if (!hasData) {
      return const SizedBox.shrink();
    }

    final title = widget.isAnime
        ? 'Episode Count Distribution'
        : 'Chapter Count Distribution';

    final trailingToggle = Container(
      decoration: BoxDecoration(
        color: hoverBgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: cardBorderColor),
      ),
      padding: const EdgeInsets.all(2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTogglePill('Titles', LengthMetricType.titles),
          _buildTogglePill(
            widget.isAnime ? 'Hours' : 'Chapters',
            LengthMetricType.timeSpent,
          ),
          _buildTogglePill('Score', LengthMetricType.score),
        ],
      ),
    );

    return Section(
      title: title,
      trailing: trailingToggle,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          decoration: BoxDecoration(
            color: hoverBgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cardBorderColor),
          ),
          child: _buildChart(sortedLengths),
        ),
      ],
    );
  }

  Widget _buildTogglePill(String label, LengthMetricType type) {
    final isActive = _activeMetric == type;
    return GestureDetector(
      onTap: () => setState(() => _activeMetric = type),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isActive
              ? paletteBlue.withValues(alpha: 0.25)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? borderColor : textSecondary,
            fontSize: 11,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildChart(List<UserLengthStat> lengths) {
    final values = lengths.map((l) {
      return switch (_activeMetric) {
        LengthMetricType.titles => l.count.toDouble(),
        LengthMetricType.timeSpent =>
          widget.isAnime
              ? (l.minutesWatched / 60.0)
              : l.chaptersRead.toDouble(),
        LengthMetricType.score =>
          StatisticsMathUtils.normalizeScore(l.meanScore),
      };
    }).toList();

    final maxVal = _activeMetric == LengthMetricType.score
        ? 10.0
        : values.fold<double>(0.0, math.max);

    return SizedBox(
      height: 160,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(lengths.length, (index) {
          final stat = lengths[index];
          final val = values[index];
          final ratio = maxVal > 0 ? (val / maxVal).clamp(0.0, 1.0) : 0.0;

          String displayVal = '';
          if (val > 0) {
            displayVal = switch (_activeMetric) {
              LengthMetricType.titles => stat.count.toString(),
              LengthMetricType.timeSpent =>
                widget.isAnime
                    ? (val < 10
                          ? val.toStringAsFixed(1)
                          : val.toStringAsFixed(0))
                    : stat.chaptersRead.toString(),
              LengthMetricType.score => StatisticsMathUtils.normalizeScore(
                stat.meanScore,
              ).toStringAsFixed(1),
            };
          }

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 16,
                    child: Text(
                      displayVal,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: textMuted,
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.04),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      alignment: Alignment.bottomCenter,
                      child: FractionallySizedBox(
                        heightFactor: ratio > 0 ? ratio : 0.02,
                        widthFactor: 1.0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: ratio > 0
                                ? borderColor
                                : Colors.white.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    stat.length,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: ratio > 0 ? textPrimary : textMuted,
                      fontSize: 10,
                      fontWeight: ratio > 0 ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
