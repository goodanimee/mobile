import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../components/app_network_image.dart';
import '../../../components/error_view.dart';
import '../../../components/loading_indicator.dart';
import '../../../models/social_user.dart';
import '../../../services/user_service.dart';
import '../../../theme/theme.dart';
import '../../../utils/app_navigation.dart';

/// Signature for fetching a page of social users.
typedef FetchUserSocialCallback =
    Future<SocialUserPage> Function({
      required int userId,
      required bool isFollowers,
      int page,
    });

/// Signature for toggling a user follow status.
typedef ToggleUserFollowCallback = Future<bool> Function(int userId);

/// Signature for navigating to a user profile.
typedef SocialUserTapCallback = void Function(int userId, String username);

/// Profile tab displaying a user's following and followers lists.
class ProfileSocialTab extends StatefulWidget {
  /// Target profile user ID.
  final int userId;

  /// Optional viewer user ID to hide follow actions on self.
  final int? viewerId;

  /// Optional parent scroll controller driving infinite pagination.
  final ScrollController? scrollController;

  /// Monotonic counter incremented when the parent profile refreshes.
  final int refreshTrigger;

  /// Initial active segment (defaults to following).
  final SocialSegment initialSegment;

  /// Optional cached initial following page.
  final SocialUserPage? initialFollowingPage;

  /// Optional cached initial followers page.
  final SocialUserPage? initialFollowersPage;

  /// Callback when the active segment changes.
  final ValueChanged<SocialSegment>? onSegmentChanged;

  /// Callback when the following page updates.
  final ValueChanged<SocialUserPage>? onFollowingPageChanged;

  /// Callback when the followers page updates.
  final ValueChanged<SocialUserPage>? onFollowersPageChanged;

  /// Callback when following status changes locally.
  final void Function(int userId, bool isFollowing)? onFollowToggle;

  /// Optional override for fetching social users (used in tests).
  final FetchUserSocialCallback? fetchSocial;

  /// Optional override for toggling follow status (used in tests).
  final ToggleUserFollowCallback? toggleFollow;

  /// Optional override for profile navigation.
  final SocialUserTapCallback? onOpenProfile;

  /// Creates a profile social tab.
  const ProfileSocialTab({
    super.key,
    required this.userId,
    this.viewerId,
    this.scrollController,
    this.refreshTrigger = 0,
    this.initialSegment = SocialSegment.following,
    this.initialFollowingPage,
    this.initialFollowersPage,
    this.onSegmentChanged,
    this.onFollowingPageChanged,
    this.onFollowersPageChanged,
    this.onFollowToggle,
    this.fetchSocial,
    this.toggleFollow,
    this.onOpenProfile,
  });

  @override
  State<ProfileSocialTab> createState() => _ProfileSocialTabState();
}

class _ProfileSocialTabState extends State<ProfileSocialTab> {
  final TextEditingController _searchController = TextEditingController();
  final Map<SocialSegment, List<SocialUser>> _usersBySegment = {};
  final Map<SocialSegment, int> _pageBySegment = {};
  final Map<SocialSegment, bool> _hasNextPageBySegment = {};
  final Map<SocialSegment, int> _totalBySegment = {};
  final Set<int> _togglingUserIds = {};

  late SocialSegment _selectedSegment;
  String _searchQuery = '';
  bool _isLoading = false;
  bool _isLoadingMore = false;
  int _requestToken = 0;
  String? _error;

  @override
  void initState() {
    super.initState();
    _selectedSegment = widget.initialSegment;
    widget.scrollController?.addListener(_onScroll);

    if (widget.initialFollowingPage != null) {
      _usersBySegment[SocialSegment.following] = List.of(
        widget.initialFollowingPage!.users,
      );
      _pageBySegment[SocialSegment.following] =
          widget.initialFollowingPage!.pageInfo.currentPage;
      _hasNextPageBySegment[SocialSegment.following] =
          widget.initialFollowingPage!.pageInfo.hasNextPage;
      _totalBySegment[SocialSegment.following] =
          widget.initialFollowingPage!.total;
    }

    if (widget.initialFollowersPage != null) {
      _usersBySegment[SocialSegment.followers] = List.of(
        widget.initialFollowersPage!.users,
      );
      _pageBySegment[SocialSegment.followers] =
          widget.initialFollowersPage!.pageInfo.currentPage;
      _hasNextPageBySegment[SocialSegment.followers] =
          widget.initialFollowersPage!.pageInfo.hasNextPage;
      _totalBySegment[SocialSegment.followers] =
          widget.initialFollowersPage!.total;
    }

    if (!_usersBySegment.containsKey(_selectedSegment)) {
      _loadSegment(_selectedSegment);
    }
  }

  @override
  void didUpdateWidget(ProfileSocialTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.scrollController != widget.scrollController) {
      oldWidget.scrollController?.removeListener(_onScroll);
      widget.scrollController?.addListener(_onScroll);
    }
    if (oldWidget.userId != widget.userId ||
        oldWidget.refreshTrigger != widget.refreshTrigger) {
      _usersBySegment.clear();
      _pageBySegment.clear();
      _hasNextPageBySegment.clear();
      _totalBySegment.clear();
      _loadSegment(_selectedSegment);
    } else if (oldWidget.initialSegment != widget.initialSegment &&
        widget.initialSegment != _selectedSegment) {
      _selectSegment(widget.initialSegment);
    }
  }

  @override
  void dispose() {
    widget.scrollController?.removeListener(_onScroll);
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final controller = widget.scrollController;
    if (controller == null || !controller.hasClients) return;
    if (controller.position.extentAfter < 300) {
      _loadMore();
    }
  }

  Future<SocialUserPage> _performFetch({
    required SocialSegment segment,
    required int page,
  }) {
    final fetcher = widget.fetchSocial;
    if (fetcher != null) {
      return fetcher(
        userId: widget.userId,
        isFollowers: segment.isFollowers,
        page: page,
      );
    }
    return UserService.getUserSocial(
      userId: widget.userId,
      isFollowers: segment.isFollowers,
      page: page,
    );
  }

  Future<bool> _performToggleFollow(int userId) {
    final toggler = widget.toggleFollow;
    if (toggler != null) {
      return toggler(userId);
    }
    return UserService.toggleFollow(userId);
  }

  void _selectSegment(SocialSegment segment) {
    if (_selectedSegment == segment) return;
    setState(() {
      _selectedSegment = segment;
      _error = null;
    });
    widget.onSegmentChanged?.call(segment);
    if (!_usersBySegment.containsKey(segment)) {
      _loadSegment(segment);
    }
  }

  Future<void> _loadSegment(SocialSegment segment) async {
    final token = ++_requestToken;
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final page = await _performFetch(segment: segment, page: 1);
      if (!mounted || token != _requestToken) return;

      setState(() {
        _usersBySegment[segment] = List.of(page.users);
        _pageBySegment[segment] = page.pageInfo.currentPage;
        _hasNextPageBySegment[segment] = page.pageInfo.hasNextPage;
        _totalBySegment[segment] = page.total;
        _isLoading = false;
      });

      if (segment == SocialSegment.following) {
        widget.onFollowingPageChanged?.call(page);
      } else {
        widget.onFollowersPageChanged?.call(page);
      }
    } catch (e) {
      if (!mounted || token != _requestToken) return;
      setState(() {
        _error = 'Failed to load ${segment.label.toLowerCase()}.';
        _isLoading = false;
      });
    }
  }

  Future<void> _loadMore() async {
    if (_isLoading || _isLoadingMore) return;
    final hasNext = _hasNextPageBySegment[_selectedSegment] ?? false;
    if (!hasNext) return;

    final currentPage = _pageBySegment[_selectedSegment] ?? 1;
    final nextPage = currentPage + 1;
    final segment = _selectedSegment;

    setState(() => _isLoadingMore = true);

    try {
      final page = await _performFetch(segment: segment, page: nextPage);
      if (!mounted || _selectedSegment != segment) return;

      final existing = _usersBySegment[segment] ?? [];
      final existingIds = existing.map((u) => u.id).toSet();
      final fresh = page.users.where((u) => !existingIds.contains(u.id));
      final merged = [...existing, ...fresh];

      setState(() {
        _usersBySegment[segment] = merged;
        _pageBySegment[segment] = page.pageInfo.currentPage;
        _hasNextPageBySegment[segment] = page.pageInfo.hasNextPage;
        _totalBySegment[segment] = page.total;
        _isLoadingMore = false;
      });

      final fullPage = SocialUserPage(
        pageInfo: page.pageInfo,
        total: page.total,
        users: merged,
      );
      if (segment == SocialSegment.following) {
        widget.onFollowingPageChanged?.call(fullPage);
      } else {
        widget.onFollowersPageChanged?.call(fullPage);
      }
    } catch (_) {
      if (mounted) {
        setState(() => _isLoadingMore = false);
      }
    }
  }

  Future<void> _handleToggleFollow(SocialUser user) async {
    if (_togglingUserIds.contains(user.id)) return;

    final previous = user;
    final optimistic = SocialMathUtils.applyOptimisticFollowToggle(user);

    setState(() {
      _togglingUserIds.add(user.id);
      _updateUserAcrossSegments(optimistic);
    });
    widget.onFollowToggle?.call(user.id, optimistic.isFollowing);

    try {
      final serverFollowing = await _performToggleFollow(user.id);
      if (!mounted) return;
      setState(() {
        _togglingUserIds.remove(user.id);
        _updateUserAcrossSegments(user.copyWith(isFollowing: serverFollowing));
      });
      if (serverFollowing != optimistic.isFollowing) {
        widget.onFollowToggle?.call(user.id, serverFollowing);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _togglingUserIds.remove(user.id);
        _updateUserAcrossSegments(previous);
      });
      widget.onFollowToggle?.call(user.id, previous.isFollowing);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update follow status: $e')),
      );
    }
  }

  void _updateUserAcrossSegments(SocialUser updated) {
    for (final seg in SocialSegment.values) {
      final list = _usersBySegment[seg];
      if (list != null) {
        final idx = list.indexWhere((u) => u.id == updated.id);
        if (idx != -1) {
          list[idx] = updated;
        }
      }
    }
  }

  void _handleOpenProfile(SocialUser user) {
    if (widget.onOpenProfile != null) {
      widget.onOpenProfile!(user.id, user.name);
      return;
    }
    AppNavigation.toProfile(context, userId: user.id, username: user.name);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          _buildSearchBar(),
          const SizedBox(height: 16),
          _buildBody(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: hoverBgColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: cardBorderColor),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (val) => setState(() => _searchQuery = val),
        style: const TextStyle(color: textPrimary, fontSize: 13.5),
        cursorColor: borderColor,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          hintText: 'Search ${_selectedSegment.label.toLowerCase()}...',
          hintStyle: const TextStyle(color: textHint, fontSize: 13.5),
          border: InputBorder.none,
          prefixIcon: const Icon(LucideIcons.search, size: 16, color: textHint),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 36,
            minHeight: 36,
          ),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(
                    LucideIcons.x,
                    size: 16,
                    color: textSecondary,
                  ),
                  onPressed: () {
                    _searchController.clear();
                    setState(() => _searchQuery = '');
                  },
                  splashRadius: 16,
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const AppLoadingIndicator(topPadding: 48);
    }

    if (_error != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 36),
        child: AppErrorView(
          message: _error!,
          onRetry: () => _loadSegment(_selectedSegment),
        ),
      );
    }

    final users = _usersBySegment[_selectedSegment] ?? const [];
    final filtered = SocialMathUtils.filterUsersByQuery(users, _searchQuery);

    if (users.isEmpty) {
      final emptyText = _selectedSegment == SocialSegment.following
          ? 'No following yet.'
          : 'No followers yet.';
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                LucideIcons.userX,
                size: 40,
                color: textHint.withValues(alpha: 0.4),
              ),
              const SizedBox(height: 12),
              Text(
                emptyText,
                style: const TextStyle(color: textMuted, fontSize: 14),
              ),
            ],
          ),
        ),
      );
    }

    if (filtered.isEmpty && _searchQuery.trim().isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                LucideIcons.search,
                size: 40,
                color: textHint.withValues(alpha: 0.4),
              ),
              const SizedBox(height: 12),
              const Text(
                'No users match your search.',
                style: TextStyle(color: textMuted, fontSize: 14),
              ),
            ],
          ),
        ),
      );
    }

    final hasNext =
        (_hasNextPageBySegment[_selectedSegment] ?? false) &&
        _searchQuery.trim().isEmpty;

    return Column(
      children: [
        for (var i = 0; i < filtered.length; i++) ...[
          if (i > 0) const SizedBox(height: 10),
          _buildUserCard(filtered[i]),
        ],
        if (_isLoadingMore)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: AppLoadingIndicator(topPadding: 0),
          )
        else if (hasNext)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: OutlinedButton(
                onPressed: _loadMore,
                style: OutlinedButton.styleFrom(
                  foregroundColor: textSecondary,
                  side: const BorderSide(color: cardBorderColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),
                child: const Text('Load more', style: TextStyle(fontSize: 13)),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildUserCard(SocialUser user) {
    final isSelf = widget.viewerId != null && user.id == widget.viewerId;
    final isToggling = _togglingUserIds.contains(user.id);

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 8, 8, 8),
      decoration: BoxDecoration(
        color: hoverBgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cardBorderColor),
      ),
      child: Row(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _handleOpenProfile(user),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: cardBorderColor, width: 1.5),
              ),
              child: ClipOval(
                child: AppNetworkImage(
                  imageUrl: user.avatarUrl,
                  width: 44,
                  height: 44,
                  fallbackIcon: LucideIcons.user,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _handleOpenProfile(user),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    user.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (user.isFollower) ...[
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: paletteBlue.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: paletteBlue.withValues(alpha: 0.4),
                        ),
                      ),
                      child: const Text(
                        'Follows you',
                        style: TextStyle(
                          fontSize: 10,
                          color: paletteBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (!isSelf) ...[
            const SizedBox(width: 10),
            _buildFollowButton(user, isToggling: isToggling),
          ],
        ],
      ),
    );
  }

  Widget _buildFollowButton(SocialUser user, {required bool isToggling}) {
    final isFollowing = user.isFollowing;
    final double buttonSize = getResponsiveSize(context, 48.0);
    final double iconSize = getResponsiveSize(context, 22.0);
    final iconColor = isFollowing ? paletteBlue : textPrimary;
    final iconData = isFollowing ? LucideIcons.userCheck : LucideIcons.userPlus;

    return Tooltip(
      message: isFollowing ? 'Following' : 'Follow',
      child: Material(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: isToggling ? null : () => _handleToggleFollow(user),
          borderRadius: BorderRadius.circular(12),
          splashColor: pressBgColor,
          highlightColor: pressBgColor,
          child: Container(
            width: buttonSize,
            height: buttonSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: cardBorderColor),
            ),
            alignment: Alignment.center,
            child: isToggling
                ? SizedBox(
                    width: iconSize * 0.85,
                    height: iconSize * 0.85,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: paletteBlue,
                    ),
                  )
                : Icon(iconData, color: iconColor, size: iconSize),
          ),
        ),
      ),
    );
  }
}
