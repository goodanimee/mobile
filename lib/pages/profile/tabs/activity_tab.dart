import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../components/error_view.dart';
import '../../../components/loading_indicator.dart';
import '../../../models/user_activity.dart';
import '../../../services/media_service.dart';
import '../../../services/user_service.dart';
import '../../../theme/theme.dart';
import '../widgets/user_activity_card.dart';

/// Signature for fetching a page of user activities.
typedef FetchUserActivitiesCallback =
    Future<UserActivityPage> Function({
      required int userId,
      required int page,
      required List<String> typeIn,
    });

/// Signature for toggling a like on an activity item.
typedef ToggleActivityLikeCallback = Future<void> Function(int activityId);

/// Profile tab displaying a user's chronological activity stream with type filters.
class ProfileActivityTab extends StatefulWidget {
  /// Target profile user ID.
  final int userId;

  /// Optional parent scroll controller driving infinite pagination.
  final ScrollController? scrollController;

  /// Monotonic counter incremented when the parent profile refreshes.
  final int refreshTrigger;

  /// Optional cached initial `All` page from parent state.
  final UserActivityPage? initialPage;

  /// Callback invoked when page 1 of `All` activities loads or updates.
  final ValueChanged<UserActivityPage>? onInitialPageLoaded;

  /// Optional override for fetching activities (used in tests).
  final FetchUserActivitiesCallback? fetchActivities;

  /// Optional override for toggling likes (used in tests).
  final ToggleActivityLikeCallback? toggleLike;

  /// Optional override for media card navigation.
  final ValueChanged<int>? onOpenMedia;

  /// Optional override for user profile navigation.
  final ActivityUserTapCallback? onOpenUser;

  /// Creates a profile activity tab.
  const ProfileActivityTab({
    super.key,
    required this.userId,
    this.scrollController,
    this.refreshTrigger = 0,
    this.initialPage,
    this.onInitialPageLoaded,
    this.fetchActivities,
    this.toggleLike,
    this.onOpenMedia,
    this.onOpenUser,
  });

  @override
  State<ProfileActivityTab> createState() => _ProfileActivityTabState();
}

class _ProfileActivityTabState extends State<ProfileActivityTab> {
  final List<UserActivity> _activities = [];
  final Set<int> _togglingIds = {};

  UserActivityTypeFilter _selectedFilter = UserActivityTypeFilter.all;
  int _currentPage = 1;
  bool _hasNextPage = false;
  bool _isLoading = true;
  bool _isLoadingMore = false;
  int _requestToken = 0;
  String? _error;

  @override
  void initState() {
    super.initState();
    widget.scrollController?.addListener(_onScroll);
    if (widget.initialPage != null) {
      _activities.addAll(widget.initialPage!.activities);
      _currentPage = widget.initialPage!.pageInfo.currentPage;
      _hasNextPage = widget.initialPage!.pageInfo.hasNextPage;
      _isLoading = false;
    } else {
      _loadFirstPage();
    }
  }

  @override
  void didUpdateWidget(ProfileActivityTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.scrollController != widget.scrollController) {
      oldWidget.scrollController?.removeListener(_onScroll);
      widget.scrollController?.addListener(_onScroll);
    }
    if (oldWidget.userId != widget.userId ||
        oldWidget.refreshTrigger != widget.refreshTrigger) {
      _loadFirstPage();
    }
  }

  @override
  void dispose() {
    widget.scrollController?.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final controller = widget.scrollController;
    if (controller == null || !controller.hasClients) return;
    if (controller.position.extentAfter < 300) {
      _loadMore();
    }
  }

  Future<UserActivityPage> _performFetch({
    required int page,
    required List<String> typeIn,
  }) {
    final fetcher = widget.fetchActivities;
    if (fetcher != null) {
      return fetcher(userId: widget.userId, page: page, typeIn: typeIn);
    }
    return UserService.getUserActivities(
      userId: widget.userId,
      page: page,
      typeIn: typeIn,
    );
  }

  Future<void> _performToggleLike(int activityId) async {
    final toggler = widget.toggleLike;
    if (toggler != null) {
      await toggler(activityId);
      return;
    }
    await MediaService.toggleActivityLike(activityId);
  }

  Future<void> _loadFirstPage() async {
    final token = ++_requestToken;
    setState(() {
      _isLoading = true;
      _isLoadingMore = false;
      _error = null;
    });

    try {
      final page = await _performFetch(
        page: 1,
        typeIn: _selectedFilter.apiTypes,
      );
      if (!mounted || token != _requestToken) return;
      setState(() {
        _activities
          ..clear()
          ..addAll(page.activities);
        _currentPage = page.pageInfo.currentPage > 0
            ? page.pageInfo.currentPage
            : 1;
        _hasNextPage = page.pageInfo.hasNextPage;
        _isLoading = false;
      });
      if (_selectedFilter == UserActivityTypeFilter.all) {
        widget.onInitialPageLoaded?.call(page);
      }
    } catch (_) {
      if (!mounted || token != _requestToken) return;
      setState(() {
        _error = 'Failed to load activity.';
        _isLoading = false;
      });
    }
  }

  Future<void> _loadMore() async {
    if (_isLoading || _isLoadingMore || !_hasNextPage || _error != null) return;
    final token = _requestToken;
    setState(() => _isLoadingMore = true);

    try {
      final nextPage = _currentPage + 1;
      final page = await _performFetch(
        page: nextPage,
        typeIn: _selectedFilter.apiTypes,
      );
      if (!mounted || token != _requestToken) return;
      final existingIds = _activities.map((a) => a.id).toSet();
      final freshItems = page.activities.where(
        (a) => !existingIds.contains(a.id),
      );
      setState(() {
        _activities.addAll(freshItems);
        _currentPage = nextPage;
        _hasNextPage = page.pageInfo.hasNextPage;
        _isLoadingMore = false;
      });
    } catch (_) {
      if (!mounted || token != _requestToken) return;
      setState(() => _isLoadingMore = false);
    }
  }

  void _selectFilter(UserActivityTypeFilter filter) {
    if (_selectedFilter == filter) return;
    setState(() => _selectedFilter = filter);
    _loadFirstPage();
  }

  Future<void> _handleToggleLike(UserActivity activity) async {
    if (_togglingIds.contains(activity.id)) return;
    final index = _activities.indexWhere((a) => a.id == activity.id);
    if (index == -1) return;

    final previous = _activities[index];
    final optimistic = previous.toggleLikeOptimistic();

    setState(() {
      _togglingIds.add(activity.id);
      _activities[index] = optimistic;
    });
    _syncCachedAllPage();

    try {
      await _performToggleLike(activity.id);
      if (mounted) {
        setState(() => _togglingIds.remove(activity.id));
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        final rollbackIdx = _activities.indexWhere((a) => a.id == activity.id);
        if (rollbackIdx != -1) {
          _activities[rollbackIdx] = previous;
        }
        _togglingIds.remove(activity.id);
      });
      _syncCachedAllPage();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to update like: $e')));
    }
  }

  void _syncCachedAllPage() {
    if (_selectedFilter != UserActivityTypeFilter.all) return;
    if (widget.onInitialPageLoaded == null) return;
    final cached = widget.initialPage;
    if (cached == null) return;
    widget.onInitialPageLoaded!(
      UserActivityPage(
        pageInfo: cached.pageInfo,
        activities: List<UserActivity>.unmodifiable(_activities),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          _buildFilterBar(),
          const SizedBox(height: 14),
          _buildBody(),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var i = 0; i < UserActivityTypeFilter.values.length; i++) ...[
            if (i > 0) const SizedBox(width: 8),
            _buildFilterPill(UserActivityTypeFilter.values[i]),
          ],
        ],
      ),
    );
  }

  Widget _buildFilterPill(UserActivityTypeFilter filter) {
    final isSelected = _selectedFilter == filter;
    return Material(
      color: isSelected ? paletteBlue.withValues(alpha: 0.2) : hoverBgColor,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () => _selectFilter(filter),
        borderRadius: BorderRadius.circular(20),
        splashColor: pressBgColor,
        highlightColor: pressBgColor,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? borderColor : cardBorderColor,
            ),
          ),
          child: Text(
            filter.label,
            style: TextStyle(
              color: isSelected ? textPrimary : textSecondary,
              fontSize: 12.5,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const AppLoadingIndicator(topPadding: 48);
    }

    if (_error != null) {
      return AppErrorView(
        message: _error!,
        topPadding: 36,
        onRetry: _loadFirstPage,
      );
    }

    if (_activities.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                LucideIcons.activity,
                size: 40,
                color: textHint.withValues(alpha: 0.4),
              ),
              const SizedBox(height: 12),
              const Text(
                'No recent activity.',
                style: TextStyle(color: textMuted, fontSize: 14),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        for (var i = 0; i < _activities.length; i++) ...[
          if (i > 0) const SizedBox(height: 12),
          UserActivityCard(
            activity: _activities[i],
            isTogglingLike: _togglingIds.contains(_activities[i].id),
            onToggleLike: () => _handleToggleLike(_activities[i]),
            onOpenMedia: widget.onOpenMedia,
            onOpenUser: widget.onOpenUser,
          ),
        ],
        if (_isLoadingMore)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: AppLoadingIndicator(topPadding: 0),
          ),
      ],
    );
  }
}
