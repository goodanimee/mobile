import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

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
    const beakHeight = 8.0;

    return CustomPaint(
      painter: _TooltipPainter(showAbove: showAbove, beakX: beakX),
      child: Container(
        width: width,
        padding: EdgeInsets.only(
          top: 16.0 + (showAbove ? 0 : beakHeight),
          bottom: 16.0 + (showAbove ? beakHeight : 0),
          left: 16.0,
          right: 16.0,
        ),
        child: child,
      ),
    );
  }
}

class _TooltipPainter extends CustomPainter {
  final bool showAbove;
  final double beakX;

  _TooltipPainter({required this.showAbove, required this.beakX});

  @override
  void paint(Canvas canvas, Size size) {
    const double beakWidth = 16.0;
    const double beakHeight = 8.0;
    const double radius = 16.0;

    final rect = showAbove
        ? Rect.fromLTWH(0, 0, size.width, size.height - beakHeight)
        : Rect.fromLTWH(0, beakHeight, size.width, size.height - beakHeight);

    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(radius));
    final pathRect = Path()..addRRect(rrect);

    final double left = (beakX - beakWidth / 2).clamp(
      radius,
      size.width - radius - beakWidth,
    );
    final double right = left + beakWidth;
    final double center = left + beakWidth / 2;

    final pathBeak = Path();
    if (showAbove) {
      pathBeak.moveTo(left, size.height - beakHeight);
      pathBeak.lineTo(center, size.height);
      pathBeak.lineTo(right, size.height - beakHeight);
    } else {
      pathBeak.moveTo(left, beakHeight);
      pathBeak.lineTo(center, 0);
      pathBeak.lineTo(right, beakHeight);
    }
    pathBeak.close();

    final path = Path.combine(PathOperation.union, pathRect, pathBeak);

    final shadowPaint = Paint()
      ..color = shadowColor.withValues(alpha: 0.4)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    canvas.drawPath(path.shift(const Offset(0, 10)), shadowPaint);

    final fillPaint = Paint()
      ..color = hoverBgColor
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);

    final borderPaint = Paint()
      ..color = textHint.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant _TooltipPainter oldDelegate) {
    return oldDelegate.showAbove != showAbove || oldDelegate.beakX != beakX;
  }
}
