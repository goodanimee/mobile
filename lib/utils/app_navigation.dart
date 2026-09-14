import 'package:flutter/material.dart';

import '../models/media_character.dart';
import '../models/media_staff.dart';
import '../pages/character_page.dart';
import '../pages/media_page.dart';
import '../pages/staff_page.dart';
import '../pages/studio_page.dart';
import '../services/media_list_controller.dart';

/// Centralized manager for app transitions and navigation
class AppNavigation {
  /// Global state for the active tab on the HomePage
  static final ValueNotifier<int> currentTab = ValueNotifier<int>(1);

  /// Notifier to track when new search filters are pending.
  static final ValueNotifier<int> pendingFiltersVersion = ValueNotifier<int>(0);

  /// Pending search type filter.
  static String? pendingSearchType;

  /// Pending genre filter.
  static String? pendingGenre;

  /// Pending tag ID filter.
  static int? pendingTagId;

  /// Pending tag name filter.
  static String? pendingTagName;

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
        MediaListController.anime.needsRefresh ||
        MediaListController.manga.needsRefresh) {
      onRefresh?.call();
    }
  }

  /// Navigate to Studio details
  static Future<void> toStudio(BuildContext context, int studioId) async {
    await Navigator.push(
      context,
      MaterialPageRoute<dynamic>(
        builder: (context) => StudioPage(studioId: studioId),
      ),
    );
  }

  /// Navigate to Staff details
  static Future<void> toStaff(BuildContext context, StaffMin staff) async {
    await Navigator.push(
      context,
      MaterialPageRoute<dynamic>(builder: (context) => StaffPage(staff: staff)),
    );
  }

  /// Navigate to Character details
  static Future<void> toCharacter(
    BuildContext context, {
    CharacterMin? character,
    int? characterId,
  }) async {
    final id = characterId ?? character?.id;
    if (id == null) return;
    await Navigator.push(
      context,
      PageRouteBuilder<void>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            CharacterPage(characterId: id, character: character),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position:
                  Tween<Offset>(
                    begin: const Offset(0.05, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ),
                  ),
              child: child,
            ),
          );
        },
      ),
    );
  }
}
