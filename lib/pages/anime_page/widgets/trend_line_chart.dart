import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../components/app_section.dart';
import 'stat_tooltip.dart';

class TrendLineChart extends StatefulWidget {
  final List trends;

  const TrendLineChart({super.key, required this.trends});

  @override
  State<TrendLineChart> createState() => _TrendLineChartState();
}

class _TrendLineChartState extends State<TrendLineChart> {
  late final List<LayerLink> _trendLinks;

  @override
  void initState() {
    super.initState();
    _trendLinks = List.generate(widget.trends.length, (_) => LayerLink());
  }

  @override
  Widget build(BuildContext context) {
    if (widget.trends.isEmpty) return const SizedBox.shrink();

    final reversedTrends = widget.trends.reversed.toList();

    return AppSection(
      title: 'Trends',
      children: [
        const SizedBox(height: 8),
        _buildChart(context, reversedTrends),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLegendItem('Score', const Color(0xFF9C8C3A)),
            const SizedBox(width: 16),
            _buildLegendItem('Viewers', const Color(0xFF32668C)),
            const SizedBox(width: 16),
            _buildLegendItem('Popularity', const Color(0xFF6B3473)),
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

  Widget _buildChart(BuildContext context, List trends) {
    if (trends.isEmpty) return const SizedBox.shrink();

    final firstDate = trends.first['date'] as int? ?? 0;
    final lastDate = trends.last['date'] as int? ?? 0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        const height = 160.0;

        return Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: height,
                  width: width,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.02),
                      borderRadius: BorderRadius.circular(8),
                      border: Border(
                        top: BorderSide(
                          color: Colors.white.withValues(alpha: 0.05),
                          width: 1,
                        ),
                        bottom: BorderSide(
                          color: Colors.white.withValues(alpha: 0.05),
                          width: 1,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CustomPaint(
                      painter: _TrendLinePainter(trends: trends),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDate(firstDate),
                  style: const TextStyle(color: Colors.white54, fontSize: 11),
                ),
                Text(
                  _formatDate(lastDate),
                  style: const TextStyle(color: Colors.white54, fontSize: 11),
                ),
              ],
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
                const Color(0xFF9C8C3A),
              ),
              _buildTrendTooltipRow(
                'Viewers',
                viewers.toString(),
                const Color(0xFF32668C),
              ),
              _buildTrendTooltipRow(
                'Popularity',
                popularity.toString(),
                const Color(0xFF6B3473),
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

    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    const int horizontalLines = 4;
    for (int i = 1; i < horizontalLines; i++) {
      final double y = size.height * (i / horizontalLines);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

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
      [const Color(0xFF9C8C3A), const Color(0xFF756A2B)],
      forcedMin: 0,
      forcedMax: 100.0,
    );
    _drawLine(canvas, size, viewers, [
      const Color(0xFF32668C),
      const Color(0xFF234A66),
    ], useExpScale: true);
    _drawLine(canvas, size, popularity, [
      const Color(0xFF6B3473),
      const Color(0xFF4C2552),
    ], useExpScale: true);
  }

  void _drawLine(
    Canvas canvas,
    Size size,
    List<double> values,
    List<Color> gradientColors, {
    double? forcedMin,
    double? forcedMax,
    bool useExpScale = false,
  }) {
    const verticalPadding = 12.0;
    final drawableHeight = size.height - (verticalPadding * 2);

    final topColor = gradientColors[0];
    final bottomColor = gradientColors[1];

    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [topColor, bottomColor],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final double maxVal = forcedMax ?? (values.reduce((a, b) => a > b ? a : b));
    final double minVal = forcedMin ?? 0.0;

    double scale(double v) {
      if (maxVal <= minVal) return 0.5;
      final double normalized =
          (v - minVal).clamp(0.0, maxVal - minVal) / (maxVal - minVal);

      if (useExpScale) {
        return math.pow(normalized, 20).toDouble();
      }
      return normalized;
    }

    final path = Path();
    for (int i = 0; i < values.length; i++) {
      final double x = size.width * (i / (values.length - 1));
      final double y =
          verticalPadding + drawableHeight * (1.0 - scale(values[i]));

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);

    final dotPaint = Paint()
      ..color = topColor
      ..style = PaintingStyle.fill;

    for (int i = 0; i < values.length; i++) {
      final double x = size.width * (i / (values.length - 1));
      final double y =
          verticalPadding + drawableHeight * (1.0 - scale(values[i]));
      canvas.drawCircle(Offset(x, y), 3, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _TrendLinePainter oldDelegate) =>
      oldDelegate.trends != trends;
}
