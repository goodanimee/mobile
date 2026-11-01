import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../api/user_api.dart';
import '../models/social_user.dart';
import '../models/user_activity.dart';
import '../models/user_favourites.dart';
import '../models/user_profile.dart';
import '../models/viewer.dart';
import '../proto/api.pb.dart';
import '../proto/viewer.pb.dart' as pb;
import 'auth_service.dart';

/// Service for managing user/viewer accounts and profiles.
class UserService {
  static const String _keyCachedUser = 'cached_viewer';
  static const String _keyCachedAt = 'cached_viewer_at';
  static const Duration _cacheTtl = Duration(hours: 1);

  /// Retrieves the cached or remote user ID.
  static Future<int?> getUserId() async {
    final viewer = await getViewer();
    return viewer?.id;
  }

  /// Retrieves the viewer profile from cache or network.
  static Future<Viewer?> getViewer({bool forceRefresh = false}) async {
    final prefs = await SharedPreferences.getInstance();

    if (!forceRefresh) {
      final cachedStr = prefs.getString(_keyCachedUser);
      final cachedAt = prefs.getInt(_keyCachedAt);

      final isFresh =
          cachedAt != null &&
          DateTime.now().millisecondsSinceEpoch - cachedAt <
              _cacheTtl.inMilliseconds;

      if (cachedStr != null && isFresh) {
        try {
          return Viewer.fromProto(
            pb.Viewer.fromBuffer(base64Decode(cachedStr)),
          );
        } catch (_) {}
      }
    }

    try {
      final token = await AuthService.getValidToken();
      final viewer = await UserApi.fetchViewer(token);

      await prefs.setString(
        _keyCachedUser,
        base64Encode(viewer.toProto().writeToBuffer()),
      );
      await prefs.setInt(_keyCachedAt, DateTime.now().millisecondsSinceEpoch);
      return viewer;
    } catch (e) {
      return null;
    }
  }

  /// Fetches a user profile by [userId] or [username].
  static Future<UserProfile?> getUserProfile({
    int? userId,
    String? username,
  }) async {
    try {
      final token = await AuthService.getRawToken() ?? '';
      return await UserApi.getUserProfile(
        userId: userId,
        username: username,
        token: token,
      );
    } catch (_) {
      return null;
    }
  }

  /// Toggles follow status for [userId].
  static Future<bool> toggleFollow(int userId) async {
    final token = await AuthService.getValidToken();
    final res = await UserApi.toggleFollow(userId, token);
    return res.isFollowing;
  }

  /// Fetches paginated activities for [userId].
  static Future<UserActivityPage> getUserActivities({
    required int userId,
    int page = 1,
    int perPage = 25,
    List<String> typeIn = const [],
  }) async {
    final token = await AuthService.getRawToken() ?? '';
    return UserApi.getUserActivities(
      userId: userId,
      page: page,
      perPage: perPage,
      typeIn: typeIn,
      token: token,
    );
  }

  /// Resolves multiple AniList entity previews in bulk.
  static Future<ResolveAnilistPreviewsResponse> resolveAnilistPreviews(
    ResolveAnilistPreviewsRequest request,
  ) async {
    final token = await AuthService.getRawToken() ?? '';
    return UserApi.resolveAnilistPreviews(request: request, token: token);
  }

  /// Fetches initial or single-category paginated favourites for [userId].
  static Future<UserFavourites> getUserFavourites({
    required int userId,
    FavouriteCategory? category,
    int page = 1,
    int perPage = 25,
  }) async {
    final token = await AuthService.getRawToken() ?? '';
    return UserApi.getUserFavourites(
      userId: userId,
      category: category?.apiKey ?? '',
      page: page,
      perPage: perPage,
      token: token,
    );
  }

  /// Fetches paginated following or followers for [userId].
  static Future<SocialUserPage> getUserSocial({
    required int userId,
    required bool isFollowers,
    int page = 1,
    int perPage = 30,
  }) async {
    final token = await AuthService.getRawToken() ?? '';
    return UserApi.getUserSocial(
      userId: userId,
      isFollowers: isFollowers,
      page: page,
      perPage: perPage,
      token: token,
    );
  }

  /// Clears user cache.
  static Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyCachedUser);
    await prefs.remove(_keyCachedAt);
  }
}
