import 'package:flutter/material.dart';

import '../../../components/error_view.dart';
import '../../../components/media_list_card.dart';
import '../../../components/section_title.dart';
import '../../../models/media_list.dart';
import '../../../utils/app_navigation.dart';
import '../../../utils/app_options.dart';

/// A list view component representing a list of media items in a linear format
class MediaListView extends StatelessWidget {
  /// The active name/title of the list section
  final String activeName;

  /// The list of media entries to display
  final List<MediaListEntryWithMedia> entries;

  /// The scroll controller for the list view
  final ScrollController scrollController;

  /// Callback to refresh the list
  final VoidCallback onRefresh;

  /// Callback when a list entry is updated
  final void Function(int mediaId, MediaOptionsResult result) onEntryUpdated;

  /// Callback when a card is long-pressed
  final void Function(BuildContext context, MediaListEntryWithMedia entry)
  onLongPress;

  /// The text to show when list is empty
  final String emptyLabel;

  /// Creates a media list view widget
  const MediaListView({
    super.key,
    required this.activeName,
    required this.entries,
    required this.scrollController,
    required this.onRefresh,
    required this.onEntryUpdated,
    required this.onLongPress,
    this.emptyLabel = 'No anime',
  });

  @override
  /// Builds the media list view widget
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return ListView(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 16, bottom: 100),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SectionTitle(title: activeName, bottomPadding: 0),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: AppErrorView(
              message: '$emptyLabel currently in $activeName',
              topPadding: 0,
            ),
          ),
        ],
      );
    }

    return ListView.builder(
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 16, bottom: 100),
      itemCount: entries.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SectionTitle(title: activeName, bottomPadding: 0),
          );
        }

        final entry = entries[index - 1];

        return MediaListCard(
          entry: entry,
          onEntryUpdated: onEntryUpdated,
          onTap: () {
            final mediaId = entry.media.id;
            if (mediaId != 0) {
              AppNavigation.toMedia(context, mediaId, onRefresh: onRefresh);
            }
          },
          onLongPress: () => onLongPress(context, entry),
        );
      },
    );
  }
}
