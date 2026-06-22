import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../components/app_relation_card.dart';
import '../../../../components/error_view.dart';
import '../../../../components/loading_indicator.dart';
import '../../../../models/media_min.dart';
import '../../../../theme/theme.dart';
import '../../../../utils/app_navigation.dart';
import '../../../../utils/utils.dart';

/// A widget that displays the list of media search results.
class SearchResultsList extends StatelessWidget {
  /// The list of media results to display.
  final List<MediaMin> mediaResults;

  /// Whether a search is currently in progress.
  final bool isSearching;

  /// Whether a paginated load more search is in progress.
  final bool isSearchingMore;

  /// Optional error message.
  final String? searchError;

  /// Callback to retry the search after an error.
  final VoidCallback onRetry;

  /// Creates a search results list.
  const SearchResultsList({
    super.key,
    required this.mediaResults,
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
    if (mediaResults.isEmpty) {
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
    for (final media in mediaResults) {
      final titleText = media.title.userPreferred.isNotEmpty
          ? media.title.userPreferred
          : media.title.romaji.isNotEmpty
          ? media.title.romaji
          : media.title.english.isNotEmpty
          ? media.title.english
          : 'Unknown';

      var subtitle = media.format.replaceAll('_', ' ');
      if (media.type == 'ANIME') {
        if (media.episodes > 0) {
          subtitle +=
              ' \u00B7 ${media.episodes} ${StringUtils.pluralize(media.episodes, "Episode", "Episodes")}';
        }
      } else if (media.type == 'MANGA') {
        if (media.chapters > 0) {
          subtitle +=
              ' \u00B7 ${media.chapters} ${StringUtils.pluralize(media.chapters, "Chapter", "Chapters")}';
        }
      }

      final colorHex = media.coverImage.color;
      final color = ColorUtils.fromHex(colorHex, fallback: Colors.transparent);

      cards.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: SizedBox(
            height: 110,
            child: AppRelationCard(
              imageUrl: media.coverImage.large,
              title: titleText,
              nativeTitle: media.title.native,
              subtitle: subtitle,
              color: color != Colors.transparent ? color : null,
              trailing: media.averageScore > 0
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          LucideIcons.star,
                          color: Colors.amber,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          (media.averageScore / 10).toStringAsFixed(1),
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  : null,
              onTap: () => AppNavigation.toMedia(context, media.id),
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
