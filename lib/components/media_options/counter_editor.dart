import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
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
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _lastValue = widget.value;
    _controller = TextEditingController(text: widget.value.toString());
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
  void didUpdateWidget(CounterEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _lastValue = oldWidget.value;
      if (!_focusNode.hasFocus) {
        _controller.text = widget.value.toString();
      }
    }
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus && mounted) {
      _submitValue(_controller.text);
    }
  }

  void _submitValue(String val) {
    final parsed = int.tryParse(val);
    if (parsed != null && parsed >= 0) {
      widget.onChanged(parsed);
    }
    if (mounted) {
      setState(() {
        _isEditing = false;
      });
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    final bool canDecrement = widget.value > 0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth;
        final bool isCompact = cardWidth < 150.0;

        final double horizontalPadding = getResponsiveSize(
          context,
          isCompact ? 8.0 : 16.0,
        );
        final double verticalPadding = getResponsiveSize(
          context,
          isCompact ? 8.0 : 12.0,
        );
        final double buttonSize = getResponsiveSize(
          context,
          isCompact ? 28.0 : 36.0,
        );
        final double buttonIconSize = getResponsiveSize(
          context,
          isCompact ? 16.0 : 20.0,
        );

        final double valueFontSize = getResponsiveFontSize(
          context,
          isCompact ? 14.0 : 16.0,
        );
        final double maxFontSize = getResponsiveFontSize(
          context,
          isCompact ? 12.0 : 14.0,
        );
        final double labelFontSize = getResponsiveFontSize(
          context,
          isCompact ? 10.0 : 11.0,
        );
        final double verticalSpacing = isCompact ? 4.0 : 8.0;

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
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
                style: TextStyle(
                  color: textMuted,
                  fontSize: labelFontSize,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                ),
              ),
              SizedBox(height: verticalSpacing),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: canDecrement
                        ? () => widget.onChanged(widget.value - 1)
                        : null,
                    behavior: HitTestBehavior.opaque,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: buttonSize,
                      height: buttonSize,
                      decoration: BoxDecoration(
                        color: canDecrement
                            ? Colors.white.withValues(alpha: 0.03)
                            : Colors.transparent,
                        border: Border.all(
                          color: canDecrement
                              ? Colors.white.withValues(alpha: 0.06)
                              : Colors.white.withValues(alpha: 0.01),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Icon(
                          LucideIcons.chevronLeft,
                          color: canDecrement ? Colors.white : Colors.white24,
                          size: buttonIconSize,
                        ),
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
                                _controller.text = widget.value.toString();
                              });
                            },
                      behavior: HitTestBehavior.opaque,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _isEditing
                              ? SizedBox(
                                  width: 48,
                                  child: TextField(
                                    controller: _controller,
                                    focusNode: _focusNode,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    autofocus: true,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: valueFontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 4,
                                      ),
                                    ),
                                    onSubmitted: _submitValue,
                                    onTapOutside: (_) => _focusNode.unfocus(),
                                  ),
                                )
                              : ClipRect(
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 250),
                                    transitionBuilder:
                                        (
                                          Widget child,
                                          Animation<double> animation,
                                        ) {
                                          final isIncoming =
                                              child.key ==
                                              ValueKey<int>(widget.value);
                                          final bool isIncreasing =
                                              widget.value >= _lastValue;

                                          final Offset beginOffset;
                                          final Offset endOffset = Offset.zero;

                                          if (isIncreasing) {
                                            beginOffset = isIncoming
                                                ? const Offset(1.5, 0.0)
                                                : const Offset(-1.5, 0.0);
                                          } else {
                                            beginOffset = isIncoming
                                                ? const Offset(-1.5, 0.0)
                                                : const Offset(1.5, 0.0);
                                          }

                                          final slideAnimation =
                                              Tween<Offset>(
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
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: valueFontSize,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                          if (widget.showMaxLimit) ...[
                            Text(
                              widget.maximum != null
                                  ? ' / ${widget.maximum}'
                                  : ' / ?',
                              style: TextStyle(
                                color: textMuted,
                                fontSize: maxFontSize,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => widget.onChanged(widget.value + 1),
                    behavior: HitTestBehavior.opaque,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: buttonSize,
                      height: buttonSize,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.03),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.06),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Icon(
                          LucideIcons.chevronRight,
                          color: Colors.white,
                          size: buttonIconSize,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
