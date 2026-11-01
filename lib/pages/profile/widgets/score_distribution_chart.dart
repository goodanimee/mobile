import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../components/section.dart';
import '../../../models/user_statistics.dart';
import '../../../theme/theme.dart';

/// Enum representing the active score distribution metric.
enum ScoreMetricType {
  /// Plots title count per score bucket.
  titles,

  /// Plots time spent or chapters read per score bucket.
  timeSpent,
}

/// Renders score distribution graphs with metric toggles.
class ScoreDistributionChart extends StatefulWidget {
  /// Raw score statistics.
  final List<UserScoreStat> scores;

  /// Whether rendering anime (true) or manga (false).
  final bool isAnime;

  /// Creates a score distribution chart.
  const ScoreDistributionChart({
    super.key,
    required this.scores,
    required this.isAnime,
  });

  @override
  State<ScoreDistributionChart> createState() => _ScoreDistributionChartState();
}

class _ScoreDistributionChartState extends State<ScoreDistributionChart> {
  ScoreMetricType _activeMetric = ScoreMetricType.titles;

  @override
  Widget build(BuildContext context) {
    final histogram = StatisticsMathUtils.computeScoreHistogram(widget.scores);
    final hasData = histogram.any((s) => s.count > 0);

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
          _buildTogglePill('Titles', ScoreMetricType.titles),
          _buildTogglePill(
            widget.isAnime ? 'Hours' : 'Chapters',
            ScoreMetricType.timeSpent,
          ),
        ],
      ),
    );

    return Section(
      title: 'Score Distribution',
      trailing: trailingToggle,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          decoration: BoxDecoration(
            color: hoverBgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cardBorderColor),
          ),
          child: hasData
              ? _buildChart(histogram)
              : const SizedBox(
                  height: 120,
                  child: Center(
                    child: Text(
                      'No score data available',
                      style: TextStyle(color: textMuted, fontSize: 13),
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildTogglePill(String label, ScoreMetricType type) {
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

  Widget _buildChart(List<UserScoreStat> histogram) {
    final values = histogram.map((s) {
      if (_activeMetric == ScoreMetricType.titles) {
        return s.count.toDouble();
      }
      return widget.isAnime
          ? (s.minutesWatched / 60.0)
          : s.chaptersRead.toDouble();
    }).toList();

    final maxVal = values.fold<double>(0.0, math.max);

    return SizedBox(
      height: 160,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(histogram.length, (index) {
          final stat = histogram[index];
          final val = values[index];
          final ratio = maxVal > 0 ? (val / maxVal).clamp(0.0, 1.0) : 0.0;

          String displayVal = '';
          if (val > 0) {
            displayVal = _activeMetric == ScoreMetricType.titles
                ? stat.count.toString()
                : widget.isAnime
                ? (val < 10 ? val.toStringAsFixed(1) : val.toStringAsFixed(0))
                : stat.chaptersRead.toString();
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
                    stat.score.toString(),
                    style: TextStyle(
                      color: ratio > 0 ? textPrimary : textMuted,
                      fontSize: 11,
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
