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
    final Size screenSize = MediaQuery.of(context).size;

    final double targetCenterX = offset.dx + renderBox.size.width / 2;
    final double targetCenterY = offset.dy + renderBox.size.height / 2;

    final bool showAbove = targetCenterY > screenSize.height / 2;

    const double padding = 16.0;
    double dx = 0;
    if (targetCenterX - width / 2 < padding) {
      dx = padding - (targetCenterX - width / 2);
    } else if (targetCenterX + width / 2 > screenSize.width - padding) {
      dx = (screenSize.width - padding) - (targetCenterX + width / 2);
    }

    final double beakX = width / 2 - dx;

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
            offset: Offset(dx, showAbove ? -10 : 10),
            followerAnchor: showAbove
                ? Alignment.bottomCenter
                : Alignment.topCenter,
            targetAnchor: showAbove
                ? Alignment.topCenter
                : Alignment.bottomCenter,
            child: Material(
              color: Colors.transparent,
              child: _TooltipBubble(
                width: width,
                showAbove: showAbove,
                beakX: beakX,
                child: child,
              ),
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
  final double beakX;

  const _TooltipBubble({
    required this.width,
    required this.child,
    required this.showAbove,
    required this.beakX,
  });

  @override
  Widget build(BuildContext context) {
    final beak = CustomPaint(
      size: Size(width, 8),
      painter: _BeakPainter(flip: showAbove, beakX: beakX),
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
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
              width: 1,
            ),
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
  final double beakX;

  _BeakPainter({required this.flip, required this.beakX});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1E1E2C)
      ..style = PaintingStyle.fill;

    const double beakWidth = 16.0;
    final double left = (beakX - beakWidth / 2).clamp(
      16.0,
      size.width - 16.0 - beakWidth,
    );
    final double right = left + beakWidth;
    final double center = left + beakWidth / 2;

    final path = Path();
    if (flip) {
      path.moveTo(left, 0);
      path.lineTo(center, size.height);
      path.lineTo(right, 0);
    } else {
      path.moveTo(left, size.height);
      path.lineTo(center, 0);
      path.lineTo(right, size.height);
    }
    path.close();

    canvas.drawPath(path, paint);

    final borderPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    if (flip) {
      canvas.drawLine(
        Offset(left, 0),
        Offset(center, size.height),
        borderPaint,
      );
      canvas.drawLine(
        Offset(center, size.height),
        Offset(right, 0),
        borderPaint,
      );
    } else {
      canvas.drawLine(
        Offset(left, size.height),
        Offset(center, 0),
        borderPaint,
      );
      canvas.drawLine(
        Offset(center, 0),
        Offset(right, size.height),
        borderPaint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
