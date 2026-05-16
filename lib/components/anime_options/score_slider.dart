import 'package:flutter/material.dart';
import '../section_title.dart';

class ScoreSlider extends StatelessWidget {
  final double score;
  final ValueChanged<double> onScoreChanged;

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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: 'Score', fontSize: 14, bottomPadding: 12),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    );
  }
}
