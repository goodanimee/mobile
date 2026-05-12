import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import 'stat_tooltip.dart';

/// A widget displaying a histogram of scores for an anime
class ScoreHistogram extends StatefulWidget {
  /// The score distribution data
  final List distribution;

  /// Creates a score histogram
  const ScoreHistogram({super.key, required this.distribution});

  @override
  State<ScoreHistogram> createState() => _ScoreHistogramState();
}

/// State for ScoreHistogram
class _ScoreHistogramState extends State<ScoreHistogram> {
  final List<LayerLink> _scoreLinks = List.generate(10, (_) => LayerLink());

  @override
  /// Builds the score histogram widget
  Widget build(BuildContext context) {
    if (widget.distribution.isEmpty) return const SizedBox.shrink();

    final maxAmount = widget.distribution
        .map((e) => e['amount'] as int)
        .fold(0, (prev, element) => element > prev ? element : prev);

    final Map<int, int> scoresMap = {
      for (var e in widget.distribution) e['score'] as int: e['amount'] as int,
    };
    final List<int> allScores = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text(
              'Score Distribution',
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
                            child: Builder(
                              builder: (context) {
                                final gradientColors = _getScoreGradient(score);
                                final topColor = gradientColors[0];
                                final bottomColor = gradientColors[1];

                                return FractionallySizedBox(
                                  widthFactor: 0.75,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(
                                        alpha: 0.03,
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    alignment: Alignment.bottomCenter,
                                    child: FractionallySizedBox(
                                      heightFactor: heightFactor.clamp(
                                        0.02,
                                        1.0,
                                      ),
                                      widthFactor: 1.0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [topColor, bottomColor],
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${(score / 10).toInt()}',
                      style: const TextStyle(color: textMuted, fontSize: 10),
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

  /// Shows a tooltip with detailed score information
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
            style: const TextStyle(color: textSecondary, fontSize: 13),
          ),
        ],
      ),
    );
  }

  /// Calculates the gradient colors for a given score
  List<Color> _getScoreGradient(int score) {
    const topRed = scoreRed;
    const topYellow = scoreYellow;
    const topGreen = scoreGreen;

    const bottomRed = scoreRedDark;
    const bottomYellow = scoreYellowDark;
    const bottomGreen = scoreGreenDark;

    Color topColor;
    Color bottomColor;

    if (score <= 50) {
      topColor = Color.lerp(topRed, topYellow, (score - 10) / 40) ?? topYellow;
      bottomColor =
          Color.lerp(bottomRed, bottomYellow, (score - 10) / 40) ??
          bottomYellow;
    } else {
      topColor = Color.lerp(topYellow, topGreen, (score - 50) / 50) ?? topGreen;
      bottomColor =
          Color.lerp(bottomYellow, bottomGreen, (score - 50) / 50) ??
          bottomGreen;
    }

    return [topColor, bottomColor];
  }
}
