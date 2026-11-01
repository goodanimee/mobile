import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../components/error_view.dart';
import '../../components/floating_nav.dart';
import '../../components/skeleton.dart';
import '../../models/user_activity.dart';
import '../../models/user_profile.dart';
import '../../services/auth_service.dart';
import '../../services/user_service.dart';
import '../../theme/theme.dart';
import '../../utils/app_navigation.dart';
import 'tabs/activity_tab.dart';
import 'tabs/info_tab.dart';
import 'widgets/profile_fab.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_sticky_header.dart';

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

  /// Callback notifying parent navigation of profile quick-nav tab sections.
  final ValueChanged<List<QuickNavSection>>? onQuickNavChanged;

  /// Creates a profile page.
  const ProfilePage({
    super.key,
    this.userId,
    this.username,
    this.onSignOut,
    this.showFloatingNav,
    this.onQuickNavChanged,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _scrollController = ScrollController();

  UserProfile? _profile;
  UserActivityPage? _cachedActivitiesPage;
  bool _isLoading = true;
  bool _isSelf = false;
  bool _isFollowLoading = false;
  bool _showStickyBar = false;
  int _selectedTabIndex = 0;
  int _refreshTrigger = 0;
  String? _error;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadProfile();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final shouldShow = _scrollController.offset > 180;
    if (shouldShow != _showStickyBar) {
      setState(() => _showStickyBar = shouldShow);
    }
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
      _cachedActivitiesPage = null;
      _refreshTrigger++;
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
        _notifyQuickNav();
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

  List<QuickNavSection> _buildQuickNavSections() {
    return QuickNavSection.fromTabs(
      tabs: const [
        (icon: LucideIcons.info, label: 'Info'),
        (icon: LucideIcons.activity, label: 'Activity'),
      ],
      selectedIndex: _selectedTabIndex,
      onSelect: (index) {
        if (_selectedTabIndex != index) {
          setState(() => _selectedTabIndex = index);
          _notifyQuickNav();
        }
      },
      scrollController: _scrollController,
    );
  }

  void _notifyQuickNav() {
    if (widget.onQuickNavChanged == null) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      widget.onQuickNavChanged?.call(_buildQuickNavSections());
    });
  }

  void _openAnimeList() => _openMediaList('ANIME');

  void _openMangaList() => _openMediaList('MANGA');

  void _openMediaList(String mediaType) {
    final profile = _profile;
    if (profile == null) return;
    if (_isSelf) {
      AppNavigation.handleNavTap(context, mediaType == 'MANGA' ? 2 : 1);
      return;
    }
    AppNavigation.toUserMediaList(
      context,
      userId: profile.id,
      username: profile.name,
      mediaType: mediaType,
    );
  }

  Widget _buildActiveTab(UserProfile profile) {
    return switch (_selectedTabIndex) {
      1 => ProfileActivityTab(
        userId: profile.id,
        scrollController: _scrollController,
        refreshTrigger: _refreshTrigger,
        initialPage: _cachedActivitiesPage,
        onInitialPageLoaded: (page) => _cachedActivitiesPage = page,
      ),
      _ => ProfileInfoTab(
        profile: profile,
        onOpenAnimeList: _openAnimeList,
        onOpenMangaList: _openMangaList,
      ),
    };
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

    final profile = _profile!;
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
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(child: ProfileHeader(profile: profile)),
                SliverToBoxAdapter(child: _buildActiveTab(profile)),
                const SliverToBoxAdapter(child: SizedBox(height: 128)),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ProfileStickyHeader(
              profile: profile,
              showStickyBar: _showStickyBar,
              onBack: canPop ? () => Navigator.of(context).pop() : null,
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
                      isFollowing: profile.isFollowing,
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
                    quickNavSections: _buildQuickNavSections(),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
