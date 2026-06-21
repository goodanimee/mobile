import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../theme/theme.dart';
import 'search_page/widgets/filter_dropdown.dart';
import 'search_page/widgets/format_filter_panel.dart';
import 'search_page/widgets/media_type_selector.dart';
import 'search_page/widgets/search_filter_button.dart';
import 'search_page/widgets/search_top_bar.dart';
import 'search_page/widgets/status_filter_panel.dart';

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
  String? _status;

  final LayerLink _formatLayerLink = LayerLink();
  final LayerLink _statusLayerLink = LayerLink();

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
    });
  }

  void _toggleStatus() {
    setState(() {
      _isStatusOpen = !_isStatusOpen;
      if (_isStatusOpen) {
        _isFormatOpen = false;
      }
    });
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
    Widget? formatBadge;

    if (trueCount + falseCount == 0) {
      formatLabel = 'Format';
      formatBorderColor = cardBorderColor;
      formatBgColor = Colors.transparent;
    } else if (trueCount + falseCount == 1) {
      formatLabel = singleSelectedKey!.replaceAll('_', ' ');
      if (singleSelectedState == true) {
        formatBgColor = paletteGreen.withValues(alpha: 0.15);
        formatBorderColor = paletteGreen;
      } else {
        formatBgColor = paletteRed.withValues(alpha: 0.15);
        formatBorderColor = paletteRed;
      }
    } else {
      formatLabel = 'Format';
      formatBorderColor = borderColor;
      formatBgColor = Colors.transparent;
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

    if (_status == null) {
      statusLabel = 'Status';
      statusBorderColor = _isStatusOpen ? borderColor : cardBorderColor;
      statusBgColor = Colors.transparent;
      statusTextColor = textPrimary;
    } else {
      statusLabel = _status!.replaceAll('_', ' ');
      statusBgColor = paletteGreen.withValues(alpha: 0.15);
      statusBorderColor = paletteGreen;
      statusTextColor = textPrimary;
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
}
