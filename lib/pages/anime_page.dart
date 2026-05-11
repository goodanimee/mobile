import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/theme.dart';
import '../components/floating_nav.dart';
import '../components/loading_indicator.dart';
import '../components/error_view.dart';
import '../components/app_network_image.dart';
import '../utils/backend_helper.dart';
import '../services/auth_service.dart';
import '../proto/medialist.pb.dart';

import 'anime_page/tabs/info_tab.dart';
import 'anime_page/tabs/characters_tab.dart';
import 'anime_page/tabs/staff_tab.dart';
import 'anime_page/tabs/media_tab.dart';
import 'anime_page/tabs/placeholder_tab.dart';
import '../components/anime_options_sheet.dart';


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
  final ScrollController _scrollController = ScrollController();

  static const int _cacheCapacity = 10;
  static const String _cacheKeysPref = 'anime_cache_keys';
  static const String _cachePrefix = 'anime_cache_';

  @override
  void initState() {
    super.initState();
    _fetchAnimeDetails();
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

    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.3,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            return AnimeOptionsSheet(
              entry: entry,
              scrollController: scrollController,
            );
          },
        );
      },
    );

    if (result != null && mounted) {
      _didUpdate = true;
      setState(() {
        final newMediaData = Map<String, dynamic>.from(_mediaData!);
        
        newMediaData['mediaListEntry'] = result;
        
        _mediaData = newMediaData;
      });

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        '$_cachePrefix${widget.mediaId}',
        json.encode(_mediaData),
      );
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
        );
      case 3:
        return AnimeCharactersTab(
          mediaId: widget.mediaId,
          scrollController: _scrollController,
          isNested: true,
        );
      case 4:
        return const PlaceholderTab(title: 'Relations Section');
      case 5:
        return const PlaceholderTab(title: 'Rankings Section');
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
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: AppErrorView(
          message: _error ?? 'Anime not found',
          onRetry: () => _fetchAnimeDetails(forceRefresh: true),
        ),
      );
    }

    final media = _mediaData!;
    final title = media['title']?['userPreferred'] ?? 'Unknown';
    final coverImage = media['coverImage'] as Map<String, dynamic>? ?? {};
    final imageUrl =
        coverImage['extraLarge'] ?? coverImage['large'] as String? ?? '';

    final bannerUrl = media['bannerImage'] as String? ?? '';

    final quickNavItems = [
      QuickNavSection(
        icon: Icons.info_outline,
        label: 'Overview',
        onTap: () {
          setState(() => _selectedTabIndex = 0);
          _scrollController.animateTo(0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut);
        },
      ),
      QuickNavSection(
        icon: Icons.perm_media_outlined,
        label: 'Media',
        onTap: () {
          setState(() => _selectedTabIndex = 1);
          _scrollController.animateTo(0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut);
        },
      ),
      QuickNavSection(
        icon: Icons.groups_outlined,
        label: 'Staff',
        onTap: () {
          setState(() => _selectedTabIndex = 2);
          _scrollController.animateTo(0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut);
        },
      ),
      QuickNavSection(
        icon: Icons.account_circle_outlined,
        label: 'Characters',
        onTap: () {
          setState(() => _selectedTabIndex = 3);
          _scrollController.animateTo(0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut);
        },
      ),
      QuickNavSection(
        icon: Icons.shuffle_rounded,
        label: 'Relations',
        onTap: () {
          setState(() => _selectedTabIndex = 4);
          _scrollController.animateTo(0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut);
        },
      ),
      QuickNavSection(
        icon: Icons.leaderboard_outlined,
        label: 'Rankings',
        onTap: () {
          setState(() => _selectedTabIndex = 5);
          _scrollController.animateTo(0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut);
        },
      ),
      QuickNavSection(
        icon: Icons.rate_review_outlined,
        label: 'Reviews',
        onTap: () {
          setState(() => _selectedTabIndex = 6);
          _scrollController.animateTo(0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut);
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
                slivers: [
                  SliverToBoxAdapter(
                    child: _buildBannerAndHeader(
                      title,
                      imageUrl,
                      bannerUrl,
                      media,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: _buildActiveTab(media),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 60),
                  ),
                ],
              ),
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
          child: Icon(
            Icons.edit_rounded,
            color: Colors.white,
            size: 22,
          ),
        ),
      ),
    );
  }

  /// Builds the banner and header information section
  Widget _buildBannerAndHeader(
    String title,
    String imageUrl,
    String bannerUrl,
    Map<String, dynamic> media,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: 280,
              width: double.infinity,
              color: Colors.black,
              child: bannerUrl.isNotEmpty
                  ? AppNetworkImage(
                      imageUrl: bannerUrl,
                      width: double.infinity,
                      height: 280,
                    )
                  : const SizedBox.shrink(),
            ),
            Container(
              height: 281,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.3),
                    Colors.transparent,
                    bgColor.withValues(alpha: 0.8),
                    bgColor,
                  ],
                  stops: const [0.0, 0.4, 0.8, 1.0],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top + 8,
              left: 16,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(_didUpdate),
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (imageUrl.isNotEmpty)
                AppNetworkImage(
                  imageUrl: imageUrl,
                  width: 120,
                  height: 180,
                  borderRadius: BorderRadius.circular(12),
                ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow(Icons.tv_outlined, '${media['format'] ?? 'TV'}'),
                    const SizedBox(height: 8),
                    _buildInfoRow(Icons.timer_outlined, '${media['episodes'] ?? '?'} Episodes'),
                    const SizedBox(height: 8),
                    _buildInfoRow(Icons.rss_feed_rounded, '${media['status'] ?? 'FINISHED'}'),
                    if (media['season'] != null && media['seasonYear'] != null) ...[
                      const SizedBox(height: 8),
                      _buildInfoRow(
                        Icons.calendar_today_rounded,
                        '${media['season']} ${media['seasonYear']}'.toUpperCase(),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds a row of information with an icon and label
  Widget _buildInfoRow(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: 18),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}


