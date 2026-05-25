import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/user_api.dart';
import '../models/viewer.dart';
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

      final isFresh = cachedAt != null &&
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

  /// Clears user cache.
  static Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyCachedUser);
    await prefs.remove(_keyCachedAt);
  }
}
