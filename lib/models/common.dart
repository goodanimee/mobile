import '../proto/common.pb.dart' as pb;

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

  /// Creates a fuzzy date from a protobuf object
  factory FuzzyDate.fromProto(pb.FuzzyDate pbObj) {
    return FuzzyDate(
      year: pbObj.hasYear() && pbObj.year > 0 ? pbObj.year : null,
      month: pbObj.hasMonth() && pbObj.month > 0 ? pbObj.month : null,
      day: pbObj.hasDay() && pbObj.day > 0 ? pbObj.day : null,
    );
  }

  /// Creates a fuzzy date from a protobuf object, returning null if empty
  static FuzzyDate? fromProtoNullable(pb.FuzzyDate? pbObj) {
    if (pbObj == null) return null;
    final date = FuzzyDate.fromProto(pbObj);
    return date.hasDate ? date : null;
  }

  /// Whether this date has valid components
  bool get hasDate =>
      (year != null && year! > 0) ||
      (month != null && month! > 0) ||
      (day != null && day! > 0);

  /// Formats the date as a string
  String toFormattedString() {
    if (year == null) return '';
    if (month == null) return '$year';
    if (day == null) return '$year-$month';
    return '$year-$month-$day';
  }

  /// Converts the fuzzy date to a protobuf object
  pb.FuzzyDate toProto() {
    final pbObj = pb.FuzzyDate();
    if (year != null) pbObj.year = year!;
    if (month != null) pbObj.month = month!;
    if (day != null) pbObj.day = day!;
    return pbObj;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FuzzyDate &&
          runtimeType == other.runtimeType &&
          year == other.year &&
          month == other.month &&
          day == other.day;

  @override
  int get hashCode => Object.hash(year, month, day);
}

/// Contains pagination information
class PageInfo {
  /// Whether more pages are available
  final bool hasNextPage;

  /// The current page number
  final int currentPage;

  /// Creates a page info
  const PageInfo({required this.hasNextPage, required this.currentPage});

  /// Creates a page info from a protobuf object
  factory PageInfo.fromProto(pb.PageInfo pbObj) {
    return PageInfo(
      hasNextPage: pbObj.hasNextPage,
      currentPage: pbObj.currentPage,
    );
  }

  /// Converts the page info to a protobuf object
  pb.PageInfo toProto() {
    return pb.PageInfo(hasNextPage: hasNextPage, currentPage: currentPage);
  }
}

/// Represents the status of a media list entry
enum MediaListStatus {
  /// Currently watching status
  current,

  /// Planning to watch status
  planning,

  /// Completed watching status
  completed,

  /// Dropped status
  dropped,

  /// Paused status
  paused,

  /// Repeating/rewatching status
  repeating;

  /// Converts the status to a protobuf enum
  pb.MediaListStatus toProto() {
    switch (this) {
      case MediaListStatus.current:
        return pb.MediaListStatus.MEDIA_LIST_STATUS_CURRENT;
      case MediaListStatus.planning:
        return pb.MediaListStatus.MEDIA_LIST_STATUS_PLANNING;
      case MediaListStatus.completed:
        return pb.MediaListStatus.MEDIA_LIST_STATUS_COMPLETED;
      case MediaListStatus.dropped:
        return pb.MediaListStatus.MEDIA_LIST_STATUS_DROPPED;
      case MediaListStatus.paused:
        return pb.MediaListStatus.MEDIA_LIST_STATUS_PAUSED;
      case MediaListStatus.repeating:
        return pb.MediaListStatus.MEDIA_LIST_STATUS_REPEATING;
    }
  }

  /// Gets the display name for the status
  String displayName({bool isManga = false}) => this == MediaListStatus.current
      ? (isManga ? 'READING' : 'WATCHING')
      : name.toUpperCase();

  /// Get the string representation of the enum value
  @override
  String toString() {
    return name.toUpperCase();
  }

  /// Parse the media list status from the string
  static MediaListStatus fromString(String status) {
    switch (status) {
      case 'current':
      case 'CURRENT':
        return MediaListStatus.current;
      case 'planning':
      case 'PLANNING':
        return MediaListStatus.planning;
      case 'completed':
      case 'COMPLETED':
        return MediaListStatus.completed;
      case 'dropped':
      case 'DROPPED':
        return MediaListStatus.dropped;
      case 'paused':
      case 'PAUSED':
        return MediaListStatus.paused;
      case 'repeating':
      case 'REPEATING':
        return MediaListStatus.repeating;
      default:
        return MediaListStatus.current;
    }
  }

  /// Parses the status from a protobuf enum
  static MediaListStatus? fromProto(pb.MediaListStatus pbStatus) {
    if (pbStatus == pb.MediaListStatus.MEDIA_LIST_STATUS_UNSPECIFIED) {
      return null;
    }
    switch (pbStatus) {
      case pb.MediaListStatus.MEDIA_LIST_STATUS_PLANNING:
        return MediaListStatus.planning;
      case pb.MediaListStatus.MEDIA_LIST_STATUS_COMPLETED:
        return MediaListStatus.completed;
      case pb.MediaListStatus.MEDIA_LIST_STATUS_DROPPED:
        return MediaListStatus.dropped;
      case pb.MediaListStatus.MEDIA_LIST_STATUS_PAUSED:
        return MediaListStatus.paused;
      case pb.MediaListStatus.MEDIA_LIST_STATUS_REPEATING:
        return MediaListStatus.repeating;
      case pb.MediaListStatus.MEDIA_LIST_STATUS_CURRENT:
      default:
        return MediaListStatus.current;
    }
  }
}
