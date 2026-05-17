/// Represents a date with optional day, month, and year
class FuzzyDate {
  /// Year component
  final int? year;

  /// Month component
  final int? month;

  /// Day component
  final int? day;

  /// Creates a fuzzy date
  const FuzzyDate({this.year, this.month, this.day});

  /// Creates a fuzzy date from a JSON map
  factory FuzzyDate.fromJson(Map<String, dynamic> json) {
    return FuzzyDate(
      year: json['year'] as int?,
      month: json['month'] as int?,
      day: json['day'] as int?,
    );
  }

  /// Formats the date as a string
  String toFormattedString() {
    if (year == null) return '';
    if (month == null) return '$year';
    if (day == null) return '$year-$month';
    return '$year-$month-$day';
  }
}

/// Contains pagination information
class PageInfo {
  /// Whether more pages are available
  final bool hasNextPage;

  /// The current page number
  final int currentPage;

  /// Creates a page info
  const PageInfo({required this.hasNextPage, required this.currentPage});

  /// Creates a page info from a JSON map
  factory PageInfo.fromJson(Map<String, dynamic> json) {
    return PageInfo(
      hasNextPage: json['hasNextPage'] as bool,
      currentPage: json['currentPage'] as int,
    );
  }
}
