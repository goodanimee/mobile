import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/common.dart';
import '../models/media_list.dart';
import '../services/media_list_service.dart';
import '../services/user_service.dart';
import '../utils/app_options.dart';
import '../utils/utils.dart';

/// Controller managing state, caching, and invalidation for media lists.
class MediaListController extends ChangeNotifier {
  /// The media type handled by this controller (e.g., 'ANIME' or 'MANGA').
  final String mediaType;

  static final Map<String, MediaListController> _instances = {};

  /// Returns the controller instance for the given media type.
  static MediaListController forType(String mediaType) {
    final key = mediaType.toUpperCase();
    return _instances.putIfAbsent(key, () => MediaListController._(key));
  }

  /// Convenience getter for the anime list controller.
  static MediaListController get anime => forType('ANIME');

  /// Convenience getter for the manga list controller.
  static MediaListController get manga => forType('MANGA');

  /// Resets state for all cached controllers.
  static void resetAll() {
    for (final controller in _instances.values) {
      controller.reset();
    }
  }

  MediaListController._(this.mediaType);

  bool _isLoading = true;
  List<MediaList> _lists = [];
  String? _error;
  MediaListStatus? _activeStatus;
  bool _needsRefresh = false;
  bool _hasFetchedThisSession = false;

  /// Whether list data is currently loading.
  bool get isLoading => _isLoading;

  /// The loaded media lists.
  List<MediaList> get lists => _lists;

  /// Error message if list loading failed.
  String? get error => _error;

  /// The active status category filter.
  MediaListStatus? get activeStatus => _activeStatus;

  /// Whether the cached list data needs a refresh.
  bool get needsRefresh => _needsRefresh;

  /// Marks that the list data is stale and requires refreshing.
  void markNeedsRefresh() {
    _needsRefresh = true;
    notifyListeners();
  }

  /// Sets the active section status category.
  void setActiveStatus(MediaListStatus status) {
    if (_activeStatus == status) return;
    _activeStatus = status;
    notifyListeners();
  }

  /// Fetches media lists for the authenticated user.
  Future<void> fetchLists({bool forceRefresh = false}) async {
    try {
      final userId = await UserService.getUserId();
      if (userId == null) {
        if (_lists.isEmpty) {
          _error = 'Failed to get user ID';
          _isLoading = false;
          notifyListeners();
        }
        return;
      }

      if (!forceRefresh) {
        final cachedLists = await MediaListService.getLists(userId, mediaType);
        _updateLists(cachedLists);

        final prefs = await SharedPreferences.getInstance();
        final hasCache = prefs.containsKey(
          'cached_${mediaType.toLowerCase()}_lists',
        );
        if (hasCache) {
          if (_hasFetchedThisSession) return;
        } else {
          _hasFetchedThisSession = true;
          return;
        }
      }

      final freshLists = await MediaListService.getLists(
        userId,
        mediaType,
        forceRefresh: true,
      );
      _hasFetchedThisSession = true;
      _needsRefresh = false;
      _updateLists(freshLists);
    } catch (e) {
      if (_lists.isEmpty) {
        _error = e.toString();
        _isLoading = false;
        notifyListeners();
      }
      rethrow;
    }
  }

  void _updateLists(List<MediaList> newLists) {
    _lists = newLists;
    _isLoading = false;
    _error = null;

    if (_activeStatus == null && newLists.isNotEmpty) {
      final firstNonEmpty = newLists.firstWhere(
        (l) => l.entries.isNotEmpty,
        orElse: () => newLists.first,
      );
      _activeStatus = firstNonEmpty.status;
    }
    notifyListeners();
  }

  /// Updates an entry across lists and persists modifications.
  Future<void> updateEntry(int mediaId, MediaOptionsResult result) async {
    await CacheUtils.invalidateMedia(mediaId);
    final updatedLists = await MediaListService.updateEntryInLists(
      _lists,
      mediaId,
      result,
      mediaType,
    );
    _updateLists(updatedLists);
  }

  /// Resets controller state.
  void reset() {
    _isLoading = true;
    _lists = [];
    _error = null;
    _activeStatus = null;
    _needsRefresh = false;
    _hasFetchedThisSession = false;
    notifyListeners();
  }
}
