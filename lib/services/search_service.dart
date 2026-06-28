import '../api/search_api.dart';
import '../models/common.dart';
import '../models/media_min.dart';
import '../models/media_studio.dart';
import '../proto/api.pb.dart';
import 'auth_service.dart';

/// Represents the paginated results of a media search.
class SearchResult {
  /// The list of media results.
  final List<MediaMin> media;

  /// The pagination information.
  final PageInfo pageInfo;

  /// Creates a search result.
  const SearchResult({required this.media, required this.pageInfo});
}

/// Represents the paginated results of a studio search.
class StudioSearchResult {
  /// The list of studio results.
  final List<Studio> studios;

  /// The pagination information.
  final PageInfo pageInfo;

  /// Creates a studio search result.
  const StudioSearchResult({required this.studios, required this.pageInfo});
}

/// Service for executing AniList media searches.
class SearchService {
  /// Searches for media with given filters.
  static Future<SearchResult> searchMedia(
    FetchMediaSearchRequest request,
  ) async {
    final token = await AuthService.getRawToken() ?? '';
    final response = await SearchApi.fetchMediaSearch(request, token);
    final media = response.media.map(MediaMin.fromProto).toList();
    final pageInfo = PageInfo.fromProto(response.pageInfo);
    return SearchResult(media: media, pageInfo: pageInfo);
  }

  /// Searches for studios with given parameters.
  static Future<StudioSearchResult> searchStudios(
    FetchStudioSearchRequest request,
  ) async {
    final token = await AuthService.getRawToken() ?? '';
    final response = await SearchApi.fetchStudioSearch(request, token);
    final studios = response.studios.map(Studio.fromProto).toList();
    final pageInfo = PageInfo.fromProto(response.pageInfo);
    return StudioSearchResult(studios: studios, pageInfo: pageInfo);
  }
}
