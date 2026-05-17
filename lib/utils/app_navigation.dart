import 'package:flutter/material.dart';
import '../pages/anime_page.dart';
import '../pages/anime_page/widgets/character_sheet.dart';
import '../models/media.dart';
import 'utils.dart';

/// Centralized manager for app transitions and navigation
class AppNavigation {
  /// Global state for the active tab on the HomePage
  static final ValueNotifier<int> currentTab = ValueNotifier<int>(0);

  /// Navigate to Anime details
  static Future<void> toAnime(
    BuildContext context,
    int mediaId, {
    VoidCallback? onRefresh,
  }) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AnimePage(mediaId: mediaId)),
    );

    if (result == true || CacheUtils.animeListNeedsRefresh.value) {
      onRefresh?.call();
    }
  }

  /// Open character details sheet
  static void toCharacter(BuildContext context, CharacterEdge character) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CharacterSheet(character: character),
    );
  }
}
