import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../theme/theme.dart';
import 'search_page/widgets/filter_dropdown.dart';
import 'search_page/widgets/format_filter_panel.dart';
import 'search_page/widgets/media_type_selector.dart';
import 'search_page/widgets/search_filter_button.dart';
import 'search_page/widgets/search_top_bar.dart';
import 'search_page/widgets/season_filter_panel.dart';
import 'search_page/widgets/status_filter_panel.dart';
import 'search_page/widgets/year_filter_panel.dart';

/// A page that allows users to search for media and filter results.
class SearchPage extends StatefulWidget {
  /// Creates a search page.
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
  bool _isFormatOpen = false;
  bool _isStatusOpen = false;
  bool _isSeasonOpen = false;
  bool _isYearOpen = false;
  String? _status;
  String? _season;
  int? _startYearMin;
  int? _startYearMax;

  final LayerLink _formatLayerLink = LayerLink();
  final LayerLink _statusLayerLink = LayerLink();
  final LayerLink _seasonLayerLink = LayerLink();
  final LayerLink _yearLayerLink = LayerLink();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _searchFocusNode.dispose();
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
        }
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: Column(
            children: [
              SearchTopBar(
                controller: _searchController,
                focusNode: _searchFocusNode,
                hasSearchText: _hasSearchText,
                onClear: _clearSearch,
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
                        padding: EdgeInsets.symmetric(horizontal: paddingVal),
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
        ),
      ),
    );
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
              });
            },
          ),
        ),
        SizedBox(height: getResponsiveSize(context, 16.0)),
        _buildFormatAndStatusRow(paddingVal),
        SizedBox(height: getResponsiveSize(context, 16.0)),
        _buildSeasonAndYearRow(paddingVal),
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
    });
  }

  void _toggleStatus() {
    setState(() {
      _isStatusOpen = !_isStatusOpen;
      _isFormatOpen = false;
      _isSeasonOpen = false;
      _isYearOpen = false;
    });
  }

  void _toggleSeason() {
    setState(() {
      _isSeasonOpen = !_isSeasonOpen;
      _isFormatOpen = false;
      _isStatusOpen = false;
      _isYearOpen = false;
    });
  }

  void _toggleYear() {
    setState(() {
      _isYearOpen = !_isYearOpen;
      _isFormatOpen = false;
      _isStatusOpen = false;
      _isSeasonOpen = false;
    });
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
      statusBgColor = paletteGreen.withValues(alpha: 0.15);
      statusBorderColor = paletteGreen;
      statusTextColor = textPrimary;
      statusIcon = _getStatusIcon(_status!);
      statusIconColor = paletteGreen;
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: CompositedTransformTarget(
        link: _formatLayerLink,
        child: CompositedTransformTarget(
          link: _statusLayerLink,
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
              ],
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
      seasonBgColor = paletteGreen.withValues(alpha: 0.15);
      seasonBorderColor = paletteGreen;
      seasonTextColor = textPrimary;
      seasonIcon = _getSeasonIcon(_season!);
      seasonIconColor = paletteGreen;
    }

    final String yearLabel;
    final Color yearBorderColor;
    final Color yearBgColor;
    final Color yearTextColor;

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
      yearBgColor = paletteGreen.withValues(alpha: 0.15);
      yearBorderColor = paletteGreen;
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
}
