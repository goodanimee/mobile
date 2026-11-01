import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../models/user_statistics.dart';
import '../../../theme/theme.dart';

/// Renders high-level overview cards displaying summary statistics.
class QuickMetricsGrid extends StatelessWidget {
  /// The media statistics to display.
  final UserMediaStatistics stats;

  /// Whether the statistics represent anime (true) or manga (false).
  final bool isAnime;

  /// Creates a quick metrics summary grid.
  const QuickMetricsGrid({
    super.key,
    required this.stats,
    required this.isAnime,
  });

  @override
  Widget build(BuildContext context) {
    final daysStr = StatisticsMathUtils.formatDays(stats.minutesWatched);
    final hoursStr = StatisticsMathUtils.formatHours(stats.minutesWatched);

    final cards = <_MetricData>[
      _MetricData(
        icon: isAnime ? LucideIcons.tv : LucideIcons.bookOpen,
        label: isAnime ? 'Total Anime' : 'Total Manga',
        value: stats.count.toString(),
      ),
      if (isAnime)
        _MetricData(
          icon: LucideIcons.playCircle,
          label: 'Episodes Watched',
          value: stats.episodesWatched.toString(),
        )
      else ...[
        _MetricData(
          icon: LucideIcons.fileText,
          label: 'Chapters Read',
          value: stats.chaptersRead.toString(),
        ),
        if (stats.volumesRead > 0)
          _MetricData(
            icon: LucideIcons.bookmark,
            label: 'Volumes Read',
            value: stats.volumesRead.toString(),
          ),
      ],
      if (isAnime)
        _MetricData(
          icon: LucideIcons.clock,
          label: 'Time Watched',
          value: '$daysStr Days',
          subValue: '$hoursStr Hours',
        ),
      _MetricData(
        icon: LucideIcons.star,
        label: 'Mean Score',
        value: stats.meanScore > 0
            ? '${stats.meanScore.toStringAsFixed(1)}%'
            : 'N/A',
      ),
      _MetricData(
        icon: LucideIcons.activity,
        label: 'Standard Dev',
        value: stats.standardDeviation > 0
            ? stats.standardDeviation.toStringAsFixed(1)
            : 'N/A',
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 500 ? 3 : 2;
        final itemWidth =
            (constraints.maxWidth - ((crossAxisCount - 1) * 10)) /
            crossAxisCount;

        return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: cards.map((data) {
            return SizedBox(
              width: itemWidth,
              child: _MetricCard(data: data),
            );
          }).toList(),
        );
      },
    );
  }
}

class _MetricData {
  final IconData icon;
  final String label;
  final String value;
  final String? subValue;

  const _MetricData({
    required this.icon,
    required this.label,
    required this.value,
    this.subValue,
  });
}

class _MetricCard extends StatelessWidget {
  final _MetricData data;

  const _MetricCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: hoverBgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cardBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: paletteBlue.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(data.icon, size: 14, color: borderColor),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  data.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            data.value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (data.subValue != null) ...[
            const SizedBox(height: 2),
            Text(
              data.subValue!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: textMuted, fontSize: 11),
            ),
          ],
        ],
      ),
    );
  }
}
