import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../theme/theme.dart';
import '../common/filter_dropdown.dart';
import '../common/search_filter_button.dart';
import '../panels/option_filter_panels.dart';
import '../panels/range_filter_panel.dart';

/// A row widget containing the Season and Year filters.
class SeasonYearRow extends StatelessWidget {
  /// Horizontal padding for the row.
  final double padding;

  /// Currently selected season.
  final String? season;

  /// Currently selected minimum year.
  final int? startYearMin;

  /// Currently selected maximum year.
  final int? startYearMax;

  /// Whether the season dropdown is open.
  final bool isSeasonOpen;

  /// Whether the year dropdown is open.
  final bool isYearOpen;

  /// LayerLink for anchoring the season dropdown overlay.
  final LayerLink seasonLayerLink;

  /// LayerLink for anchoring the year dropdown overlay.
  final LayerLink yearLayerLink;

  /// Callback to toggle season dropdown.
  final VoidCallback toggleSeason;

  /// Callback to toggle year dropdown.
  final VoidCallback toggleYear;

  /// Callback when the season selection changes.
  final ValueChanged<String?> onSeasonChanged;

  /// Callback when the year range selection changes.
  final void Function(int? min, int? max) onYearChanged;

  /// Creates a season and year row.
  const SeasonYearRow({
    super.key,
    required this.padding,
    required this.season,
    required this.startYearMin,
    required this.startYearMax,
    required this.isSeasonOpen,
    required this.isYearOpen,
    required this.seasonLayerLink,
    required this.yearLayerLink,
    required this.toggleSeason,
    required this.toggleYear,
    required this.onSeasonChanged,
    required this.onYearChanged,
  });

  @override
  Widget build(BuildContext context) {
    final String seasonLabel;
    final Color seasonBorderColor;
    final Color seasonBgColor;
    final Color seasonTextColor;
    final IconData? seasonIcon;
    final Color? seasonIconColor;

    if (season == null) {
      seasonLabel = 'Season';
      seasonBorderColor = isSeasonOpen ? borderColor : cardBorderColor;
      seasonBgColor = Colors.transparent;
      seasonTextColor = textPrimary;
      seasonIcon = null;
      seasonIconColor = Colors.transparent;
    } else {
      seasonLabel = season!;
      seasonBgColor = borderColor.withValues(alpha: 0.15);
      seasonBorderColor = borderColor;
      seasonTextColor = textPrimary;
      seasonIcon = _getSeasonIcon(season!);
      seasonIconColor = borderColor;
    }

    final String yearLabel;
    final Color yearBorderColor;
    final Color yearBgColor;
    final Color yearTextColor;
    final IconData yearIcon = LucideIcons.calendarDays;
    final Color yearIconColor = (startYearMin == null && startYearMax == null)
        ? textSecondary
        : borderColor;

    if (startYearMin == null && startYearMax == null) {
      yearLabel = 'Year';
      yearBorderColor = isYearOpen ? borderColor : cardBorderColor;
      yearBgColor = Colors.transparent;
      yearTextColor = textPrimary;
    } else {
      if (startYearMin == startYearMax) {
        yearLabel = '$startYearMin';
      } else {
        yearLabel = '$startYearMin - $startYearMax';
      }
      yearBgColor = borderColor.withValues(alpha: 0.15);
      yearBorderColor = borderColor;
      yearTextColor = textPrimary;
    }

    final int currentYearLimit = DateTime.now().year + 1;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: CompositedTransformTarget(
        link: seasonLayerLink,
        child: CompositedTransformTarget(
          link: yearLayerLink,
          child: SizedBox(
            width: double.infinity,
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                FilterDropdown(
                  layerLink: seasonLayerLink,
                  useAnchorAsTarget: false,
                  isOpen: isSeasonOpen,
                  onTapOutside: toggleSeason,
                  anchor: SearchFilterButton(
                    label: seasonLabel,
                    onTap: toggleSeason,
                    icon: seasonIcon,
                    iconColor: seasonIconColor,
                    backgroundColor: seasonBgColor,
                    borderColor: seasonBorderColor,
                    textColor: seasonTextColor,
                  ),
                  menu: SeasonFilterPanel(
                    selectedSeason: season,
                    onChanged: onSeasonChanged,
                  ),
                ),
                FilterDropdown(
                  layerLink: yearLayerLink,
                  useAnchorAsTarget: false,
                  isOpen: isYearOpen,
                  onTapOutside: toggleYear,
                  anchor: SearchFilterButton(
                    label: yearLabel,
                    onTap: toggleYear,
                    icon: yearIcon,
                    iconColor: yearIconColor,
                    backgroundColor: yearBgColor,
                    borderColor: yearBorderColor,
                    textColor: yearTextColor,
                  ),
                  menu: RangeFilterPanel(
                    title: 'Year Range',
                    minLabel: 'Min Year',
                    maxLabel: 'Max Year',
                    minLimit: 1917.0,
                    maxLimit: currentYearLimit.toDouble(),
                    selectedMin: startYearMin?.toDouble(),
                    selectedMax: startYearMax?.toDouble(),
                    divisions: currentYearLimit - 1917,
                    isDecimal: false,
                    onChanged: (min, max) {
                      onYearChanged(min?.round(), max?.round());
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getSeasonIcon(String season) {
    switch (season.toUpperCase()) {
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
}
