import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/media_list_api.dart';
import '../proto/api.pb.dart';
import '../utils/app_navigation.dart';
import 'auth_service.dart';
import 'user_service.dart';

/// Service managing custom media lists, drawer open/close persistence,
/// and synchronization with AniList.
class CustomListService extends ChangeNotifier {
  /// SharedPreferences key for panel open state
  static const String keyPanelOpen = 'cached_custom_list_panel_open';

  /// SharedPreferences key for cached anime custom lists
  static const String keyAnimeCustomLists = 'cached_anime_custom_lists';

  /// SharedPreferences key for cached manga custom lists
  static const String keyMangaCustomLists = 'cached_manga_custom_lists';

  static final CustomListService _instance = CustomListService._();

  /// Singleton instance of [CustomListService].
  static CustomListService get instance => _instance;

  CustomListService._();

  bool _isPanelOpen = false;
  List<String> _animeCustomLists = [];
  List<String> _mangaCustomLists = [];
  bool _initialized = false;

  /// Whether the custom list management panel is expanded.
  bool get isPanelOpen => _isPanelOpen;

  /// Whether the service has loaded its initial state from cache.
  bool get isInitialized => _initialized;

  /// Initializes the service by loading cached preferences and lists.
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _isPanelOpen = prefs.getBool(keyPanelOpen) ?? false;
    _animeCustomLists = prefs.getStringList(keyAnimeCustomLists) ?? [];
    _mangaCustomLists = prefs.getStringList(keyMangaCustomLists) ?? [];
    _initialized = true;
    notifyListeners();

    await syncFromRemote();
  }

  /// Synchronizes custom lists from AniList viewer settings.
  Future<void> syncFromRemote({bool forceRefresh = true}) async {
    try {
      final token = await AuthService.getRawToken();
      if (token == null || token.isEmpty) return;

      final viewer = await UserService.getViewer(forceRefresh: forceRefresh);
      if (viewer == null) return;

      final prefs = await SharedPreferences.getInstance();
      _animeCustomLists = List.from(viewer.animeCustomLists);
      _mangaCustomLists = List.from(viewer.mangaCustomLists);
      await prefs.setStringList(keyAnimeCustomLists, _animeCustomLists);
      await prefs.setStringList(keyMangaCustomLists, _mangaCustomLists);
      notifyListeners();
    } catch (_) {}
  }

  /// Sets the custom lists for the given [mediaType] and persists them.
  Future<void> setCustomLists(String mediaType, List<String> lists) async {
    final isManga = mediaType.toUpperCase() == 'MANGA';
    final sanitized = lists
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toSet()
        .toList();

    if (isManga) {
      _mangaCustomLists = sanitized;
    } else {
      _animeCustomLists = sanitized;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      isManga ? keyMangaCustomLists : keyAnimeCustomLists,
      sanitized,
    );
    notifyListeners();
  }

  /// Sets whether the custom list management drawer is open and persists the state.
  Future<void> setPanelOpen(bool open) async {
    if (_isPanelOpen == open) return;
    _isPanelOpen = open;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyPanelOpen, open);
    notifyListeners();
  }

  /// Toggles the drawer open/closed state.
  Future<void> togglePanel() async {
    await setPanelOpen(!_isPanelOpen);
  }

  /// Returns the custom list names for the given [mediaType] ('ANIME' or 'MANGA').
  List<String> getCustomLists(String mediaType) {
    final isManga = mediaType.toUpperCase() == 'MANGA';
    return List.unmodifiable(isManga ? _mangaCustomLists : _animeCustomLists);
  }

  /// Adds a custom list for the specified [mediaType].
  Future<bool> addCustomList(String mediaType, String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return false;

    final isManga = mediaType.toUpperCase() == 'MANGA';
    final currentLists = isManga ? _mangaCustomLists : _animeCustomLists;

    final exists = currentLists.any(
      (item) => item.toLowerCase() == trimmed.toLowerCase(),
    );
    if (exists) return false;

    final previousLists = List<String>.from(currentLists);
    final updated = List<String>.from(currentLists)..add(trimmed);
    if (isManga) {
      _mangaCustomLists = updated;
    } else {
      _animeCustomLists = updated;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      isManga ? keyMangaCustomLists : keyAnimeCustomLists,
      updated,
    );
    notifyListeners();

    try {
      final token = await AuthService.getRawToken();
      if (token != null && token.isNotEmpty) {
        final req = UpdateCustomListsRequest(
          mediaType: isManga ? 'MANGA' : 'ANIME',
          customLists: updated,
        );
        await MediaListApi.updateCustomLists(req, token);
      }
      return true;
    } catch (_) {
      if (isManga) {
        _mangaCustomLists = previousLists;
      } else {
        _animeCustomLists = previousLists;
      }
      await prefs.setStringList(
        isManga ? keyMangaCustomLists : keyAnimeCustomLists,
        previousLists,
      );
      notifyListeners();
      AppNavigation.showSnackBar('Failed to sync custom list with AniList');
      return false;
    }
  }

  /// Deletes a custom list by [name] for the specified [mediaType].
  Future<bool> deleteCustomList(String mediaType, String name) async {
    final trimmed = name.trim();
    final isManga = mediaType.toUpperCase() == 'MANGA';
    final currentLists = isManga ? _mangaCustomLists : _animeCustomLists;

    final initialCount = currentLists.length;
    final updated = currentLists
        .where((item) => item.toLowerCase() != trimmed.toLowerCase())
        .toList();

    if (updated.length == initialCount) return false;

    final previousLists = List<String>.from(currentLists);
    if (isManga) {
      _mangaCustomLists = updated;
    } else {
      _animeCustomLists = updated;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      isManga ? keyMangaCustomLists : keyAnimeCustomLists,
      updated,
    );
    notifyListeners();

    try {
      final token = await AuthService.getRawToken();
      if (token != null && token.isNotEmpty) {
        final req = UpdateCustomListsRequest(
          mediaType: isManga ? 'MANGA' : 'ANIME',
          customLists: updated,
        );
        await MediaListApi.updateCustomLists(req, token);
      }
      return true;
    } catch (_) {
      if (isManga) {
        _mangaCustomLists = previousLists;
      } else {
        _animeCustomLists = previousLists;
      }
      await prefs.setStringList(
        isManga ? keyMangaCustomLists : keyAnimeCustomLists,
        previousLists,
      );
      notifyListeners();
      AppNavigation.showSnackBar('Failed to sync list deletion with AniList');
      return false;
    }
  }

  /// Resets state for logout or testing.
  void reset() {
    _isPanelOpen = false;
    _animeCustomLists = [];
    _mangaCustomLists = [];
    _initialized = false;
    notifyListeners();
  }
}
