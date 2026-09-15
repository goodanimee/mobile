import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../components/error_view.dart';
import '../../../../components/loading_indicator.dart';
import '../../../../components/relation_card.dart';
import '../../../../models/media_character.dart';
import '../../../../theme/theme.dart';
import '../../../../utils/app_navigation.dart';
import '../../../../utils/utils.dart';

/// A widget that displays the list of character search results.
class CharacterResultsList extends StatelessWidget {
  /// The list of character results to display.
  final List<Character> characterResults;

  /// Whether a search is currently in progress.
  final bool isSearching;

  /// Whether a paginated load more search is in progress.
  final bool isSearchingMore;

  /// Optional error message.
  final String? searchError;

  /// Callback to retry the search after an error.
  final VoidCallback onRetry;

  /// Creates a character search results list.
  const CharacterResultsList({
    super.key,
    required this.characterResults,
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
    if (characterResults.isEmpty) {
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
    for (final character in characterResults) {
      final name = character.name;
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

      cards.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: SizedBox(
            height: 110,
            child: RelationCard(
              imageUrl: character.image?.large ?? '',
              title: titleText,
              nativeTitle: character.name?.native,
              subtitle: '',
              trailing:
                  (character.favourites != null && character.favourites! > 0)
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
                          StringUtils.formatCompactNumber(
                            character.favourites!,
                          ),
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  : null,
              onTap: () => AppNavigation.toCharacter(
                context,
                character: character.toMin(),
                characterId: character.id,
              ),
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
