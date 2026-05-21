import 'package:shared_preferences/shared_preferences.dart';
import '../api/user_api.dart';

const _keyToken = 'anilist_access_token';
const _keyExpiry = 'anilist_token_expiry';

/// Manages the AniList OAuth access token lifecycle
class AuthService {
  static Future<SharedPreferences> get _prefs =>
      SharedPreferences.getInstance();

  /// Persists token and optional expiry to local storage
  static Future<void> saveToken(String token, {int? expiresInSeconds}) async {
    final prefs = await _prefs;
    await prefs.setString(_keyToken, token);
    if (expiresInSeconds != null) {
      final expiry = DateTime.now()
          .add(Duration(seconds: expiresInSeconds))
          .millisecondsSinceEpoch;
      await prefs.setInt(_keyExpiry, expiry);
    }
  }

  /// Removes the stored token and expiry from local storage
  static Future<void> clearToken() async {
    final prefs = await _prefs;
    await prefs.remove(_keyToken);
    await prefs.remove(_keyExpiry);
  }

  /// Returns the raw stored token string without validation
  static Future<String?> getRawToken() async {
    final prefs = await _prefs;
    return prefs.getString(_keyToken);
  }

  /// Returns the stored token expiry timestamp
  static Future<DateTime?> getTokenExpiry() async {
    final prefs = await _prefs;
    final expiry = prefs.getInt(_keyExpiry);
    if (expiry == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(expiry);
  }

  /// Returns the stored token if it is present and not expired
  static Future<String> getValidToken() async {
    final prefs = await _prefs;
    final token = prefs.getString(_keyToken);

    if (token == null) throw AuthExpiredException();

    final expiry = prefs.getInt(_keyExpiry);
    if (expiry != null) {
      if (DateTime.now().millisecondsSinceEpoch >= expiry) {
        await clearToken();
        throw AuthExpiredException();
      }
      return token;
    }

    final valid = await _probe(token);
    if (!valid) {
      await clearToken();
      throw AuthExpiredException();
    }

    return token;
  }

  /// Verifies the token with a lightweight backend probe
  static Future<bool> _probe(String token) async {
    try {
      final viewer = await UserApi.fetchViewer(token);
      return viewer.id != 0;
    } catch (_) {
      return false;
    }
  }
}

/// Thrown when the stored access token is missing or invalid
class AuthExpiredException implements Exception {
  @override
  String toString() => 'Access token expired or invalid.';
}
