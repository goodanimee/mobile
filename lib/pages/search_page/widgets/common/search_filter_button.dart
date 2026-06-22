import 'package:flutter/material.dart';
import '../../../../theme/theme.dart';

/// A reusable custom button for advanced search filters.
class SearchFilterButton extends StatelessWidget {
  /// The main label text on the button.
  final String label;

  /// Optional leading icon.
  final IconData? icon;

  /// Optional color for the leading icon.
  final Color? iconColor;

  /// Optional custom background color.
  final Color? backgroundColor;

  /// The border color of the button.
  final Color borderColor;

  /// The color of the label text.
  final Color textColor;

  /// Optional trailing badge or numeric indicator.
  final Widget? badge;

  /// Callback when the button is tapped.
  final VoidCallback onTap;

  /// Optional custom border radius.
  final BorderRadius? borderRadius;

  /// Creates a search filter button.
  const SearchFilterButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.iconColor,
    this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    this.badge,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final double height = getResponsiveSize(context, 32.0);
    final double padding = getResponsiveSize(context, 12.0);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: height,
        padding: EdgeInsets.symmetric(horizontal: padding),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.transparent,
          borderRadius: borderRadius ?? BorderRadius.circular(8.0),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: iconColor ?? textColor,
                size: getResponsiveSize(context, 16.0),
              ),
              const SizedBox(width: 6.0),
            ],
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: fontSmall(context),
                fontWeight: FontWeight.w600,
              ),
            ),
            if (badge != null) ...[const SizedBox(width: 6.0), badge!],
          ],
        ),
      ),
    );
  }
}
