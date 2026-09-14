/// Represents the currently active dropdown filter in the search UI.
enum ActiveDropdown {
  /// Format filter dropdown.
  format,

  /// Release status filter dropdown.
  status,

  /// Season filter dropdown.
  season,

  /// Start year range filter dropdown.
  year,

  /// Count (episodes/chapters) range filter dropdown.
  count,

  /// Duration/Volumes range filter dropdown.
  duration,

  /// Average score range filter dropdown.
  score,

  /// Sort dropdown menu.
  sort,
}
