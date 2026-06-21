import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../theme/theme.dart';

/// The selection dropdown panel for advanced format filters.
class FormatFilterPanel extends StatelessWidget {
  /// Current map of format states.
  final Map<String, bool?> formats;

  /// Callback when a format chip state changes.
  final void Function(String key, bool? state) onChanged;

  /// Creates a format filter panel.
  const FormatFilterPanel({
    super.key,
    required this.formats,
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
    final List<String> formatKeys = [
      'TV',
      'MOVIE',
      'SPECIAL',
      'OVA',
      'ONA',
      'MUSIC',
      'MANGA',
      'NOVEL',
      'ONE_SHOT',
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

  /// Builds a single option item widget.
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
