import 'package:flutter/material.dart';
import '../../../../theme/theme.dart';

/// Selector for media type (Anime or Manga).
class MediaTypeSelector extends StatelessWidget {
  /// The currently selected media type value.
  final String selectedType;

  /// Callback when a media type is selected.
  final void Function(String value) onChanged;

  /// Creates a media type selector.
  const MediaTypeSelector({
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
