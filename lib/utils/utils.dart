import 'package:flutter/material.dart';

/// Utilities for working with colors
class ColorUtils {
  /// Parses a hex color string into a Flutter Color
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
  /// Maps a language name to its short abbreviation
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
}
