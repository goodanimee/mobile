import '../models/media_list.dart';
import '../models/media_list_entry.dart';
import '../proto/api.pb.dart';
import 'ffi_core.dart';

/// API class for media list operations
class MediaListApi {
  /// Fetches the media list for a given user ID and authentication token.
  static Future<MediaListCollection> fetchMediaList(
    int userId,
    String token,
    String mediaType,
  ) async {
    final bytes = await FfiCore.executeMediaListCall(userId, token, mediaType);
    final response = FetchMediaListResponse.fromBuffer(bytes);
    if (response.error.isNotEmpty) {
      throw Exception('Error fetching media list: ${response.error}');
    }
    return MediaListCollection.fromProto(response.collection);
  }

  /// Saves or updates a media list entry
  static Future<MediaListEntry> saveMediaListEntry(
    SaveMediaListEntryRequest request,
    String token,
  ) async {
    final bytes = await FfiCore.executeProtoCall(
      'SaveMediaListEntry',
      request.writeToBuffer(),
      token,
    );
    final response = SaveMediaListEntryResponse.fromBuffer(bytes);
    if (response.error.isNotEmpty) throw Exception(response.error);
    return MediaListEntry.fromProto(response.entry);
  }

  /// Deletes a media list entry
  static Future<DeleteMediaListEntryResponse> deleteMediaListEntry(
    DeleteMediaListEntryRequest request,
    String token,
  ) async {
    final bytes = await FfiCore.executeProtoCall(
      'DeleteMediaListEntry',
      request.writeToBuffer(),
      token,
    );
    final response = DeleteMediaListEntryResponse.fromBuffer(bytes);
    if (response.error.isNotEmpty) throw Exception(response.error);
    return response;
  }
}
