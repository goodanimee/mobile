import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../theme/theme.dart';

/// Sticky top bar for text search query entry.
class SearchTopBar extends StatelessWidget {
  /// Controller for the search input field.
  final TextEditingController controller;

  /// Focus node for the search input field.
  final FocusNode focusNode;

  /// Whether the search input currently has text.
  final bool hasSearchText;

  /// Callback to clear the search query.
  final VoidCallback onClear;

  /// Widget to display as the sort button/dropdown.
  final Widget sortButton;

  /// Creates a search top bar.
  const SearchTopBar({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.hasSearchText,
    required this.onClear,
    required this.sortButton,
  });

  @override
  Widget build(BuildContext context) {
    final double padding = getResponsiveSize(context, 16.0);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 8.0),
      decoration: const BoxDecoration(
        color: bgColor,
        border: Border(bottom: BorderSide(color: cardBorderColor)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: getResponsiveSize(context, 44.0),
              decoration: const BoxDecoration(color: Colors.transparent),
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Row(
                children: [
                  Icon(
                    LucideIcons.search,
                    color: textMuted,
                    size: getResponsiveSize(context, 18.0),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      focusNode: focusNode,
                      autofocus: true,
                      style: TextStyle(
                        color: textPrimary,
                        fontSize: fontBody(context),
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: TextStyle(
                          color: textHint,
                          fontSize: fontBody(context),
                        ),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                  if (hasSearchText)
                    GestureDetector(
                      onTap: onClear,
                      child: Icon(
                        LucideIcons.x,
                        color: textMuted,
                        size: getResponsiveSize(context, 18.0),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          sortButton,
        ],
      ),
    );
  }
}
