import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../components/error_view.dart';
import '../components/floating_nav.dart';
import '../components/loading_indicator.dart';
import '../components/paged_scroll_listener.dart';
import '../models/media_character.dart';
import '../services/character_service.dart';
import '../theme/theme.dart';
import '../utils/app_navigation.dart';
import 'character_page/tabs/character_info_tab.dart';
import 'character_page/tabs/character_media_tab.dart';
import 'character_page/widgets/character_sticky_header.dart';

/// A page displaying details for a character
class CharacterPage extends StatefulWidget {
  /// The character ID
  final int? characterId;

  /// Initial minimal character data
  final CharacterMin? character;

  /// Creates a character page
  const CharacterPage({super.key, this.characterId, this.character});

  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  final ScrollController _scrollController = ScrollController();
  int _selectedTabIndex = 0;
  bool _isFavouriteLoading = false;
  bool _isLoading = true;
  Character? _character;
  String? _error;

  int _mediaPage = 1;
  bool _hasNextMediaPage = false;
  bool _isFetchingMoreMedia = false;

  @override
  void initState() {
    super.initState();
    _fetchCharacterDetails();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  int? get _resolvedId => widget.characterId ?? widget.character?.id;

  void _onLoadMore() {
    if (_character == null || _isLoading) return;
    if (_selectedTabIndex == 1) {
      _loadMoreMedia();
    }
  }

  Future<void> _fetchCharacterDetails() async {
    final id = _resolvedId;
    if (id == null) {
      setState(() {
        _error = 'Invalid character identifier';
        _isLoading = false;
      });
      return;
    }

    try {
      final data = await CharacterService.getCharacterDetails(id, 1);
      if (mounted) {
        setState(() {
          _character = data;
          _hasNextMediaPage = data.media?.pageInfo.hasNextPage ?? false;
          _mediaPage = 1;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Failed to load character details: $e';
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _loadMoreMedia() async {
    final id = _resolvedId;
    if (_isFetchingMoreMedia ||
        !_hasNextMediaPage ||
        _character == null ||
        id == null) {
      return;
    }

    setState(() {
      _isFetchingMoreMedia = true;
    });

    try {
      final data = await CharacterService.getCharacterDetails(
        id,
        _mediaPage + 1,
      );

      if (mounted) {
        setState(() {
          final currentMedia = _character!.media;
          if (currentMedia != null && data.media != null) {
            final newEdges = [...currentMedia.edges, ...data.media!.edges];
            _character = _character!.copyWith(
              media: CharacterMediaConnection(
                edges: newEdges,
                pageInfo: data.media!.pageInfo,
              ),
            );
          }
          _mediaPage++;
          _hasNextMediaPage = data.media?.pageInfo.hasNextPage ?? false;
          _isFetchingMoreMedia = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isFetchingMoreMedia = false;
        });
      }
    }
  }

  Future<void> _toggleFavourite() async {
    final id = _character?.id ?? _resolvedId;
    if (id == null || _isFavouriteLoading) return;

    setState(() {
      _isFavouriteLoading = true;
    });

    try {
      await CharacterService.toggleFavouriteCharacter(id);
      if (mounted) {
        setState(() {
          final wasFav = _character?.isFavourite ?? false;
          final currentCount = _character?.favourites ?? 0;
          _character = _character?.copyWith(
            isFavourite: !wasFav,
            favourites: !wasFav
                ? currentCount + 1
                : (currentCount > 0 ? currentCount - 1 : 0),
          );
          _isFavouriteLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isFavouriteLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update favourite: $e')),
        );
      }
    }
  }

  void _handleNavTap(int index) {
    AppNavigation.currentTab.value = index;
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  Widget _buildActiveTab() {
    if (_isLoading && _character == null) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 80),
        child: AppLoadingIndicator(topPadding: 0),
      );
    }

    if (_error != null && _character == null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: AppErrorView(
          message: _error!,
          onRetry: () {
            setState(() {
              _isLoading = true;
              _error = null;
            });
            _fetchCharacterDetails();
          },
        ),
      );
    }

    if (_character == null) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 80),
        child: AppLoadingIndicator(topPadding: 0),
      );
    }

    switch (_selectedTabIndex) {
      case 0:
        return CharacterInfoTab(
          character: _character!,
          fallbackMin: widget.character,
        );
      case 1:
        return CharacterMediaTab(
          character: _character!,
          isLoadingMore: _isFetchingMoreMedia,
        );
      default:
        return CharacterInfoTab(
          character: _character!,
          fallbackMin: widget.character,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final characterName =
        _character?.name?.userPreferred ??
        _character?.name?.full ??
        widget.character?.name?.userPreferred ??
        widget.character?.name?.full ??
        'Character';

    final isFav = _character?.isFavourite ?? false;
    final favouritesCount = _character?.favourites ?? 0;

    final quickNavItems = [
      QuickNavSection(
        icon: LucideIcons.info,
        label: 'Info',
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
        icon: LucideIcons.film,
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
    ];

    final hasMore = _selectedTabIndex == 1 && _hasNextMediaPage;
    final isFetchingMore = _selectedTabIndex == 1 && _isFetchingMoreMedia;

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          PagedScrollListener(
            hasMore: hasMore,
            isLoading: isFetchingMore,
            onLoadMore: _onLoadMore,
            child: CustomScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).padding.top + 56 + 16,
                  ),
                ),
                SliverToBoxAdapter(child: _buildActiveTab()),
                const SliverToBoxAdapter(child: SizedBox(height: 128)),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CharacterStickyHeader(
              characterName: characterName,
              onBack: () => Navigator.of(context).pop(),
              isFavourite: isFav,
              favouritesCount: favouritesCount,
              onToggleFavourite: _toggleFavourite,
              isFavouriteLoading: _isFavouriteLoading,
              showFavourite: !_isLoading && _character != null,
            ),
          ),
          Positioned(
            bottom: 24,
            right: 20,
            child: FloatingNav(
              selectedIndex: -1,
              onTap: _handleNavTap,
              quickNavSections: quickNavItems,
            ),
          ),
        ],
      ),
    );
  }
}
