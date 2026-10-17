import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../theme/theme.dart';
import '../../utils/media_list_mutations.dart';
import '../lucide_icons_helper.dart';

/// Slider and precision stepper component for updating score rating of a list entry
class ScoreSlider extends StatefulWidget {
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

  @override
  State<ScoreSlider> createState() => _ScoreSliderState();
}

class _ScoreSliderState extends State<ScoreSlider> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.score.toStringAsFixed(1));
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ScoreSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.score != widget.score && !_focusNode.hasFocus) {
      _controller.text = widget.score.toStringAsFixed(1);
    }
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus && mounted) {
      _submitValue(_controller.text);
    }
  }

  void _submitValue(String val) {
    final parsed = double.tryParse(val.trim());
    if (parsed != null) {
      final normalized = MediaListEntryMutation.normalizeScore(parsed);
      widget.onScoreChanged(normalized);
      _controller.text = normalized.toStringAsFixed(1);
    } else {
      _controller.text = widget.score.toStringAsFixed(1);
    }
    if (mounted) {
      setState(() {
        _isEditing = false;
      });
    }
  }

  void _handleInteraction(double dx, double maxWidth) {
    final rawScore = (dx / maxWidth) * 10;
    widget.onScoreChanged(MediaListEntryMutation.normalizeScore(rawScore));
  }

  Widget _buildStepButton({
    required IconData icon,
    required bool enabled,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: kAnimFast,
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: enabled
              ? Colors.white.withValues(alpha: 0.03)
              : Colors.transparent,
          border: Border.all(
            color: enabled
                ? Colors.white.withValues(alpha: 0.06)
                : Colors.white.withValues(alpha: 0.01),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Icon(
            icon,
            color: enabled ? Colors.white : Colors.white24,
            size: 18,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool canDecrement = widget.score > 0.0;
    final bool canIncrement = widget.score < 10.0;

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStepButton(
                      icon: LucideIcons.minus,
                      enabled: canDecrement,
                      onTap: () => widget.onScoreChanged(
                        MediaListEntryMutation.normalizeScore(
                          widget.score - 0.1,
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: _isEditing
                            ? null
                            : () {
                                setState(() {
                                  _isEditing = true;
                                  _controller.text = widget.score
                                      .toStringAsFixed(1);
                                });
                              },
                        behavior: HitTestBehavior.opaque,
                        child: Center(
                          child: _isEditing
                              ? SizedBox(
                                  width: 72,
                                  child: TextField(
                                    controller: _controller,
                                    focusNode: _focusNode,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                          decimal: true,
                                        ),
                                    textAlign: TextAlign.center,
                                    autofocus: true,
                                    style: const TextStyle(
                                      color: Colors.amber,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 2,
                                      ),
                                    ),
                                    onSubmitted: _submitValue,
                                    onTapOutside: (_) => _focusNode.unfocus(),
                                  ),
                                )
                              : Text(
                                  widget.score.toStringAsFixed(1),
                                  style: const TextStyle(
                                    color: Colors.amber,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    _buildStepButton(
                      icon: LucideIcons.plus,
                      enabled: canIncrement,
                      onTap: () => widget.onScoreChanged(
                        MediaListEntryMutation.normalizeScore(
                          widget.score + 0.1,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
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
                              (index) => LucideStarIcon(
                                isFilled: false,
                                color: Colors.white.withValues(alpha: 0.1),
                                size: starWidth,
                              ),
                            ),
                          ),
                          ClipRect(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              widthFactor: widget.score / 10.0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                  10,
                                  (index) => LucideStarIcon(
                                    isFilled: true,
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
