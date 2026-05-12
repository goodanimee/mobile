import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/theme.dart';

/// A badge indicating adult/18+ content with glassmorphism effect
class AppAdultBadge extends StatelessWidget {
  /// Creates an adult badge
  const AppAdultBadge({super.key});

  @override
  /// Builds the adult badge widget
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          decoration: BoxDecoration(
            color: adultBadge.withValues(alpha: 0.2),
            border: Border.all(color: adultBadge.withValues(alpha: 0.5)),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Text(
            'ADULT',
            style: TextStyle(
              color: textPrimary,
              fontSize: 10,
              fontWeight: FontWeight.w900,
              shadows: [
                Shadow(
                  offset: Offset(0, 1),
                  blurRadius: 2.0,
                  color: surfaceBackgroundDeep,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A heart icon indicating a favorite item
class AppFavouriteBadge extends StatelessWidget {
  /// Whether to show a circular background
  final bool hasBackground;

  /// The size of the heart icon
  final double size;

  /// Creates a favorite badge
  const AppFavouriteBadge({
    super.key,
    this.hasBackground = false,
    this.size = 14,
  });

  @override
  /// Builds the favorite badge widget
  Widget build(BuildContext context) {
    final icon = Icon(Icons.favorite_rounded, size: size, color: heartIcon);

    if (!hasBackground) return icon;

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        color: surfaceBackgroundDark,
        shape: BoxShape.circle,
      ),
      child: icon,
    );
  }
}
