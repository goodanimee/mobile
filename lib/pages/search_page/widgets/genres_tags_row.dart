import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../models/media_misc.dart';
import '../../../theme/theme.dart';
import 'search_filter_button.dart';

/// A row widget containing the Genres and Tags filters.
class GenresTagsRow extends StatelessWidget {
  /// Horizontal padding for the row.
  final double padding;

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

  /// Creates a genres and tags filter row.
  const GenresTagsRow({
    super.key,
    required this.padding,
    required this.genres,
    required this.tags,
    required this.allTags,
    required this.showGenreBottomSheet,
    required this.showTagBottomSheet,
  });

  @override
  Widget build(BuildContext context) {
    int trueCount = 0;
    int falseCount = 0;
    String? singleSelectedKey;
    bool? singleSelectedState;

    genres.forEach((key, value) {
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

    tags.forEach((key, value) {
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
      final tagObj = allTags.firstWhere((t) => t.id == singleSelectedTagId);
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
              onTap: showGenreBottomSheet,
              icon: genreIcon,
              iconColor: genreIconColor,
              backgroundColor: genreBgColor,
              borderColor: genreBorderColor,
              textColor: textPrimary,
              badge: genreBadge,
            ),
            SearchFilterButton(
              label: tagLabel,
              onTap: showTagBottomSheet,
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
}
