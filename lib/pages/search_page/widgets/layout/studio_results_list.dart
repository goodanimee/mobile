import 'package:flutter/material.dart';
import '../../../../components/error_view.dart';
import '../../../../components/loading_indicator.dart';
import '../../../../components/lucide_icons_helper.dart';
import '../../../../models/media_studio.dart';
import '../../../../theme/theme.dart';
import '../../../../utils/app_navigation.dart';
import '../../../../utils/utils.dart';

/// A widget that displays the list of studio search results.
class StudioResultsList extends StatelessWidget {
  /// The list of studio results to display.
  final List<Studio> studioResults;

  /// Whether a search is currently in progress.
  final bool isSearching;

  /// Whether a paginated load more search is in progress.
  final bool isSearchingMore;

  /// Optional error message.
  final String? searchError;

  /// Callback to retry the search after an error.
  final VoidCallback onRetry;

  /// Creates a studio results list.
  const StudioResultsList({
    super.key,
    required this.studioResults,
    required this.isSearching,
    required this.isSearchingMore,
    required this.searchError,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final double paddingVal = getResponsiveSize(context, 16.0);
    if (isSearching) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40.0),
          child: AppLoadingIndicator(),
        ),
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
    if (studioResults.isEmpty) {
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

    final List<Widget> bars = [];
    for (final studio in studioResults) {
      final String formattedFavourites = StringUtils.formatCompactNumber(
        studio.favourites ?? 0,
      );

      bars.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: InkWell(
            onTap: () => AppNavigation.toStudio(context, studio.id),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.03),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      studio.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        formattedFavourites,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 6),
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Center(
                          child: ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: loveGradient,
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ).createShader(bounds),
                            child: const LucideHeartIcon(
                              isFilled: false,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    if (isSearchingMore) {
      bars.add(
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
        children: bars,
      ),
    );
  }
}
