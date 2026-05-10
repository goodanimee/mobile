import 'package:shared_preferences/shared_preferences.dart';
import '../utils/backend_helper.dart';

const _keyToken = 'anilist_access_token';
const _keyExpiry = 'anilist_token_expiry';

/// Manages the AniList OAuth access token lifecycle.
///
/// Tokens and their expiry timestamps are persisted in [SharedPreferences].
/// All methods are static; no instance is required.
class AuthService {
  static Future<SharedPreferences> get _prefs =>
      SharedPreferences.getInstance();

  /// Persists [token] to local storage.
  ///
  /// If [expiresInSeconds] is provided the absolute expiry timestamp is
  /// computed and stored alongside the token.
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

  /// Removes the stored token and its expiry from local storage.
  static Future<void> clearToken() async {
    final prefs = await _prefs;
    await prefs.remove(_keyToken);
    await prefs.remove(_keyExpiry);
  }

  /// Returns the raw stored token string without performing any validation,
  /// or null if no token is present.
  static Future<String?> getRawToken() async {
    final prefs = await _prefs;
    return prefs.getString(_keyToken);
  }

  /// Returns the stored token expiry as a [DateTime], or null if unknown.
  static Future<DateTime?> getTokenExpiry() async {
    final prefs = await _prefs;
    final expiry = prefs.getInt(_keyExpiry);
    if (expiry == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(expiry);
  }

  /// Returns the stored token if it is present and not expired.
  ///
  /// Validation order:
  /// 1. If no token exists, throws [AuthExpiredException].
  /// 2. If a stored expiry timestamp exists and has passed, clears the token
  ///    and throws [AuthExpiredException].
  /// 3. If no expiry is stored (implicit / non-expiring token), performs a
  ///    lightweight network probe against the AniList API.
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

  /// Sends a minimal GraphQL query to AniList to verify the token is accepted.
  ///
  /// Returns true if the server responds with a valid Viewer object, false otherwise.
  static Future<bool> _probe(String token) async {
    try {
      final response = await BackendHelper.fetchViewer(token);
      return response.viewer.id != 0;
    } catch (_) {
      return false;
    }
  }
}

/// Thrown when the stored access token is missing, expired, or rejected by AniList.
class AuthExpiredException implements Exception {
  @override
  String toString() => 'Access token expired or invalid.';
}
