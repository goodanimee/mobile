import 'package:flutter/material.dart';
import '../../../utils/app_navigation.dart';
import '../../../components/app_media_card.dart';
import '../../../components/app_badges.dart';
import '../../../components/section_title.dart';
import '../../../components/error_view.dart';
import '../../../models/media_list.dart';

class AnimeListGridView extends StatelessWidget {
  final String activeName;
  final List<MediaListEntryWithMedia> entries;
  final ScrollController scrollController;
  final VoidCallback onRefresh;
  final void Function(BuildContext context, MediaListEntryWithMedia entry)
  onLongPress;

  const AnimeListGridView({
    super.key,
    required this.activeName,
    required this.entries,
    required this.scrollController,
    required this.onRefresh,
    required this.onLongPress,
  });

  @override
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
                      AppNavigation.toAnime(
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
