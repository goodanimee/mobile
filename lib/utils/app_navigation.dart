import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/media_character.dart';
import '../models/media_staff.dart';
import '../pages/characters/page.dart';
import '../pages/media/page.dart';
import '../pages/staff/page.dart';
import '../pages/studio/page.dart';
import '../services/media_list_controller.dart';
import '../theme/theme.dart';
import 'anilist_url_parser.dart';

/// Centralized manager for app transitions and navigation
class AppNavigation {
  /// Global navigator key for root-level route dispatch
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// Global scaffold messenger key for displaying snackbars
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

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

  static Route<T> _buildPageRoute<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.05, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(parent: animation, curve: kCurveEnter)),
            child: child,
          ),
        );
      },
    );
  }

  /// Displays a snackbar message using the global scaffold messenger
  static void showSnackBar(String message) {
    final messenger = scaffoldMessengerKey.currentState;
    if (messenger == null) return;
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  /// Navigates to the native page corresponding to [target]
  static Future<void> openAnilistTarget(
    AnilistRouteTarget target, {
    BuildContext? context,
  }) async {
    final navContext = context ?? navigatorKey.currentContext;
    if (navContext == null) return;

    switch (target.type) {
      case AnilistEntityType.anime:
      case AnilistEntityType.manga:
        await toMedia(navContext, target.id);
      case AnilistEntityType.character:
        await toCharacter(navContext, characterId: target.id);
      case AnilistEntityType.staff:
        await toStaff(navContext, StaffMin(id: target.id));
      case AnilistEntityType.studio:
        await toStudio(navContext, target.id);
    }
  }

  /// Intercepts AniList entity links for internal routing or launches external URLs
  static Future<void> handleLinkTap(BuildContext context, String rawUrl) async {
    final target = AnilistUrlParser.parse(rawUrl, allowRelative: true);
    if (target != null) {
      await openAnilistTarget(target, context: context);
      return;
    }

    if (AnilistUrlParser.isAnilistEntityPath(rawUrl, allowRelative: true)) {
      showSnackBar('Invalid AniList link.');
      return;
    }

    final uri = Uri.tryParse(rawUrl.trim());
    if (uri != null && (uri.hasScheme || uri.host.isNotEmpty)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  /// Handles bottom navigation tap by updating tab index and popping to root
  static void handleNavTap(BuildContext context, int index) {
    currentTab.value = index;
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  /// Navigate to Media details
  static Future<void> toMedia(
    BuildContext context,
    int mediaId, {
    VoidCallback? onRefresh,
  }) async {
    final result = await Navigator.push<dynamic>(
      context,
      _buildPageRoute(MediaPage(mediaId: mediaId)),
    );

    if (result == true ||
        MediaListController.anime.needsRefresh ||
        MediaListController.manga.needsRefresh) {
      onRefresh?.call();
    }
  }

  /// Navigate to Studio details
  static Future<void> toStudio(BuildContext context, int studioId) async {
    await Navigator.push<dynamic>(
      context,
      _buildPageRoute(StudioPage(studioId: studioId)),
    );
  }

  /// Navigate to Staff details
  static Future<void> toStaff(BuildContext context, StaffMin staff) async {
    await Navigator.push<dynamic>(
      context,
      _buildPageRoute(StaffPage(staff: staff)),
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
    await Navigator.push<void>(
      context,
      _buildPageRoute(CharacterPage(characterId: id, character: character)),
    );
  }
}
