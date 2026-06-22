import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../theme/theme.dart';
import 'search_page/widgets/count_filter_panel.dart';
import 'search_page/widgets/duration_filter_panel.dart';
import 'search_page/widgets/filter_dropdown.dart';
import 'search_page/widgets/format_filter_panel.dart';
import 'search_page/widgets/genre_filter_sheet.dart';
import 'search_page/widgets/media_type_selector.dart';
import 'search_page/widgets/score_filter_panel.dart';
import 'search_page/widgets/search_filter_button.dart';
import 'search_page/widgets/search_top_bar.dart';
import 'search_page/widgets/season_filter_panel.dart';
import 'search_page/widgets/status_filter_panel.dart';
import 'search_page/widgets/tag_filter_sheet.dart';
import 'search_page/widgets/year_filter_panel.dart';

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
  final Map<String, bool?> _genres = {
    'Action': null,
    'Adventure': null,
    'Comedy': null,
    'Drama': null,
    'Ecchi': null,
    'Fantasy': null,
    'Hentai': null,
    'Horror': null,
    'Mahou Shoujo': null,
    'Mecha': null,
    'Music': null,
    'Mystery': null,
    'Psychological': null,
    'Romance': null,
    'Sci-Fi': null,
    'Slice of Life': null,
    'Sports': null,
    'Supernatural': null,
    'Thriller': null,
  };
  final Map<int, bool?> _tags = {
    1: null,
    2: null,
    3: null,
    4: null,
    5: null,
    6: null,
    7: null,
    8: null,
    9: null,
    10: null,
  };
  int _minTagPercentage = 18;

  static const List<MediaTag> _allTags = [
    MediaTag(id: 1, name: 'CGI'),
    MediaTag(id: 2, name: 'Magic'),
    MediaTag(id: 3, name: 'Mecha'),
    MediaTag(id: 4, name: 'School'),
    MediaTag(id: 5, name: 'Seinen'),
    MediaTag(id: 6, name: 'Shounen'),
    MediaTag(id: 7, name: 'Super Power'),
    MediaTag(id: 8, name: 'Time Travel'),
    MediaTag(id: 9, name: 'Post-Apocalyptic'),
    MediaTag(id: 10, name: 'Space'),
  ];

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

  @override
  void initState() {
    super.initState();
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
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _searchFocusNode.dispose();
    _sortMenuController.dispose();
    _filtersController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final hasText = _searchController.text.isNotEmpty;
    if (hasText != _hasSearchText) {
      setState(() {
        _hasSearchText = hasText;
      });
    }
  }

  void _clearSearch() {
    _searchController.clear();
    _searchFocusNode.requestFocus();
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
              _buildSortMenuOverlay(),
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
                _buildFormatAndStatusRow(paddingVal),
                SizedBox(height: getResponsiveSize(context, 16.0)),
                _buildSeasonAndYearRow(paddingVal),
                SizedBox(height: getResponsiveSize(context, 16.0)),
                _buildCountAndDurationRow(paddingVal),
                SizedBox(height: getResponsiveSize(context, 16.0)),
                _buildAdultRow(paddingVal),
                SizedBox(height: getResponsiveSize(context, 16.0)),
                _buildGenresAndTagsRow(paddingVal),
              ],
            ),
          ),
        ),
        SizedBox(height: getResponsiveSize(context, 8.0)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingVal),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
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
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOnListButton() {
    final state = _onList;
    final Color bg;
    final Color border;
    final IconData? icon;
    final Color iconColor;

    if (state == null) {
      bg = Colors.transparent;
      border = cardBorderColor;
      icon = null;
      iconColor = Colors.transparent;
    } else if (state == true) {
      bg = paletteGreen.withValues(alpha: 0.15);
      border = paletteGreen;
      icon = LucideIcons.circleCheck;
      iconColor = paletteGreen;
    } else {
      bg = paletteRed.withValues(alpha: 0.15);
      border = paletteRed;
      icon = LucideIcons.circleX;
      iconColor = paletteRed;
    }

    return SearchFilterButton(
      label: 'On my lists',
      onTap: () {
        setState(() {
          if (_onList == null) {
            _onList = true;
          } else if (_onList == true) {
            _onList = false;
          } else {
            _onList = null;
          }
        });
      },
      icon: icon,
      iconColor: iconColor,
      backgroundColor: bg,
      borderColor: border,
      textColor: textPrimary,
    );
  }

  Widget _buildResultsArea() {
    final double paddingVal = getResponsiveSize(context, 16.0);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingVal),
      child: Text(
        'Results will appear here',
        style: TextStyle(color: textMuted, fontSize: fontBody(context)),
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

  IconData _getFormatIcon(String format) {
    switch (format.toUpperCase()) {
      case 'TV':
      case 'TV_SHORT':
        return LucideIcons.monitor;
      case 'MOVIE':
        return LucideIcons.clapperboard;
      case 'SPECIAL':
        return LucideIcons.ticket;
      case 'OVA':
        return LucideIcons.disc;
      case 'ONA':
        return LucideIcons.globe;
      case 'MUSIC':
        return LucideIcons.music;
      case 'MANGA':
        return LucideIcons.bookImage;
      case 'NOVEL':
        return LucideIcons.book;
      case 'ONE_SHOT':
        return LucideIcons.fileText;
      default:
        return LucideIcons.monitor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toUpperCase()) {
      case 'FINISHED':
        return LucideIcons.badgeCheck;
      case 'RELEASING':
        return LucideIcons.activity;
      case 'NOT_YET_RELEASED':
        return LucideIcons.calendar;
      case 'CANCELLED':
        return LucideIcons.badgeX;
      case 'HIATUS':
        return LucideIcons.circlePause;
      default:
        return LucideIcons.helpCircle;
    }
  }

  IconData _getSeasonIcon(String season) {
    switch (season.toUpperCase()) {
      case 'WINTER':
        return LucideIcons.snowflake;
      case 'SPRING':
        return LucideIcons.sprout;
      case 'SUMMER':
        return LucideIcons.sun;
      case 'FALL':
        return LucideIcons.leaf;
      default:
        return LucideIcons.calendar;
    }
  }

  Widget _buildFormatAndStatusRow(double padding) {
    int trueCount = 0;
    int falseCount = 0;
    String? singleSelectedKey;
    bool? singleSelectedState;

    _formats.forEach((key, value) {
      if (value != null) {
        if (value == true) {
          trueCount++;
        } else {
          falseCount++;
        }
        singleSelectedKey = key;
        singleSelectedState = value;
      }
    });

    final String formatLabel;
    final Color formatBorderColor;
    final Color formatBgColor;
    final IconData? formatIcon;
    final Color? formatIconColor;
    Widget? formatBadge;

    if (trueCount + falseCount == 0) {
      formatLabel = 'Format';
      formatBorderColor = cardBorderColor;
      formatBgColor = Colors.transparent;
      formatIcon = null;
      formatIconColor = Colors.transparent;
    } else if (trueCount + falseCount == 1) {
      formatLabel = singleSelectedKey!.replaceAll('_', ' ');
      formatIcon = _getFormatIcon(singleSelectedKey!);
      if (singleSelectedState == true) {
        formatBgColor = paletteGreen.withValues(alpha: 0.15);
        formatBorderColor = paletteGreen;
        formatIconColor = paletteGreen;
      } else {
        formatBgColor = paletteRed.withValues(alpha: 0.15);
        formatBorderColor = paletteRed;
        formatIconColor = paletteRed;
      }
    } else {
      formatLabel = 'Format';
      formatBorderColor = borderColor;
      formatBgColor = Colors.transparent;
      formatIcon = null;
      formatIconColor = Colors.transparent;
      formatBadge = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trueCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 5.0,
                vertical: 1.0,
              ),
              decoration: BoxDecoration(
                color: paletteGreen,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                '$trueCount',
                style: const TextStyle(
                  color: textPrimary,
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (trueCount > 0 && falseCount > 0) const SizedBox(width: 4.0),
          if (falseCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 5.0,
                vertical: 1.0,
              ),
              decoration: BoxDecoration(
                color: paletteRed,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                '$falseCount',
                style: const TextStyle(
                  color: textPrimary,
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      );
    }

    final String statusLabel;
    final Color statusBorderColor;
    final Color statusBgColor;
    final Color statusTextColor;
    final IconData? statusIcon;
    final Color? statusIconColor;

    if (_status == null) {
      statusLabel = 'Status';
      statusBorderColor = _isStatusOpen ? borderColor : cardBorderColor;
      statusBgColor = Colors.transparent;
      statusTextColor = textPrimary;
      statusIcon = null;
      statusIconColor = Colors.transparent;
    } else {
      statusLabel = _status!.replaceAll('_', ' ');
      statusBgColor = borderColor.withValues(alpha: 0.15);
      statusBorderColor = borderColor;
      statusTextColor = textPrimary;
      statusIcon = _getStatusIcon(_status!);
      statusIconColor = borderColor;
    }

    final String scoreLabel;
    final Color scoreBorderColor;
    final Color scoreBgColor;
    final Color scoreTextColor;
    final IconData scoreIcon = LucideIcons.star;
    final Color scoreIconColor = (_scoreMin == null && _scoreMax == null)
        ? textSecondary
        : borderColor;

    if (_scoreMin == null && _scoreMax == null) {
      scoreLabel = 'Score';
      scoreBorderColor = _isScoreOpen ? borderColor : cardBorderColor;
      scoreBgColor = Colors.transparent;
      scoreTextColor = textPrimary;
    } else {
      final String minStr = _scoreMin!.toStringAsFixed(1);
      final String maxStr = _scoreMax!.toStringAsFixed(1);
      if (_scoreMin == _scoreMax) {
        scoreLabel = minStr;
      } else {
        scoreLabel = '$minStr - $maxStr';
      }
      scoreBgColor = borderColor.withValues(alpha: 0.15);
      scoreBorderColor = borderColor;
      scoreTextColor = textPrimary;
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: CompositedTransformTarget(
        link: _formatLayerLink,
        child: CompositedTransformTarget(
          link: _statusLayerLink,
          child: CompositedTransformTarget(
            link: _scoreLayerLink,
            child: SizedBox(
              width: double.infinity,
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: [
                  FilterDropdown(
                    layerLink: _formatLayerLink,
                    useAnchorAsTarget: false,
                    isOpen: _isFormatOpen,
                    onTapOutside: _toggleFormat,
                    anchor: SearchFilterButton(
                      label: formatLabel,
                      onTap: _toggleFormat,
                      icon: formatIcon,
                      iconColor: formatIconColor,
                      backgroundColor: formatBgColor,
                      borderColor: _isFormatOpen
                          ? borderColor
                          : formatBorderColor,
                      textColor: textPrimary,
                      badge: formatBadge,
                    ),
                    menu: FormatFilterPanel(
                      formats: _formats,
                      onChanged: (key, state) {
                        setState(() {
                          _formats[key] = state;
                        });
                      },
                    ),
                  ),
                  FilterDropdown(
                    layerLink: _statusLayerLink,
                    useAnchorAsTarget: false,
                    isOpen: _isStatusOpen,
                    onTapOutside: _toggleStatus,
                    anchor: SearchFilterButton(
                      label: statusLabel,
                      onTap: _toggleStatus,
                      icon: statusIcon,
                      iconColor: statusIconColor,
                      backgroundColor: statusBgColor,
                      borderColor: statusBorderColor,
                      textColor: statusTextColor,
                    ),
                    menu: StatusFilterPanel(
                      selectedStatus: _status,
                      onChanged: (status) {
                        setState(() {
                          _status = status;
                        });
                      },
                    ),
                  ),
                  _buildOnListButton(),
                  FilterDropdown(
                    layerLink: _scoreLayerLink,
                    useAnchorAsTarget: false,
                    isOpen: _isScoreOpen,
                    onTapOutside: _toggleScore,
                    anchor: SearchFilterButton(
                      label: scoreLabel,
                      onTap: _toggleScore,
                      icon: scoreIcon,
                      iconColor: scoreIconColor,
                      backgroundColor: scoreBgColor,
                      borderColor: scoreBorderColor,
                      textColor: scoreTextColor,
                    ),
                    menu: ScoreFilterPanel(
                      selectedMin: _scoreMin,
                      selectedMax: _scoreMax,
                      onChanged: (min, max) {
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSeasonAndYearRow(double padding) {
    final String seasonLabel;
    final Color seasonBorderColor;
    final Color seasonBgColor;
    final Color seasonTextColor;
    final IconData? seasonIcon;
    final Color? seasonIconColor;

    if (_season == null) {
      seasonLabel = 'Season';
      seasonBorderColor = _isSeasonOpen ? borderColor : cardBorderColor;
      seasonBgColor = Colors.transparent;
      seasonTextColor = textPrimary;
      seasonIcon = null;
      seasonIconColor = Colors.transparent;
    } else {
      seasonLabel = _season!;
      seasonBgColor = borderColor.withValues(alpha: 0.15);
      seasonBorderColor = borderColor;
      seasonTextColor = textPrimary;
      seasonIcon = _getSeasonIcon(_season!);
      seasonIconColor = borderColor;
    }

    final String yearLabel;
    final Color yearBorderColor;
    final Color yearBgColor;
    final Color yearTextColor;
    final IconData yearIcon = LucideIcons.calendarDays;
    final Color yearIconColor = (_startYearMin == null && _startYearMax == null)
        ? textSecondary
        : borderColor;

    if (_startYearMin == null && _startYearMax == null) {
      yearLabel = 'Year';
      yearBorderColor = _isYearOpen ? borderColor : cardBorderColor;
      yearBgColor = Colors.transparent;
      yearTextColor = textPrimary;
    } else {
      if (_startYearMin == _startYearMax) {
        yearLabel = '$_startYearMin';
      } else {
        yearLabel = '$_startYearMin - $_startYearMax';
      }
      yearBgColor = borderColor.withValues(alpha: 0.15);
      yearBorderColor = borderColor;
      yearTextColor = textPrimary;
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: CompositedTransformTarget(
        link: _seasonLayerLink,
        child: CompositedTransformTarget(
          link: _yearLayerLink,
          child: SizedBox(
            width: double.infinity,
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                FilterDropdown(
                  layerLink: _seasonLayerLink,
                  useAnchorAsTarget: false,
                  isOpen: _isSeasonOpen,
                  onTapOutside: _toggleSeason,
                  anchor: SearchFilterButton(
                    label: seasonLabel,
                    onTap: _toggleSeason,
                    icon: seasonIcon,
                    iconColor: seasonIconColor,
                    backgroundColor: seasonBgColor,
                    borderColor: seasonBorderColor,
                    textColor: seasonTextColor,
                  ),
                  menu: SeasonFilterPanel(
                    selectedSeason: _season,
                    onChanged: (season) {
                      setState(() {
                        _season = season;
                      });
                    },
                  ),
                ),
                FilterDropdown(
                  layerLink: _yearLayerLink,
                  useAnchorAsTarget: false,
                  isOpen: _isYearOpen,
                  onTapOutside: _toggleYear,
                  anchor: SearchFilterButton(
                    label: yearLabel,
                    onTap: _toggleYear,
                    icon: yearIcon,
                    iconColor: yearIconColor,
                    backgroundColor: yearBgColor,
                    borderColor: yearBorderColor,
                    textColor: yearTextColor,
                  ),
                  menu: YearFilterPanel(
                    selectedMin: _startYearMin,
                    selectedMax: _startYearMax,
                    onChanged: (min, max) {
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCountAndDurationRow(double padding) {
    final String countLabel;
    final Color countBorderColor;
    final Color countBgColor;
    final Color countTextColor;
    final IconData countIcon = _mediaType == 'ANIME'
        ? LucideIcons.tvMinimalPlay
        : LucideIcons.bookOpen;
    final Color countIconColor = (_countMin == null && _countMax == null)
        ? textSecondary
        : borderColor;

    final String countDefaultLabel = _mediaType == 'ANIME'
        ? 'Episodes'
        : 'Chapters';

    if (_countMin == null && _countMax == null) {
      countLabel = countDefaultLabel;
      countBorderColor = _isCountOpen ? borderColor : cardBorderColor;
      countBgColor = Colors.transparent;
      countTextColor = textPrimary;
    } else {
      if (_countMin == _countMax) {
        countLabel = '$_countMin';
      } else {
        countLabel = '$_countMin - $_countMax';
      }
      countBgColor = borderColor.withValues(alpha: 0.15);
      countBorderColor = borderColor;
      countTextColor = textPrimary;
    }

    final String durationDefaultLabel = _mediaType == 'ANIME'
        ? 'Duration'
        : 'Volumes';
    final String durationLabel;
    final Color durationBorderColor;
    final Color durationBgColor;
    final Color durationTextColor;
    final IconData durationIcon = _mediaType == 'ANIME'
        ? LucideIcons.clock
        : LucideIcons.bookCopy;
    final Color durationIconColor =
        (_durationMin == null && _durationMax == null)
        ? textSecondary
        : borderColor;

    if (_durationMin == null && _durationMax == null) {
      durationLabel = durationDefaultLabel;
      durationBorderColor = _isDurationOpen ? borderColor : cardBorderColor;
      durationBgColor = Colors.transparent;
      durationTextColor = textPrimary;
    } else {
      if (_durationMin == _durationMax) {
        durationLabel = '$_durationMin';
      } else {
        durationLabel = '$_durationMin - $_durationMax';
      }
      durationBgColor = borderColor.withValues(alpha: 0.15);
      durationBorderColor = borderColor;
      durationTextColor = textPrimary;
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: CompositedTransformTarget(
        link: _countLayerLink,
        child: CompositedTransformTarget(
          link: _durationLayerLink,
          child: SizedBox(
            width: double.infinity,
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                FilterDropdown(
                  layerLink: _countLayerLink,
                  useAnchorAsTarget: false,
                  isOpen: _isCountOpen,
                  onTapOutside: _toggleCount,
                  anchor: SearchFilterButton(
                    label: countLabel,
                    onTap: _toggleCount,
                    icon: countIcon,
                    iconColor: countIconColor,
                    backgroundColor: countBgColor,
                    borderColor: countBorderColor,
                    textColor: countTextColor,
                  ),
                  menu: CountFilterPanel(
                    selectedMin: _countMin,
                    selectedMax: _countMax,
                    mediaType: _mediaType,
                    onChanged: (min, max) {
                      setState(() {
                        if (min == 0 && max == 500) {
                          _countMin = null;
                          _countMax = null;
                        } else {
                          _countMin = min;
                          _countMax = max;
                        }
                      });
                    },
                  ),
                ),
                FilterDropdown(
                  layerLink: _durationLayerLink,
                  useAnchorAsTarget: false,
                  isOpen: _isDurationOpen,
                  onTapOutside: _toggleDuration,
                  anchor: SearchFilterButton(
                    label: durationLabel,
                    onTap: _toggleDuration,
                    icon: durationIcon,
                    iconColor: durationIconColor,
                    backgroundColor: durationBgColor,
                    borderColor: durationBorderColor,
                    textColor: durationTextColor,
                  ),
                  menu: DurationFilterPanel(
                    selectedMin: _durationMin,
                    selectedMax: _durationMax,
                    mediaType: _mediaType,
                    onChanged: (min, max) {
                      setState(() {
                        if (min == 0 && max == 200) {
                          _durationMin = null;
                          _durationMax = null;
                        } else {
                          _durationMin = min;
                          _durationMax = max;
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAdultRow(double padding) {
    final Color adultBg;
    final Color adultBorder;
    final String adultLabel;
    final IconData adultIcon = LucideIcons.shieldAlert;
    final Color adultIconColor;

    if (_isAdult == null) {
      adultBg = Colors.transparent;
      adultBorder = cardBorderColor;
      adultIconColor = textSecondary;
      adultLabel = 'Adult';
    } else if (_isAdult == true) {
      adultBg = paletteGreen.withValues(alpha: 0.15);
      adultBorder = paletteGreen;
      adultIconColor = paletteGreen;
      adultLabel = 'Adult';
    } else {
      adultBg = paletteRed.withValues(alpha: 0.15);
      adultBorder = paletteRed;
      adultIconColor = paletteRed;
      adultLabel = 'Adult';
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: SizedBox(
        width: double.infinity,
        child: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            SearchFilterButton(
              label: adultLabel,
              onTap: () {
                setState(() {
                  if (_isAdult == null) {
                    _isAdult = true;
                  } else if (_isAdult == true) {
                    _isAdult = false;
                  } else {
                    _isAdult = null;
                  }
                });
              },
              icon: adultIcon,
              iconColor: adultIconColor,
              backgroundColor: adultBg,
              borderColor: adultBorder,
              textColor: textPrimary,
            ),
          ],
        ),
      ),
    );
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

  Widget _buildGenresAndTagsRow(double padding) {
    int trueCount = 0;
    int falseCount = 0;
    String? singleSelectedKey;
    bool? singleSelectedState;

    _genres.forEach((key, value) {
      if (value != null) {
        if (value == true) {
          trueCount++;
        } else {
          falseCount++;
        }
        singleSelectedKey = key;
        singleSelectedState = value;
      }
    });

    final String genreLabel;
    final Color genreBorderColor;
    final Color genreBgColor;
    final IconData? genreIcon;
    final Color? genreIconColor;
    Widget? genreBadge;

    if (trueCount + falseCount == 0) {
      genreLabel = 'Genres';
      genreBorderColor = cardBorderColor;
      genreBgColor = Colors.transparent;
      genreIcon = null;
      genreIconColor = Colors.transparent;
      genreBadge = Icon(
        LucideIcons.plus,
        color: textSecondary,
        size: getResponsiveSize(context, 14.0),
      );
    } else if (trueCount + falseCount == 1) {
      genreLabel = singleSelectedKey!;
      if (singleSelectedState == true) {
        genreBgColor = paletteGreen.withValues(alpha: 0.15);
        genreBorderColor = paletteGreen;
        genreIcon = LucideIcons.circleCheck;
        genreIconColor = paletteGreen;
      } else {
        genreBgColor = paletteRed.withValues(alpha: 0.15);
        genreBorderColor = paletteRed;
        genreIcon = LucideIcons.circleX;
        genreIconColor = paletteRed;
      }
    } else {
      genreLabel = 'Genres';
      genreBorderColor = borderColor;
      genreBgColor = Colors.transparent;
      genreIcon = null;
      genreIconColor = Colors.transparent;
      genreBadge = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trueCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 5.0,
                vertical: 1.0,
              ),
              decoration: BoxDecoration(
                color: paletteGreen,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                '$trueCount',
                style: const TextStyle(
                  color: textPrimary,
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (trueCount > 0 && falseCount > 0) const SizedBox(width: 4.0),
          if (falseCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 5.0,
                vertical: 1.0,
              ),
              decoration: BoxDecoration(
                color: paletteRed,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                '$falseCount',
                style: const TextStyle(
                  color: textPrimary,
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      );
    }

    int tagTrueCount = 0;
    int tagFalseCount = 0;
    int? singleSelectedTagId;
    bool? singleSelectedTagState;

    _tags.forEach((key, value) {
      if (value != null) {
        if (value == true) {
          tagTrueCount++;
        } else {
          tagFalseCount++;
        }
        singleSelectedTagId = key;
        singleSelectedTagState = value;
      }
    });

    final String tagLabel;
    final Color tagBorderColor;
    final Color tagBgColor;
    final IconData? tagIcon;
    final Color? tagIconColor;
    Widget? tagBadge;

    if (tagTrueCount + tagFalseCount == 0) {
      tagLabel = 'Tags';
      tagBorderColor = cardBorderColor;
      tagBgColor = Colors.transparent;
      tagIcon = null;
      tagIconColor = Colors.transparent;
      tagBadge = Icon(
        LucideIcons.plus,
        color: textSecondary,
        size: getResponsiveSize(context, 14.0),
      );
    } else if (tagTrueCount + tagFalseCount == 1) {
      final tagObj = _allTags.firstWhere((t) => t.id == singleSelectedTagId);
      tagLabel = tagObj.name;
      if (singleSelectedTagState == true) {
        tagBgColor = paletteGreen.withValues(alpha: 0.15);
        tagBorderColor = paletteGreen;
        tagIcon = LucideIcons.circleCheck;
        tagIconColor = paletteGreen;
      } else {
        tagBgColor = paletteRed.withValues(alpha: 0.15);
        tagBorderColor = paletteRed;
        tagIcon = LucideIcons.circleX;
        tagIconColor = paletteRed;
      }
    } else {
      tagLabel = 'Tags';
      tagBorderColor = borderColor;
      tagBgColor = Colors.transparent;
      tagIcon = null;
      tagIconColor = Colors.transparent;
      tagBadge = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (tagTrueCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 5.0,
                vertical: 1.0,
              ),
              decoration: BoxDecoration(
                color: paletteGreen,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                '$tagTrueCount',
                style: const TextStyle(
                  color: textPrimary,
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (tagTrueCount > 0 && tagFalseCount > 0) const SizedBox(width: 4.0),
          if (tagFalseCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 5.0,
                vertical: 1.0,
              ),
              decoration: BoxDecoration(
                color: paletteRed,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                '$tagFalseCount',
                style: const TextStyle(
                  color: textPrimary,
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: SizedBox(
        width: double.infinity,
        child: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            SearchFilterButton(
              label: genreLabel,
              onTap: _showGenreBottomSheet,
              icon: genreIcon,
              iconColor: genreIconColor,
              backgroundColor: genreBgColor,
              borderColor: genreBorderColor,
              textColor: textPrimary,
              badge: genreBadge,
            ),
            SearchFilterButton(
              label: tagLabel,
              onTap: _showTagBottomSheet,
              icon: tagIcon,
              iconColor: tagIconColor,
              backgroundColor: tagBgColor,
              borderColor: tagBorderColor,
              textColor: textPrimary,
              badge: tagBadge,
            ),
          ],
        ),
      ),
    );
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

  Widget _buildSortMenuOverlay() {
    if (!_isSortOpen) return const SizedBox.shrink();

    final itemHeight = getResponsiveSize(context, 48.0);
    final List<({String type, String label})> options = [
      (type: 'search_match', label: 'Search Match'),
      (type: 'score_desc', label: 'Highest Score'),
      if (_mediaType == 'ANIME')
        (type: 'episodes_desc', label: 'Most Episodes')
      else
        (type: 'chapters_desc', label: 'Most Chapters'),
      (type: 'popularity_desc', label: 'Most Popular'),
      (type: 'trending_desc', label: 'Trending'),
    ];
    final totalHeight = options.length * itemHeight;
    final menuWidth = getResponsiveSize(context, 160.0);

    return Stack(
      children: [
        GestureDetector(
          onTap: _toggleSort,
          behavior: HitTestBehavior.opaque,
          child: const SizedBox.expand(),
        ),
        Positioned(
          top: getResponsiveSize(context, 56.0),
          right: getResponsiveSize(context, 16.0),
          child: AnimatedBuilder(
            animation: _sortMenuController,
            builder: (context, _) {
              return Container(
                width: menuWidth,
                height: totalHeight * _sortMenuAnimation.value,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: cardBorderColor),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.5),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Opacity(
                    opacity: _iconsFade.value,
                    child: OverflowBox(
                      minWidth: menuWidth,
                      maxWidth: menuWidth,
                      minHeight: totalHeight,
                      maxHeight: totalHeight,
                      alignment: Alignment.topCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: options.map((opt) {
                          final isActive = _sortBy == opt.type;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _sortBy = opt.type;
                              });
                              _toggleSort();
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              width: double.infinity,
                              height: itemHeight,
                              color: isActive
                                  ? hoverBgColor
                                  : Colors.transparent,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      opt.label,
                                      style: TextStyle(
                                        color: isActive
                                            ? borderColor
                                            : textPrimary,
                                        fontSize: fontBody(context),
                                        fontWeight: isActive
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  if (isActive)
                                    Icon(
                                      LucideIcons.check,
                                      size: getResponsiveSize(context, 16.0),
                                      color: borderColor,
                                    ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
