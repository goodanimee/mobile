import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/error_view.dart';
import '../../components/loading_indicator.dart';
import '../../components/sort_menu.dart';
import '../../models/common.dart';
import '../../models/media_list.dart';
import '../../services/media_list_controller.dart';
import '../../theme/theme.dart';
import '../../utils/app_options.dart';
import '../../utils/utils.dart';
import 'widgets/grid_view.dart';
import 'widgets/list_view.dart';

/// Unified tab widget for displaying user's anime or manga lists.
class MediaListTab extends StatefulWidget {
  /// The media type ('ANIME' or 'MANGA').
  final String mediaType;

  /// Whether to display items in a grid.
  final bool isGridMode;

  /// Callback for signing out.
  final VoidCallback onSignOut;

  /// Callback when the list of categories changes.
  final void Function(
    List<MediaListStatus> statuses,
    MediaListStatus? activeStatus,
    void Function(MediaListStatus) scrollTo,
  )?
  onSectionsChanged;

  /// Creates a media list tab.
  const MediaListTab({
    super.key,
    required this.mediaType,
    this.isGridMode = false,
    required this.onSignOut,
    this.onSectionsChanged,
  });

  @override
  State<MediaListTab> createState() => _MediaListTabState();
}

class _MediaListTabState extends State<MediaListTab>
    with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();
  late MediaListController _controller;

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

  String get _sortTypePrefKey => '${widget.mediaType.toLowerCase()}_sort_type';
  String _sortDirPrefKey(String key) =>
      '${widget.mediaType.toLowerCase()}_sort_dir_$key';

  @override
  void initState() {
    super.initState();
    _controller = MediaListController.forType(widget.mediaType);
    _controller.addListener(_onControllerUpdated);

    _sortMenuController = AnimationController(
      vsync: this,
      duration: kAnimStandard,
    );
    _sortMenuAnimation = CurvedAnimation(
      parent: _sortMenuController,
      curve: kCurveSymmetric,
    );
    _iconsFade = CurvedAnimation(
      parent: _sortMenuController,
      curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
    );

    _loadSortSettings().then((_) {
      if (mounted) {
        if (_controller.needsRefresh || _controller.lists.isEmpty) {
          _controller.fetchLists(forceRefresh: _controller.needsRefresh);
        } else {
          _notifySections();
        }
      }
    });
  }

  @override
  void didUpdateWidget(covariant MediaListTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.mediaType != widget.mediaType) {
      _controller.removeListener(_onControllerUpdated);
      _controller = MediaListController.forType(widget.mediaType);
      _controller.addListener(_onControllerUpdated);
      _loadSortSettings();
      if (_controller.lists.isEmpty || _controller.needsRefresh) {
        _controller.fetchLists(forceRefresh: _controller.needsRefresh);
      } else {
        _notifySections();
      }
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerUpdated);
    _scrollController.dispose();
    _sortMenuController.dispose();
    super.dispose();
  }

  void _onControllerUpdated() {
    if (!mounted) return;
    _notifySections();
    setState(() {});
    if (_controller.needsRefresh) {
      _controller.fetchLists(forceRefresh: true);
    }
  }

  void _notifySections() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      widget.onSectionsChanged?.call(
        _controller.lists
            .where((l) => !l.isCustomList && l.status != null)
            .map((l) => l.status!)
            .toList(),
        _controller.activeStatus,
        _selectSection,
      );
    });
  }

  void _selectSection(MediaListStatus status) {
    if (_controller.activeStatus == status &&
        _controller.activeCustomList == null) {
      return;
    }
    _controller.setActiveStatus(status);
    _notifySections();
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }
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

  Future<void> _showItemOptions(
    BuildContext context,
    MediaListEntryWithMedia entry,
  ) async {
    final result = await showMediaOptions(context, entry);
    if (result != null && mounted) {
      final mediaId = entry.media.id;
      if (mediaId != 0) {
        await _controller.updateEntry(mediaId, result);
      }
    }
  }

  Future<void> _loadSortSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final type = prefs.getString(_sortTypePrefKey);
      if (type != null) {
        setState(() {
          _sortType = type;
        });
      }
      for (final key in _sortDirections.keys) {
        final val = prefs.getBool(_sortDirPrefKey(key));
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
      await prefs.setString(_sortTypePrefKey, _sortType);
      for (final entry in _sortDirections.entries) {
        await prefs.setBool(_sortDirPrefKey(entry.key), entry.value);
      }
    } catch (_) {}
  }

  void _sortEntries(List<MediaListEntryWithMedia> entries) {
    final isAscending = _sortDirections[_sortType] ?? false;
    MediaListSortUtils.sortEntries(
      entries,
      sortType: _sortType,
      isAscending: isAscending,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_controller.isLoading) {
      return const AppLoadingIndicator();
    }

    if (_controller.error != null) {
      return AppErrorView(
        message: _controller.error!,
        onRetry: () => _controller.fetchLists(forceRefresh: true),
      );
    }

    if (_controller.lists.isEmpty) {
      final typeLabel = widget.mediaType.toLowerCase();
      return AppErrorView(message: 'No $typeLabel lists found.');
    }

    final activeList = _controller.activeCustomList != null
        ? _controller.lists.firstWhere(
            (l) => l.isCustomList && l.name == _controller.activeCustomList,
            orElse: () => _controller.lists.firstWhere(
              (l) => !l.isCustomList,
              orElse: () => _controller.lists.first,
            ),
          )
        : _controller.lists.firstWhere(
            (l) => l.status == _controller.activeStatus,
            orElse: () => _controller.lists.first,
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
                onRefresh: () => _controller.fetchLists(forceRefresh: true),
                child: widget.isGridMode
                    ? MediaListGridView(
                        activeName: activeName,
                        entries: sortedEntries,
                        scrollController: _scrollController,
                        onRefresh: () =>
                            _controller.fetchLists(forceRefresh: true),
                        onLongPress: _showItemOptions,
                        emptyLabel: widget.mediaType.toUpperCase() == 'MANGA'
                            ? 'No manga'
                            : 'No anime',
                      )
                    : MediaListView(
                        activeName: activeName,
                        entries: sortedEntries,
                        scrollController: _scrollController,
                        onRefresh: () =>
                            _controller.fetchLists(forceRefresh: true),
                        onEntryUpdated: _controller.updateEntry,
                        onLongPress: _showItemOptions,
                        emptyLabel: widget.mediaType.toUpperCase() == 'MANGA'
                            ? 'No manga'
                            : 'No anime',
                      ),
              ),
            ),
          ],
        ),
        SortMenuOverlay(
          visible: _showSortMenu,
          options: const [
            (type: 'score', label: 'Score'),
            (type: 'title', label: 'Title'),
            (type: 'progress', label: 'Progress'),
            (type: 'release_date', label: 'Release date'),
            (type: 'started_date', label: 'Started date'),
            (type: 'completed_date', label: 'Completed date'),
          ],
          activeSortType: _sortType,
          sortDirections: _sortDirections,
          sizeAnimation: _sortMenuAnimation,
          fadeAnimation: _iconsFade,
          topOffset: 60,
          rightOffset: 16,
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
}
