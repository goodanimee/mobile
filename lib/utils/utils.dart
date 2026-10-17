import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/common.dart';
import '../models/media_list.dart';

/// Utilities for working with colors
class ColorUtils {
  /// Parse hex color string to Color
  static Color fromHex(String? hexString, {Color fallback = Colors.grey}) {
    if (hexString == null || hexString.isEmpty) return fallback;

    try {
      final hex = hexString.replaceAll('#', '');
      if (hex.length == 6) {
        return Color(int.parse('FF$hex', radix: 16));
      } else if (hex.length == 8) {
        return Color(int.parse(hex, radix: 16));
      }
    } catch (_) {}

    return fallback;
  }
}

/// Utilities for working with strings
class StringUtils {
  /// Language name to short abbreviation
  static String getLanguageAbbreviation(String? language) {
    if (language == null) return 'Link';

    final l = language.toLowerCase();
    if (l.contains('japanese')) return 'JP';
    if (l.contains('english')) return 'EN';
    if (l.contains('chinese')) return 'CN';
    if (l.contains('korean')) return 'KR';
    if (l.contains('spanish')) return 'ES';
    if (l.contains('french')) return 'FR';
    if (l.contains('german')) return 'DE';
    if (l.contains('italian')) return 'IT';
    if (l.contains('portuguese')) return 'PT';

    return 'Link';
  }

  /// Capitalize text
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text
        .split(' ')
        .map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(' ');
  }

  /// Format duration to human-readable airing string
  static String formatAiringDuration(int remainingSeconds) {
    final duration = Duration(seconds: remainingSeconds);
    if (duration.inDays >= 1) {
      return '${duration.inDays} ${pluralize(duration.inDays, "day", "days")}';
    } else if (duration.inHours >= 1) {
      return '${duration.inHours} ${pluralize(duration.inHours, "hour", "hours")}';
    } else {
      return 'an hour';
    }
  }

  /// Format numbers compactly (e.g. 4312 -> 4.3k, 1104299 -> 1.1m)
  static String formatCompactNumber(int number) {
    return NumberFormat.compact().format(number).toLowerCase();
  }

  /// Returns the correct singular or plural form of a word based on the [count].
  static String pluralize(int count, String singular, String plural) {
    return Intl.plural(count, one: singular, other: plural);
  }
}

/// Utilities for sorting media list entries and comparing fuzzy dates.
class MediaListSortUtils {
  /// Sorts [entries] in-place according to [sortType] and [isAscending].
  static void sortEntries(
    List<MediaListEntryWithMedia> entries, {
    required String sortType,
    required bool isAscending,
  }) {
    switch (sortType) {
      case 'title':
        entries.sort((a, b) {
          final tA = a.media.title.userPreferred.trim().toLowerCase();
          final tB = b.media.title.userPreferred.trim().toLowerCase();
          if (tA.isEmpty && tB.isEmpty) return 0;
          if (tA.isEmpty) return -1;
          if (tB.isEmpty) return 1;
          return isAscending ? tA.compareTo(tB) : tB.compareTo(tA);
        });
        break;
      case 'score':
        entries.sort((a, b) {
          final scoreA = a.score;
          final scoreB = b.score;
          final hasScoreA = scoreA > 0;
          final hasScoreB = scoreB > 0;

          if (hasScoreA && hasScoreB) {
            return isAscending
                ? scoreA.compareTo(scoreB)
                : scoreB.compareTo(scoreA);
          }
          if (hasScoreA) return -1;
          if (hasScoreB) return 1;

          final commA = a.media.averageScore;
          final commB = b.media.averageScore;
          return isAscending ? commA.compareTo(commB) : commB.compareTo(commA);
        });
        break;
      case 'progress':
        entries.sort((a, b) {
          return isAscending
              ? a.progress.compareTo(b.progress)
              : b.progress.compareTo(a.progress);
        });
        break;
      case 'release_date':
        entries.sort((a, b) {
          final yA = (a.media.startYear == 0) ? null : a.media.startYear;
          final yB = (b.media.startYear == 0) ? null : b.media.startYear;
          if (yA == null && yB == null) return 0;
          if (yA == null) return 1;
          if (yB == null) return -1;
          return isAscending ? yA.compareTo(yB) : yB.compareTo(yA);
        });
        break;
      case 'started_date':
        entries.sort((a, b) {
          return compareFuzzyDates(
            a.startedAt,
            b.startedAt,
            ascending: isAscending,
          );
        });
        break;
      case 'completed_date':
        entries.sort((a, b) {
          return compareFuzzyDates(
            a.completedAt,
            b.completedAt,
            ascending: isAscending,
          );
        });
        break;
    }
  }

  /// Compares two [FuzzyDate] instances with null/zero components sorted last.
  static int compareFuzzyDates(
    FuzzyDate? a,
    FuzzyDate? b, {
    required bool ascending,
  }) {
    if (a == null && b == null) return 0;
    if (a == null) return 1;
    if (b == null) return -1;

    final yA = (a.year == 0) ? null : a.year;
    final yB = (b.year == 0) ? null : b.year;
    if (yA == null && yB == null) return 0;
    if (yA == null) return 1;
    if (yB == null) return -1;
    if (yA != yB) {
      return ascending ? yA.compareTo(yB) : yB.compareTo(yA);
    }

    final mA = (a.month == 0) ? null : a.month;
    final mB = (b.month == 0) ? null : b.month;
    if (mA == null && mB == null) return 0;
    if (mA == null) return 1;
    if (mB == null) return -1;
    if (mA != mB) {
      return ascending ? mA.compareTo(mB) : mB.compareTo(mA);
    }

    final dA = (a.day == 0) ? null : a.day;
    final dB = (b.day == 0) ? null : b.day;
    if (dA == null && dB == null) return 0;
    if (dA == null) return 1;
    if (dB == null) return -1;
    return ascending ? dA.compareTo(dB) : dB.compareTo(dA);
  }
}

/// Utilities for cache management
class CacheUtils {
  static const String _cachePrefix = 'media_cache_';
  static const String _cacheKeysPref = 'media_cache_keys';

  /// Remove media entry from disk cache
  static Future<void> invalidateMedia(int mediaId) async {
    final prefs = await SharedPreferences.getInstance();
    final idStr = mediaId.toString();

    await prefs.remove('$_cachePrefix$idStr');

    final List<String> keys = prefs.getStringList(_cacheKeysPref) ?? [];
    if (keys.contains(idStr)) {
      keys.remove(idStr);
      await prefs.setStringList(_cacheKeysPref, keys);
    }
  }
}
