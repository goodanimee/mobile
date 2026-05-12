import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../components/app_section.dart';
import '../widgets/ranking_pill.dart';
import '../widgets/stat_tooltip.dart';

class AnimeRankingsTab extends StatefulWidget {
  final Map<String, dynamic> media;
  final bool isNested;

  const AnimeRankingsTab({
    super.key,
    required this.media,
    this.isNested = false,
  });

  @override
  State<AnimeRankingsTab> createState() => _AnimeRankingsTabState();
}

class _AnimeRankingsTabState extends State<AnimeRankingsTab> {
  final LayerLink _statusLink = LayerLink();

  @override
  void dispose() {
    StatTooltip.hide();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rankings = widget.media['rankings'] as List? ?? [];

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (rankings.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(40),
              child: Text(
                'No rankings available',
                style: TextStyle(color: Colors.white54, fontSize: 16),
              ),
            ),
          )
        else
          ...rankings.map((ranking) {
            if (ranking is! Map<String, dynamic>) return const SizedBox.shrink();
            return RankingPill(ranking: ranking);
          }),
        const SizedBox(height: 16),
        _buildStatsSection(context),
        const SizedBox(height: 40),
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

  Widget _buildStatsSection(BuildContext context) {
    return AppSection(
      title: 'Stats',
      children: [
        const SizedBox(height: 8),
        CompositedTransformTarget(
          link: _statusLink,
          child: _buildStatusDistributionBar(
            context,
            widget.media['stats']?['statusDistribution'] as List? ?? [],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusDistributionBar(BuildContext context, List distribution) {
    if (distribution.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Status Distribution',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.info_outline_rounded, size: 12, color: Colors.white30),
            const SizedBox(width: 4),
            const Text(
              'Tap for details',
              style: TextStyle(color: Colors.white30, fontSize: 10),
            ),
          ],
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () => _showStatusTooltip(context, distribution),
          behavior: HitTestBehavior.opaque,
          child: Container(
            height: 16,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: hoverBgColor,
              border: Border.all(color: cardBorderColor, width: 1),
            ),
            child: Row(
              children: distribution.map((item) {
                final status = item['status']?.toString() ?? '';
                final amount = item['amount'] as int? ?? 0;
                if (amount == 0) return const SizedBox.shrink();
                return Flexible(
                  flex: amount,
                  child: Container(color: _getStatusColor(status)),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

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
                        color: Colors.white70,
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

  Color _getStatusColor(String status) {
    switch (status) {
      case 'CURRENT':
        return const Color(0xFF66BB6A);
      case 'COMPLETED':
        return const Color(0xFF42A5F5);
      case 'PAUSED':
        return const Color(0xFFFFA726);
      case 'DROPPED':
        return const Color(0xFFEF5350);
      case 'PLANNING':
        return const Color(0xFFAB47BC);
      default:
        return Colors.grey;
    }
  }

  String _formatStatus(String status) {
    if (status == 'CURRENT') return 'WATCHING';
    return status;
  }
}
