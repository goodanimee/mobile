import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      return '${duration.inDays} ${duration.inDays == 1 ? "day" : "days"}';
    } else if (duration.inHours >= 1) {
      return '${duration.inHours} ${duration.inHours == 1 ? "hour" : "hours"}';
    } else {
      return 'an hour';
    }
  }
}

/// Utilities for cache management
class CacheUtils {
  static const String _cachePrefix = 'anime_cache_';
  static const String _cacheKeysPref = 'anime_cache_keys';

  /// Notification flag for AnimeListTab stale data
  static final animeListNeedsRefresh = ValueNotifier<bool>(false);

  /// Notification flag for MangaListTab stale data
  static final mangaListNeedsRefresh = ValueNotifier<bool>(false);

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
