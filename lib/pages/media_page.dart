import 'package:flutter/material.dart';
import 'package:goodanime/utils/app_navigation.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../components/error_view.dart';
import '../components/floating_nav.dart';
import '../components/loading_indicator.dart';
import '../models/media.dart';
import '../models/media_list.dart';
import '../models/media_list_entry.dart';
import '../services/media_service.dart';
import '../theme/theme.dart';
import '../utils/app_options.dart';
import '../utils/utils.dart';
import 'media_page/tabs/characters_tab.dart';
import 'media_page/tabs/content_tab.dart';
import 'media_page/tabs/info_tab.dart';
import 'media_page/tabs/placeholder_tab.dart';
import 'media_page/tabs/rankings_tab.dart';
import 'media_page/tabs/relations_tab.dart';
import 'media_page/tabs/reviews_tab.dart';
import 'media_page/tabs/staff_tab.dart';
import 'media_page/widgets/edit_entry_fab.dart';
import 'media_page/widgets/media_page_header.dart';
import 'media_page/widgets/sticky_header.dart';

/// A page displaying detailed information about a media item
class MediaPage extends StatefulWidget {
  /// The ID of the media to display
  final int mediaId;

  /// Creates a media page
  const MediaPage({super.key, required this.mediaId});

  @override
  State<MediaPage> createState() => _MediaPageState();
}

/// State for MediaPage
class _MediaPageState extends State<MediaPage> {
  bool _isLoading = true;
  Media? _mediaData;
  String? _error;
  bool _showSpoilers = false;
  int _selectedTabIndex = 0;
  bool _didUpdate = false;
  bool _isTogglingFavourite = false;
  int _refreshCount = 0;

  /// Whether the sticky header bar is visible
  bool _showStickyBar = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchMediaDetails();
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

  /// Fetches media details from cache or network
  Future<void> _fetchMediaDetails({bool forceRefresh = false}) async {
    try {
      final data = await MediaService.getMediaDetails(
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

  /// Toggles the media's favourite status
  Future<void> _toggleFavourite() async {
    if (_mediaData == null || _isTogglingFavourite) return;
    final bool currentFav = _mediaData!.isFavourite;

    setState(() => _isTogglingFavourite = true);

    try {
      if (_mediaData!.type == 'MANGA') {
        await MediaService.toggleFavouriteManga(widget.mediaId, _mediaData!);
      } else {
        await MediaService.toggleFavouriteAnime(widget.mediaId, _mediaData!);
      }
      setState(
        () => _mediaData = _mediaData!.copyWith(isFavourite: !currentFav),
      );
      _didUpdate = true;
    } catch (e) {
      if (mounted) {
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

  /// Shows the media options bottom sheet
  Future<void> _showItemOptions() async {
    if (_mediaData == null) return;

    final media = _mediaData!;
    final typedEntry = MediaListEntryWithMedia(
      id: media.mediaListEntry?.id ?? 0,
      status: media.mediaListEntry?.status,
      progress: media.mediaListEntry?.progress ?? 0,
      score: media.mediaListEntry?.score ?? 0,
      repeat: media.mediaListEntry?.repeat ?? 0,
      progressVolumes: media.mediaListEntry?.progressVolumes ?? 0,
      startedAt: media.mediaListEntry?.startedAt,
      completedAt: media.mediaListEntry?.completedAt,
      media: media,
    );
    final result = await showMediaOptions(context, typedEntry);

    if (result != null && mounted) {
      _didUpdate = true;
      setState(() {
        if (result.deleted) {
          _mediaData = media.copyWith();
        } else if (result.entry != null) {
          final typedEntry = result.entry!;
          final updatedEntry = MediaListEntry(
            id: typedEntry.id,
            status: typedEntry.status,
            progress: typedEntry.progress,
            score: typedEntry.score,
            repeat: typedEntry.repeat,
            progressVolumes: typedEntry.progressVolumes,
            startedAt: typedEntry.startedAt,
            completedAt: typedEntry.completedAt,
          );
          _mediaData = media.copyWith(mediaListEntry: updatedEntry);
        }
      });

      await CacheUtils.invalidateMedia(widget.mediaId);
      if (_mediaData!.type == 'ANIME') {
        CacheUtils.animeListNeedsRefresh.value = true;
      } else if (_mediaData!.type == 'MANGA') {
        CacheUtils.mangaListNeedsRefresh.value = true;
      }
      await _fetchMediaDetails(forceRefresh: true);
    }
  }

  /// Handles manual pull-to-refresh
  Future<void> _handleRefresh() async {
    await _fetchMediaDetails(forceRefresh: true);
    if (_selectedTabIndex == 6) {
      setState(() {
        _refreshCount++;
      });
    }
  }

  /// Builds the content of the currently selected tab
  Widget _buildActiveTab(Media media) {
    switch (_selectedTabIndex) {
      case 0:
        return MediaInfoTab(
          media: media,
          showSpoilers: _showSpoilers,
          onToggleSpoilers: () =>
              setState(() => _showSpoilers = !_showSpoilers),
          isNested: true,
        );
      case 1:
        return MediaContentTab(media: media, isNested: true);
      case 2:
        return MediaStaffTab(
          mediaId: widget.mediaId,
          scrollController: _scrollController,
          isNested: true,
          initialData: media.staff,
        );
      case 3:
        return MediaCharactersTab(
          mediaId: widget.mediaId,
          scrollController: _scrollController,
          isNested: true,
          initialData: media.characters,
        );
      case 4:
        return MediaRelationsTab(
          mediaId: widget.mediaId,
          relationsData: media.relations,
          initialRecommendations: media.recommendations,
          isNested: true,
        );
      case 5:
        return MediaRankingsTab(media: media, isNested: true);
      case 6:
        final name = media.title.english.isNotEmpty
            ? media.title.english
            : media.title.romaji.isNotEmpty
            ? media.title.romaji
            : media.title.userPreferred;
        return MediaReviewsTab(
          mediaId: widget.mediaId,
          mediaName: name,
          mediaType: media.type,
          initialData: media.reviews,
          isNested: true,
          refreshTrigger: _refreshCount,
        );
      default:
        return const PlaceholderTab(title: 'Overview Section');
    }
  }

  @override
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
          onRetry: () => _fetchMediaDetails(forceRefresh: true),
        ),
      );
    }

    final media = _mediaData!;

    final quickNavItems = [
      QuickNavSection(
        icon: LucideIcons.info,
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
        icon: LucideIcons.monitorPlay,
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
        icon: LucideIcons.users,
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
        icon: LucideIcons.userRound,
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
        icon: LucideIcons.network,
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
        icon: LucideIcons.barChart3,
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
        icon: LucideIcons.messageSquareHeart,
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
                  SliverToBoxAdapter(child: MediaPageHeader(media: media)),
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
                isFavourite: _mediaData?.isFavourite ?? false,
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
                  EditEntryFab(
                    onTap: _showItemOptions,
                    isEdit: media.mediaListEntry != null,
                  ),
                  const SizedBox(height: 8),
                  FloatingNav(
                    selectedIndex: -1,
                    onTap: _handleNavTap,
                    quickNavSections: quickNavItems,
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
