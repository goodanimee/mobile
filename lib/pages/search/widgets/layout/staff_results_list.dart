import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../components/error_view.dart';
import '../../../../components/loading_indicator.dart';
import '../../../../components/relation_card.dart';
import '../../../../components/skeleton.dart';
import '../../../../models/media_staff.dart';
import '../../../../theme/theme.dart';
import '../../../../utils/app_navigation.dart';
import '../../../../utils/utils.dart';

/// A widget that displays the list of staff search results.
class StaffResultsList extends StatelessWidget {
  /// The list of staff results to display.
  final List<Staff> staffResults;

  /// Whether a search is currently in progress.
  final bool isSearching;

  /// Whether a paginated load more search is in progress.
  final bool isSearchingMore;

  /// Optional error message.
  final String? searchError;

  /// Callback to retry the search after an error.
  final VoidCallback onRetry;

  /// Creates a staff search results list.
  const StaffResultsList({
    super.key,
    required this.staffResults,
    required this.isSearching,
    required this.isSearchingMore,
    required this.searchError,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final double paddingVal = getResponsiveSize(context, 16.0);
    if (isSearching) {
      return Skeleton.list(
        padding: EdgeInsets.symmetric(horizontal: paddingVal),
      );
    }
    if (searchError != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: AppErrorView(message: searchError!, onRetry: onRetry),
        ),
      );
    }
    if (staffResults.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Text(
            'No results found',
            style: TextStyle(color: textMuted, fontSize: fontBody(context)),
          ),
        ),
      );
    }

    final List<Widget> cards = [];
    for (final staff in staffResults) {
      final name = staff.name;
      final String titleText;
      if (name != null) {
        final preferred = name.userPreferred;
        if (preferred != null && preferred.isNotEmpty) {
          titleText = preferred;
        } else if (name.full.isNotEmpty) {
          titleText = name.full;
        } else {
          titleText = 'Unknown';
        }
      } else {
        titleText = 'Unknown';
      }

      final primaryOccupations = staff.primaryOccupations.isNotEmpty
          ? staff.primaryOccupations.join(', ')
          : null;

      cards.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: SizedBox(
            height: 110,
            child: RelationCard(
              imageUrl: staff.image?.large ?? '',
              title: titleText,
              nativeTitle: staff.name?.native,
              format: primaryOccupations,
              subtitle: '',
              trailing: (staff.favourites != null && staff.favourites! > 0)
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          LucideIcons.heart,
                          color: paletteRed,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          StringUtils.formatCompactNumber(staff.favourites!),
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  : null,
              onTap: () => AppNavigation.toStaff(context, staff.toMin()),
            ),
          ),
        ),
      );
    }

    if (isSearchingMore) {
      cards.add(
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: AppLoadingIndicator(),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingVal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: cards,
      ),
    );
  }
}
