import 'package:flutter/material.dart';
import '../theme/theme.dart';

/// A versatile pill/chip widget for tags, links, and metadata
class AppPill extends StatelessWidget {
  /// The main label text
  final String label;

  /// Optional leading text (e.g. rank or language abbreviation)
  final String? leadingText;

  /// Whether the pill contains spoiler information
  final bool isSpoiler;

  /// Optional callback when the pill is tapped
  final VoidCallback? onTap;

  /// The horizontal and vertical padding
  final EdgeInsetsGeometry padding;

  /// Optional trailing widget
  final Widget? trailing;

  /// Creates an app pill
  const AppPill({
    super.key,
    required this.label,
    this.leadingText,
    this.isSpoiler = false,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    this.trailing,
  });

  @override
  /// Builds the app pill widget
  Widget build(BuildContext context) {
    final color = isSpoiler ? spoilerColor : Colors.white70;

    final Widget content = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: isSpoiler
            ? spoilerColor.withValues(alpha: 0.1)
            : Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isSpoiler
              ? spoilerColor.withValues(alpha: 0.2)
              : Colors.white12,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leadingText != null) ...[
            Text(
              leadingText!,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 1,
              height: 12,
              color: isSpoiler
                  ? spoilerColor.withValues(alpha: 0.3)
                  : Colors.white24,
            ),
            const SizedBox(width: 8),
          ],
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (trailing != null) ...[const SizedBox(width: 6), trailing!],
        ],
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: content,
      );
    }

    return content;
  }
}
