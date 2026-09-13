import '../models/media_misc.dart';
import '../proto/api.pb.dart';
import 'ffi_core.dart';

/// API class for genre and tag-related operations
class GenreApi {
  /// Fetches the list of all genres
  static Future<List<String>> fetchGenres(String token) async {
    final bytes = await FfiCore.executeTokenCall('FetchGenres', token);
    final response = FetchGenresResponse.fromBuffer(bytes);
    if (response.error.isNotEmpty) {
      throw Exception('Error fetching genres: ${response.error}');
    }
    return response.genres;
  }

  /// Fetches the list of all media tags
  static Future<List<MediaTag>> fetchTags(String token) async {
    final bytes = await FfiCore.executeTokenCall('FetchTags', token);
    final response = FetchTagsResponse.fromBuffer(bytes);
    if (response.error.isNotEmpty) {
      throw Exception('Error fetching tags: ${response.error}');
    }
    return response.tags.map(MediaTag.fromProto).toList();
  }
}
