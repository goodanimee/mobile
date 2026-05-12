import 'dart:math' as math;
import 'package:flutter/material.dart';
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
  final List<LayerLink> _scoreLinks = List.generate(10, (_) => LayerLink());
  final List<LayerLink> _trendLinks = List.generate(14, (_) => LayerLink());

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
            if (ranking is! Map<String, dynamic>) {
              return const SizedBox.shrink();
            }
            return RankingPill(ranking: ranking);
          }),
        const SizedBox(height: 16),
        _buildStatsSection(context),
        const SizedBox(height: 32),
        _buildTrendsSection(context),
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
        const SizedBox(height: 40),
        _buildScoreHistogram(
          widget.media['stats']?['scoreDistribution'] as List? ?? [],
        ),
        const SizedBox(height: 20),
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
            const Icon(
              Icons.info_outline_rounded,
              size: 12,
              color: Colors.white30,
            ),
            const SizedBox(width: 4),
            const Text(
              'Tap for details',
              style: TextStyle(color: Colors.white54, fontSize: 10),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Builder(
          builder: (localContext) => GestureDetector(
            onTap: () => _showStatusTooltip(localContext, distribution),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                height: 8,
                child: Row(
                  children: (() {
                    final validItems = distribution
                        .where((item) => (item['amount'] as int? ?? 0) > 0)
                        .toList();
                    return validItems.asMap().entries.map((entry) {
                      final isLast = entry.key == validItems.length - 1;
                      final item = entry.value;
                      final status = item['status']?.toString() ?? '';
                      final amount = item['amount'] as int? ?? 0;

                      final color = _getStatusColor(status);
                      final hsl = HSLColor.fromColor(color);

                      final leftColor = hsl
                          .withLightness((hsl.lightness + 0.1).clamp(0.0, 1.0))
                          .toColor();
                      final rightColor = hsl
                          .withLightness((hsl.lightness - 0.12).clamp(0.0, 1.0))
                          .toColor();

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
                            boxShadow: [
                              BoxShadow(
                                color: rightColor.withValues(alpha: 0.3),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
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

  Widget _buildScoreHistogram(List distribution) {
    if (distribution.isEmpty) return const SizedBox.shrink();

    final maxAmount = distribution
        .map((e) => e['amount'] as int)
        .fold(0, (prev, element) => element > prev ? element : prev);

    final Map<int, int> scoresMap = {
      for (var e in distribution) e['score'] as int: e['amount'] as int,
    };
    final List<int> allScores = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Score Distribution',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.info_outline_rounded,
              size: 12,
              color: Colors.white30,
            ),
            const SizedBox(width: 4),
            const Text(
              'Tap for details',
              style: TextStyle(color: Colors.white54, fontSize: 10),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 140,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(allScores.length, (index) {
              final score = allScores[index];
              final amount = scoresMap[score] ?? 0;
              final heightFactor = maxAmount > 0 ? amount / maxAmount : 0.0;

              return Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: CompositedTransformTarget(
                        link: _scoreLinks[index],
                        child: Builder(
                          builder: (localContext) => GestureDetector(
                            onTap: () => _showScoreTooltip(
                              localContext,
                              index,
                              score,
                              amount,
                            ),
                            behavior: HitTestBehavior.opaque,
                            child: FractionallySizedBox(
                              heightFactor: heightFactor.clamp(0.02, 1.0),
                              widthFactor: 0.8,
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _getScoreColor(score),
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(4),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: _getScoreColor(
                                        score,
                                      ).withValues(alpha: 0.2),
                                      blurRadius: 8,
                                      offset: const Offset(0, 0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${(score / 10).toInt()}',
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  void _showScoreTooltip(
    BuildContext context,
    int index,
    int score,
    int amount,
  ) {
    StatTooltip.show(
      context: context,
      link: _scoreLinks[index],
      width: 180,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Score: ${(score / 10).toStringAsFixed(1)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$amount users',
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Color _getScoreColor(int score) {
    const red = Color(0xFFEF5350);
    const yellow = Color(0xFFFFEE58);
    const green = Color(0xFF66BB6A);

    if (score <= 50) {
      return Color.lerp(red, yellow, (score - 10) / 40) ?? yellow;
    } else {
      return Color.lerp(yellow, green, (score - 50) / 50) ?? green;
    }
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

  Widget _buildTrendsSection(BuildContext context) {
    final trendsNodes = widget.media['trends']?['nodes'] as List? ?? [];
    if (trendsNodes.isEmpty) return const SizedBox.shrink();

    final trends = trendsNodes.reversed.toList();

    return AppSection(
      title: 'Trends',
      children: [
        const SizedBox(height: 12),
        _buildTrendLineChart(context, trends),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLegendItem('Score', const Color(0xFFFFB300)),
            const SizedBox(width: 16),
            _buildLegendItem('Viewers', const Color(0xFF42A5F5)),
            const SizedBox(width: 16),
            _buildLegendItem('Popularity', const Color(0xFFAB47BC)),
          ],
        ),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(color: Colors.white60, fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildTrendLineChart(BuildContext context, List trends) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        const height = 160.0;

        return Stack(
          children: [
            SizedBox(
              height: height,
              width: width,
              child: CustomPaint(painter: _TrendLinePainter(trends: trends)),
            ),
            Positioned.fill(
              child: Row(
                children: List.generate(trends.length, (index) {
                  return Expanded(
                    child: CompositedTransformTarget(
                      link: _trendLinks[index],
                      child: Builder(
                        builder: (localContext) => GestureDetector(
                          onTap: () => _showTrendTooltip(
                            localContext,
                            index,
                            trends[index],
                          ),
                          behavior: HitTestBehavior.opaque,
                          child: const SizedBox.expand(),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showTrendTooltip(BuildContext context, int index, dynamic node) {
    final date = node['date'] as int? ?? 0;
    final score = (node['averageScore'] as num?)?.toDouble() ?? 0.0;
    final viewers = node['inProgress'] as int? ?? 0;
    final popularity = node['popularity'] as int? ?? 0;

    StatTooltip.show(
      context: context,
      link: _trendLinks[index],
      width: 200,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _formatDate(date),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: FixedColumnWidth(20),
              1: FlexColumnWidth(),
              2: IntrinsicColumnWidth(),
            },
            children: [
              _buildTrendTooltipRow(
                'Score',
                (score / 10).toStringAsFixed(1),
                const Color(0xFFFFB300),
              ),
              _buildTrendTooltipRow(
                'Viewers',
                viewers.toString(),
                const Color(0xFF42A5F5),
              ),
              _buildTrendTooltipRow(
                'Popularity',
                popularity.toString(),
                const Color(0xFFAB47BC),
              ),
            ],
          ),
        ],
      ),
    );
  }

  TableRow _buildTrendTooltipRow(String label, String value, Color color) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
        Text(
          value,
          textAlign: TextAlign.right,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  String _formatDate(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

class _TrendLinePainter extends CustomPainter {
  final List trends;

  _TrendLinePainter({required this.trends});

  @override
  void paint(Canvas canvas, Size size) {
    if (trends.length < 2) return;

    final scores = trends
        .map((n) => (n['averageScore'] as num?)?.toDouble() ?? 0.0)
        .toList();
    final viewers = trends
        .map((n) => (n['inProgress'] as num?)?.toDouble() ?? 0.0)
        .toList();
    final popularity = trends
        .map((n) => (n['popularity'] as num?)?.toDouble() ?? 0.0)
        .toList();

    _drawLine(
      canvas,
      size,
      scores,
      const Color(0xFFFFB300),
      forcedMin: 0,
      forcedMax: 100.0,
    );
    _drawLine(
      canvas,
      size,
      viewers,
      const Color(0xFF42A5F5),
      useExpScale: true,
    );
    _drawLine(
      canvas,
      size,
      popularity,
      const Color(0xFFAB47BC),
      useExpScale: true,
    );
  }

  void _drawLine(
    Canvas canvas,
    Size size,
    List<double> values,
    Color color, {
    double? forcedMin,
    double? forcedMax,
    bool useExpScale = false,
  }) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final double maxVal = forcedMax ?? (values.reduce((a, b) => a > b ? a : b));
    final double minVal = forcedMin ?? 0.0;

    double scale(double v) {
      if (maxVal <= minVal) return 0.5;
      final double normalized =
          (v - minVal).clamp(0.0, maxVal - minVal) / (maxVal - minVal);

      if (useExpScale) {
        return math.pow(normalized, 10).toDouble();
      } else {
        return normalized;
      }
    }

    final path = Path();
    final stepX = size.width / (values.length - 1);

    for (int i = 0; i < values.length; i++) {
      final x = i * stepX;
      final double yFactor = scale(values[i]);
      final double y =
          size.height - (yFactor * size.height * 0.8 + size.height * 0.1);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }

      canvas.drawCircle(Offset(x, y), 3.5, Paint()..color = color);
      canvas.drawCircle(Offset(x, y), 2, Paint()..color = Colors.white);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
