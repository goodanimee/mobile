import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../theme/theme.dart';
import 'count_filter_panel.dart';
import 'duration_filter_panel.dart';
import 'filter_dropdown.dart';
import 'search_filter_button.dart';

/// A row widget containing the Episode/Chapter Count and Duration/Volume filters.
class CountDurationRow extends StatelessWidget {
  /// Horizontal padding for the row.
  final double padding;

  /// Active media type (ANIME or MANGA).
  final String mediaType;

  /// Currently selected minimum count limit.
  final int? countMin;

  /// Currently selected maximum count limit.
  final int? countMax;

  /// Currently selected minimum duration/volume limit.
  final int? durationMin;

  /// Currently selected maximum duration/volume limit.
  final int? durationMax;

  /// Whether the count dropdown is open.
  final bool isCountOpen;

  /// Whether the duration dropdown is open.
  final bool isDurationOpen;

  /// LayerLink for anchoring the count dropdown overlay.
  final LayerLink countLayerLink;

  /// LayerLink for anchoring the duration dropdown overlay.
  final LayerLink durationLayerLink;

  /// Callback to toggle count dropdown.
  final VoidCallback toggleCount;

  /// Callback to toggle duration dropdown.
  final VoidCallback toggleDuration;

  /// Callback when the count range selection changes.
  final void Function(int? min, int? max) onCountChanged;

  /// Callback when the duration range selection changes.
  final void Function(int? min, int? max) onDurationChanged;

  /// Creates a count and duration row.
  const CountDurationRow({
    super.key,
    required this.padding,
    required this.mediaType,
    required this.countMin,
    required this.countMax,
    required this.durationMin,
    required this.durationMax,
    required this.isCountOpen,
    required this.isDurationOpen,
    required this.countLayerLink,
    required this.durationLayerLink,
    required this.toggleCount,
    required this.toggleDuration,
    required this.onCountChanged,
    required this.onDurationChanged,
  });

  @override
  Widget build(BuildContext context) {
    final String countLabel;
    final Color countBorderColor;
    final Color countBgColor;
    final Color countTextColor;
    final IconData countIcon = mediaType == 'ANIME'
        ? LucideIcons.tvMinimalPlay
        : LucideIcons.bookOpen;
    final Color countIconColor = (countMin == null && countMax == null)
        ? textSecondary
        : borderColor;

    final String countDefaultLabel = mediaType == 'ANIME'
        ? 'Episodes'
        : 'Chapters';

    if (countMin == null && countMax == null) {
      countLabel = countDefaultLabel;
      countBorderColor = isCountOpen ? borderColor : cardBorderColor;
      countBgColor = Colors.transparent;
      countTextColor = textPrimary;
    } else {
      if (countMin == countMax) {
        countLabel = '$countMin';
      } else {
        countLabel = '$countMin - $countMax';
      }
      countBgColor = borderColor.withValues(alpha: 0.15);
      countBorderColor = borderColor;
      countTextColor = textPrimary;
    }

    final String durationDefaultLabel = mediaType == 'ANIME'
        ? 'Duration'
        : 'Volumes';
    final String durationLabel;
    final Color durationBorderColor;
    final Color durationBgColor;
    final Color durationTextColor;
    final IconData durationIcon = mediaType == 'ANIME'
        ? LucideIcons.clock
        : LucideIcons.bookCopy;
    final Color durationIconColor = (durationMin == null && durationMax == null)
        ? textSecondary
        : borderColor;

    if (durationMin == null && durationMax == null) {
      durationLabel = durationDefaultLabel;
      durationBorderColor = isDurationOpen ? borderColor : cardBorderColor;
      durationBgColor = Colors.transparent;
      durationTextColor = textPrimary;
    } else {
      if (durationMin == durationMax) {
        durationLabel = '$durationMin';
      } else {
        durationLabel = '$durationMin - $durationMax';
      }
      durationBgColor = borderColor.withValues(alpha: 0.15);
      durationBorderColor = borderColor;
      durationTextColor = textPrimary;
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: CompositedTransformTarget(
        link: countLayerLink,
        child: CompositedTransformTarget(
          link: durationLayerLink,
          child: SizedBox(
            width: double.infinity,
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                FilterDropdown(
                  layerLink: countLayerLink,
                  useAnchorAsTarget: false,
                  isOpen: isCountOpen,
                  onTapOutside: toggleCount,
                  anchor: SearchFilterButton(
                    label: countLabel,
                    onTap: toggleCount,
                    icon: countIcon,
                    iconColor: countIconColor,
                    backgroundColor: countBgColor,
                    borderColor: countBorderColor,
                    textColor: countTextColor,
                  ),
                  menu: CountFilterPanel(
                    selectedMin: countMin,
                    selectedMax: countMax,
                    mediaType: mediaType,
                    onChanged: (min, max) {
                      if (min == 0 && max == 500) {
                        onCountChanged(null, null);
                      } else {
                        onCountChanged(min, max);
                      }
                    },
                  ),
                ),
                FilterDropdown(
                  layerLink: durationLayerLink,
                  useAnchorAsTarget: false,
                  isOpen: isDurationOpen,
                  onTapOutside: toggleDuration,
                  anchor: SearchFilterButton(
                    label: durationLabel,
                    onTap: toggleDuration,
                    icon: durationIcon,
                    iconColor: durationIconColor,
                    backgroundColor: durationBgColor,
                    borderColor: durationBorderColor,
                    textColor: durationTextColor,
                  ),
                  menu: DurationFilterPanel(
                    selectedMin: durationMin,
                    selectedMax: durationMax,
                    mediaType: mediaType,
                    onChanged: (min, max) {
                      if (min == 0 && max == 200) {
                        onDurationChanged(null, null);
                      } else {
                        onDurationChanged(min, max);
                      }
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
}
