import '../models/viewer.dart';
import '../proto/api.pb.dart';
import 'ffi_core.dart';

/// API class for user-related operations
class UserApi {
  /// Fetches viewer information using the provided token
  static Future<Viewer> fetchViewer(String token) async {
    final bytes = await FfiCore.executeTokenCall('FetchViewer', token);
    final response = FetchViewerResponse.fromBuffer(bytes);
    if (response.error.isNotEmpty) {
      throw Exception('Error fetching viewer: ${response.error}');
    }
    return Viewer.fromProto(response.viewer);
  }
}
