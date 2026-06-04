import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/error_view.dart';
import '../components/loading_indicator.dart';
import '../models/common.dart';
import '../models/media_list.dart';
import '../services/media_list_service.dart';
import '../services/user_service.dart';
import '../theme/theme.dart';
import '../utils/app_options.dart';
import '../utils/utils.dart';
import 'media_list_tab/widgets/grid_view.dart';
import 'media_list_tab/widgets/list_view.dart';

/// Display user's manga lists
class MangaListTab extends StatefulWidget {
  /// Whether to display items in a grid
  final bool isGridMode;

  /// Callback for signing out
  final VoidCallback onSignOut;

  /// Callback when the list of categories changes
  final void Function(
    List<MediaListStatus> statuses,
    MediaListStatus activeStatus,
    void Function(MediaListStatus) scrollTo,
  )?
  onSectionsChanged;

  /// Creates a home tab
  const MangaListTab({
    super.key,
    this.isGridMode = false,
    required this.onSignOut,
    this.onSectionsChanged,
  });

  @override
  State<MangaListTab> createState() => _MangaListTabState();
}

/// State for MangaListTab
class _MangaListTabState extends State<MangaListTab> {
  bool _isLoading = true;
  List<MediaList> _lists = [];
  String? _error;
  final _scrollController = ScrollController();
  MediaListStatus? _activeStatus;

  bool _hasFetchedThisSession = false;

  @override
  void initState() {
    super.initState();
    _fetchLists();
    CacheUtils.mangaListNeedsRefresh.addListener(_onCacheInvalidated);
  }

  void _onCacheInvalidated() {
    if (CacheUtils.mangaListNeedsRefresh.value) {
      CacheUtils.mangaListNeedsRefresh.value = false;
      _fetchLists(forceRefresh: true);
    }
  }

  @override
  /// Disposes the scroll controller and removes cache listener
  void dispose() {
    _scrollController.dispose();
    CacheUtils.mangaListNeedsRefresh.removeListener(_onCacheInvalidated);
    super.dispose();
  }

  /// Notifies parent of the available list sections
  void _notifySections() {
    widget.onSectionsChanged?.call(
      _lists.map((l) => l.status ?? MediaListStatus.current).toList(),
      _activeStatus ?? MediaListStatus.current,
      _selectSection,
    );
  }

  /// Selects a section by status and scrolls to top
  void _selectSection(MediaListStatus status) {
    if (_activeStatus == status) return;
    setState(() => _activeStatus = status);
    _notifySections();
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }
  }

  Future<void> _fetchLists({bool forceRefresh = false}) async {
    try {
      final userId = await UserService.getUserId();
      if (userId == null) {
        if (mounted && _lists.isEmpty) {
          setState(() {
            _error = 'Failed to get user ID';
            _isLoading = false;
          });
        }
        return;
      }

      if (!forceRefresh) {
        final lists = await MediaListService.getLists(userId, 'MANGA');
        _updateUIWithLists(lists);

        final prefs = await SharedPreferences.getInstance();
        final hasCache = prefs.containsKey('cached_manga_lists');
        if (hasCache) {
          if (_hasFetchedThisSession) return;
        } else {
          _hasFetchedThisSession = true;
          return;
        }
      }

      final freshLists = await MediaListService.getLists(
        userId,
        'MANGA',
        forceRefresh: true,
      );
      _hasFetchedThisSession = true;
      _updateUIWithLists(freshLists);
    } catch (e) {
      if (mounted && _lists.isEmpty) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      } else if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to refresh lists: $e')));
      }
    }
  }

  void _updateUIWithLists(List<MediaList> newLists) {
    if (!mounted) return;

    setState(() {
      _lists = newLists;
      _isLoading = false;
      _error = null;

      if (_activeStatus == null) {
        final firstNonEmpty = newLists.firstWhere(
          (l) => l.entries.isNotEmpty,
          orElse: () => newLists.first,
        );
        _activeStatus = firstNonEmpty.status;
      }
    });
    _notifySections();
  }

  Future<void> _handleEntryUpdated(
    int mediaId,
    MediaOptionsResult result,
  ) async {
    await CacheUtils.invalidateMedia(mediaId);
    final updatedLists = await MediaListService.updateEntryInLists(
      _lists,
      mediaId,
      result,
      'MANGA',
    );
    _updateUIWithLists(updatedLists);
  }

  /// Shows the media options bottom sheet
  Future<void> _showItemOptions(
    BuildContext context,
    MediaListEntryWithMedia entry,
  ) async {
    final result = await showMediaOptions(context, entry);

    if (result != null && mounted) {
      final mediaId = entry.media.id;
      if (mediaId != 0) {
        await CacheUtils.invalidateMedia(mediaId);
        await _handleEntryUpdated(mediaId, result);
      }
    }
  }

  @override
  /// Builds the main home tab widget
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const AppLoadingIndicator();
    }

    if (_error != null) {
      return AppErrorView(
        message: _error!,
        onRetry: () => _fetchLists(forceRefresh: true),
      );
    }

    if (_lists.isEmpty) {
      return const AppErrorView(message: 'No manga lists found.');
    }

    final activeList = _lists.firstWhere(
      (l) => l.status == _activeStatus,
      orElse: () => _lists.first,
    );
    final activeName = activeList.name;
    final activeEntries = activeList.entries;

    return RefreshIndicator(
      color: borderColor,
      backgroundColor: hoverBgColor,
      onRefresh: () => _fetchLists(forceRefresh: true),
      child: widget.isGridMode
          ? MediaListGridView(
              activeName: activeName,
              entries: activeEntries,
              scrollController: _scrollController,
              onRefresh: () => _fetchLists(forceRefresh: true),
              onLongPress: _showItemOptions,
              emptyLabel: 'No manga',
            )
          : MediaListView(
              activeName: activeName,
              entries: activeEntries,
              scrollController: _scrollController,
              onRefresh: () => _fetchLists(forceRefresh: true),
              onEntryUpdated: _handleEntryUpdated,
              onLongPress: _showItemOptions,
              emptyLabel: 'No manga',
            ),
    );
  }
}
