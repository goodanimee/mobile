import '../api/search_api.dart';
import '../models/common.dart';
import '../models/media_character.dart';
import '../models/media_min.dart';
import '../models/media_staff.dart';
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

/// Represents the paginated results of a character search.
class CharacterSearchResult {
  /// The list of character results.
  final List<Character> characters;

  /// The pagination information.
  final PageInfo pageInfo;

  /// Creates a character search result.
  const CharacterSearchResult({
    required this.characters,
    required this.pageInfo,
  });
}

/// Represents the paginated results of a staff search.
class StaffSearchResult {
  /// The list of staff results.
  final List<Staff> staff;

  /// The pagination information.
  final PageInfo pageInfo;

  /// Creates a staff search result.
  const StaffSearchResult({required this.staff, required this.pageInfo});
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

  /// Searches for characters with given parameters.
  static Future<CharacterSearchResult> searchCharacters(
    FetchCharacterSearchRequest request,
  ) async {
    final token = await AuthService.getRawToken() ?? '';
    final response = await SearchApi.fetchCharacterSearch(request, token);
    final characters = response.characters.map(Character.fromProto).toList();
    final pageInfo = PageInfo.fromProto(response.pageInfo);
    return CharacterSearchResult(characters: characters, pageInfo: pageInfo);
  }

  /// Searches for staff with given parameters.
  static Future<StaffSearchResult> searchStaff(
    FetchStaffSearchRequest request,
  ) async {
    final token = await AuthService.getRawToken() ?? '';
    final response = await SearchApi.fetchStaffSearch(request, token);
    final staff = response.staff.map(Staff.fromProto).toList();
    final pageInfo = PageInfo.fromProto(response.pageInfo);
    return StaffSearchResult(staff: staff, pageInfo: pageInfo);
  }
}
