import 'package:flutter/material.dart';

import '../../../components/app_badges.dart';
import '../../../components/app_media_card.dart';
import '../../../components/error_view.dart';
import '../../../components/section_title.dart';
import '../../../models/media_list.dart';
import '../../../utils/app_navigation.dart';

/// A grid view component representing a list of anime items
class AnimeListGridView extends StatelessWidget {
  /// The active name/title of the list section
  final String activeName;

  /// The list of media entries to display
  final List<MediaListEntryWithMedia> entries;

  /// The scroll controller for the custom scroll view
  final ScrollController scrollController;

  /// Callback to refresh the list
  final VoidCallback onRefresh;

  /// Callback when a card is long-pressed
  final void Function(BuildContext context, MediaListEntryWithMedia entry)
  onLongPress;

  /// Creates an anime list grid view widget
  const AnimeListGridView({
    super.key,
    required this.activeName,
    required this.entries,
    required this.scrollController,
    required this.onRefresh,
    required this.onLongPress,
  });

  @override
  /// Builds the anime list grid view widget
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
            child: SectionTitle(title: activeName),
          ),
        ),
        if (entries.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: AppErrorView(
              message: 'No anime currently in $activeName',
              topPadding: 0,
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 100),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.7,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                final entry = entries[index];
                final media = entry.media;

                return AppMediaCard(
                  imageUrl: media.coverImage.large,
                  title: media.title.userPreferred,
                  colorStr: media.coverImage.color,
                  isAdult: media.isAdult,
                  isFavourite: media.isFavourite,
                  favouriteBadge: const AppFavouriteBadge(hasBackground: true),
                  adultBadge: const AppAdultBadge(),
                  onTap: () {
                    final mediaId = media.id;
                    if (mediaId != 0) {
                      AppNavigation.toMedia(
                        context,
                        mediaId,
                        onRefresh: onRefresh,
                      );
                    }
                  },
                  onLongPress: () => onLongPress(context, entry),
                );
              }, childCount: entries.length),
            ),
          ),
      ],
    );
  }
}
