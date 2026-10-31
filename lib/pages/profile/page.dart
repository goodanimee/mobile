import 'package:flutter/material.dart';

import '../../components/error_view.dart';
import '../../components/floating_nav.dart';
import '../../components/skeleton.dart';
import '../../models/user_profile.dart';
import '../../services/auth_service.dart';
import '../../services/user_service.dart';
import '../../theme/theme.dart';
import '../../utils/app_navigation.dart';
import 'widgets/profile_fab.dart';
import 'widgets/profile_header.dart';

/// A page displaying a user profile, social stats, and activity.
class ProfilePage extends StatefulWidget {
  /// The user ID of the profile to display (optional, defaults to authenticated user).
  final int? userId;

  /// The username of the profile to display (optional).
  final String? username;

  /// Callback for signing out (optional when viewed as a subroute).
  final VoidCallback? onSignOut;

  /// Explicit flag to control floating nav bar visibility.
  final bool? showFloatingNav;

  /// Creates a profile page.
  const ProfilePage({
    super.key,
    this.userId,
    this.username,
    this.onSignOut,
    this.showFloatingNav,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserProfile? _profile;
  bool _isLoading = true;
  bool _isSelf = false;
  bool _isFollowLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  void didUpdateWidget(ProfilePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.userId != widget.userId ||
        oldWidget.username != widget.username) {
      _loadProfile();
    }
  }

  Future<void> _loadProfile() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final viewerId = await UserService.getUserId();
      UserProfile? profile;

      if (widget.userId == null && widget.username == null) {
        if (viewerId == null) {
          throw AuthExpiredException();
        }
        profile = await UserService.getUserProfile(userId: viewerId);
        _isSelf = true;
      } else {
        profile = await UserService.getUserProfile(
          userId: widget.userId,
          username: widget.username,
        );
        _isSelf = viewerId != null && profile != null && profile.id == viewerId;
      }

      if (profile == null) {
        throw Exception('Failed to load profile');
      }

      if (mounted) {
        setState(() {
          _profile = profile;
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
        await _handleSignOut();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Failed to load profile.';
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _handleToggleFollow() async {
    if (_profile == null || _isFollowLoading) return;

    final previousProfile = _profile!;
    final targetFollowing = !previousProfile.isFollowing;
    final targetFollowersCount = targetFollowing
        ? previousProfile.followersCount + 1
        : (previousProfile.followersCount > 0
              ? previousProfile.followersCount - 1
              : 0);

    setState(() {
      _isFollowLoading = true;
      _profile = previousProfile.copyWith(
        isFollowing: targetFollowing,
        followersCount: targetFollowersCount,
      );
    });

    try {
      final serverFollowing = await UserService.toggleFollow(
        previousProfile.id,
      );
      if (mounted) {
        setState(() {
          _profile = _profile?.copyWith(isFollowing: serverFollowing);
          _isFollowLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _profile = previousProfile;
          _isFollowLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update follow status: $e')),
        );
      }
    }
  }

  Future<void> _handleSignOut() async {
    await AuthService.clearToken();
    await UserService.clearCache();
    if (widget.onSignOut != null) {
      widget.onSignOut!();
    } else if (mounted && Navigator.of(context).canPop()) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(backgroundColor: bgColor, body: Skeleton.profile());
    }

    if (_error != null || _profile == null) {
      return Scaffold(
        backgroundColor: bgColor,
        body: Center(
          child: AppErrorView(
            message: _error ?? 'Failed to load profile.',
            onRetry: _loadProfile,
          ),
        ),
      );
    }

    final canPop = widget.showFloatingNav ?? Navigator.of(context).canPop();
    final showFab = (!_isSelf) || (_isSelf && widget.onSignOut != null);

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          RefreshIndicator(
            color: borderColor,
            backgroundColor: hoverBgColor,
            onRefresh: _loadProfile,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: ProfileHeader(
                    profile: _profile!,
                    onBack: canPop ? () => Navigator.of(context).pop() : null,
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 128)),
              ],
            ),
          ),
          if (canPop)
            Positioned(
              bottom: 24 + MediaQuery.of(context).padding.bottom,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (showFab) ...[
                    ProfileFab(
                      isSelf: _isSelf,
                      isFollowing: _profile!.isFollowing,
                      isFollowLoading: _isFollowLoading,
                      onToggleFollow: _handleToggleFollow,
                      onSignOut: widget.onSignOut != null
                          ? _handleSignOut
                          : null,
                    ),
                    const SizedBox(height: 8),
                  ],
                  FloatingNav(
                    selectedIndex: -1,
                    onTap: (index) =>
                        AppNavigation.handleNavTap(context, index),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
