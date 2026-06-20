import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
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
import 'media_list_tab/widgets/sort_menu.dart';

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
class _MangaListTabState extends State<MangaListTab>
    with SingleTickerProviderStateMixin {
  bool _isLoading = true;
  List<MediaList> _lists = [];
  String? _error;
  final _scrollController = ScrollController();
  MediaListStatus? _activeStatus;

  bool _hasFetchedThisSession = false;
  bool _showSortMenu = false;
  String _sortType = 'score';
  final Map<String, bool> _sortDirections = {
    'score': false,
    'title': true,
    'progress': false,
    'release_date': false,
    'started_date': false,
    'completed_date': false,
  };

  late final AnimationController _sortMenuController;
  late final Animation<double> _sortMenuAnimation;
  late final Animation<double> _iconsFade;

  @override
  void initState() {
    super.initState();
    _sortMenuController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _sortMenuAnimation = CurvedAnimation(
      parent: _sortMenuController,
      curve: Curves.easeInOut,
    );
    _iconsFade = CurvedAnimation(
      parent: _sortMenuController,
      curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
    );
    _loadSortSettings().then((_) {
      if (mounted) {
        _fetchLists();
      }
    });
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
    _sortMenuController.dispose();
    CacheUtils.mangaListNeedsRefresh.removeListener(_onCacheInvalidated);
    super.dispose();
  }

  void _toggleSortMenu() {
    if (_showSortMenu) {
      _sortMenuController.reverse().then((_) {
        if (mounted) {
          setState(() {
            _showSortMenu = false;
          });
        }
      });
    } else {
      setState(() {
        _showSortMenu = true;
      });
      _sortMenuController.forward();
    }
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
    final sortedEntries = List<MediaListEntryWithMedia>.from(activeEntries);
    _sortEntries(sortedEntries);

    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: 56,
              decoration: const BoxDecoration(
                color: bgColor,
                border: Border(bottom: BorderSide(color: cardBorderColor)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      activeName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textPrimary,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(
                        LucideIcons.sortDesc,
                        color: textPrimary,
                      ),
                      onPressed: _toggleSortMenu,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                color: borderColor,
                backgroundColor: hoverBgColor,
                onRefresh: () => _fetchLists(forceRefresh: true),
                child: widget.isGridMode
                    ? MediaListGridView(
                        activeName: activeName,
                        entries: sortedEntries,
                        scrollController: _scrollController,
                        onRefresh: () => _fetchLists(forceRefresh: true),
                        onLongPress: _showItemOptions,
                        emptyLabel: 'No manga',
                      )
                    : MediaListView(
                        activeName: activeName,
                        entries: sortedEntries,
                        scrollController: _scrollController,
                        onRefresh: () => _fetchLists(forceRefresh: true),
                        onEntryUpdated: _handleEntryUpdated,
                        onLongPress: _showItemOptions,
                        emptyLabel: 'No manga',
                      ),
              ),
            ),
          ],
        ),
        SortMenuOverlay(
          visible: _showSortMenu,
          activeSortType: _sortType,
          sortDirections: _sortDirections,
          animationController: _sortMenuController,
          sizeAnimation: _sortMenuAnimation,
          fadeAnimation: _iconsFade,
          onDismiss: _toggleSortMenu,
          onSelected: (type) {
            setState(() {
              if (_sortType == type) {
                _sortDirections[type] = !(_sortDirections[type] ?? false);
              } else {
                _sortType = type;
              }
            });
            _saveSortSettings();
          },
        ),
      ],
    );
  }

  Future<void> _loadSortSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final type = prefs.getString('manga_sort_type');
      if (type != null) {
        setState(() {
          _sortType = type;
        });
      }
      for (final key in _sortDirections.keys) {
        final val = prefs.getBool('manga_sort_dir_$key');
        if (val != null) {
          setState(() {
            _sortDirections[key] = val;
          });
        }
      }
    } catch (_) {}
  }

  Future<void> _saveSortSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('manga_sort_type', _sortType);
      for (final entry in _sortDirections.entries) {
        await prefs.setBool('manga_sort_dir_${entry.key}', entry.value);
      }
    } catch (_) {}
  }

  void _sortEntries(List<MediaListEntryWithMedia> entries) {
    final isAscending = _sortDirections[_sortType] ?? false;
    switch (_sortType) {
      case 'title':
        entries.sort((a, b) {
          final tA = a.media.title.userPreferred.trim().toLowerCase();
          final tB = b.media.title.userPreferred.trim().toLowerCase();
          if (tA.isEmpty && tB.isEmpty) return 0;
          if (tA.isEmpty) return -1;
          if (tB.isEmpty) return 1;
          return isAscending ? tA.compareTo(tB) : tB.compareTo(tA);
        });
        break;
      case 'score':
        entries.sort((a, b) {
          final scoreA = a.score;
          final scoreB = b.score;
          final hasScoreA = scoreA > 0;
          final hasScoreB = scoreB > 0;

          if (hasScoreA && hasScoreB) {
            return isAscending
                ? scoreA.compareTo(scoreB)
                : scoreB.compareTo(scoreA);
          }
          if (hasScoreA) return -1;
          if (hasScoreB) return 1;

          final commA = a.media.averageScore;
          final commB = b.media.averageScore;
          return isAscending ? commA.compareTo(commB) : commB.compareTo(commA);
        });
        break;
      case 'progress':
        entries.sort((a, b) {
          return isAscending
              ? a.progress.compareTo(b.progress)
              : b.progress.compareTo(a.progress);
        });
        break;
      case 'release_date':
        entries.sort((a, b) {
          final yA = (a.media.startYear == 0) ? null : a.media.startYear;
          final yB = (b.media.startYear == 0) ? null : b.media.startYear;
          if (yA == null && yB == null) return 0;
          if (yA == null) return 1;
          if (yB == null) return -1;
          return isAscending ? yA.compareTo(yB) : yB.compareTo(yA);
        });
        break;
      case 'started_date':
        entries.sort((a, b) {
          return _compareFuzzyDates(a.startedAt, b.startedAt, isAscending);
        });
        break;
      case 'completed_date':
        entries.sort((a, b) {
          return _compareFuzzyDates(a.completedAt, b.completedAt, isAscending);
        });
        break;
    }
  }

  int _compareFuzzyDates(FuzzyDate? a, FuzzyDate? b, bool ascending) {
    if (a == null && b == null) return 0;
    if (a == null) return 1;
    if (b == null) return -1;

    final yA = (a.year == 0) ? null : a.year;
    final yB = (b.year == 0) ? null : b.year;
    if (yA == null && yB == null) return 0;
    if (yA == null) return 1;
    if (yB == null) return -1;
    if (yA != yB) {
      return ascending ? yA.compareTo(yB) : yB.compareTo(yA);
    }

    final mA = (a.month == 0) ? null : a.month;
    final mB = (b.month == 0) ? null : b.month;
    if (mA == null && mB == null) return 0;
    if (mA == null) return 1;
    if (mB == null) return -1;
    if (mA != mB) {
      return ascending ? mA.compareTo(mB) : mB.compareTo(mA);
    }

    final dA = (a.day == 0) ? null : a.day;
    final dB = (b.day == 0) ? null : b.day;
    if (dA == null && dB == null) return 0;
    if (dA == null) return 1;
    if (dB == null) return -1;
    return ascending ? dA.compareTo(dB) : dB.compareTo(dA);
  }
}
