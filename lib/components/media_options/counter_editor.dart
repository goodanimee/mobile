import 'package:flutter/material.dart';
import '../../theme/theme.dart';

/// Compact counter editor widget with controls.
class CounterEditor extends StatefulWidget {
  /// The label displaying above the counter.
  final String label;

  /// The current count value.
  final int value;

  /// The optional maximum progress limit.
  final int? maximum;

  /// Whether to show the maximum limit.
  final bool showMaxLimit;

  /// Callback triggered on count change.
  final ValueChanged<int> onChanged;

  /// Creates a counter editor.
  const CounterEditor({
    super.key,
    required this.label,
    required this.value,
    this.maximum,
    this.showMaxLimit = true,
    required this.onChanged,
  });

  @override
  State<CounterEditor> createState() => _CounterEditorState();
}

class _CounterEditorState extends State<CounterEditor> {
  late int _lastValue;

  @override
  void initState() {
    super.initState();
    _lastValue = widget.value;
  }

  @override
  void didUpdateWidget(CounterEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _lastValue = oldWidget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool canDecrement = widget.value > 0;
    final bool canIncrement = widget.maximum == null || widget.value < widget.maximum!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF161616),
        border: Border.all(color: cardBorderColor),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.label.toUpperCase(),
            style: const TextStyle(
              color: textMuted,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: canDecrement ? () => widget.onChanged(widget.value - 1) : null,
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Icon(
                    Icons.keyboard_arrow_left_rounded,
                    color: canDecrement ? Colors.white : Colors.white24,
                    size: 24,
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRect(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          final isIncoming = child.key == ValueKey<int>(widget.value);
                          final bool isIncreasing = widget.value >= _lastValue;

                          Offset beginOffset;
                          Offset endOffset = Offset.zero;

                          if (isIncreasing) {
                            beginOffset = isIncoming ? const Offset(1.5, 0.0) : const Offset(-1.5, 0.0);
                          } else {
                            beginOffset = isIncoming ? const Offset(-1.5, 0.0) : const Offset(1.5, 0.0);
                          }

                          final slideAnimation = Tween<Offset>(
                            begin: beginOffset,
                            end: endOffset,
                          ).animate(
                            CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeInOutCubic,
                            ),
                          );

                          return FadeTransition(
                            opacity: animation,
                            child: SlideTransition(
                              position: slideAnimation,
                              child: child,
                            ),
                          );
                        },
                        child: Text(
                          '${widget.value}',
                          key: ValueKey<int>(widget.value),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    if (widget.showMaxLimit) ...[
                      Text(
                        widget.maximum != null ? ' / ${widget.maximum}' : ' / ?',
                        style: const TextStyle(
                          color: textMuted,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              GestureDetector(
                onTap: canIncrement ? () => widget.onChanged(widget.value + 1) : null,
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Icon(
                    Icons.keyboard_arrow_right_rounded,
                    color: canIncrement ? Colors.white : Colors.white24,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
