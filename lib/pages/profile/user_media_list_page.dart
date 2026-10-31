import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/error_view.dart';
import '../../components/floating_nav.dart';
import '../../components/loading_indicator.dart';
import '../../components/sort_menu.dart';
import '../../models/common.dart';
import '../../models/media_list.dart';
import '../../services/media_list_service.dart';
import '../../theme/theme.dart';
import '../../utils/app_navigation.dart';
import '../../utils/utils.dart';
import '../media_list/widgets/grid_view.dart';
import '../media_list/widgets/list_view.dart';

/// A read-only page displaying another user's anime or manga list.
class UserMediaListPage extends StatefulWidget {
  /// The AniList user ID whose list is displayed.
  final int userId;

  /// The display name of the user.
  final String username;

  /// The media type ('ANIME' or 'MANGA').
  final String mediaType;

  /// Creates a read-only user media list page.
  const UserMediaListPage({
    super.key,
    required this.userId,
    required this.username,
    required this.mediaType,
  });

  @override
  State<UserMediaListPage> createState() => _UserMediaListPageState();
}

class _UserMediaListPageState extends State<UserMediaListPage>
    with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();

  List<MediaList> _lists = [];
  bool _isLoading = true;
  String? _error;
  MediaListStatus? _activeStatus = MediaListStatus.current;
  String? _activeCustomList;
  bool _isGridMode = true;

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

  bool get _isManga => widget.mediaType.toUpperCase() == 'MANGA';

  @override
  void initState() {
    super.initState();
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
    unawaited(_initPreferencesAndLists());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _sortMenuController.dispose();
    super.dispose();
  }

  Future<void> _initPreferencesAndLists() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedGrid = prefs.getBool('cached_is_grid_mode');
      if (cachedGrid != null && mounted) {
        setState(() => _isGridMode = cachedGrid);
      }
    } catch (_) {}
    await _loadLists();
  }

  Future<void> _loadLists() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final lists = await MediaListService.getPublicUserLists(
        widget.userId,
        widget.mediaType,
      );
      if (!mounted) return;

      MediaListStatus? nextStatus = _activeStatus;
      String? nextCustom = _activeCustomList;

      if (nextCustom == null) {
        final currentList = lists
            .where((l) => l.status == nextStatus)
            .firstOrNull;
        if (currentList == null || currentList.entries.isEmpty) {
          final firstNonEmpty = lists
              .where((l) => l.entries.isNotEmpty)
              .firstOrNull;
          if (firstNonEmpty != null) {
            if (firstNonEmpty.isCustomList) {
              nextCustom = firstNonEmpty.name;
              nextStatus = null;
            } else {
              nextStatus = firstNonEmpty.status;
            }
          }
        }
      }

      setState(() {
        _lists = lists;
        _activeStatus = nextStatus;
        _activeCustomList = nextCustom;
        _isLoading = false;
      });
    } catch (_) {
      if (mounted) {
        setState(() {
          _error = 'Failed to load user lists.';
          _isLoading = false;
        });
      }
    }
  }

  void _toggleGridMode() {
    setState(() => _isGridMode = !_isGridMode);
  }

  void _toggleSortMenu() {
    if (_showSortMenu) {
      _sortMenuController.reverse().then((_) {
        if (mounted) {
          setState(() => _showSortMenu = false);
        }
      });
    } else {
      setState(() => _showSortMenu = true);
      _sortMenuController.forward();
    }
  }

  void _selectStatusSection(MediaListStatus status) {
    if (_activeCustomList == null && _activeStatus == status) return;
    setState(() {
      _activeStatus = status;
      _activeCustomList = null;
    });
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }
  }

  void _selectCustomSection(String name) {
    if (_activeCustomList == name) return;
    setState(() {
      _activeCustomList = name;
      _activeStatus = null;
    });
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }
  }

  IconData _statusIcon(MediaListStatus status) => switch (status) {
    MediaListStatus.current =>
      _isManga ? LucideIcons.bookOpenText : LucideIcons.playCircle,
    MediaListStatus.planning => LucideIcons.bookmark,
    MediaListStatus.completed => LucideIcons.badgeCheck,
    MediaListStatus.repeating => LucideIcons.rotateCcw,
    MediaListStatus.paused => LucideIcons.circlePause,
    MediaListStatus.dropped => LucideIcons.ban,
  };

  List<QuickNavSection> _buildQuickNavSections() {
    final statusSections = _lists
        .where((l) => !l.isCustomList && l.status != null)
        .map(
          (l) => QuickNavSection(
            icon: _statusIcon(l.status!),
            label: l.name,
            isSelected: _activeCustomList == null && _activeStatus == l.status,
            onTap: () => _selectStatusSection(l.status!),
          ),
        );

    final customSections = _lists
        .where((l) => l.isCustomList && l.entries.isNotEmpty)
        .take(3)
        .map(
          (l) => QuickNavSection(
            icon: LucideIcons.folder,
            label: l.name,
            isSelected: _activeCustomList == l.name,
            onTap: () => _selectCustomSection(l.name),
          ),
        );

    return [...statusSections, ...customSections];
  }

  Widget _buildHeader({String? activeSectionName}) {
    final typeTitle = _isManga ? 'Manga List' : 'Anime List';
    final subtitle = "${widget.username}'s $typeTitle";

    return Container(
      height: 56,
      decoration: const BoxDecoration(
        color: bgColor,
        border: Border(bottom: BorderSide(color: cardBorderColor)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(LucideIcons.arrowLeft, color: textPrimary),
              onPressed: () => Navigator.of(context).pop(),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activeSectionName ?? subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: textPrimary,
                      height: 1.15,
                    ),
                  ),
                  if (activeSectionName != null)
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: textSecondary,
                      ),
                    ),
                ],
              ),
            ),
            if (activeSectionName != null)
              IconButton(
                icon: const Icon(LucideIcons.sortDesc, color: textPrimary),
                onPressed: _toggleSortMenu,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return Column(
        children: [
          _buildHeader(),
          const Expanded(child: AppLoadingIndicator()),
        ],
      );
    }

    if (_error != null) {
      return Column(
        children: [
          _buildHeader(),
          Expanded(
            child: AppErrorView(message: _error!, onRetry: _loadLists),
          ),
        ],
      );
    }

    if (_lists.isEmpty) {
      final typeLabel = _isManga ? 'manga' : 'anime';
      return Column(
        children: [
          _buildHeader(),
          Expanded(child: AppErrorView(message: 'No $typeLabel lists found.')),
        ],
      );
    }

    final activeList = _activeCustomList != null
        ? _lists.firstWhere(
            (l) => l.isCustomList && l.name == _activeCustomList,
            orElse: () => _lists.first,
          )
        : _lists.firstWhere(
            (l) => l.status == _activeStatus,
            orElse: () => _lists.first,
          );
    final activeName = activeList.name;
    final sortedEntries = List<MediaListEntryWithMedia>.from(
      activeList.entries,
    );
    MediaListSortUtils.sortEntries(
      sortedEntries,
      sortType: _sortType,
      isAscending: _sortDirections[_sortType] ?? false,
    );
    final emptyLabel = _isManga ? 'No manga' : 'No anime';

    return Stack(
      children: [
        Column(
          children: [
            _buildHeader(activeSectionName: activeName),
            Expanded(
              child: RefreshIndicator(
                color: borderColor,
                backgroundColor: hoverBgColor,
                onRefresh: _loadLists,
                child: _isGridMode
                    ? MediaListGridView(
                        activeName: activeName,
                        entries: sortedEntries,
                        scrollController: _scrollController,
                        onRefresh: () => unawaited(_loadLists()),
                        emptyLabel: emptyLabel,
                      )
                    : MediaListView(
                        activeName: activeName,
                        entries: sortedEntries,
                        scrollController: _scrollController,
                        onRefresh: () => unawaited(_loadLists()),
                        emptyLabel: emptyLabel,
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
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasLists = !_isLoading && _error == null && _lists.isNotEmpty;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            _buildContent(),
            Positioned(
              bottom: 24,
              right: 20,
              child: FloatingNav(
                selectedIndex: -1,
                onTap: (index) => AppNavigation.handleNavTap(context, index),
                quickNavSections: hasLists ? _buildQuickNavSections() : null,
                isGridMode: hasLists ? _isGridMode : null,
                onToggleGridMode: hasLists ? _toggleGridMode : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
