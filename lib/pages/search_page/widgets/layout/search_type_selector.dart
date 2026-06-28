import 'package:flutter/material.dart';
import '../../../../theme/theme.dart';

/// Selector for search type (Anime, Manga, etc.).
class SearchTypeSelector extends StatelessWidget {
  /// The currently selected search type value.
  final String selectedType;

  /// Callback when a search type is selected.
  final void Function(String value) onChanged;

  /// Creates a search type selector.
  const SearchTypeSelector({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildTypeChip(context, 'Anime', 'ANIME'),
        const SizedBox(width: 8.0),
        _buildTypeChip(context, 'Manga', 'MANGA'),
        const SizedBox(width: 8.0),
        _buildTypeChip(context, 'Studio', 'STUDIO'),
      ],
    );
  }

  Widget _buildTypeChip(BuildContext context, String label, String value) {
    final isSelected = selectedType == value;
    final double height = getResponsiveSize(context, 32.0);
    final double padding = getResponsiveSize(context, 16.0);

    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          onChanged(value);
        }
      },
      child: Container(
        height: height,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: padding),
        decoration: BoxDecoration(
          color: isSelected
              ? borderColor.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: isSelected ? borderColor : cardBorderColor),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? textPrimary : textMuted,
            fontSize: fontSmall(context),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
