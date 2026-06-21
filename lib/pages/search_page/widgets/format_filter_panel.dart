import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../theme/theme.dart';
import 'search_filter_button.dart';

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
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: formatKeys.map((key) {
          final state = formats[key];
          final Color bg;
          final Color border;
          final IconData? icon;
          final Color iconColor;

          if (state == null) {
            bg = bgColor;
            border = cardBorderColor;
            icon = null;
            iconColor = Colors.transparent;
          } else if (state == true) {
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
            label: key.replaceAll('_', ' '),
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
            icon: icon,
            iconColor: iconColor,
            backgroundColor: bg,
            borderColor: border,
            textColor: textPrimary,
          );
        }).toList(),
      ),
    );
  }
}
