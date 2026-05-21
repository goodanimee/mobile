import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/user_api.dart';
import '../theme/theme.dart';
import '../components/user_profile.dart';
import '../services/auth_service.dart';
import '../models/viewer.dart';

const _keyCachedUser = 'cached_viewer';
const _keyCachedAt = 'cached_viewer_at';
const _cacheTtl = Duration(hours: 1);

/// A page displaying the user's profile and account options
class ProfilePage extends StatefulWidget {
  /// Callback for signing out
  final VoidCallback onSignOut;

  /// Creates a profile page
  const ProfilePage({super.key, required this.onSignOut});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

/// State for ProfilePage
class _ProfilePageState extends State<ProfilePage> {
  Viewer? _userData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  /// Loads user data from cache or network
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedJson = prefs.getString(_keyCachedUser);
    final cachedAt = prefs.getInt(_keyCachedAt);

    final isFresh =
        cachedAt != null &&
        DateTime.now().millisecondsSinceEpoch - cachedAt <
            _cacheTtl.inMilliseconds;

    if (cachedJson != null && isFresh) {
      if (mounted) {
        setState(() {
          _userData = Viewer.fromJson(jsonDecode(cachedJson));
          _isLoading = false;
        });
      }
      return;
    }

    await _fetchAndCache(prefs);
  }

  /// Fetches viewer data from the backend and updates cache
  Future<void> _fetchAndCache(SharedPreferences prefs) async {
    try {
      final token = await AuthService.getValidToken();
      final viewer = await UserApi.fetchViewer(token);

      await prefs.setString(_keyCachedUser, jsonEncode(viewer.toJson()));
      await prefs.setInt(_keyCachedAt, DateTime.now().millisecondsSinceEpoch);

      if (mounted) {
        setState(() {
          _userData = viewer;
          _isLoading = false;
        });
      }
    } on AuthExpiredException {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Session expired. Please sign in again.'),
          ),
        );
        widget.onSignOut();
      }
    } catch (e) {
      debugPrint('Backend Error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load profile.')),
        );
        setState(() => _isLoading = false);
      }
    }
  }

  /// Clears auth token and local cache then signs out
  Future<void> _handleSignOut() async {
    final prefs = await SharedPreferences.getInstance();
    await AuthService.clearToken();
    await prefs.remove(_keyCachedUser);
    await prefs.remove(_keyCachedAt);
    widget.onSignOut();
  }

  @override
  /// Builds the profile page widget
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator(color: borderColor)
            : UserProfile(userData: _userData!, onSignOut: _handleSignOut),
      ),
    );
  }
}
