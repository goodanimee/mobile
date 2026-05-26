import 'package:flutter/material.dart';
import '../components/media_options_sheet.dart';
import '../models/media_list.dart';

/// The result from the anime options sheet
class MediaOptionsResult {
  /// Whether the entry was deleted
  final bool deleted;

  /// The updated entry (null if deleted)
  final MediaListEntryWithMedia? entry;

  /// Creates a result
  const MediaOptionsResult({this.deleted = false, this.entry});
}

/// Shows the anime options bottom sheet
Future<MediaOptionsResult?> showMediaOptions(
  BuildContext context,
  MediaListEntryWithMedia entry,
) {
  return showModalBottomSheet<MediaOptionsResult>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        minChildSize: 0.3,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return MediaOptionsSheet(
            entry: entry,
            scrollController: scrollController,
          );
        },
      );
    },
  );
}
