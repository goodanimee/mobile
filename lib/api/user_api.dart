import '../models/user_activity.dart';
import '../models/user_profile.dart';
import '../models/viewer.dart';
import '../proto/api.pb.dart';
import 'ffi_core.dart';

/// API class for user profile and social operations.
class UserApi {
  /// Fetches viewer information using the provided token.
  static Future<Viewer> fetchViewer(String token) async {
    final bytes = await FfiCore.executeTokenCall('FetchViewer', token);
    final response = FetchViewerResponse.fromBuffer(bytes);
    if (response.error.isNotEmpty) {
      throw Exception('Error fetching viewer: ${response.error}');
    }
    return Viewer.fromProto(response.viewer);
  }

  /// Fetches a user profile by ID or username.
  static Future<UserProfile> getUserProfile({
    int? userId,
    String? username,
    required String token,
  }) async {
    final request = GetUserProfileRequest();
    if (userId != null && userId > 0) {
      request.userId = userId;
    }
    if (username != null && username.isNotEmpty) {
      request.username = username;
    }

    final bytes = await FfiCore.executeProtoCall(
      'GetUserProfile',
      request.writeToBuffer(),
      token,
    );
    final response = GetUserProfileResponse.fromBuffer(bytes);
    if (response.error.isNotEmpty) throw Exception(response.error);
    return UserProfile.fromProto(response.profile);
  }

  /// Toggles follow status for a user.
  static Future<ToggleFollowResponse> toggleFollow(
    int userId,
    String token,
  ) async {
    final request = ToggleFollowRequest(userId: userId);
    final bytes = await FfiCore.executeProtoCall(
      'ToggleFollow',
      request.writeToBuffer(),
      token,
    );
    final response = ToggleFollowResponse.fromBuffer(bytes);
    if (response.error.isNotEmpty) throw Exception(response.error);
    return response;
  }

  /// Fetches paginated activities for [userId].
  static Future<UserActivityPage> getUserActivities({
    required int userId,
    int page = 1,
    int perPage = 25,
    List<String> typeIn = const [],
    required String token,
  }) async {
    final request = GetUserActivitiesRequest(
      userId: userId,
      page: page,
      perPage: perPage,
      typeIn: typeIn,
    );
    final bytes = await FfiCore.executeProtoCall(
      'GetUserActivities',
      request.writeToBuffer(),
      token,
    );
    final response = GetUserActivitiesResponse.fromBuffer(bytes);
    if (response.error.isNotEmpty) throw Exception(response.error);
    return UserActivityPage.fromProto(response);
  }

  /// Resolves multiple AniList entity previews in bulk.
  static Future<ResolveAnilistPreviewsResponse> resolveAnilistPreviews({
    required ResolveAnilistPreviewsRequest request,
    required String token,
  }) async {
    final bytes = await FfiCore.executeProtoCall(
      'ResolveAnilistPreviews',
      request.writeToBuffer(),
      token,
    );
    final response = ResolveAnilistPreviewsResponse.fromBuffer(bytes);
    if (response.error.isNotEmpty) throw Exception(response.error);
    return response;
  }
}
