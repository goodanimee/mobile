import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../theme/theme.dart';

/// The selection dropdown panel for advanced format filters.
class FormatFilterPanel extends StatelessWidget {
  /// Current map of format states.
  final Map<String, bool?> formats;

  /// List of format keys that are allowed for this search type.
  final List<String> allowedFormats;

  /// Callback when a format chip state changes.
  final void Function(String key, bool? state) onChanged;

  /// Creates a format filter panel.
  const FormatFilterPanel({
    super.key,
    required this.formats,
    required this.allowedFormats,
    required this.onChanged,
  });

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

  @override
  Widget build(BuildContext context) {
    final List<String> formatKeys = allowedFormats;

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
          for (int i = 0; i < formatKeys.length; i++) ...[
            if (i > 0)
              const Divider(
                color: cardBorderColor,
                height: 1.0,
                thickness: 1.0,
              ),
            _buildOption(context, formatKeys[i]),
          ],
        ],
      ),
    );
  }

  Widget _buildOption(BuildContext context, String key) {
    final state = formats[key];
    final double paddingVal = getResponsiveSize(context, 12.0);

    final Color bg;
    final Color border;
    final Color iconColor;
    final Color textColor;
    final FontWeight fontWeight;
    final IconData? rightIcon;
    final Color rightIconColor;

    if (state == null) {
      bg = Colors.transparent;
      border = Colors.transparent;
      iconColor = textMuted;
      textColor = textMuted;
      fontWeight = FontWeight.normal;
      rightIcon = null;
      rightIconColor = Colors.transparent;
    } else if (state == true) {
      bg = paletteGreen.withValues(alpha: 0.1);
      border = paletteGreen.withValues(alpha: 0.3);
      iconColor = paletteGreen;
      textColor = textPrimary;
      fontWeight = FontWeight.bold;
      rightIcon = LucideIcons.circleCheck;
      rightIconColor = paletteGreen;
    } else {
      bg = paletteRed.withValues(alpha: 0.1);
      border = paletteRed.withValues(alpha: 0.3);
      iconColor = paletteRed;
      textColor = textPrimary;
      fontWeight = FontWeight.bold;
      rightIcon = LucideIcons.circleX;
      rightIconColor = paletteRed;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: () {
          final bool? nextState;
          if (state == null) {
            nextState = true;
          } else if (state == true) {
            nextState = false;
          } else {
            nextState = null;
          }
          onChanged(key, nextState);
        },
        borderRadius: BorderRadius.circular(6.0),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: paddingVal,
            vertical: getResponsiveSize(context, 10.0),
          ),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: border),
          ),
          child: Row(
            children: [
              Icon(
                _getFormatIcon(key),
                color: iconColor,
                size: getResponsiveSize(context, 18.0),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  key.replaceAll('_', ' '),
                  style: TextStyle(
                    color: textColor,
                    fontSize: fontBody(context),
                    fontWeight: fontWeight,
                  ),
                ),
              ),
              if (rightIcon != null)
                Icon(
                  rightIcon,
                  color: rightIconColor,
                  size: getResponsiveSize(context, 18.0),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The selection dropdown panel for advanced status filters.
class StatusFilterPanel extends StatelessWidget {
  /// Current selected status.
  final String? selectedStatus;

  /// Callback when a status option is tapped.
  final void Function(String? status) onChanged;

  /// Creates a status filter panel.
  const StatusFilterPanel({
    super.key,
    required this.selectedStatus,
    required this.onChanged,
  });

  IconData _getIcon(String key) {
    switch (key) {
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
        return LucideIcons.helpCircle;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> statusKeys = [
      'FINISHED',
      'RELEASING',
      'NOT_YET_RELEASED',
      'CANCELLED',
      'HIATUS',
    ];

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
          for (int i = 0; i < statusKeys.length; i++) ...[
            if (i > 0)
              const Divider(
                color: cardBorderColor,
                height: 1.0,
                thickness: 1.0,
              ),
            _buildOption(context, statusKeys[i]),
          ],
        ],
      ),
    );
  }

  Widget _buildOption(BuildContext context, String key) {
    final isSelected = selectedStatus == key;
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
                  key.replaceAll('_', ' '),
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
