import 'package:flutter/material.dart';

import '../components/user_profile.dart';
import '../models/viewer.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';
import '../theme/theme.dart';

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
    try {
      final viewer = await UserService.getViewer();
      if (viewer == null) throw Exception('No viewer profile loaded');

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
    await AuthService.clearToken();
    await UserService.clearCache();
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
