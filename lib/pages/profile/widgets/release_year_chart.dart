import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../components/section.dart';
import '../../../models/user_statistics.dart';
import '../../../theme/theme.dart';

/// Active metric for release year distribution graph.
enum YearMetricType {
  /// Title count.
  titles,

  /// Time spent in hours or chapters read.
  timeSpent,

  /// Average score.
  score,
}

/// Renders chronological release year graphs with multi-metric toggles.
class ReleaseYearChart extends StatefulWidget {
  /// Release year statistics entries.
  final List<UserReleaseYearStat> releaseYears;

  /// Whether rendering anime (true) or manga (false).
  final bool isAnime;

  /// Creates a release year analytics chart.
  const ReleaseYearChart({
    super.key,
    required this.releaseYears,
    required this.isAnime,
  });

  @override
  State<ReleaseYearChart> createState() => _ReleaseYearChartState();
}

class _ReleaseYearChartState extends State<ReleaseYearChart> {
  YearMetricType _activeMetric = YearMetricType.titles;

  @override
  Widget build(BuildContext context) {
    final sortedYears = StatisticsMathUtils.sortChronologicalYears(
      widget.releaseYears,
    );
    final hasData =
        sortedYears.isNotEmpty && sortedYears.any((y) => y.count > 0);

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
          _buildTogglePill('Titles', YearMetricType.titles),
          _buildTogglePill(
            widget.isAnime ? 'Hours' : 'Chapters',
            YearMetricType.timeSpent,
          ),
          _buildTogglePill('Score', YearMetricType.score),
        ],
      ),
    );

    return Section(
      title: 'Release Year Distribution',
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
              ? _buildChart(sortedYears)
              : const SizedBox(
                  height: 120,
                  child: Center(
                    child: Text(
                      'No release year data available',
                      style: TextStyle(color: textMuted, fontSize: 13),
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildTogglePill(String label, YearMetricType type) {
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

  Widget _buildChart(List<UserReleaseYearStat> years) {
    final values = years.map((y) {
      return switch (_activeMetric) {
        YearMetricType.titles => y.count.toDouble(),
        YearMetricType.timeSpent =>
          widget.isAnime
              ? (y.minutesWatched / 60.0)
              : y.chaptersRead.toDouble(),
        YearMetricType.score => y.meanScore,
      };
    }).toList();

    final maxVal = values.fold<double>(0.0, math.max);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 320),
        child: SizedBox(
          height: 160,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(years.length, (index) {
              final stat = years[index];
              final val = values[index];
              final ratio = maxVal > 0 ? (val / maxVal).clamp(0.0, 1.0) : 0.0;

              String displayVal = '';
              if (val > 0) {
                displayVal = switch (_activeMetric) {
                  YearMetricType.titles => stat.count.toString(),
                  YearMetricType.timeSpent =>
                    widget.isAnime
                        ? (val < 10
                              ? val.toStringAsFixed(1)
                              : val.toStringAsFixed(0))
                        : stat.chaptersRead.toString(),
                  YearMetricType.score =>
                    '${stat.meanScore.toStringAsFixed(0)}%',
                };
              }

              return Container(
                width: math.max(44.0, 320.0 / years.length),
                padding: const EdgeInsets.symmetric(horizontal: 3),
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
                      stat.releaseYear.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: ratio > 0 ? textPrimary : textMuted,
                        fontSize: 10,
                        fontWeight: ratio > 0
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
