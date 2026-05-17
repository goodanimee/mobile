import 'package:flutter/material.dart';
import 'package:goodanime/utils/app_navigation.dart';
import '../theme/theme.dart';
import '../components/floating_nav.dart';
import '../components/loading_indicator.dart';
import '../components/error_view.dart';
import '../services/anime_repo.dart';
import '../utils/utils.dart';
import '../utils/app_options.dart';
import '../models/media_list.dart';
import '../models/media.dart';

import 'anime_page/tabs/info_tab.dart';
import 'anime_page/tabs/characters_tab.dart';
import 'anime_page/tabs/staff_tab.dart';
import 'anime_page/tabs/media_tab.dart';
import 'anime_page/tabs/relations_tab.dart';
import 'anime_page/tabs/rankings_tab.dart';
import 'anime_page/tabs/placeholder_tab.dart';
import 'anime_page/widgets/anime_page_header.dart';
import 'anime_page/widgets/sticky_header.dart';
import 'anime_page/widgets/edit_entry_fab.dart';

/// A page displaying detailed information about an anime
class AnimePage extends StatefulWidget {
  /// The media ID of the anime to display
  final int mediaId;

  /// Creates an anime page
  const AnimePage({super.key, required this.mediaId});

  @override
  State<AnimePage> createState() => _AnimePageState();
}

/// State for AnimePage
class _AnimePageState extends State<AnimePage> {
  bool _isLoading = true;
  Map<String, dynamic>? _mediaData;
  String? _error;
  bool _showSpoilers = false;
  int _selectedTabIndex = 0;
  bool _didUpdate = false;
  bool _isTogglingFavourite = false;

  /// Whether the sticky header bar is visible
  bool _showStickyBar = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchAnimeDetails();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  /// Listener for scroll changes to toggle sticky header visibility
  void _scrollListener() {
    if (_scrollController.offset > 200 && !_showStickyBar) {
      setState(() => _showStickyBar = true);
    } else if (_scrollController.offset <= 200 && _showStickyBar) {
      setState(() => _showStickyBar = false);
    }
  }

  /// Fetches anime details from cache or network
  Future<void> _fetchAnimeDetails({bool forceRefresh = false}) async {
    try {
      final data = await AnimeRepo.getAnimeDetails(
        widget.mediaId,
        forceRefresh: forceRefresh,
      );

      if (mounted) {
        setState(() {
          _mediaData = data;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Failed to load details: $e';
          _isLoading = false;
        });
      }
    }
  }

  /// Toggles the anime's favourite status
  Future<void> _toggleFavourite() async {
    if (_mediaData == null || _isTogglingFavourite) return;
    final bool currentFav = _mediaData!['isFavourite'] == true;

    setState(() => _isTogglingFavourite = true);

    try {
      await AnimeRepo.toggleFavourite(widget.mediaId, _mediaData!);
      setState(() => _mediaData!['isFavourite'] = !currentFav);
      _didUpdate = true;
    } catch (e) {
      if (mounted) {
        setState(() => _mediaData!['isFavourite'] = currentFav);
        await AnimeRepo.restoreFavouriteCache(widget.mediaId, _mediaData!);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to toggle favourite: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isTogglingFavourite = false);
      }
    }
  }

  /// Handles navigation bar taps
  void _handleNavTap(int index) {
    AppNavigation.currentTab.value = index;
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  /// Shows the anime options bottom sheet
  void _showItemOptions() async {
    if (_mediaData == null) return;

    final media = _mediaData!;
    final entry = Map<String, dynamic>.from(media['mediaListEntry'] ?? {});
    entry['media'] = media;

    final typedEntry = MediaListEntryWithMedia.fromJson(entry);
    final result = await showAnimeOptions(context, typedEntry);

    if (result != null && mounted) {
      _didUpdate = true;
      setState(() {
        if (result['deleted'] == true) {
          _mediaData!['mediaListEntry'] = null;
        } else {
          final entryMap =
              _mediaData!['mediaListEntry'] as Map<String, dynamic>? ?? {};
          final updatedEntry = Map<String, dynamic>.from(entryMap);
          result.forEach((key, value) {
            updatedEntry[key] = value;
          });
          _mediaData!['mediaListEntry'] = updatedEntry;
        }
      });

      await AnimeRepo.restoreFavouriteCache(widget.mediaId, _mediaData!);

      await CacheUtils.invalidateMedia(widget.mediaId);
      CacheUtils.animeListNeedsRefresh.value = true;
      await _fetchAnimeDetails(forceRefresh: true);
    }
  }

  /// Handles manual pull-to-refresh
  Future<void> _handleRefresh() async {
    await _fetchAnimeDetails(forceRefresh: true);
  }

  /// Builds the content of the currently selected tab
  Widget _buildActiveTab(Map<String, dynamic> media) {
    switch (_selectedTabIndex) {
      case 0:
        return AnimeInfoTab(
          media: Media.fromJson(media),
          showSpoilers: _showSpoilers,
          onToggleSpoilers: () =>
              setState(() => _showSpoilers = !_showSpoilers),
          isNested: true,
        );
      case 1:
        return AnimeMediaTab(media: media, isNested: true);
      case 2:
        return AnimeStaffTab(
          mediaId: widget.mediaId,
          scrollController: _scrollController,
          isNested: true,
          initialData: media['staff'] as Map<String, dynamic>?,
        );
      case 3:
        return AnimeCharactersTab(
          mediaId: widget.mediaId,
          scrollController: _scrollController,
          isNested: true,
          initialData: media['characters'] as Map<String, dynamic>?,
        );
      case 4:
        return AnimeRelationsTab(
          mediaId: widget.mediaId,
          relationsData: media['relations'] as Map<String, dynamic>?,
          initialRecommendations:
              media['recommendations'] as Map<String, dynamic>?,
          isNested: true,
        );
      case 5:
        return AnimeRankingsTab(media: media, isNested: true);
      case 6:
        return const PlaceholderTab(title: 'Reviews Section');
      default:
        return const PlaceholderTab(title: 'Overview Section');
    }
  }

  @override
  /// Builds the main anime page widget
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: bgColor,
        body: AppLoadingIndicator(),
      );
    }

    if (_error != null || _mediaData == null) {
      return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: bgColor,
          iconTheme: const IconThemeData(color: textPrimary),
        ),
        body: AppErrorView(
          message: _error ?? 'Anime not found',
          onRetry: () => _fetchAnimeDetails(forceRefresh: true),
        ),
      );
    }

    final media = _mediaData!;

    final quickNavItems = [
      QuickNavSection(
        icon: Icons.info_outline,
        label: 'Overview',
        isSelected: _selectedTabIndex == 0,
        onTap: () {
          setState(() => _selectedTabIndex = 0);
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        },
      ),
      QuickNavSection(
        icon: Icons.perm_media_outlined,
        label: 'Media',
        isSelected: _selectedTabIndex == 1,
        onTap: () {
          setState(() => _selectedTabIndex = 1);
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        },
      ),
      QuickNavSection(
        icon: Icons.groups_outlined,
        label: 'Staff',
        isSelected: _selectedTabIndex == 2,
        onTap: () {
          setState(() => _selectedTabIndex = 2);
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        },
      ),
      QuickNavSection(
        icon: Icons.account_circle_outlined,
        label: 'Characters',
        isSelected: _selectedTabIndex == 3,
        onTap: () {
          setState(() => _selectedTabIndex = 3);
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        },
      ),
      QuickNavSection(
        icon: Icons.shuffle_rounded,
        label: 'Relations',
        isSelected: _selectedTabIndex == 4,
        onTap: () {
          setState(() => _selectedTabIndex = 4);
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        },
      ),
      QuickNavSection(
        icon: Icons.leaderboard_outlined,
        label: 'Rankings',
        isSelected: _selectedTabIndex == 5,
        onTap: () {
          setState(() => _selectedTabIndex = 5);
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        },
      ),
      QuickNavSection(
        icon: Icons.rate_review_outlined,
        label: 'Reviews',
        isSelected: _selectedTabIndex == 6,
        onTap: () {
          setState(() => _selectedTabIndex = 6);
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        },
      ),
    ];

    return Scaffold(
      backgroundColor: bgColor,
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          Navigator.of(context).pop(_didUpdate);
        },
        child: Stack(
          children: [
            RefreshIndicator(
              color: borderColor,
              backgroundColor: hoverBgColor,
              onRefresh: _handleRefresh,
              child: CustomScrollView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: AnimePageHeader(media: Media.fromJson(media)),
                  ),
                  SliverToBoxAdapter(child: _buildActiveTab(media)),
                  const SliverToBoxAdapter(child: SizedBox(height: 128)),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: StickyHeader(
                media: media,
                showStickyBar: _showStickyBar,
                isFavourite: _mediaData?['isFavourite'] == true,
                isFavouriteLoading: _isTogglingFavourite,
                onBack: () => Navigator.of(context).pop(_didUpdate),
                onToggleFavourite: _toggleFavourite,
              ),
            ),
            Positioned(
              bottom: 24,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  EditEntryFab(onTap: _showItemOptions),
                  const SizedBox(height: 8),
                  FloatingNav(
                    selectedIndex: -1,
                    onTap: _handleNavTap,
                    quickNavSections: quickNavItems,
                    isGridMode: null,
                    onToggleGridMode: null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
