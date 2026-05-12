import 'package:flutter/material.dart';
import '../components/anime_options_sheet.dart';

/// Shows the anime options bottom sheet
Future<Map<String, dynamic>?> showAnimeOptions(
  BuildContext context,
  Map<String, dynamic> entry,
) {
  return showModalBottomSheet<Map<String, dynamic>>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.3,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return AnimeOptionsSheet(
            entry: entry,
            scrollController: scrollController,
          );
        },
      );
    },
  );
}
