import 'package:flutter/material.dart';
import '../services/anime_list_repo.dart';
import '../theme/theme.dart';
import '../components/loading_indicator.dart';
import '../components/error_view.dart';
import '../utils/utils.dart';
import '../utils/app_options.dart';
import '../models/media_list.dart';

import 'anime_list_tab/widgets/grid_view.dart';
import 'anime_list_tab/widgets/list_view.dart';

/// Display user's anime lists
class AnimeListTab extends StatefulWidget {
  /// Whether to display items in a grid
  final bool isGridMode;

  /// Callback for signing out
  final VoidCallback onSignOut;

  /// Callback when the list of categories changes
  final void Function(
    List<String> statuses,
    String activeStatus,
    void Function(String) scrollTo,
  )?
  onSectionsChanged;

  /// Creates a home tab
  const AnimeListTab({
    super.key,
    this.isGridMode = false,
    required this.onSignOut,
    this.onSectionsChanged,
  });

  @override
  State<AnimeListTab> createState() => _AnimeListTabState();
}

/// State for AnimeListTab
class _AnimeListTabState extends State<AnimeListTab> {
  bool _isLoading = true;
  List<dynamic> _lists = [];
  String? _error;
  final _scrollController = ScrollController();
  String? _activeStatus;

  static bool _hasFetchedThisSession = false;

  @override
  void initState() {
    super.initState();
    _fetchLists();
    CacheUtils.animeListNeedsRefresh.addListener(_onCacheInvalidated);
  }

  void _onCacheInvalidated() {
    if (CacheUtils.animeListNeedsRefresh.value) {
      CacheUtils.animeListNeedsRefresh.value = false;
      _fetchLists(forceRefresh: true);
    }
  }

  @override
  /// Disposes the scroll controller and removes cache listener
  void dispose() {
    _scrollController.dispose();
    CacheUtils.animeListNeedsRefresh.removeListener(_onCacheInvalidated);
    super.dispose();
  }

  /// Notifies parent of the available list sections
  void _notifySections() {
    widget.onSectionsChanged?.call(
      _lists.map((l) => l['name'] as String).toList(),
      _activeStatus ?? '',
      _selectSection,
    );
  }

  /// Selects a section by name and scrolls to top
  void _selectSection(String name) {
    if (_activeStatus == name) return;
    setState(() => _activeStatus = name);
    _notifySections();
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }
  }

  Future<void> _fetchLists({bool forceRefresh = false}) async {
    if (!forceRefresh) {
      final cachedLists = await AnimeListRepo.getCachedLists();
      if (cachedLists != null) {
        _updateUIWithLists(cachedLists);
        if (_hasFetchedThisSession) return;
      }
    }

    try {
      final userId = await AnimeListRepo.getUserId();
      if (userId == null) {
        if (mounted && _lists.isEmpty) {
          setState(() {
            _error = 'Failed to get user ID';
            _isLoading = false;
          });
        }
        return;
      }

      final freshLists = await AnimeListRepo.fetchNetworkLists(userId);
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

  void _updateUIWithLists(List<dynamic> newLists) {
    if (!mounted) return;

    setState(() {
      _lists = newLists;
      _isLoading = false;
      _error = null;

      if (_activeStatus == null) {
        final firstNonEmpty = newLists.firstWhere(
          (l) => (l['entries'] as List).isNotEmpty,
          orElse: () => newLists.first as Map<String, dynamic>,
        );
        _activeStatus = firstNonEmpty['name'] as String;
      }
    });
    _notifySections();
  }

  Future<void> _handleEntryUpdated(
    int mediaId,
    Map<String, dynamic> updates,
  ) async {
    final updatedLists = await AnimeListRepo.updateEntryInLists(
      _lists,
      mediaId,
      updates,
    );
    _updateUIWithLists(updatedLists);
  }

  /// Shows the anime options bottom sheet
  void _showItemOptions(
    BuildContext context,
    Map<String, dynamic> entry,
  ) async {
    final typedEntry = MediaListEntryWithMedia.fromJson(entry);
    final result = await showAnimeOptions(context, typedEntry);

    if (result != null && mounted) {
      final media = entry['media'] as Map<String, dynamic>? ?? {};
      final mediaId = media.mediaId;
      if (mediaId != 0) {
        CacheUtils.invalidateMedia(mediaId);
        _handleEntryUpdated(mediaId, result);
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
      return const AppErrorView(message: 'No anime lists found.');
    }

    final activeList =
        _lists.firstWhere(
              (l) => l['name'] == _activeStatus,
              orElse: () => _lists.first as Map<String, dynamic>,
            )
            as Map<String, dynamic>;
    final activeName = activeList['name'] as String? ?? '';
    final activeEntries = activeList['entries'] as List<dynamic>? ?? [];

    return RefreshIndicator(
      color: borderColor,
      backgroundColor: hoverBgColor,
      onRefresh: () => _fetchLists(forceRefresh: true),
      child: widget.isGridMode
          ? AnimeListGridView(
              activeName: activeName,
              entries: activeEntries,
              scrollController: _scrollController,
              onRefresh: () => _fetchLists(forceRefresh: true),
              onLongPress: _showItemOptions,
            )
          : AnimeListView(
              activeName: activeName,
              entries: activeEntries,
              scrollController: _scrollController,
              onRefresh: () => _fetchLists(forceRefresh: true),
              onEntryUpdated: _handleEntryUpdated,
              onLongPress: _showItemOptions,
            ),
    );
  }
}
