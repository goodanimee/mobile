import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../components/detail_header.dart';
import '../components/error_view.dart';
import '../components/floating_nav.dart';
import '../components/paged_scroll_listener.dart';
import '../components/skeleton.dart';
import '../models/media_character.dart';
import '../services/character_service.dart';
import '../theme/theme.dart';
import '../utils/app_navigation.dart';
import 'character_page/tabs/character_info_tab.dart';
import 'character_page/tabs/character_media_tab.dart';
import 'character_page/widgets/character_language_fab.dart';
import 'character_page/widgets/character_language_sheet.dart';

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
  String _selectedLanguage = 'Japanese';

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

  List<String> get _availableLanguages {
    final edges = _character?.media?.edges ?? [];
    final languages = <String>{};
    for (final edge in edges) {
      for (final va in edge.voiceActors) {
        if (va.languageV2 != null && va.languageV2!.isNotEmpty) {
          languages.add(va.languageV2!);
        }
      }
    }
    final list = languages.toList();
    list.sort((a, b) {
      if (a.toLowerCase() == 'japanese') return -1;
      if (b.toLowerCase() == 'japanese') return 1;
      return a.compareTo(b);
    });
    return list;
  }

  void _showLanguageSelector() {
    final languages = _availableLanguages;
    if (languages.isEmpty) return;

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => CharacterLanguageSheet(
        languages: languages,
        selectedLanguage: _selectedLanguage,
        onLanguageSelected: (language) {
          setState(() {
            _selectedLanguage = language;
          });
        },
      ),
    );
  }

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

  Widget _buildActiveTab() {
    if (_isLoading && _character == null) {
      return Skeleton.tabContent();
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
      return Skeleton.tabContent();
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
          selectedLanguage: _selectedLanguage,
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

    final quickNavItems = QuickNavSection.fromTabs(
      tabs: const [
        (icon: LucideIcons.info, label: 'Info'),
        (icon: LucideIcons.film, label: 'Media'),
      ],
      selectedIndex: _selectedTabIndex,
      onSelect: (index) => setState(() => _selectedTabIndex = index),
      scrollController: _scrollController,
    );

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
            child: DetailHeader(
              title: characterName,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                CharacterLanguageFab(
                  isVisible:
                      _selectedTabIndex == 1 && _availableLanguages.isNotEmpty,
                  onTap: _showLanguageSelector,
                ),
                FloatingNav(
                  selectedIndex: -1,
                  onTap: (index) => AppNavigation.handleNavTap(context, index),
                  quickNavSections: quickNavItems,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
