import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../theme/theme.dart';
import '../common/filter_dropdown.dart';
import '../common/search_filter_button.dart';
import '../panels/option_filter_panels.dart';
import '../panels/range_filter_panel.dart';

/// A row widget containing the Format, Status, onList, and Score filters.
class FormatStatusRow extends StatelessWidget {
  /// Horizontal padding for the row.
  final double padding;

  /// Active formats selection.
  final Map<String, bool?> formats;

  /// Selected media release status.
  final String? status;

  /// Personalized listing filter status.
  final bool? onList;

  /// Current minimum score range value.
  final double? scoreMin;

  /// Current maximum score range value.
  final double? scoreMax;

  /// Whether the Format dropdown is open.
  final bool isFormatOpen;

  /// Whether the Status dropdown is open.
  final bool isStatusOpen;

  /// Whether the Score dropdown is open.
  final bool isScoreOpen;

  /// LayerLink for anchoring the Format dropdown overlay.
  final LayerLink formatLayerLink;

  /// LayerLink for anchoring the Status dropdown overlay.
  final LayerLink statusLayerLink;

  /// LayerLink for anchoring the Score dropdown overlay.
  final LayerLink scoreLayerLink;

  /// Callback to toggle the Format dropdown visibility.
  final VoidCallback toggleFormat;

  /// Callback to toggle the Status dropdown visibility.
  final VoidCallback toggleStatus;

  /// Callback to toggle the Score dropdown visibility.
  final VoidCallback toggleScore;

  /// Callback when a format inclusion/exclusion state changes.
  final void Function(String key, bool? state) onFormatChanged;

  /// Callback when the status selection changes.
  final ValueChanged<String?> onStatusChanged;

  /// Callback when the onList filter state changes.
  final ValueChanged<bool?> onOnListChanged;

  /// Callback when the score range selection changes.
  final void Function(double? min, double? max) onScoreChanged;

  /// Creates a format and status row.
  const FormatStatusRow({
    super.key,
    required this.padding,
    required this.formats,
    required this.status,
    required this.onList,
    required this.scoreMin,
    required this.scoreMax,
    required this.isFormatOpen,
    required this.isStatusOpen,
    required this.isScoreOpen,
    required this.formatLayerLink,
    required this.statusLayerLink,
    required this.scoreLayerLink,
    required this.toggleFormat,
    required this.toggleStatus,
    required this.toggleScore,
    required this.onFormatChanged,
    required this.onStatusChanged,
    required this.onOnListChanged,
    required this.onScoreChanged,
  });

  @override
  Widget build(BuildContext context) {
    int trueCount = 0;
    int falseCount = 0;
    String? singleSelectedKey;
    bool? singleSelectedState;

    formats.forEach((key, value) {
      if (value != null) {
        if (value == true) {
          trueCount++;
        } else {
          falseCount++;
        }
        singleSelectedKey = key;
        singleSelectedState = value;
      }
    });

    final String formatLabel;
    final Color formatBorderColor;
    final Color formatBgColor;
    final IconData? formatIcon;
    final Color? formatIconColor;
    Widget? formatBadge;

    if (trueCount + falseCount == 0) {
      formatLabel = 'Format';
      formatBorderColor = cardBorderColor;
      formatBgColor = Colors.transparent;
      formatIcon = null;
      formatIconColor = Colors.transparent;
    } else if (trueCount + falseCount == 1) {
      formatLabel = singleSelectedKey!.replaceAll('_', ' ');
      formatIcon = _getFormatIcon(singleSelectedKey!);
      if (singleSelectedState == true) {
        formatBgColor = paletteGreen.withValues(alpha: 0.15);
        formatBorderColor = paletteGreen;
        formatIconColor = paletteGreen;
      } else {
        formatBgColor = paletteRed.withValues(alpha: 0.15);
        formatBorderColor = paletteRed;
        formatIconColor = paletteRed;
      }
    } else {
      formatLabel = 'Format';
      formatBorderColor = borderColor;
      formatBgColor = Colors.transparent;
      formatIcon = null;
      formatIconColor = Colors.transparent;
      formatBadge = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trueCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 5.0,
                vertical: 1.0,
              ),
              decoration: BoxDecoration(
                color: paletteGreen,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                '$trueCount',
                style: const TextStyle(
                  color: textPrimary,
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (trueCount > 0 && falseCount > 0) const SizedBox(width: 4.0),
          if (falseCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 5.0,
                vertical: 1.0,
              ),
              decoration: BoxDecoration(
                color: paletteRed,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                '$falseCount',
                style: const TextStyle(
                  color: textPrimary,
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      );
    }

    final String statusLabel;
    final Color statusBorderColor;
    final Color statusBgColor;
    final Color statusTextColor;
    final IconData? statusIcon;
    final Color? statusIconColor;

    if (status == null) {
      statusLabel = 'Status';
      statusBorderColor = isStatusOpen ? borderColor : cardBorderColor;
      statusBgColor = Colors.transparent;
      statusTextColor = textPrimary;
      statusIcon = null;
      statusIconColor = Colors.transparent;
    } else {
      statusLabel = status!.replaceAll('_', ' ');
      statusBgColor = borderColor.withValues(alpha: 0.15);
      statusBorderColor = borderColor;
      statusTextColor = textPrimary;
      statusIcon = _getStatusIcon(status!);
      statusIconColor = borderColor;
    }

    final String scoreLabel;
    final Color scoreBorderColor;
    final Color scoreBgColor;
    final Color scoreTextColor;
    final IconData scoreIcon = LucideIcons.star;
    final Color scoreIconColor = (scoreMin == null && scoreMax == null)
        ? textSecondary
        : borderColor;

    if (scoreMin == null && scoreMax == null) {
      scoreLabel = 'Score';
      scoreBorderColor = isScoreOpen ? borderColor : cardBorderColor;
      scoreBgColor = Colors.transparent;
      scoreTextColor = textPrimary;
    } else {
      final String minStr = scoreMin!.toStringAsFixed(1);
      final String maxStr = scoreMax!.toStringAsFixed(1);
      if (scoreMin == scoreMax) {
        scoreLabel = minStr;
      } else {
        scoreLabel = '$minStr - $maxStr';
      }
      scoreBgColor = borderColor.withValues(alpha: 0.15);
      scoreBorderColor = borderColor;
      scoreTextColor = textPrimary;
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: CompositedTransformTarget(
        link: formatLayerLink,
        child: CompositedTransformTarget(
          link: statusLayerLink,
          child: CompositedTransformTarget(
            link: scoreLayerLink,
            child: SizedBox(
              width: double.infinity,
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: [
                  FilterDropdown(
                    layerLink: formatLayerLink,
                    useAnchorAsTarget: false,
                    isOpen: isFormatOpen,
                    onTapOutside: toggleFormat,
                    anchor: SearchFilterButton(
                      label: formatLabel,
                      onTap: toggleFormat,
                      icon: formatIcon,
                      iconColor: formatIconColor,
                      backgroundColor: formatBgColor,
                      borderColor: isFormatOpen
                          ? borderColor
                          : formatBorderColor,
                      textColor: textPrimary,
                      badge: formatBadge,
                    ),
                    menu: FormatFilterPanel(
                      formats: formats,
                      onChanged: onFormatChanged,
                    ),
                  ),
                  FilterDropdown(
                    layerLink: statusLayerLink,
                    useAnchorAsTarget: false,
                    isOpen: isStatusOpen,
                    onTapOutside: toggleStatus,
                    anchor: SearchFilterButton(
                      label: statusLabel,
                      onTap: toggleStatus,
                      icon: statusIcon,
                      iconColor: statusIconColor,
                      backgroundColor: statusBgColor,
                      borderColor: statusBorderColor,
                      textColor: statusTextColor,
                    ),
                    menu: StatusFilterPanel(
                      selectedStatus: status,
                      onChanged: onStatusChanged,
                    ),
                  ),
                  _buildOnListButton(context),
                  FilterDropdown(
                    layerLink: scoreLayerLink,
                    useAnchorAsTarget: false,
                    isOpen: isScoreOpen,
                    onTapOutside: toggleScore,
                    anchor: SearchFilterButton(
                      label: scoreLabel,
                      onTap: toggleScore,
                      icon: scoreIcon,
                      iconColor: scoreIconColor,
                      backgroundColor: scoreBgColor,
                      borderColor: scoreBorderColor,
                      textColor: scoreTextColor,
                    ),
                    menu: RangeFilterPanel(
                      title: 'Score Range',
                      minLabel: 'Min Score',
                      maxLabel: 'Max Score',
                      minLimit: 0.0,
                      maxLimit: 10.0,
                      selectedMin: scoreMin,
                      selectedMax: scoreMax,
                      divisions: 100,
                      isDecimal: true,
                      onChanged: onScoreChanged,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOnListButton(BuildContext context) {
    final Color bg;
    final Color border;
    final IconData? icon;
    final Color iconColor;

    if (onList == null) {
      bg = Colors.transparent;
      border = cardBorderColor;
      icon = null;
      iconColor = Colors.transparent;
    } else if (onList == true) {
      bg = paletteGreen.withValues(alpha: 0.15);
      border = paletteGreen;
      icon = LucideIcons.circleCheck;
      iconColor = paletteGreen;
    } else {
      bg = paletteRed.withValues(alpha: 0.15);
      border = paletteRed;
      icon = LucideIcons.circleX;
      iconColor = paletteRed;
    }

    return SearchFilterButton(
      label: 'On my lists',
      onTap: () {
        if (onList == null) {
          onOnListChanged(true);
        } else if (onList == true) {
          onOnListChanged(false);
        } else {
          onOnListChanged(null);
        }
      },
      icon: icon,
      iconColor: iconColor,
      backgroundColor: bg,
      borderColor: border,
      textColor: textPrimary,
    );
  }

  IconData _getFormatIcon(String format) {
    switch (format.toUpperCase()) {
      case 'TV':
      case 'TV_SHORT':
        return LucideIcons.monitor;
      case 'MOVIE':
        return LucideIcons.clapperboard;
      case 'SPECIAL':
        return LucideIcons.ticket;
      case 'OVA':
        return LucideIcons.disc;
      case 'ONA':
        return LucideIcons.globe;
      case 'MUSIC':
        return LucideIcons.music;
      case 'MANGA':
        return LucideIcons.bookImage;
      case 'NOVEL':
        return LucideIcons.book;
      case 'ONE_SHOT':
        return LucideIcons.fileText;
      default:
        return LucideIcons.monitor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toUpperCase()) {
      case 'FINISHED':
        return LucideIcons.badgeCheck;
      case 'RELEASING':
        return LucideIcons.activity;
      case 'NOT_YET_RELEASED':
        return LucideIcons.calendar;
      case 'CANCELLED':
        return LucideIcons.badgeX;
      case 'HIATUS':
        return LucideIcons.circlePause;
      default:
        return LucideIcons.badgeCheck;
    }
  }
}
