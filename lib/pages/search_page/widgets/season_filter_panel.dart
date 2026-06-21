import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../theme/theme.dart';

/// The selection dropdown panel for advanced season filters.
class SeasonFilterPanel extends StatelessWidget {
  /// Current selected season.
  final String? selectedSeason;

  /// Callback when a season option is tapped.
  final void Function(String? season) onChanged;

  /// Creates a season filter panel.
  const SeasonFilterPanel({
    super.key,
    required this.selectedSeason,
    required this.onChanged,
  });

  IconData _getIcon(String key) {
    switch (key) {
      case 'WINTER':
        return LucideIcons.snowflake;
      case 'SPRING':
        return LucideIcons.sprout;
      case 'SUMMER':
        return LucideIcons.sun;
      case 'FALL':
        return LucideIcons.leaf;
      default:
        return LucideIcons.calendar;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> seasonKeys = ['WINTER', 'SPRING', 'SUMMER', 'FALL'];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF161616),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: cardBorderColor),
      ),
      padding: EdgeInsets.all(getResponsiveSize(context, 12.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < seasonKeys.length; i++) ...[
            if (i > 0)
              const Divider(
                color: cardBorderColor,
                height: 1.0,
                thickness: 1.0,
              ),
            _buildOption(context, seasonKeys[i]),
          ],
        ],
      ),
    );
  }

  /// Builds a single option item widget.
  Widget _buildOption(BuildContext context, String key) {
    final isSelected = selectedSeason == key;
    final double paddingVal = getResponsiveSize(context, 12.0);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: () {
          onChanged(isSelected ? null : key);
        },
        borderRadius: BorderRadius.circular(6.0),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: paddingVal,
            vertical: getResponsiveSize(context, 10.0),
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? borderColor.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(
              color: isSelected
                  ? borderColor.withValues(alpha: 0.3)
                  : Colors.transparent,
            ),
          ),
          child: Row(
            children: [
              Icon(
                _getIcon(key),
                color: isSelected ? borderColor : textMuted,
                size: getResponsiveSize(context, 18.0),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  key,
                  style: TextStyle(
                    color: isSelected ? textPrimary : textMuted,
                    fontSize: fontBody(context),
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
              if (isSelected)
                Icon(
                  LucideIcons.check,
                  color: borderColor,
                  size: getResponsiveSize(context, 18.0),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
