import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../../models/media_misc.dart';
import '../../../../../theme/theme.dart';
import '../../common/active_dropdown.dart';
import '../../common/filter_dropdown.dart';
import '../../common/search_filter_button.dart';
import '../../panels/range_filter_panel.dart';
import '../../rows/adult_row.dart';
import '../../rows/count_duration_row.dart';
import '../../rows/format_status_row.dart';
import '../../rows/genres_tags_row.dart';

/// A component containing filter controls specific to Manga.
class MangaFilters extends StatelessWidget {
  /// Horizontal padding for the filters.
  final double paddingVal;

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

  /// Currently selected minimum year.
  final int? startYearMin;

  /// Currently selected maximum year.
  final int? startYearMax;

  /// LayerLink for anchoring the year dropdown overlay.
  final LayerLink yearLayerLink;

  /// Callback when year range selection changes.
  final void Function(int? min, int? max) onYearChanged;

  /// Currently selected minimum chapter count.
  final int? countMin;

  /// Currently selected maximum chapter count.
  final int? countMax;

  /// Currently selected minimum volume count.
  final int? durationMin;

  /// Currently selected maximum volume count.
  final int? durationMax;

  /// LayerLink for anchoring the chapter count dropdown overlay.
  final LayerLink countLayerLink;

  /// LayerLink for anchoring the volume count dropdown overlay.
  final LayerLink durationLayerLink;

  /// Callback when chapter count range changes.
  final void Function(int? min, int? max) onCountChanged;

  /// Callback when volume count range changes.
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

  /// Creates a Manga filters layout.
  const MangaFilters({
    super.key,
    required this.paddingVal,
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
    required this.startYearMin,
    required this.startYearMax,
    required this.yearLayerLink,
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
  });

  @override
  Widget build(BuildContext context) {
    final bool isYearOpen = activeDropdown == ActiveDropdown.year;
    void toggleYear() => onToggleDropdown(ActiveDropdown.year);

    final String yearLabel;
    final Color yearBorderColor;
    final Color yearBgColor;
    final Color yearTextColor;
    final IconData yearIcon = LucideIcons.calendarDays;
    final Color yearIconColor = (startYearMin == null && startYearMax == null)
        ? textSecondary
        : borderColor;

    if (startYearMin == null && startYearMax == null) {
      yearLabel = 'Year';
      yearBorderColor = isYearOpen ? borderColor : cardBorderColor;
      yearBgColor = Colors.transparent;
      yearTextColor = textPrimary;
    } else {
      if (startYearMin == startYearMax) {
        yearLabel = '$startYearMin';
      } else {
        yearLabel = '$startYearMin - $startYearMax';
      }
      yearBgColor = borderColor.withValues(alpha: 0.15);
      yearBorderColor = borderColor;
      yearTextColor = textPrimary;
    }

    final int currentYearLimit = DateTime.now().year + 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        FormatStatusRow(
          padding: paddingVal,
          formats: formats,
          allowedFormats: const ['MANGA', 'NOVEL', 'ONE_SHOT'],
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingVal),
          child: CompositedTransformTarget(
            link: yearLayerLink,
            child: SizedBox(
              width: double.infinity,
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: [
                  FilterDropdown(
                    layerLink: yearLayerLink,
                    useAnchorAsTarget: false,
                    isOpen: isYearOpen,
                    onTapOutside: toggleYear,
                    anchor: SearchFilterButton(
                      label: yearLabel,
                      onTap: toggleYear,
                      icon: yearIcon,
                      iconColor: yearIconColor,
                      backgroundColor: yearBgColor,
                      borderColor: yearBorderColor,
                      textColor: yearTextColor,
                    ),
                    menu: RangeFilterPanel(
                      title: 'Year Range',
                      minLabel: 'Min Year',
                      maxLabel: 'Max Year',
                      minLimit: 1917.0,
                      maxLimit: currentYearLimit.toDouble(),
                      selectedMin: startYearMin?.toDouble(),
                      selectedMax: startYearMax?.toDouble(),
                      divisions: currentYearLimit - 1917,
                      isDecimal: false,
                      onChanged: (min, max) {
                        onYearChanged(min?.round(), max?.round());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        CountDurationRow(
          padding: paddingVal,
          mediaType: 'MANGA',
          countMin: countMin,
          countMax: countMax,
          durationMin: durationMin,
          durationMax: durationMax,
          isCountOpen: activeDropdown == ActiveDropdown.count,
          isDurationOpen: activeDropdown == ActiveDropdown.duration,
          countLayerLink: countLayerLink,
          durationLayerLink: durationLayerLink,
          toggleCount: () => onToggleDropdown(ActiveDropdown.count),
          toggleDuration: () => onToggleDropdown(ActiveDropdown.duration),
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
    );
  }
}
