import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:ui';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/theme.dart';
import '../components/floating_nav.dart';
import '../components/loading_indicator.dart';
import '../components/error_view.dart';
import '../utils/backend_helper.dart';
import '../services/auth_service.dart';
import '../proto/medialist.pb.dart';
import '../utils/utils.dart';
import '../utils/app_options.dart';

import 'anime_page/tabs/info_tab.dart';
import 'anime_page/tabs/characters_tab.dart';
import 'anime_page/tabs/staff_tab.dart';
import 'anime_page/tabs/media_tab.dart';
import 'anime_page/tabs/relations_tab.dart';
import 'anime_page/tabs/rankings_tab.dart';
import 'anime_page/tabs/placeholder_tab.dart';
import 'anime_page/widgets/anime_page_header.dart';

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

  /// Whether the sticky header bar is visible
  bool _showStickyBar = false;
  final ScrollController _scrollController = ScrollController();

  static const int _cacheCapacity = 10;
  static const String _cacheKeysPref = 'anime_cache_keys';
  static const String _cachePrefix = 'anime_cache_';

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
    final prefs = await SharedPreferences.getInstance();

    if (!forceRefresh) {
      final cachedStr = prefs.getString('$_cachePrefix${widget.mediaId}');
      if (cachedStr != null) {
        List<String> keys = prefs.getStringList(_cacheKeysPref) ?? [];
        keys.remove(widget.mediaId.toString());
        keys.add(widget.mediaId.toString());
        await prefs.setStringList(_cacheKeysPref, keys);

        if (mounted) {
          setState(() {
            _mediaData = json.decode(cachedStr);
            _isLoading = false;
          });
        }
        return;
      }
    } else {
      await prefs.remove('$_cachePrefix${widget.mediaId}');
    }

    try {
      final token = await AuthService.getRawToken() ?? '';
      final req = FetchMediaDetailsRequest(mediaId: widget.mediaId);
      final response = await BackendHelper.fetchMediaDetails(req, token);

      if (mounted) {
        setState(() {
          _mediaData = json.decode(response.rawJson);
          _isLoading = false;
        });

        if (_mediaData != null) {
          _saveToDiskCache(prefs, widget.mediaId, response.rawJson);
        }
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

  /// Saves anime data to disk cache
  Future<void> _saveToDiskCache(
    SharedPreferences prefs,
    int mediaId,
    String rawJson,
  ) async {
    List<String> keys = prefs.getStringList(_cacheKeysPref) ?? [];
    final idStr = mediaId.toString();

    keys.remove(idStr);
    keys.add(idStr);

    if (keys.length > _cacheCapacity) {
      final oldestKey = keys.removeAt(0);
      await prefs.remove('$_cachePrefix$oldestKey');
    }

    await prefs.setStringList(_cacheKeysPref, keys);
    await prefs.setString('$_cachePrefix$idStr', rawJson);
  }

  /// Handles navigation bar taps
  void _handleNavTap(int index) {
    if (index != 0) {
      Navigator.of(context).pop(index);
    }
  }

  /// Shows the anime options bottom sheet
  void _showItemOptions() async {
    if (_mediaData == null) return;

    final media = _mediaData!;
    final entry = Map<String, dynamic>.from(media['mediaListEntry'] ?? {});
    entry['media'] = media;

    final result = await showAnimeOptions(context, entry);

    if (result != null && mounted) {
      _didUpdate = true;
      await CacheUtils.invalidateMedia(widget.mediaId);
      CacheUtils.homeNeedsRefresh.value = true;
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
          media: media,
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
                  SliverToBoxAdapter(child: AnimePageHeader(media: media)),
                  SliverToBoxAdapter(child: _buildActiveTab(media)),
                  const SliverToBoxAdapter(child: SizedBox(height: 48)),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _buildStickyHeader(media),
            ),
            Positioned(
              bottom: 24,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildEditFab(),
                  const SizedBox(height: 8),
                  FloatingNav(
                    selectedIndex: 0,
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

  /// Builds the edit floating action button
  Widget _buildEditFab() {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cardBorderColor, width: 1.0),
      ),
      child: GestureDetector(
        onTap: _showItemOptions,
        behavior: HitTestBehavior.opaque,
        child: const Center(
          child: Icon(Icons.edit_rounded, color: textPrimary, size: 22),
        ),
      ),
    );
  }

  /// Builds the sticky header bar
  Widget _buildStickyHeader(Map<String, dynamic> media) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: topPadding + 56,
          padding: EdgeInsets.only(top: topPadding),
          decoration: BoxDecoration(
            color: _showStickyBar ? bgColor : Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: _showStickyBar ? cardBorderColor : Colors.transparent,
                width: 1.0,
              ),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 16,
                top: 0,
                bottom: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(_didUpdate),
                    child: ClipOval(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: _showStickyBar ? 0 : 10,
                          sigmaY: _showStickyBar ? 0 : 10,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: _showStickyBar
                                ? Colors.transparent
                                : shadowColor.withValues(alpha: 0.4),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_back_rounded,
                            color: textPrimary,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                left: 72,
                right: 16,
                child: AnimatedOpacity(
                  opacity: _showStickyBar ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: Center(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            media.titleText,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 16,
                top: 0,
                bottom: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      final url = media['siteUrl']?.toString();
                      if (url != null && url.isNotEmpty) {
                        Share.share(url);
                      }
                    },
                    child: ClipOval(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: _showStickyBar ? 0 : 10,
                          sigmaY: _showStickyBar ? 0 : 10,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: _showStickyBar
                                ? Colors.transparent
                                : shadowColor.withValues(alpha: 0.4),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.share_rounded,
                            color: textPrimary,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
