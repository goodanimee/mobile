import '../api/search_api.dart';
import '../models/common.dart';
import '../models/media_min.dart';
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
}
