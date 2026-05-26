import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

String _toSvgColor(Color color) {
  final r = (color.r * 255).round();
  final g = (color.g * 255).round();
  final b = (color.b * 255).round();
  final a = color.a;
  return 'rgba($r, $g, $b, $a)';
}

/// Custom Lucide Heart Icon with dynamic fill support.
class LucideHeartIcon extends StatelessWidget {
  /// Whether the heart should be rendered as filled.
  final bool isFilled;

  /// The size of the heart.
  final double size;

  /// The fill or main color.
  final Color color;

  /// The optional stroke outline color.
  final Color? strokeColor;

  /// Creates a Lucide Heart Icon.
  const LucideHeartIcon({
    super.key,
    required this.isFilled,
    required this.color,
    this.size = 24,
    this.strokeColor,
  });

  @override
  Widget build(BuildContext context) {
    final fillVal = isFilled ? _toSvgColor(color) : 'none';
    final strokeVal = _toSvgColor(strokeColor ?? color);

    return SvgPicture.string(
      '''<svg xmlns="http://www.w3.org/2000/svg" width="$size" height="$size" viewBox="0 0 24 24" fill="$fillVal" stroke="$strokeVal" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M19 14c1.49-1.46 3-3.21 3-5.5A5.5 5.5 0 0 0 16.5 3c-1.76 0-3 .5-4.5 2-1.5-1.5-2.74-2-4.5-2A5.5 5.5 0 0 0 2 8.5c0 2.3 1.5 4.05 3 5.5l7 7Z"/></svg>''',
      width: size,
      height: size,
    );
  }
}

/// Custom Lucide Star Icon with dynamic fill support.
class LucideStarIcon extends StatelessWidget {
  /// Whether the star should be rendered as filled.
  final bool isFilled;

  /// The size of the star.
  final double size;

  /// The fill or main color.
  final Color color;

  /// The optional stroke outline color.
  final Color? strokeColor;

  /// Creates a Lucide Star Icon.
  const LucideStarIcon({
    super.key,
    required this.isFilled,
    required this.color,
    this.size = 24,
    this.strokeColor,
  });

  @override
  Widget build(BuildContext context) {
    final fillVal = isFilled ? _toSvgColor(color) : 'none';
    final strokeVal = _toSvgColor(strokeColor ?? color);

    return SvgPicture.string(
      '''<svg xmlns="http://www.w3.org/2000/svg" width="$size" height="$size" viewBox="0 0 24 24" fill="$fillVal" stroke="$strokeVal" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M11.525 2.295a.53.53 0 0 1 .95 0l2.31 4.679a2.123 2.123 0 0 0 1.595 1.16l5.166.756a.53.53 0 0 1 .294.904l-3.736 3.638a2.123 2.123 0 0 0-.611 1.878l.882 5.14a.53.53 0 0 1-.771.56l-4.618-2.428a2.122 2.122 0 0 0-1.973 0L6.396 21.01a.53.53 0 0 1-.77-.56l.881-5.139a2.122 2.122 0 0 0-.611-1.879L2.16 9.795a.53.53 0 0 1 .294-.906l5.165-.755a2.122 2.122 0 0 0 1.597-1.16z"/></svg>''',
      width: size,
      height: size,
    );
  }
}
