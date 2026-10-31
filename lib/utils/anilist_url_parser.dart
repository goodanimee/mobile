/// Supported AniList entity types for in-app routing.
enum AnilistEntityType {
  /// Anime media entity.
  anime,

  /// Manga media entity.
  manga,

  /// Character entity.
  character,

  /// Staff entity.
  staff,

  /// Studio entity.
  studio,

  /// User profile entity.
  user,
}

/// Resolved navigation target parsed from an AniList URL.
class AnilistRouteTarget {
  /// The resolved entity type.
  final AnilistEntityType type;

  /// The positive numeric entity ID.
  final int? id;

  /// The username for user entity targets.
  final String? username;

  /// Creates an AniList route target.
  const AnilistRouteTarget({required this.type, this.id, this.username});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnilistRouteTarget &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          id == other.id &&
          username == other.username;

  @override
  int get hashCode => Object.hash(type, id, username);
}

/// Parser for AniList entity URLs and paths.
class AnilistUrlParser {
  static const Set<String> _validHosts = {'anilist.co', 'www.anilist.co'};

  /// Parses an AniList URL or relative path into an [AnilistRouteTarget].
  static AnilistRouteTarget? parse(
    String rawUrl, {
    bool allowRelative = false,
  }) {
    final uri = _normalizeAndParseUri(rawUrl, allowRelative: allowRelative);
    if (uri == null) return null;

    final segments = uri.pathSegments.where((s) => s.isNotEmpty).toList();
    if (segments.length < 2) return null;

    final entityType = _parseEntityType(segments[0]);
    if (entityType == null) return null;

    if (entityType == AnilistEntityType.user) {
      final identifier = segments[1].trim();
      if (identifier.isEmpty) return null;
      final numericId = int.tryParse(identifier);
      if (numericId != null && numericId > 0) {
        return AnilistRouteTarget(type: entityType, id: numericId);
      }
      return AnilistRouteTarget(type: entityType, username: identifier);
    }

    final id = int.tryParse(segments[1]);
    if (id == null || id <= 0) return null;

    return AnilistRouteTarget(type: entityType, id: id);
  }

  /// Checks whether [rawUrl] points to an AniList entity path prefix.
  static bool isAnilistEntityPath(String rawUrl, {bool allowRelative = false}) {
    final uri = _normalizeAndParseUri(rawUrl, allowRelative: allowRelative);
    if (uri == null) return false;

    final segments = uri.pathSegments.where((s) => s.isNotEmpty).toList();
    if (segments.isEmpty) return false;

    return _parseEntityType(segments[0]) != null;
  }

  static Uri? _normalizeAndParseUri(
    String rawUrl, {
    required bool allowRelative,
  }) {
    final trimmed = rawUrl.trim();
    if (trimmed.isEmpty) return null;

    String candidate = trimmed;
    final lower = trimmed.toLowerCase();
    if (lower.startsWith('anilist.co/') ||
        lower.startsWith('www.anilist.co/')) {
      candidate = 'https://$trimmed';
    }

    final uri = Uri.tryParse(candidate);
    if (uri == null) return null;

    if (uri.hasScheme || uri.host.isNotEmpty) {
      final scheme = uri.scheme.toLowerCase();
      if (scheme != 'http' && scheme != 'https') return null;
      if (!_validHosts.contains(uri.host.toLowerCase())) return null;
      return uri;
    }

    if (allowRelative && trimmed.startsWith('/')) {
      return uri;
    }

    return null;
  }

  static AnilistEntityType? _parseEntityType(String segment) {
    switch (segment.toLowerCase()) {
      case 'anime':
        return AnilistEntityType.anime;
      case 'manga':
        return AnilistEntityType.manga;
      case 'character':
        return AnilistEntityType.character;
      case 'staff':
        return AnilistEntityType.staff;
      case 'studio':
        return AnilistEntityType.studio;
      case 'user':
        return AnilistEntityType.user;
      default:
        return null;
    }
  }
}
