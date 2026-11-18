import 'package:material_ui/material_ui.dart';

/// Container that measures child content and clamps height if exceeding [maxHeight].
class ClampedFeedContent extends StatefulWidget {
  /// Content to display.
  final Widget child;

  /// Maximum allowed vertical height before clamping.
  final double maxHeight;

  /// Whether clamping is enabled.
  final bool enabled;

  /// Callback fired when overflow state is determined.
  final ValueChanged<bool>? onOverflowChanged;

  /// Creates a clamped feed content container.
  const ClampedFeedContent({
    super.key,
    required this.child,
    this.maxHeight = 240.0,
    this.enabled = true,
    this.onOverflowChanged,
  });

  @override
  State<ClampedFeedContent> createState() => _ClampedFeedContentState();
}

class _ClampedFeedContentState extends State<ClampedFeedContent> {
  final GlobalKey _measureKey = GlobalKey();
  bool _isOverflowing = false;

  @override
  void initState() {
    super.initState();
    if (widget.enabled) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _checkOverflow());
    }
  }

  @override
  void didUpdateWidget(covariant ClampedFeedContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _checkOverflow());
    } else if (_isOverflowing) {
      setState(() => _isOverflowing = false);
      widget.onOverflowChanged?.call(false);
    }
  }

  void _checkOverflow() {
    if (!mounted || !widget.enabled) return;
    final renderBox =
        _measureKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null && renderBox.hasSize) {
      final overflows = renderBox.size.height > widget.maxHeight;
      if (overflows != _isOverflowing) {
        setState(() => _isOverflowing = overflows);
        widget.onOverflowChanged?.call(overflows);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.child;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Offstage(
              child: SizedBox(
                width: constraints.maxWidth,
                child: KeyedSubtree(key: _measureKey, child: widget.child),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: _isOverflowing ? widget.maxHeight : double.infinity,
              ),
              child: ClipRect(
                child: ShaderMask(
                  shaderCallback: (bounds) {
                    if (!_isOverflowing) {
                      return const LinearGradient(
                        colors: [Colors.black, Colors.black],
                      ).createShader(bounds);
                    }
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.0, 0.75, 1.0],
                      colors: [Colors.black, Colors.black, Colors.transparent],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.dstIn,
                  child: widget.child,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
