import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../theme/theme.dart';

/// Floating action button to switch voice acting language
class CharacterLanguageFab extends StatelessWidget {
  /// Whether the FAB is currently visible
  final bool isVisible;

  /// Callback when the FAB is tapped
  final VoidCallback onTap;

  /// Creates a character language floating action button
  const CharacterLanguageFab({
    super.key,
    required this.isVisible,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double fabSize = getResponsiveSize(context, 52.0);
    final double iconSize = getResponsiveSize(context, 22.0);

    return AnimatedSize(
      duration: kAnimStandard,
      curve: kCurveSymmetric,
      child: AnimatedScale(
        scale: isVisible ? 1.0 : 0.0,
        duration: kAnimStandard,
        curve: kCurveSymmetric,
        child: AnimatedOpacity(
          opacity: isVisible ? 1.0 : 0.0,
          duration: kAnimFast,
          curve: kCurveSymmetric,
          child: isVisible
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Container(
                    width: fabSize,
                    height: fabSize,
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: cardBorderColor),
                    ),
                    child: GestureDetector(
                      onTap: onTap,
                      behavior: HitTestBehavior.opaque,
                      child: Center(
                        child: Icon(
                          LucideIcons.globe,
                          color: textPrimary,
                          size: iconSize,
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
