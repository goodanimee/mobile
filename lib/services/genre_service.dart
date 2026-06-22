import '../api/genre_api.dart';
import '../models/media_misc.dart';
import 'auth_service.dart';

/// Service for managing and caching AniList genres and community tags.
class GenreService {
  static List<String>? _cachedGenres;
  static List<MediaTag>? _cachedTags;

  /// Fetches all genres, using in-memory cache if available.
  static Future<List<String>> getGenres({bool forceRefresh = false}) async {
    if (!forceRefresh && _cachedGenres != null) {
      return _cachedGenres!;
    }
    final token = await AuthService.getRawToken() ?? '';
    final genres = await GenreApi.fetchGenres(token);
    _cachedGenres = genres;
    return genres;
  }

  /// Fetches all tags, using in-memory cache if available.
  static Future<List<MediaTag>> getTags({bool forceRefresh = false}) async {
    if (!forceRefresh && _cachedTags != null) {
      return _cachedTags!;
    }
    final token = await AuthService.getRawToken() ?? '';
    final tags = await GenreApi.fetchTags(token);
    _cachedTags = tags;
    return tags;
  }
}
