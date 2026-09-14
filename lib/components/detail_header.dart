import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../theme/theme.dart';
import '../utils/utils.dart';
import 'lucide_icons_helper.dart';

/// Sticky app bar header for detail screens with title and optional favourite action
class DetailHeader extends StatelessWidget {
  /// Header title text
  final String title;

  /// Callback when back button is pressed
  final VoidCallback onBack;

  /// Whether the item is marked as favourite
  final bool isFavourite;

  /// Total number of favourites
  final int favouritesCount;

  /// Callback to toggle favourite status
  final VoidCallback onToggleFavourite;

  /// Whether the favourite operation is in progress
  final bool isFavouriteLoading;

  /// Whether to display the favourite action
  final bool showFavourite;

  /// Creates a detail header
  const DetailHeader({
    super.key,
    required this.title,
    required this.onBack,
    this.isFavourite = false,
    this.favouritesCount = 0,
    required this.onToggleFavourite,
    this.isFavouriteLoading = false,
    this.showFavourite = true,
  });

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Container(
      height: topPadding + 56,
      padding: EdgeInsets.only(top: topPadding),
      decoration: const BoxDecoration(
        color: bgColor,
        border: Border(bottom: BorderSide(color: cardBorderColor)),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 8,
            top: 0,
            bottom: 0,
            child: Center(
              child: IconButton(
                icon: const Icon(LucideIcons.arrowLeft, color: textPrimary),
                onPressed: onBack,
              ),
            ),
          ),
          Positioned.fill(
            left: 56,
            right: 120,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: fontTitle(context),
                  fontWeight: FontWeight.bold,
                  color: textPrimary,
                ),
              ),
            ),
          ),
          if (showFavourite)
            Positioned(
              right: 16,
              top: 0,
              bottom: 0,
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '(${StringUtils.formatCompactNumber(favouritesCount)})',
                      style: TextStyle(
                        color: textSecondary,
                        fontSize: fontBody(context),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: isFavouriteLoading ? null : onToggleFavourite,
                      child: isFavouriteLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: textPrimary,
                              ),
                            )
                          : LucideHeartIcon(
                              isFilled: isFavourite,
                              color: isFavourite
                                  ? Colors.redAccent.shade400
                                  : textPrimary,
                            ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
