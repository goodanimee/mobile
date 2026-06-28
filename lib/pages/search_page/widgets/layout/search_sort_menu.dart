import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../theme/theme.dart';

/// A sort overlay dropdown menu for the search page.
class SearchSortMenu extends StatelessWidget {
  /// Whether the sort menu is currently visible.
  final bool isOpen;

  /// Active search type (ANIME, MANGA, etc.).
  final String searchType;

  /// Currently selected sort option.
  final String sortBy;

  /// Animation for the menu height expansion.
  final Animation<double> sortMenuAnimation;

  /// Animation for the menu icons/text opacity fade.
  final Animation<double> iconsFade;

  /// Callback to toggle or close the sort menu.
  final VoidCallback toggleSort;

  /// Callback when the sort option changes.
  final ValueChanged<String> onSortChanged;

  /// Map of search types to allowed sort options.
  static const Map<String, List<({String type, String label})>> _sortOptions = {
    'ANIME': [
      (type: 'search_match', label: 'Search Match'),
      (type: 'title_romaji', label: 'Title (Asc)'),
      (type: 'title_romaji_desc', label: 'Title (Desc)'),
      (type: 'score_desc', label: 'Highest Score'),
      (type: 'episodes_desc', label: 'Most Episodes'),
      (type: 'popularity_desc', label: 'Most Popular'),
      (type: 'trending_desc', label: 'Trending'),
    ],
    'MANGA': [
      (type: 'search_match', label: 'Search Match'),
      (type: 'title_romaji', label: 'Title (Asc)'),
      (type: 'title_romaji_desc', label: 'Title (Desc)'),
      (type: 'score_desc', label: 'Highest Score'),
      (type: 'chapters_desc', label: 'Most Chapters'),
      (type: 'popularity_desc', label: 'Most Popular'),
      (type: 'trending_desc', label: 'Trending'),
    ],
    'STUDIO': [
      (type: 'search_match', label: 'Search Match'),
      (type: 'name', label: 'Name (Asc)'),
      (type: 'name_desc', label: 'Name (Desc)'),
      (type: 'favourites', label: 'Favourites (Asc)'),
      (type: 'favourites_desc', label: 'Favourites (Desc)'),
    ],
  };

  /// Creates a search sort menu.
  const SearchSortMenu({
    super.key,
    required this.isOpen,
    required this.searchType,
    required this.sortBy,
    required this.sortMenuAnimation,
    required this.iconsFade,
    required this.toggleSort,
    required this.onSortChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (!isOpen) return const SizedBox.shrink();

    final itemHeight = getResponsiveSize(context, 48.0);
    final List<({String type, String label})> options =
        _sortOptions[searchType] ?? _sortOptions['ANIME']!;
    final totalHeight = options.length * itemHeight;
    final menuWidth = getResponsiveSize(context, 160.0);

    return Stack(
      children: [
        GestureDetector(
          onTap: toggleSort,
          behavior: HitTestBehavior.opaque,
          child: const SizedBox.expand(),
        ),
        Positioned(
          top: getResponsiveSize(context, 56.0),
          right: getResponsiveSize(context, 16.0),
          child: AnimatedBuilder(
            animation: sortMenuAnimation,
            builder: (context, _) {
              return Container(
                width: menuWidth,
                height: totalHeight * sortMenuAnimation.value,
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
                    opacity: iconsFade.value,
                    child: OverflowBox(
                      minWidth: menuWidth,
                      maxWidth: menuWidth,
                      minHeight: totalHeight,
                      maxHeight: totalHeight,
                      alignment: Alignment.topCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: options.map((opt) {
                          final isActive = sortBy == opt.type;
                          return GestureDetector(
                            onTap: () {
                              onSortChanged(opt.type);
                              toggleSort();
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
