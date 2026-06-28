import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../models/media_min.dart';
import '../models/media_misc.dart';
import '../models/media_studio.dart';
import '../proto/api.pb.dart';
import '../services/genre_service.dart';
import '../services/search_service.dart';
import '../theme/theme.dart';
import '../utils/app_navigation.dart';
import 'search_page/utils/search_request_builder.dart';
import 'search_page/widgets/common/active_dropdown.dart';
import 'search_page/widgets/layout/search_filters_panel.dart';
import 'search_page/widgets/layout/search_results_list.dart';
import 'search_page/widgets/layout/search_sort_menu.dart';
import 'search_page/widgets/layout/search_top_bar.dart';
import 'search_page/widgets/layout/studio_results_list.dart';
import 'search_page/widgets/panels/genre_filter_sheet.dart';
import 'search_page/widgets/panels/tag_filter_sheet.dart';

/// A page that allows users to search for media and filter results.
class SearchPage extends StatefulWidget {
  /// Creates a search page.
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _hasSearchText = false;
  String _searchType = 'ANIME';
  bool? _onList;
  final Map<String, bool?> _formats = {
    'TV': null,
    'MOVIE': null,
    'SPECIAL': null,
    'OVA': null,
    'ONA': null,
    'MUSIC': null,
    'MANGA': null,
    'NOVEL': null,
    'ONE_SHOT': null,
  };
  final List<String> _allGenres = [];
  final List<MediaTag> _allTags = [];
  final Map<String, bool?> _genres = {};
  final Map<int, bool?> _tags = {};
  int _minTagPercentage = 18;

  ActiveDropdown? _activeDropdown;
  bool _showAllFilters = true;
  String _sortBy = 'search_match';
  String? _status;
  String? _season;
  int? _startYearMin;
  int? _startYearMax;
  int? _countMin;
  int? _countMax;
  int? _durationMin;
  int? _durationMax;
  double? _scoreMin;
  double? _scoreMax;
  bool? _isAdult;

  final LayerLink _formatLayerLink = LayerLink();
  final LayerLink _statusLayerLink = LayerLink();
  final LayerLink _seasonLayerLink = LayerLink();
  final LayerLink _yearLayerLink = LayerLink();
  final LayerLink _countLayerLink = LayerLink();
  final LayerLink _durationLayerLink = LayerLink();
  final LayerLink _scoreLayerLink = LayerLink();
  late final AnimationController _sortMenuController;
  late final Animation<double> _sortMenuAnimation;
  late final Animation<double> _iconsFade;
  late final AnimationController _filtersController;
  late final Animation<double> _filtersAnimation;

  Timer? _debounceTimer;
  final ScrollController _scrollController = ScrollController();
  final List<MediaMin> _mediaResults = [];
  final List<Studio> _studioResults = [];
  bool _isSearching = false;
  bool _isSearchingMore = false;
  bool _hasNextPage = false;
  int _currentPage = 1;
  String? _searchError;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _loadGenresAndTags();
    _searchController.addListener(_onSearchChanged);
    AppNavigation.pendingFiltersVersion.addListener(_checkPendingFilters);
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
    _filtersController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _filtersAnimation = CurvedAnimation(
      parent: _filtersController,
      curve: Curves.easeInOut,
    );
    _filtersController.value = 1.0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkPendingFilters();
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.removeListener(_onSearchChanged);
    AppNavigation.pendingFiltersVersion.removeListener(_checkPendingFilters);
    _searchController.dispose();
    _searchFocusNode.dispose();
    _sortMenuController.dispose();
    _filtersController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (!_hasNextPage || _isSearchingMore || _isSearching) return;
    final threshold = _scrollController.position.maxScrollExtent - 400;
    if (_scrollController.offset >= threshold) {
      _loadMore();
    }
  }

  Future<void> _loadGenresAndTags() async {
    try {
      final genresList = await GenreService.getGenres();
      final tagsList = await GenreService.getTags();
      if (mounted) {
        setState(() {
          _allGenres.addAll(genresList);
          _allTags.addAll(tagsList);
          for (final genre in genresList) {
            if (!_genres.containsKey(genre)) {
              _genres[genre] = null;
            }
          }
          for (final tag in tagsList) {
            if (!_tags.containsKey(tag.id)) {
              _tags[tag.id] = null;
            }
          }
        });
      }
    } catch (_) {}
    await _performSearch();
  }

  void _checkPendingFilters() {
    if (AppNavigation.pendingGenre != null ||
        AppNavigation.pendingTagName != null) {
      setState(() {
        _onList = null;
        _formats.updateAll((key, val) => null);
        _status = null;
        _season = null;
        _startYearMin = null;
        _startYearMax = null;
        _countMin = null;
        _countMax = null;
        _durationMin = null;
        _durationMax = null;
        _scoreMin = null;
        _scoreMax = null;
        _isAdult = null;
        _genres.updateAll((key, val) => null);
        _tags.updateAll((key, val) => null);
        _minTagPercentage = 18;
        _activeDropdown = null;
        _searchController.clear();
        _hasSearchText = false;
        _studioResults.clear();

        _searchType = AppNavigation.pendingSearchType ?? 'ANIME';

        if (AppNavigation.pendingGenre != null) {
          _genres[AppNavigation.pendingGenre!] = true;
          AppNavigation.pendingGenre = null;
        }

        if (AppNavigation.pendingTagName != null &&
            AppNavigation.pendingTagId != null) {
          _tags[AppNavigation.pendingTagId!] = true;
          final hasTag = _allTags.any(
            (t) => t.id == AppNavigation.pendingTagId,
          );
          if (!hasTag) {
            _allTags.add(
              MediaTag(
                id: AppNavigation.pendingTagId!,
                name: AppNavigation.pendingTagName!,
                rank: 0,
                isGeneralSpoiler: false,
                isMediaSpoiler: false,
              ),
            );
          }
          AppNavigation.pendingTagId = null;
          AppNavigation.pendingTagName = null;
        }
        AppNavigation.pendingSearchType = null;
      });

      _performSearch();
    }
  }

  void _onSearchChanged() {
    final hasText = _searchController.text.isNotEmpty;
    if (hasText != _hasSearchText) {
      setState(() {
        _hasSearchText = hasText;
      });
    }
    _onSearchInputChanged();
  }

  void _onSearchInputChanged() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), _performSearch);
  }

  void _clearSearch() {
    _searchController.clear();
    _searchFocusNode.requestFocus();
  }

  Future<void> _performSearch() async {
    if (mounted) {
      setState(() {
        _isSearching = true;
        _searchError = null;
      });
    }
    try {
      if (_searchType == 'STUDIO') {
        final req = FetchStudioSearchRequest(page: 1);
        if (_searchController.text.isNotEmpty) {
          req.query = _searchController.text;
        }
        final mappedSort = _mapStudioSortOption(_sortBy);
        if (mappedSort != null) {
          req.sort.add(mappedSort);
        }
        final result = await SearchService.searchStudios(req);
        if (mounted) {
          setState(() {
            _studioResults.clear();
            _studioResults.addAll(result.studios);
            _currentPage = 1;
            _hasNextPage = result.pageInfo.hasNextPage;
            _isSearching = false;
          });
        }
      } else {
        final req = buildSearchRequest(
          page: 1,
          query: _searchController.text,
          mediaType: _searchType,
          sortBy: _sortBy,
          formats: _formats,
          status: _status,
          onList: _onList,
          scoreMin: _scoreMin,
          scoreMax: _scoreMax,
          season: _season,
          startYearMin: _startYearMin,
          startYearMax: _startYearMax,
          countMin: _countMin,
          countMax: _countMax,
          durationMin: _durationMin,
          durationMax: _durationMax,
          isAdult: _isAdult,
          genres: _genres,
          tags: _tags,
          allTags: _allTags,
          minTagPercentage: _minTagPercentage,
        );
        final result = await SearchService.searchMedia(req);
        if (mounted) {
          setState(() {
            _mediaResults.clear();
            _mediaResults.addAll(result.media);
            _currentPage = 1;
            _hasNextPage = result.pageInfo.hasNextPage;
            _isSearching = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _searchError = e.toString();
          _mediaResults.clear();
          _studioResults.clear();
          _hasNextPage = false;
          _currentPage = 1;
          _isSearching = false;
        });
      }
    }
  }

  Future<void> _loadMore() async {
    if (_isSearchingMore || !_hasNextPage) return;
    setState(() {
      _isSearchingMore = true;
    });
    try {
      if (_searchType == 'STUDIO') {
        final req = FetchStudioSearchRequest(page: _currentPage + 1);
        if (_searchController.text.isNotEmpty) {
          req.query = _searchController.text;
        }
        final mappedSort = _mapStudioSortOption(_sortBy);
        if (mappedSort != null) {
          req.sort.add(mappedSort);
        }
        final result = await SearchService.searchStudios(req);
        if (mounted) {
          setState(() {
            _studioResults.addAll(result.studios);
            _currentPage++;
            _hasNextPage = result.pageInfo.hasNextPage;
            _isSearchingMore = false;
          });
        }
      } else {
        final req = buildSearchRequest(
          page: _currentPage + 1,
          query: _searchController.text,
          mediaType: _searchType,
          sortBy: _sortBy,
          formats: _formats,
          status: _status,
          onList: _onList,
          scoreMin: _scoreMin,
          scoreMax: _scoreMax,
          season: _season,
          startYearMin: _startYearMin,
          startYearMax: _startYearMax,
          countMin: _countMin,
          countMax: _countMax,
          durationMin: _durationMin,
          durationMax: _durationMax,
          isAdult: _isAdult,
          genres: _genres,
          tags: _tags,
          allTags: _allTags,
          minTagPercentage: _minTagPercentage,
        );
        final result = await SearchService.searchMedia(req);
        if (mounted) {
          setState(() {
            _mediaResults.addAll(result.media);
            _currentPage++;
            _hasNextPage = result.pageInfo.hasNextPage;
            _isSearchingMore = false;
          });
        }
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isSearchingMore = false;
        });
      }
    }
  }

  String? _mapStudioSortOption(String sortBy) {
    switch (sortBy) {
      case 'name':
        return 'NAME';
      case 'name_desc':
        return 'NAME_DESC';
      case 'favourites':
        return 'FAVOURITES';
      case 'favourites_desc':
        return 'FAVOURITES_DESC';
      case 'search_match':
      default:
        return null;
    }
  }

  void _toggleDropdown(ActiveDropdown type) {
    if (type == ActiveDropdown.sort) {
      if (_activeDropdown == ActiveDropdown.sort) {
        _sortMenuController.reverse().then((_) {
          if (mounted) {
            setState(() {
              _activeDropdown = null;
            });
          }
        });
      } else {
        setState(() {
          _activeDropdown = ActiveDropdown.sort;
        });
        _sortMenuController.forward();
      }
      return;
    }

    setState(() {
      if (_activeDropdown == type) {
        _activeDropdown = null;
      } else {
        if (_activeDropdown == ActiveDropdown.sort) {
          _sortMenuController.reverse();
        }
        _activeDropdown = type;
      }
    });
  }

  bool _hasActiveFilters() {
    if (_onList != null) return true;
    if (_formats.values.any((val) => val != null)) return true;
    if (_status != null) return true;
    if (_season != null) return true;
    if (_startYearMin != null || _startYearMax != null) return true;
    if (_countMin != null || _countMax != null) return true;
    if (_durationMin != null || _durationMax != null) return true;
    if (_scoreMin != null || _scoreMax != null) return true;
    if (_isAdult != null) return true;
    if (_genres.values.any((val) => val != null)) return true;
    if (_tags.values.any((val) => val != null)) return true;
    if (_minTagPercentage != 18) return true;
    return false;
  }

  void _resetAllFilters() {
    setState(() {
      _onList = null;
      _formats.updateAll((key, val) => null);
      _status = null;
      _season = null;
      _startYearMin = null;
      _startYearMax = null;
      _countMin = null;
      _countMax = null;
      _durationMin = null;
      _durationMax = null;
      _scoreMin = null;
      _scoreMax = null;
      _isAdult = null;
      _genres.updateAll((key, val) => null);
      _tags.updateAll((key, val) => null);
      _minTagPercentage = 18;
      _activeDropdown = null;
      _studioResults.clear();
    });
  }

  Future<void> _showGenreBottomSheet() async {
    setState(() {
      _activeDropdown = null;
    });

    final Map<String, bool?>? result =
        await showModalBottomSheet<Map<String, bool?>>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (BuildContext context) {
            return DraggableScrollableSheet(
              initialChildSize: 0.65,
              minChildSize: 0.3,
              maxChildSize: 0.85,
              expand: false,
              builder: (context, scrollController) {
                return GenreFilterSheet(
                  initialGenres: _genres,
                  allGenres: _allGenres,
                  scrollController: scrollController,
                );
              },
            );
          },
        );

    if (result != null) {
      setState(() {
        _genres.clear();
        _genres.addAll(result);
      });
    }
  }

  Future<void> _showTagBottomSheet() async {
    setState(() {
      _activeDropdown = null;
    });

    final Map<String, dynamic>? result =
        await showModalBottomSheet<Map<String, dynamic>>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (BuildContext context) {
            return DraggableScrollableSheet(
              initialChildSize: 0.65,
              minChildSize: 0.3,
              maxChildSize: 0.85,
              expand: false,
              builder: (context, scrollController) {
                return TagFilterSheet(
                  initialTags: _tags,
                  initialMinPercentage: _minTagPercentage,
                  allTags: _allTags,
                  scrollController: scrollController,
                );
              },
            );
          },
        );

    if (result != null) {
      setState(() {
        _tags.clear();
        _tags.addAll(result['tags'] as Map<int, bool?>);
        _minTagPercentage = result['minPercentage'] as int;
      });
    }
  }

  Widget _buildSortButton() {
    return IconButton(
      icon: Icon(
        LucideIcons.sortDesc,
        color:
            _activeDropdown == ActiveDropdown.sort || _sortBy != 'search_match'
            ? borderColor
            : textPrimary,
        size: getResponsiveSize(context, 24.0),
      ),
      onPressed: () => _toggleDropdown(ActiveDropdown.sort),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double paddingVal = getResponsiveSize(context, 16.0);

    return GestureDetector(
      onTap: () {
        if (_activeDropdown != null) {
          _toggleDropdown(_activeDropdown!);
        }
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  SearchTopBar(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    hasSearchText: _hasSearchText,
                    onClear: _clearSearch,
                    sortButton: _buildSortButton(),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16.0),
                          SearchFiltersPanel(
                            paddingVal: paddingVal,
                            searchType: _searchType,
                            onSearchTypeChanged: (value) {
                              setState(() {
                                _searchType = value;
                                _countMin = null;
                                _countMax = null;
                                _durationMin = null;
                                _durationMax = null;
                                _formats.updateAll((key, val) => null);
                                _sortBy = 'search_match';
                                _studioResults.clear();
                              });
                              _performSearch();
                            },
                            filtersAnimation: _filtersAnimation,
                            formats: _formats,
                            status: _status,
                            onList: _onList,
                            scoreMin: _scoreMin,
                            scoreMax: _scoreMax,
                            activeDropdown: _activeDropdown,
                            formatLayerLink: _formatLayerLink,
                            statusLayerLink: _statusLayerLink,
                            scoreLayerLink: _scoreLayerLink,
                            onToggleDropdown: _toggleDropdown,
                            onFormatChanged: (key, state) {
                              setState(() {
                                _formats[key] = state;
                              });
                            },
                            onStatusChanged: (status) {
                              setState(() {
                                _status = status;
                              });
                            },
                            onOnListChanged: (val) {
                              setState(() {
                                _onList = val;
                              });
                            },
                            onScoreChanged: (min, max) {
                              setState(() {
                                if (min == 0.0 && max == 10.0) {
                                  _scoreMin = null;
                                  _scoreMax = null;
                                } else {
                                  _scoreMin = min;
                                  _scoreMax = max;
                                }
                              });
                            },
                            season: _season,
                            startYearMin: _startYearMin,
                            startYearMax: _startYearMax,
                            seasonLayerLink: _seasonLayerLink,
                            yearLayerLink: _yearLayerLink,
                            onSeasonChanged: (season) {
                              setState(() {
                                _season = season;
                              });
                            },
                            onYearChanged: (min, max) {
                              setState(() {
                                final int maxLimit = DateTime.now().year + 1;
                                if (min == 1917 && max == maxLimit) {
                                  _startYearMin = null;
                                  _startYearMax = null;
                                } else {
                                  _startYearMin = min;
                                  _startYearMax = max;
                                }
                              });
                            },
                            countMin: _countMin,
                            countMax: _countMax,
                            durationMin: _durationMin,
                            durationMax: _durationMax,
                            countLayerLink: _countLayerLink,
                            durationLayerLink: _durationLayerLink,
                            onCountChanged: (min, max) {
                              setState(() {
                                _countMin = min;
                                _countMax = max;
                              });
                            },
                            onDurationChanged: (min, max) {
                              setState(() {
                                _durationMin = min;
                                _durationMax = max;
                              });
                            },
                            isAdult: _isAdult,
                            onAdultChanged: (val) {
                              setState(() {
                                _isAdult = val;
                              });
                            },
                            genres: _genres,
                            tags: _tags,
                            allTags: _allTags,
                            showGenreBottomSheet: _showGenreBottomSheet,
                            showTagBottomSheet: _showTagBottomSheet,
                            showAllFilters: _showAllFilters,
                            hasActiveFilters: _hasActiveFilters(),
                            onToggleFilters: () {
                              if (_showAllFilters) {
                                _filtersController.reverse();
                                setState(() {
                                  _showAllFilters = false;
                                  _activeDropdown = null;
                                });
                              } else {
                                setState(() {
                                  _showAllFilters = true;
                                });
                                _filtersController.forward();
                              }
                            },
                            onReset: _resetAllFilters,
                            onApply: _performSearch,
                          ),
                          const SizedBox(height: 16.0),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: paddingVal,
                            ),
                            child: const Divider(
                              color: cardBorderColor,
                              height: 1.0,
                              thickness: 1.0,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          if (_searchType == 'STUDIO')
                            StudioResultsList(
                              studioResults: _studioResults,
                              isSearching: _isSearching,
                              isSearchingMore: _isSearchingMore,
                              searchError: _searchError,
                              onRetry: _performSearch,
                            )
                          else
                            SearchResultsList(
                              mediaResults: _mediaResults,
                              isSearching: _isSearching,
                              isSearchingMore: _isSearchingMore,
                              searchError: _searchError,
                              onRetry: _performSearch,
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SearchSortMenu(
                isOpen: _activeDropdown == ActiveDropdown.sort,
                searchType: _searchType,
                sortBy: _sortBy,
                sortMenuAnimation: _sortMenuAnimation,
                iconsFade: _iconsFade,
                toggleSort: () => _toggleDropdown(ActiveDropdown.sort),
                onSortChanged: (val) {
                  setState(() {
                    _sortBy = val;
                  });
                  _performSearch();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
