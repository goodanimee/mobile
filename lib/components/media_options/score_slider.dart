import 'package:flutter/material.dart';
import '../../theme/theme.dart';

/// Slider component for updating score rating of a list entry
class ScoreSlider extends StatelessWidget {
  /// The current score (0.0 to 10.0)
  final double score;

  /// Callback when score changes
  final ValueChanged<double> onScoreChanged;

  /// Creates a score slider widget
  const ScoreSlider({
    super.key,
    required this.score,
    required this.onScoreChanged,
  });

  void _handleInteraction(double dx, double maxWidth) {
    double rawScore = (dx / maxWidth) * 10;
    if (rawScore < 0) rawScore = 0;
    if (rawScore > 10) rawScore = 10;
    onScoreChanged(double.parse(rawScore.toStringAsFixed(1)));
  }

  @override
  /// Builds the score slider widget
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF161616),
          border: Border.all(color: cardBorderColor),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'SCORE',
              style: TextStyle(
                color: textMuted,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 12),
            Column(
              children: [
                Text(
                  score.toStringAsFixed(1),
                  style: const TextStyle(
                    color: Colors.amber,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final starWidth = constraints.maxWidth / 10;
                    return GestureDetector(
                      onPanUpdate: (details) => _handleInteraction(
                        details.localPosition.dx,
                        constraints.maxWidth,
                      ),
                      onTapDown: (details) => _handleInteraction(
                        details.localPosition.dx,
                        constraints.maxWidth,
                      ),
                      child: Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                              10,
                              (index) => Icon(
                                Icons.star_rounded,
                                color: Colors.white.withValues(alpha: 0.1),
                                size: starWidth,
                              ),
                            ),
                          ),
                          ClipRect(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              widthFactor: score / 10.0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                  10,
                                  (index) => Icon(
                                    Icons.star_rounded,
                                    color: Colors.amber,
                                    size: starWidth,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
