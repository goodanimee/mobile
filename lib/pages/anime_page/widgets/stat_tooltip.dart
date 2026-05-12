import 'package:flutter/material.dart';

/// A manager and widget for displaying premium stat tooltips with a pointed beak.
class StatTooltip {
  static OverlayEntry? _currentEntry;

  /// Shows a tooltip anchored to the provided [link].
  static void show({
    required BuildContext context,
    required LayerLink link,
    required Widget child,
    double width = 260,
  }) {
    hide();

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final double screenHeight = MediaQuery.of(context).size.height;
    final double targetCenterY = offset.dy + renderBox.size.height / 2;

    final bool showAbove = targetCenterY > screenHeight / 2;

    _currentEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: hide,
              behavior: HitTestBehavior.opaque,
              child: Container(color: Colors.transparent),
            ),
          ),
          CompositedTransformFollower(
            link: link,
            showWhenUnlinked: false,
            offset: showAbove ? const Offset(0, -10) : const Offset(0, 10),
            followerAnchor: showAbove ? Alignment.bottomCenter : Alignment.topCenter,
            targetAnchor: showAbove ? Alignment.topCenter : Alignment.bottomCenter,
            child: Material(
              color: Colors.transparent,
              child: _TooltipBubble(width: width, showAbove: showAbove, child: child),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_currentEntry!);
  }

  /// Hides the current tooltip.
  static void hide() {
    _currentEntry?.remove();
    _currentEntry = null;
  }
}

class _TooltipBubble extends StatelessWidget {
  final double width;
  final Widget child;
  final bool showAbove;

  const _TooltipBubble({
    required this.width,
    required this.child,
    required this.showAbove,
  });

  @override
  Widget build(BuildContext context) {
    final beak = CustomPaint(
      size: const Size(16, 8),
      painter: _BeakPainter(flip: showAbove),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!showAbove) beak,
        Container(
          width: width,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E2C),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.4),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: child,
        ),
        if (showAbove) beak,
      ],
    );
  }
}

class _BeakPainter extends CustomPainter {
  final bool flip;

  _BeakPainter({required this.flip});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1E1E2C)
      ..style = PaintingStyle.fill;

    final path = Path();
    if (flip) {
      path.moveTo(0, 0);
      path.lineTo(size.width / 2, size.height);
      path.lineTo(size.width, 0);
    } else {
      path.moveTo(0, size.height);
      path.lineTo(size.width / 2, 0);
      path.lineTo(size.width, size.height);
    }
    path.close();

    canvas.drawPath(path, paint);
    
    final borderPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
      
    if (flip) {
      canvas.drawLine(Offset(0, 0), Offset(size.width / 2, size.height), borderPaint);
      canvas.drawLine(Offset(size.width / 2, size.height), Offset(size.width, 0), borderPaint);
    } else {
      canvas.drawLine(Offset(0, size.height), Offset(size.width / 2, 0), borderPaint);
      canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width, size.height), borderPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
