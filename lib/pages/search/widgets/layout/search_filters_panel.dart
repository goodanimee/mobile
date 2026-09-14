import 'package:flutter/material.dart';
import '../../../../models/media_misc.dart';
import '../common/active_dropdown.dart';
import 'filter_actions_row.dart';
import 'search_type_selector.dart';
import 'types/anime_filters.dart';
import 'types/manga_filters.dart';

/// A panel containing all filter dropdowns, toggles, selectors, and action buttons.
class SearchFiltersPanel extends StatelessWidget {
  /// Horizontal padding for the panel.
  final double paddingVal;

  /// Currently selected search type (ANIME, MANGA, etc.).
  final String searchType;

  /// Callback when search type selection changes.
  final ValueChanged<String> onSearchTypeChanged;

  /// Animation for sliding filters open and closed.
  final Animation<double> filtersAnimation;

  /// Active formats selection.
  final Map<String, bool?> formats;

  /// Selected media release status.
  final String? status;

  /// Personalized listing filter status.
  final bool? onList;

  /// Current minimum score range value.
  final double? scoreMin;

  /// Current maximum score range value.
  final double? scoreMax;

  /// Currently active dropdown filter.
  final ActiveDropdown? activeDropdown;

  /// LayerLink for anchoring the Format dropdown overlay.
  final LayerLink formatLayerLink;

  /// LayerLink for anchoring the Status dropdown overlay.
  final LayerLink statusLayerLink;

  /// LayerLink for anchoring the Score dropdown overlay.
  final LayerLink scoreLayerLink;

  /// Callback to toggle dropdown filter visibility.
  final void Function(ActiveDropdown type) onToggleDropdown;

  /// Callback when format selection changes.
  final void Function(String key, bool? state) onFormatChanged;

  /// Callback when release status changes.
  final ValueChanged<String?> onStatusChanged;

  /// Callback when onList filter state changes.
  final ValueChanged<bool?> onOnListChanged;

  /// Callback when score range changes.
  final void Function(double? min, double? max) onScoreChanged;

  /// Currently selected season.
  final String? season;

  /// Currently selected minimum year.
  final int? startYearMin;

  /// Currently selected maximum year.
  final int? startYearMax;

  /// LayerLink for anchoring the season dropdown overlay.
  final LayerLink seasonLayerLink;

  /// LayerLink for anchoring the year dropdown overlay.
  final LayerLink yearLayerLink;

  /// Callback when season selection changes.
  final ValueChanged<String?> onSeasonChanged;

  /// Callback when year range selection changes.
  final void Function(int? min, int? max) onYearChanged;

  /// Currently selected minimum count.
  final int? countMin;

  /// Currently selected maximum count.
  final int? countMax;

  /// Currently selected minimum duration/volume limit.
  final int? durationMin;

  /// Currently selected maximum duration/volume limit.
  final int? durationMax;

  /// LayerLink for anchoring the count dropdown overlay.
  final LayerLink countLayerLink;

  /// LayerLink for anchoring the duration dropdown overlay.
  final LayerLink durationLayerLink;

  /// Callback when count range changes.
  final void Function(int? min, int? max) onCountChanged;

  /// Callback when duration range changes.
  final void Function(int? min, int? max) onDurationChanged;

  /// Whether adult content is filtered.
  final bool? isAdult;

  /// Callback when adult filter state changes.
  final ValueChanged<bool?> onAdultChanged;

  /// Active genres selection map.
  final Map<String, bool?> genres;

  /// Active tags selection map.
  final Map<int, bool?> tags;

  /// All available media tags.
  final List<MediaTag> allTags;

  /// Callback to trigger the Genre bottom sheet.
  final VoidCallback showGenreBottomSheet;

  /// Callback to trigger the Tag bottom sheet.
  final VoidCallback showTagBottomSheet;

  /// Whether all filters are currently shown.
  final bool showAllFilters;

  /// Whether there are active filters selected.
  final bool hasActiveFilters;

  /// Callback when the filters visibility toggles.
  final VoidCallback onToggleFilters;

  /// Callback when filters are reset.
  final VoidCallback onReset;

  /// Callback when filters are applied.
  final VoidCallback onApply;

  /// Creates a search filters panel.
  const SearchFiltersPanel({
    super.key,
    required this.paddingVal,
    required this.searchType,
    required this.onSearchTypeChanged,
    required this.filtersAnimation,
    required this.formats,
    required this.status,
    required this.onList,
    required this.scoreMin,
    required this.scoreMax,
    required this.activeDropdown,
    required this.formatLayerLink,
    required this.statusLayerLink,
    required this.scoreLayerLink,
    required this.onToggleDropdown,
    required this.onFormatChanged,
    required this.onStatusChanged,
    required this.onOnListChanged,
    required this.onScoreChanged,
    required this.season,
    required this.startYearMin,
    required this.startYearMax,
    required this.seasonLayerLink,
    required this.yearLayerLink,
    required this.onSeasonChanged,
    required this.onYearChanged,
    required this.countMin,
    required this.countMax,
    required this.durationMin,
    required this.durationMax,
    required this.countLayerLink,
    required this.durationLayerLink,
    required this.onCountChanged,
    required this.onDurationChanged,
    required this.isAdult,
    required this.onAdultChanged,
    required this.genres,
    required this.tags,
    required this.allTags,
    required this.showGenreBottomSheet,
    required this.showTagBottomSheet,
    required this.showAllFilters,
    required this.hasActiveFilters,
    required this.onToggleFilters,
    required this.onReset,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    final bool isStudio = searchType == 'STUDIO';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingVal),
          child: SearchTypeSelector(
            selectedType: searchType,
            onChanged: onSearchTypeChanged,
          ),
        ),
        if (!isStudio) ...[
          ClipRect(
            child: SizeTransition(
              sizeFactor: filtersAnimation,
              alignment: Alignment.topCenter,
              child: _buildTypeSpecificFilters(),
            ),
          ),
          const SizedBox(height: 8.0),
          FilterActionsRow(
            padding: paddingVal,
            showAllFilters: showAllFilters,
            hasActiveFilters: hasActiveFilters,
            onToggleFilters: onToggleFilters,
            onReset: onReset,
            onApply: onApply,
          ),
        ],
      ],
    );
  }

  Widget _buildTypeSpecificFilters() {
    switch (searchType) {
      case 'ANIME':
        return AnimeFilters(
          paddingVal: paddingVal,
          formats: formats,
          status: status,
          onList: onList,
          scoreMin: scoreMin,
          scoreMax: scoreMax,
          activeDropdown: activeDropdown,
          formatLayerLink: formatLayerLink,
          statusLayerLink: statusLayerLink,
          scoreLayerLink: scoreLayerLink,
          onToggleDropdown: onToggleDropdown,
          onFormatChanged: onFormatChanged,
          onStatusChanged: onStatusChanged,
          onOnListChanged: onOnListChanged,
          onScoreChanged: onScoreChanged,
          season: season,
          startYearMin: startYearMin,
          startYearMax: startYearMax,
          seasonLayerLink: seasonLayerLink,
          yearLayerLink: yearLayerLink,
          onSeasonChanged: onSeasonChanged,
          onYearChanged: onYearChanged,
          countMin: countMin,
          countMax: countMax,
          durationMin: durationMin,
          durationMax: durationMax,
          countLayerLink: countLayerLink,
          durationLayerLink: durationLayerLink,
          onCountChanged: onCountChanged,
          onDurationChanged: onDurationChanged,
          isAdult: isAdult,
          onAdultChanged: onAdultChanged,
          genres: genres,
          tags: tags,
          allTags: allTags,
          showGenreBottomSheet: showGenreBottomSheet,
          showTagBottomSheet: showTagBottomSheet,
        );
      case 'MANGA':
        return MangaFilters(
          paddingVal: paddingVal,
          formats: formats,
          status: status,
          onList: onList,
          scoreMin: scoreMin,
          scoreMax: scoreMax,
          activeDropdown: activeDropdown,
          formatLayerLink: formatLayerLink,
          statusLayerLink: statusLayerLink,
          scoreLayerLink: scoreLayerLink,
          onToggleDropdown: onToggleDropdown,
          onFormatChanged: onFormatChanged,
          onStatusChanged: onStatusChanged,
          onOnListChanged: onOnListChanged,
          onScoreChanged: onScoreChanged,
          startYearMin: startYearMin,
          startYearMax: startYearMax,
          yearLayerLink: yearLayerLink,
          onYearChanged: onYearChanged,
          countMin: countMin,
          countMax: countMax,
          durationMin: durationMin,
          durationMax: durationMax,
          countLayerLink: countLayerLink,
          durationLayerLink: durationLayerLink,
          onCountChanged: onCountChanged,
          onDurationChanged: onDurationChanged,
          isAdult: isAdult,
          onAdultChanged: onAdultChanged,
          genres: genres,
          tags: tags,
          allTags: allTags,
          showGenreBottomSheet: showGenreBottomSheet,
          showTagBottomSheet: showTagBottomSheet,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
