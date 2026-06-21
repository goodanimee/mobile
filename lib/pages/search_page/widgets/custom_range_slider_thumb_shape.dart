import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

/// A custom vertical bar thumb shape for a modern, sleek range slider.
class CustomRangeSliderThumbShape extends RangeSliderThumbShape {
  /// Width of the vertical bar thumb.
  final double thumbWidth;

  /// Height of the vertical bar thumb.
  final double thumbHeight;

  /// Corner radius of the vertical bar thumb.
  final double borderRadius;

  /// Creates a custom range slider thumb shape.
  const CustomRangeSliderThumbShape({
    this.thumbWidth = 6.0,
    this.thumbHeight = 16.0,
    this.borderRadius = 3.0,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(thumbWidth, thumbHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = true,
    bool isOnTop = false,
    bool isPressed = false,
    required SliderThemeData sliderTheme,
    TextDirection? textDirection,
    Thumb? thumb,
  }) {
    final Canvas canvas = context.canvas;

    final RRect rect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: center,
        width: thumbWidth,
        height: thumbHeight,
      ),
      Radius.circular(borderRadius),
    );

    final Paint fillPaint = Paint()
      ..color = const Color(0xFF161616)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(rect, fillPaint);

    final Paint strokePaint = Paint()
      ..color = sliderTheme.thumbColor ?? borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawRRect(rect, strokePaint);
  }
}
