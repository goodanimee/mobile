import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../models/common.dart';
import 'stat_tooltip.dart';

/// A widget displaying a horizontal bar showing the status distribution of an anime
class StatusDistributionBar extends StatefulWidget {
  /// The distribution data
  final List distribution;

  /// Creates a status distribution bar
  const StatusDistributionBar({super.key, required this.distribution});

  @override
  State<StatusDistributionBar> createState() => _StatusDistributionBarState();
}

/// State for StatusDistributionBar
class _StatusDistributionBarState extends State<StatusDistributionBar> {
  final LayerLink _statusLink = LayerLink();

  @override
  /// Builds the status distribution bar widget
  Widget build(BuildContext context) {
    if (widget.distribution.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text(
              'Status Distribution',
              style: TextStyle(
                color: textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.info_outline_rounded, size: 12, color: textHint),
            SizedBox(width: 4),
            Text(
              'Tap for details',
              style: TextStyle(color: textMuted, fontSize: 10),
            ),
          ],
        ),
        const SizedBox(height: 12),
        CompositedTransformTarget(
          link: _statusLink,
          child: Builder(
            builder: (localContext) => GestureDetector(
              onTap: () =>
                  _showStatusTooltip(localContext, widget.distribution),
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  height: 8,
                  child: Row(
                    children: (() {
                      final validItems = widget.distribution
                          .where((item) => (item['amount'] as int? ?? 0) > 0)
                          .toList();
                      return validItems.asMap().entries.map((entry) {
                        final isLast = entry.key == validItems.length - 1;
                        final item = entry.value;
                        final status = item['status']?.toString() ?? '';
                        final amount = item['amount'] as int? ?? 0;

                        final gradientColors = _getStatusGradient(status);
                        final leftColor = gradientColors[0];
                        final rightColor = gradientColors[1];

                        return Flexible(
                          flex: amount,
                          child: Container(
                            margin: EdgeInsets.only(right: isLast ? 0 : 3),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [leftColor, rightColor],
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        );
                      }).toList();
                    })(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Shows a tooltip with detailed status distribution information
  void _showStatusTooltip(BuildContext context, List distribution) {
    StatTooltip.show(
      context: context,
      link: _statusLink,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Distribution',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: FixedColumnWidth(24),
              1: FlexColumnWidth(),
              2: IntrinsicColumnWidth(),
            },
            children: distribution.map((item) {
              final status = item['status']?.toString() ?? '';
              final amount = item['amount'] as int? ?? 0;
              return TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _getStatusColor(status),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Text(
                      _formatStatus(status),
                      style: const TextStyle(
                        color: textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Text(
                      amount.toString(),
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  /// Returns the primary color for a status
  Color _getStatusColor(String status) {
    switch (status) {
      case 'CURRENT':
        return statusWatching;
      case 'COMPLETED':
        return statusCompleted;
      case 'PAUSED':
        return statusPaused;
      case 'DROPPED':
        return statusDropped;
      case 'PLANNING':
        return statusPlanning;
      default:
        return statusOther;
    }
  }

  /// Returns the gradient colors for a status
  List<Color> _getStatusGradient(String status) {
    switch (status) {
      case 'CURRENT':
        return [statusWatching, statusWatchingDark];
      case 'COMPLETED':
        return [statusCompleted, statusCompletedDark];
      case 'PAUSED':
        return [statusPaused, statusPausedDark];
      case 'DROPPED':
        return [statusDropped, statusDroppedDark];
      case 'PLANNING':
        return [statusPlanning, statusPlanningDark];
      default:
        return [statusOther, statusOtherDark];
    }
  }

  /// Formats the status string for display
  String _formatStatus(String status) {
    return MediaListStatus.fromString(status).displayName;
  }
}
