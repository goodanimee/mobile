import '../proto/api.pb.dart';
import 'ffi_core.dart';

/// API class for media search operations using native FFI bindings.
class SearchApi {
  /// Searches for media on AniList using native FFI.
  static Future<FetchMediaSearchResponse> fetchMediaSearch(
    FetchMediaSearchRequest request,
    String token,
  ) async {
    final bytes = await FfiCore.executeProtoCall(
      'FetchMediaSearch',
      request.writeToBuffer(),
      token,
    );
    final response = FetchMediaSearchResponse.fromBuffer(bytes);
    if (response.error.isNotEmpty) {
      throw Exception(response.error);
    }
    return response;
  }

  /// Searches for studios on AniList using native FFI.
  static Future<FetchStudioSearchResponse> fetchStudioSearch(
    FetchStudioSearchRequest request,
    String token,
  ) async {
    final bytes = await FfiCore.executeProtoCall(
      'FetchStudioSearch',
      request.writeToBuffer(),
      token,
    );
    final response = FetchStudioSearchResponse.fromBuffer(bytes);
    if (response.error.isNotEmpty) {
      throw Exception(response.error);
    }
    return response;
  }
}
