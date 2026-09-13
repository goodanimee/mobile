import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../theme/theme.dart';

/// Button widget that triggers the sort menu overlay in the search page.
class SearchSortButton extends StatelessWidget {
  /// Whether the sort menu dropdown is currently active.
  final bool isActive;

  /// The currently applied sort criterion.
  final String sortBy;

  /// Callback invoked when the sort button is tapped.
  final VoidCallback onPressed;

  /// Creates a search sort button.
  const SearchSortButton({
    super.key,
    required this.isActive,
    required this.sortBy,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        LucideIcons.sortDesc,
        color: isActive || sortBy != 'search_match' ? borderColor : textPrimary,
        size: getResponsiveSize(context, 24.0),
      ),
      onPressed: onPressed,
    );
  }
}
