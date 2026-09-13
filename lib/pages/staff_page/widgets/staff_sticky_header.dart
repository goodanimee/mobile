import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../components/lucide_icons_helper.dart';
import '../../../theme/theme.dart';
import '../../../utils/utils.dart';

/// Sticky header for the staff details page with title and favourite action.
class StaffStickyHeader extends StatelessWidget {
  /// The full name of the staff member.
  final String staffName;

  /// Callback when the back button is pressed.
  final VoidCallback onBack;

  /// Whether the staff member is marked as favourite.
  final bool isFavourite;

  /// The total number of favourites.
  final int favouritesCount;

  /// Callback to toggle the favourite status.
  final VoidCallback onToggleFavourite;

  /// Whether the favourite operation is in progress.
  final bool isFavouriteLoading;

  /// Whether to display the favourite action.
  final bool showFavourite;

  /// Creates a staff sticky header.
  const StaffStickyHeader({
    super.key,
    required this.staffName,
    required this.onBack,
    required this.isFavourite,
    required this.favouritesCount,
    required this.onToggleFavourite,
    required this.isFavouriteLoading,
    required this.showFavourite,
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
                staffName,
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
