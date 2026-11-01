import 'package:flutter/material.dart';

import '../../../components/section.dart';
import '../../../models/user_statistics.dart';
import '../../../theme/theme.dart';

/// Renders visual breakdowns for list statuses and media formats.
class StatusFormatBreakdown extends StatelessWidget {
  /// Status statistics entries.
  final List<UserStatusStat> statuses;

  /// Format statistics entries.
  final List<UserFormatStat> formats;

  /// Whether rendering anime (true) or manga (false).
  final bool isAnime;

  /// Creates a status and format breakdown widget.
  const StatusFormatBreakdown({
    super.key,
    required this.statuses,
    required this.formats,
    required this.isAnime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_buildStatusSection(), _buildFormatSection()],
    );
  }

  Widget _buildStatusSection() {
    final validStatuses = statuses.where((s) => s.count > 0).toList();
    final total = validStatuses.fold<int>(0, (sum, s) => sum + s.count);

    return Section(
      title: 'Status Distribution',
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: hoverBgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cardBorderColor),
          ),
          child: total > 0
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSegmentedBar(
                      segments: validStatuses.map((s) {
                        return _BarSegment(
                          label: _formatStatusLabel(s.status, isAnime),
                          count: s.count,
                          color: _statusColor(s.status),
                        );
                      }).toList(),
                      total: total,
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      children: validStatuses.map((s) {
                        final pct = StatisticsMathUtils.calculatePercentage(
                          s.count,
                          total,
                        );
                        return _buildLegendItem(
                          color: _statusColor(s.status),
                          label: _formatStatusLabel(s.status, isAnime),
                          value: '${s.count} (${pct.toStringAsFixed(0)}%)',
                        );
                      }).toList(),
                    ),
                  ],
                )
              : const SizedBox(
                  height: 60,
                  child: Center(
                    child: Text(
                      'No status distribution data available',
                      style: TextStyle(color: textMuted, fontSize: 13),
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildFormatSection() {
    final validFormats = formats.where((f) => f.count > 0).toList();
    final total = validFormats.fold<int>(0, (sum, f) => sum + f.count);

    return Section(
      title: 'Format Distribution',
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: hoverBgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cardBorderColor),
          ),
          child: total > 0
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSegmentedBar(
                      segments: validFormats.map((f) {
                        return _BarSegment(
                          label: _formatName(f.format),
                          count: f.count,
                          color: _formatColor(f.format),
                        );
                      }).toList(),
                      total: total,
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      children: validFormats.map((f) {
                        final pct = StatisticsMathUtils.calculatePercentage(
                          f.count,
                          total,
                        );
                        return _buildLegendItem(
                          color: _formatColor(f.format),
                          label: _formatName(f.format),
                          value: '${f.count} (${pct.toStringAsFixed(0)}%)',
                        );
                      }).toList(),
                    ),
                  ],
                )
              : const SizedBox(
                  height: 60,
                  child: Center(
                    child: Text(
                      'No format distribution data available',
                      style: TextStyle(color: textMuted, fontSize: 13),
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildSegmentedBar({
    required List<_BarSegment> segments,
    required int total,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: SizedBox(
        height: 12,
        child: Row(
          children: segments.map((seg) {
            return Expanded(
              flex: seg.count,
              child: Container(color: seg.color),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildLegendItem({
    required Color color,
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: textPrimary,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 4),
        Text(value, style: const TextStyle(color: textSecondary, fontSize: 11)),
      ],
    );
  }

  static Color _statusColor(String status) {
    return switch (status.toUpperCase()) {
      'COMPLETED' => const Color(0xFF22C55E),
      'CURRENT' => borderColor,
      'PLANNING' => const Color(0xFFEAB308),
      'PAUSED' => const Color(0xFFF97316),
      'DROPPED' => const Color(0xFFEF4444),
      'REPEATING' => const Color(0xFFA855F7),
      _ => const Color(0xFF94A3B8),
    };
  }

  static String _formatStatusLabel(String status, bool isAnime) {
    return switch (status.toUpperCase()) {
      'CURRENT' => isAnime ? 'Watching' : 'Reading',
      'COMPLETED' => 'Completed',
      'PLANNING' => 'Planning',
      'PAUSED' => 'Paused',
      'DROPPED' => 'Dropped',
      'REPEATING' => isAnime ? 'Rewatching' : 'Rereading',
      _ => status,
    };
  }

  static Color _formatColor(String format) {
    return switch (format.toUpperCase()) {
      'TV' => const Color(0xFF3B82F6),
      'TV_SHORT' => const Color(0xFF60A5FA),
      'MOVIE' => const Color(0xFFEC4899),
      'SPECIAL' => const Color(0xFF8B5CF6),
      'OVA' => const Color(0xFF06B6D4),
      'ONA' => const Color(0xFF14B8A6),
      'MUSIC' => const Color(0xFFF43F5E),
      'MANGA' => const Color(0xFF10B981),
      'NOVEL' => const Color(0xFFF59E0B),
      'ONE_SHOT' => const Color(0xFF6366F1),
      _ => const Color(0xFF64748B),
    };
  }

  static String _formatName(String format) {
    return switch (format.toUpperCase()) {
      'TV' => 'TV',
      'TV_SHORT' => 'TV Short',
      'MOVIE' => 'Movie',
      'SPECIAL' => 'Special',
      'OVA' => 'OVA',
      'ONA' => 'ONA',
      'MUSIC' => 'Music',
      'MANGA' => 'Manga',
      'NOVEL' => 'Light Novel',
      'ONE_SHOT' => 'One Shot',
      _ => format,
    };
  }
}

class _BarSegment {
  final String label;
  final int count;
  final Color color;

  const _BarSegment({
    required this.label,
    required this.count,
    required this.color,
  });
}
