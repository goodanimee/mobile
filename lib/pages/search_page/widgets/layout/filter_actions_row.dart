import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../theme/theme.dart';

/// A widget that displays the filter actions row (Show/Hide, Reset, Apply).
class FilterActionsRow extends StatelessWidget {
  /// Horizontal padding for the row.
  final double padding;

  /// Whether all filters are currently shown.
  final bool showAllFilters;

  /// Whether there are active filters selected.
  final bool hasActiveFilters;

  /// Callback when the filters visibility toggles.
  final VoidCallback onToggleFilters;

  /// Callback when filters are reset.
  final VoidCallback onReset;

  /// Callback when filters are applied.
  final VoidCallback onApply;

  /// Creates a filter actions row.
  const FilterActionsRow({
    super.key,
    required this.padding,
    required this.showAllFilters,
    required this.hasActiveFilters,
    required this.onToggleFilters,
    required this.onReset,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Row(
        children: [
          TextButton(
            onPressed: onToggleFilters,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  showAllFilters ? 'Hide Filters' : 'Show Filters',
                  style: TextStyle(
                    color: textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: fontSmall(context),
                  ),
                ),
                const SizedBox(width: 4.0),
                Icon(
                  showAllFilters
                      ? LucideIcons.chevronUp
                      : LucideIcons.chevronDown,
                  color: textPrimary,
                  size: getResponsiveSize(context, 16.0),
                ),
              ],
            ),
          ),
          if (hasActiveFilters) ...[
            const SizedBox(width: 8.0),
            TextButton(
              onPressed: onReset,
              child: Text(
                'Reset',
                style: TextStyle(
                  color: paletteRed,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSmall(context),
                ),
              ),
            ),
          ],
          const Spacer(),
          InkWell(
            onTap: onApply,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: borderColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Apply',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
