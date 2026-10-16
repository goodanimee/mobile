import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/release_info.dart';
import '../utils/semver.dart';

/// Service for checking application updates via GitHub Releases
class UpdateService {
  static const String _apiUrl =
      'https://api.github.com/repos/goodanimee/mobile/releases/latest';
  static const String _keyLastCheckAt = 'update_last_check_at';
  static const String _keySkippedTag = 'update_skipped_tag';
  static const Duration _checkInterval = Duration(hours: 24);

  /// Checks for a newer release, throttled to once every 24 hours
  static Future<ReleaseInfo?> checkForUpdate() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastCheckAt = prefs.getInt(_keyLastCheckAt);
      final now = DateTime.now().millisecondsSinceEpoch;

      if (lastCheckAt != null &&
          now - lastCheckAt < _checkInterval.inMilliseconds) {
        return null;
      }

      final response = await http.get(
        Uri.parse(_apiUrl),
        headers: {'Accept': 'application/vnd.github+json'},
      );

      await prefs.setInt(_keyLastCheckAt, now);

      if (response.statusCode != 200) {
        return null;
      }

      final data = jsonDecode(response.body);
      if (data is! Map<String, dynamic>) {
        return null;
      }

      final release = ReleaseInfo.fromJson(data);
      if (release.tagName.isEmpty) {
        return null;
      }

      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = SemVer.parse(packageInfo.version);
      final latestVersion = SemVer.parse(release.tagName);

      if (latestVersion <= currentVersion) {
        return null;
      }

      final skippedTag = prefs.getString(_keySkippedTag);
      if (skippedTag == release.tagName) {
        return null;
      }

      return release;
    } catch (_) {
      return null;
    }
  }

  /// Marks a release tag as skipped in local storage
  static Future<void> skipRelease(String tagName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keySkippedTag, tagName);
  }
}
