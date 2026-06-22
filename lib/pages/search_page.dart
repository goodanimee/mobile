import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../components/app_relation_card.dart';
import '../components/error_view.dart';
import '../components/loading_indicator.dart';
import '../models/media_min.dart';
import '../models/media_misc.dart';
import '../proto/api.pb.dart';
import '../services/genre_service.dart';
import '../services/search_service.dart';
import '../theme/theme.dart';
import '../utils/app_navigation.dart';
import '../utils/utils.dart';
import 'search_page/widgets/adult_row.dart';
import 'search_page/widgets/count_duration_row.dart';
import 'search_page/widgets/format_status_row.dart';
import 'search_page/widgets/genre_filter_sheet.dart';
import 'search_page/widgets/genres_tags_row.dart';
import 'search_page/widgets/media_type_selector.dart';
import 'search_page/widgets/search_sort_menu.dart';
import 'search_page/widgets/search_top_bar.dart';
import 'search_page/widgets/season_year_row.dart';
import 'search_page/widgets/tag_filter_sheet.dart';

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
  String _mediaType = 'ANIME';
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

  bool _isFormatOpen = false;
  bool _isStatusOpen = false;
  bool _isSeasonOpen = false;
  bool _isYearOpen = false;
  bool _isCountOpen = false;
  bool _isDurationOpen = false;
  bool _isScoreOpen = false;
  bool _isSortOpen = false;
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
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.removeListener(_onSearchChanged);
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
            _genres[genre] = null;
          }
          for (final tag in tagsList) {
            _tags[tag.id] = null;
          }
        });
      }
    } catch (_) {}
    await _performSearch();
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

  String? _mapSortOption(String sortBy) {
    switch (sortBy) {
      case 'score_desc':
        return 'SCORE_DESC';
      case 'episodes_desc':
        return 'EPISODES_DESC';
      case 'chapters_desc':
        return 'CHAPTERS_DESC';
      case 'popularity_desc':
        return 'POPULARITY_DESC';
      case 'trending_desc':
        return 'TRENDING_DESC';
      case 'search_match':
      default:
        return null;
    }
  }

  FetchMediaSearchRequest _buildSearchRequest({required int page}) {
    final req = FetchMediaSearchRequest(page: page);
    if (_searchController.text.isNotEmpty) {
      req.query = _searchController.text;
    }
    req.type = _mediaType;

    final mappedSort = _mapSortOption(_sortBy);
    if (mappedSort != null) {
      req.sort.add(mappedSort);
    }

    final includedFormats = _formats.entries
        .where((e) => e.value == true)
        .map((e) => e.key)
        .toList();
    final excludedFormats = _formats.entries
        .where((e) => e.value == false)
        .map((e) => e.key)
        .toList();

    if (includedFormats.length == 1) {
      req.format = includedFormats.first;
    } else if (includedFormats.length > 1) {
      req.formatIn.addAll(includedFormats);
    }

    if (excludedFormats.length == 1) {
      req.formatNot = excludedFormats.first;
    } else if (excludedFormats.length > 1) {
      req.formatNotIn.addAll(excludedFormats);
    }

    if (_status != null) {
      req.status = _status!;
    }
    if (_onList != null) {
      req.onList = _onList!;
    }

    if (_scoreMin != null) {
      req.minAverageScore = _scoreMin!.round();
    }
    if (_scoreMax != null) {
      req.maxAverageScore = _scoreMax!.round();
    }

    if (_season != null) {
      req.season = _season!;
    }

    if (_startYearMin != null) {
      req.minStartDate = _startYearMin!;
    }
    if (_startYearMax != null) {
      req.maxStartDate = _startYearMax!;
    }

    if (_mediaType == 'ANIME') {
      if (_countMin != null) {
        req.minEpisodes = _countMin!;
      }
      if (_countMax != null) {
        req.maxEpisodes = _countMax!;
      }
      if (_durationMin != null) {
        req.minDuration = _durationMin!;
      }
      if (_durationMax != null) {
        req.maxDuration = _durationMax!;
      }
    } else if (_mediaType == 'MANGA') {
      if (_countMin != null) {
        req.minChapters = _countMin!;
      }
      if (_countMax != null) {
        req.maxChapters = _countMax!;
      }
      if (_durationMin != null) {
        req.minVolumes = _durationMin!;
      }
      if (_durationMax != null) {
        req.maxVolumes = _durationMax!;
      }
    }

    if (_isAdult != null) {
      req.isAdult = _isAdult!;
    }

    final includedGenres = _genres.entries
        .where((e) => e.value == true)
        .map((e) => e.key)
        .toList();
    final excludedGenres = _genres.entries
        .where((e) => e.value == false)
        .map((e) => e.key)
        .toList();

    if (includedGenres.isNotEmpty) {
      req.genreIn.addAll(includedGenres);
    }
    if (excludedGenres.isNotEmpty) {
      req.genreNotIn.addAll(excludedGenres);
    }

    final tagInNames = <String>[];
    final tagNotInNames = <String>[];
    _tags.forEach((tagId, value) {
      if (value != null) {
        final tag = _allTags.firstWhere(
          (t) => t.id == tagId,
          orElse: () => const MediaTag(
            id: 0,
            name: '',
            isGeneralSpoiler: false,
            isMediaSpoiler: false,
            rank: 0,
          ),
        );
        if (tag.name.isNotEmpty) {
          if (value == true) {
            tagInNames.add(tag.name);
          } else {
            tagNotInNames.add(tag.name);
          }
        }
      }
    });

    if (tagInNames.isNotEmpty) {
      req.tagIn.addAll(tagInNames);
    }
    if (tagNotInNames.isNotEmpty) {
      req.tagNotIn.addAll(tagNotInNames);
    }

    if (tagInNames.isNotEmpty || tagNotInNames.isNotEmpty) {
      req.minimumTagRank = _minTagPercentage;
    }

    return req;
  }

  Future<void> _performSearch() async {
    if (mounted) {
      setState(() {
        _isSearching = true;
        _searchError = null;
      });
    }
    try {
      final req = _buildSearchRequest(page: 1);
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
    } catch (e) {
      if (mounted) {
        setState(() {
          _searchError = e.toString();
          _mediaResults.clear();
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
      final req = _buildSearchRequest(page: _currentPage + 1);
      final result = await SearchService.searchMedia(req);
      if (mounted) {
        setState(() {
          _mediaResults.addAll(result.media);
          _currentPage++;
          _hasNextPage = result.pageInfo.hasNextPage;
          _isSearchingMore = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isSearchingMore = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double paddingVal = getResponsiveSize(context, 16.0);

    return GestureDetector(
      onTap: () {
        if (_isFormatOpen) {
          _toggleFormat();
        } else if (_isStatusOpen) {
          _toggleStatus();
        } else if (_isSeasonOpen) {
          _toggleSeason();
        } else if (_isYearOpen) {
          _toggleYear();
        } else if (_isCountOpen) {
          _toggleCount();
        } else if (_isDurationOpen) {
          _toggleDuration();
        } else if (_isScoreOpen) {
          _toggleScore();
        } else if (_isSortOpen) {
          _toggleSort();
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
                          SizedBox(height: getResponsiveSize(context, 16.0)),
                          _buildFiltersSection(),
                          SizedBox(height: getResponsiveSize(context, 16.0)),
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
                          SizedBox(height: getResponsiveSize(context, 16.0)),
                          _buildResultsArea(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SearchSortMenu(
                isOpen: _isSortOpen,
                mediaType: _mediaType,
                sortBy: _sortBy,
                sortMenuAnimation: _sortMenuAnimation,
                iconsFade: _iconsFade,
                toggleSort: _toggleSort,
                onSortChanged: (val) {
                  setState(() {
                    _sortBy = val;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
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

      _isFormatOpen = false;
      _isStatusOpen = false;
      _isSeasonOpen = false;
      _isYearOpen = false;
      _isCountOpen = false;
      _isDurationOpen = false;
      _isScoreOpen = false;
    });
  }

  Widget _buildFiltersSection() {
    final double paddingVal = getResponsiveSize(context, 16.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingVal),
          child: MediaTypeSelector(
            selectedType: _mediaType,
            onChanged: (value) {
              setState(() {
                _mediaType = value;
                _countMin = null;
                _countMax = null;
                _durationMin = null;
                _durationMax = null;
              });
            },
          ),
        ),
        ClipRect(
          child: SizeTransition(
            sizeFactor: _filtersAnimation,
            alignment: Alignment.topCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: getResponsiveSize(context, 16.0)),
                FormatStatusRow(
                  padding: paddingVal,
                  formats: _formats,
                  status: _status,
                  onList: _onList,
                  scoreMin: _scoreMin,
                  scoreMax: _scoreMax,
                  isFormatOpen: _isFormatOpen,
                  isStatusOpen: _isStatusOpen,
                  isScoreOpen: _isScoreOpen,
                  formatLayerLink: _formatLayerLink,
                  statusLayerLink: _statusLayerLink,
                  scoreLayerLink: _scoreLayerLink,
                  toggleFormat: _toggleFormat,
                  toggleStatus: _toggleStatus,
                  toggleScore: _toggleScore,
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
                ),
                SizedBox(height: getResponsiveSize(context, 16.0)),
                SeasonYearRow(
                  padding: paddingVal,
                  season: _season,
                  startYearMin: _startYearMin,
                  startYearMax: _startYearMax,
                  isSeasonOpen: _isSeasonOpen,
                  isYearOpen: _isYearOpen,
                  seasonLayerLink: _seasonLayerLink,
                  yearLayerLink: _yearLayerLink,
                  toggleSeason: _toggleSeason,
                  toggleYear: _toggleYear,
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
                ),
                SizedBox(height: getResponsiveSize(context, 16.0)),
                CountDurationRow(
                  padding: paddingVal,
                  mediaType: _mediaType,
                  countMin: _countMin,
                  countMax: _countMax,
                  durationMin: _durationMin,
                  durationMax: _durationMax,
                  isCountOpen: _isCountOpen,
                  isDurationOpen: _isDurationOpen,
                  countLayerLink: _countLayerLink,
                  durationLayerLink: _durationLayerLink,
                  toggleCount: _toggleCount,
                  toggleDuration: _toggleDuration,
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
                ),
                SizedBox(height: getResponsiveSize(context, 16.0)),
                AdultRow(
                  padding: paddingVal,
                  isAdult: _isAdult,
                  onAdultChanged: (val) {
                    setState(() {
                      _isAdult = val;
                    });
                  },
                ),
                SizedBox(height: getResponsiveSize(context, 16.0)),
                GenresTagsRow(
                  padding: paddingVal,
                  genres: _genres,
                  tags: _tags,
                  allTags: _allTags,
                  showGenreBottomSheet: _showGenreBottomSheet,
                  showTagBottomSheet: _showTagBottomSheet,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: getResponsiveSize(context, 8.0)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingVal),
          child: Row(
            children: [
              TextButton(
                onPressed: () {
                  if (_showAllFilters) {
                    _filtersController.reverse();
                    setState(() {
                      _showAllFilters = false;
                      _isFormatOpen = false;
                      _isStatusOpen = false;
                      _isSeasonOpen = false;
                      _isYearOpen = false;
                      _isCountOpen = false;
                      _isDurationOpen = false;
                      _isScoreOpen = false;
                    });
                  } else {
                    setState(() {
                      _showAllFilters = true;
                    });
                    _filtersController.forward();
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _showAllFilters ? 'Hide Filters' : 'Show Filters',
                      style: TextStyle(
                        color: textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: fontSmall(context),
                      ),
                    ),
                    const SizedBox(width: 4.0),
                    Icon(
                      _showAllFilters
                          ? LucideIcons.chevronUp
                          : LucideIcons.chevronDown,
                      color: textPrimary,
                      size: getResponsiveSize(context, 16.0),
                    ),
                  ],
                ),
              ),
              if (_hasActiveFilters()) ...[
                const SizedBox(width: 8.0),
                TextButton(
                  onPressed: _resetAllFilters,
                  child: Text(
                    'Reset',
                    style: TextStyle(
                      color: paletteRed,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSmall(context),
                    ),
                  ),
                ),
              ],
              const Spacer(),
              InkWell(
                onTap: _performSearch,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: borderColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Apply',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
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

  Widget _buildResultsArea() {
    final double paddingVal = getResponsiveSize(context, 16.0);
    if (_isSearching) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40.0),
          child: AppLoadingIndicator(),
        ),
      );
    }
    if (_searchError != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: AppErrorView(message: _searchError!, onRetry: _performSearch),
        ),
      );
    }
    if (_mediaResults.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Text(
            'No results found',
            style: TextStyle(color: textMuted, fontSize: fontBody(context)),
          ),
        ),
      );
    }

    final List<Widget> cards = [];
    for (final media in _mediaResults) {
      final titleText = media.title.userPreferred.isNotEmpty
          ? media.title.userPreferred
          : media.title.romaji.isNotEmpty
          ? media.title.romaji
          : media.title.english.isNotEmpty
          ? media.title.english
          : 'Unknown';

      var subtitle = media.format.replaceAll('_', ' ');
      if (media.type == 'ANIME') {
        if (media.episodes > 0) {
          subtitle +=
              ' \u00B7 ${media.episodes} ${StringUtils.pluralize(media.episodes, "Episode", "Episodes")}';
        }
      } else if (media.type == 'MANGA') {
        if (media.chapters > 0) {
          subtitle +=
              ' \u00B7 ${media.chapters} ${StringUtils.pluralize(media.chapters, "Chapter", "Chapters")}';
        }
      }

      final colorHex = media.coverImage.color;
      final color = ColorUtils.fromHex(colorHex, fallback: Colors.transparent);

      cards.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: SizedBox(
            height: 110,
            child: AppRelationCard(
              imageUrl: media.coverImage.large,
              title: titleText,
              nativeTitle: media.title.native,
              subtitle: subtitle,
              color: color != Colors.transparent ? color : null,
              trailing: media.averageScore > 0
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          LucideIcons.star,
                          color: Colors.amber,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          (media.averageScore / 10).toStringAsFixed(1),
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  : null,
              onTap: () => AppNavigation.toMedia(context, media.id),
            ),
          ),
        ),
      );
    }

    if (_isSearchingMore) {
      cards.add(
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: AppLoadingIndicator(),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingVal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: cards,
      ),
    );
  }

  void _toggleFormat() {
    setState(() {
      _isFormatOpen = !_isFormatOpen;
      _isStatusOpen = false;
      _isSeasonOpen = false;
      _isYearOpen = false;
      _isCountOpen = false;
      _isDurationOpen = false;
      _isScoreOpen = false;
      _isSortOpen = false;
    });
  }

  void _toggleStatus() {
    setState(() {
      _isStatusOpen = !_isStatusOpen;
      _isFormatOpen = false;
      _isSeasonOpen = false;
      _isYearOpen = false;
      _isCountOpen = false;
      _isDurationOpen = false;
      _isScoreOpen = false;
      _isSortOpen = false;
    });
  }

  void _toggleSeason() {
    setState(() {
      _isSeasonOpen = !_isSeasonOpen;
      _isFormatOpen = false;
      _isStatusOpen = false;
      _isYearOpen = false;
      _isCountOpen = false;
      _isDurationOpen = false;
      _isScoreOpen = false;
      _isSortOpen = false;
    });
  }

  void _toggleYear() {
    setState(() {
      _isYearOpen = !_isYearOpen;
      _isFormatOpen = false;
      _isStatusOpen = false;
      _isSeasonOpen = false;
      _isCountOpen = false;
      _isDurationOpen = false;
      _isScoreOpen = false;
      _isSortOpen = false;
    });
  }

  void _toggleCount() {
    setState(() {
      _isCountOpen = !_isCountOpen;
      _isFormatOpen = false;
      _isStatusOpen = false;
      _isSeasonOpen = false;
      _isYearOpen = false;
      _isDurationOpen = false;
      _isScoreOpen = false;
      _isSortOpen = false;
    });
  }

  void _toggleDuration() {
    setState(() {
      _isDurationOpen = !_isDurationOpen;
      _isFormatOpen = false;
      _isStatusOpen = false;
      _isSeasonOpen = false;
      _isYearOpen = false;
      _isCountOpen = false;
      _isScoreOpen = false;
      _isSortOpen = false;
    });
  }

  void _toggleScore() {
    setState(() {
      _isScoreOpen = !_isScoreOpen;
      _isFormatOpen = false;
      _isStatusOpen = false;
      _isSeasonOpen = false;
      _isYearOpen = false;
      _isCountOpen = false;
      _isDurationOpen = false;
      _isSortOpen = false;
    });
  }

  void _toggleSort() {
    if (_isSortOpen) {
      _sortMenuController.reverse().then((_) {
        if (mounted) {
          setState(() {
            _isSortOpen = false;
          });
        }
      });
    } else {
      setState(() {
        _isSortOpen = true;
        _isFormatOpen = false;
        _isStatusOpen = false;
        _isSeasonOpen = false;
        _isYearOpen = false;
        _isCountOpen = false;
        _isDurationOpen = false;
        _isScoreOpen = false;
      });
      _sortMenuController.forward();
    }
  }

  Future<void> _showGenreBottomSheet() async {
    setState(() {
      _isFormatOpen = false;
      _isStatusOpen = false;
      _isSeasonOpen = false;
      _isYearOpen = false;
      _isCountOpen = false;
      _isDurationOpen = false;
      _isScoreOpen = false;
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
      _isFormatOpen = false;
      _isStatusOpen = false;
      _isSeasonOpen = false;
      _isYearOpen = false;
      _isCountOpen = false;
      _isDurationOpen = false;
      _isScoreOpen = false;
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
        color: _isSortOpen || _sortBy != 'search_match'
            ? borderColor
            : textPrimary,
        size: getResponsiveSize(context, 24.0),
      ),
      onPressed: _toggleSort,
    );
  }
}
