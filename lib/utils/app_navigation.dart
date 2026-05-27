import 'package:flutter/material.dart';

import '../models/media_character.dart';
import '../pages/media_page.dart';
import '../pages/media_page/widgets/character_sheet.dart';
import 'utils.dart';

/// Centralized manager for app transitions and navigation
class AppNavigation {
  /// Global state for the active tab on the HomePage
  static final ValueNotifier<int> currentTab = ValueNotifier<int>(0);

  /// Navigate to Media details
  static Future<void> toMedia(
    BuildContext context,
    int mediaId, {
    VoidCallback? onRefresh,
  }) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute<dynamic>(
        builder: (context) => MediaPage(mediaId: mediaId),
      ),
    );

    if (result == true ||
        CacheUtils.animeListNeedsRefresh.value ||
        CacheUtils.mangaListNeedsRefresh.value) {
      onRefresh?.call();
    }
  }

  /// Open character details sheet
  static void toCharacter(BuildContext context, CharacterEdge character) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CharacterSheet(character: character),
    );
  }
}
