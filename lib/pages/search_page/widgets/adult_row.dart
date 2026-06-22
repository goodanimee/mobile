import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../theme/theme.dart';
import 'search_filter_button.dart';

/// A row widget containing the isAdult filter toggle button.
class AdultRow extends StatelessWidget {
  /// Horizontal padding for the row.
  final double padding;

  /// Whether adult content is included/excluded.
  final bool? isAdult;

  /// Callback when adult content filter selection changes.
  final ValueChanged<bool?> onAdultChanged;

  /// Creates an adult content filter row.
  const AdultRow({
    super.key,
    required this.padding,
    required this.isAdult,
    required this.onAdultChanged,
  });

  @override
  Widget build(BuildContext context) {
    final Color adultBg;
    final Color adultBorder;
    final String adultLabel;
    final IconData adultIcon = LucideIcons.shieldAlert;
    final Color adultIconColor;

    if (isAdult == null) {
      adultBg = Colors.transparent;
      adultBorder = cardBorderColor;
      adultIconColor = textSecondary;
      adultLabel = 'Adult';
    } else if (isAdult == true) {
      adultBg = paletteGreen.withValues(alpha: 0.15);
      adultBorder = paletteGreen;
      adultIconColor = paletteGreen;
      adultLabel = 'Adult';
    } else {
      adultBg = paletteRed.withValues(alpha: 0.15);
      adultBorder = paletteRed;
      adultIconColor = paletteRed;
      adultLabel = 'Adult';
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: SizedBox(
        width: double.infinity,
        child: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            SearchFilterButton(
              label: adultLabel,
              onTap: () {
                if (isAdult == null) {
                  onAdultChanged(true);
                } else if (isAdult == true) {
                  onAdultChanged(false);
                } else {
                  onAdultChanged(null);
                }
              },
              icon: adultIcon,
              iconColor: adultIconColor,
              backgroundColor: adultBg,
              borderColor: adultBorder,
              textColor: textPrimary,
            ),
          ],
        ),
      ),
    );
  }
}
