import 'package:flutter/material.dart';
import '../../../../models/media_misc.dart';
import '../common/active_dropdown.dart';
import '../rows/adult_row.dart';
import '../rows/count_duration_row.dart';
import '../rows/format_status_row.dart';
import '../rows/genres_tags_row.dart';
import '../rows/season_year_row.dart';
import 'filter_actions_row.dart';
import 'media_type_selector.dart';

/// A panel containing all filter dropdowns, toggles, selectors, and action buttons.
class SearchFiltersPanel extends StatelessWidget {
  /// Horizontal padding for the panel.
  final double paddingVal;

  /// Currently selected media type (ANIME or MANGA).
  final String mediaType;

  /// Callback when media type selection changes.
  final ValueChanged<String> onMediaTypeChanged;

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
    required this.mediaType,
    required this.onMediaTypeChanged,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingVal),
          child: MediaTypeSelector(
            selectedType: mediaType,
            onChanged: onMediaTypeChanged,
          ),
        ),
        ClipRect(
          child: SizeTransition(
            sizeFactor: filtersAnimation,
            alignment: Alignment.topCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16.0),
                FormatStatusRow(
                  padding: paddingVal,
                  formats: formats,
                  status: status,
                  onList: onList,
                  scoreMin: scoreMin,
                  scoreMax: scoreMax,
                  isFormatOpen: activeDropdown == ActiveDropdown.format,
                  isStatusOpen: activeDropdown == ActiveDropdown.status,
                  isScoreOpen: activeDropdown == ActiveDropdown.score,
                  formatLayerLink: formatLayerLink,
                  statusLayerLink: statusLayerLink,
                  scoreLayerLink: scoreLayerLink,
                  toggleFormat: () => onToggleDropdown(ActiveDropdown.format),
                  toggleStatus: () => onToggleDropdown(ActiveDropdown.status),
                  toggleScore: () => onToggleDropdown(ActiveDropdown.score),
                  onFormatChanged: onFormatChanged,
                  onStatusChanged: onStatusChanged,
                  onOnListChanged: onOnListChanged,
                  onScoreChanged: onScoreChanged,
                ),
                const SizedBox(height: 16.0),
                SeasonYearRow(
                  padding: paddingVal,
                  season: season,
                  startYearMin: startYearMin,
                  startYearMax: startYearMax,
                  isSeasonOpen: activeDropdown == ActiveDropdown.season,
                  isYearOpen: activeDropdown == ActiveDropdown.year,
                  seasonLayerLink: seasonLayerLink,
                  yearLayerLink: yearLayerLink,
                  toggleSeason: () => onToggleDropdown(ActiveDropdown.season),
                  toggleYear: () => onToggleDropdown(ActiveDropdown.year),
                  onSeasonChanged: onSeasonChanged,
                  onYearChanged: onYearChanged,
                ),
                const SizedBox(height: 16.0),
                CountDurationRow(
                  padding: paddingVal,
                  mediaType: mediaType,
                  countMin: countMin,
                  countMax: countMax,
                  durationMin: durationMin,
                  durationMax: durationMax,
                  isCountOpen: activeDropdown == ActiveDropdown.count,
                  isDurationOpen: activeDropdown == ActiveDropdown.duration,
                  countLayerLink: countLayerLink,
                  durationLayerLink: durationLayerLink,
                  toggleCount: () => onToggleDropdown(ActiveDropdown.count),
                  toggleDuration: () =>
                      onToggleDropdown(ActiveDropdown.duration),
                  onCountChanged: onCountChanged,
                  onDurationChanged: onDurationChanged,
                ),
                const SizedBox(height: 16.0),
                AdultRow(
                  padding: paddingVal,
                  isAdult: isAdult,
                  onAdultChanged: onAdultChanged,
                ),
                const SizedBox(height: 16.0),
                GenresTagsRow(
                  padding: paddingVal,
                  genres: genres,
                  tags: tags,
                  allTags: allTags,
                  showGenreBottomSheet: showGenreBottomSheet,
                  showTagBottomSheet: showTagBottomSheet,
                ),
              ],
            ),
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
    );
  }
}
