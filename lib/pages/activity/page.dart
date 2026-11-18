import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../components/app_fab.dart';
import '../../components/floating_nav.dart';
import '../../components/loading_indicator.dart';
import '../../components/lucide_icons_helper.dart';
import '../../models/user_activity.dart';
import '../../services/activity_service.dart';
import '../../services/media_service.dart';
import '../../theme/theme.dart';
import '../../utils/app_navigation.dart';
import '../profile/widgets/user_activity_card.dart';
import 'widgets/activity_comments_sheet.dart';

/// Full screen view for displaying a single activity post and its interactions.
class ActivityPage extends StatefulWidget {
  /// Optional activity ID to load.
  final int? activityId;

  /// Optional preloaded activity data.
  final UserActivity? initialActivity;

  /// Optional test override for fetching an activity by ID.
  final Future<UserActivity> Function(int activityId)? fetchActivity;

  /// Optional test override for toggling activity like.
  final Future<void> Function(int activityId)? toggleLike;

  /// Creates an activity details page.
  const ActivityPage({
    super.key,
    this.activityId,
    this.initialActivity,
    this.fetchActivity,
    this.toggleLike,
  }) : assert(
         activityId != null || initialActivity != null,
         'Must provide either activityId or initialActivity',
       );

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  UserActivity? _activity;
  bool _isLoading = false;
  String? _error;
  bool _isTogglingLike = false;

  @override
  void initState() {
    super.initState();
    _activity = widget.initialActivity;
    if (_activity == null && widget.activityId != null) {
      _loadActivity();
    }
  }

  Future<void> _loadActivity() async {
    final id = widget.activityId;
    if (id == null) return;
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final act = widget.fetchActivity != null
          ? await widget.fetchActivity!(id)
          : await ActivityService.getActivityById(id);
      if (!mounted) return;
      setState(() {
        _activity = act;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Failed to load post: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _handleToggleLike() async {
    final act = _activity;
    if (act == null || _isTogglingLike) return;

    final optimistic = act.toggleLikeOptimistic();
    setState(() {
      _isTogglingLike = true;
      _activity = optimistic;
    });

    try {
      if (widget.toggleLike != null) {
        await widget.toggleLike!(act.id);
      } else {
        await MediaService.toggleActivityLike(act.id);
      }
      if (mounted) {
        setState(() => _isTogglingLike = false);
      }
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _activity = act;
        _isTogglingLike = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope<UserActivity>(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        Navigator.of(context).pop(_activity);
      },
      child: Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  _buildAppBar(context),
                  Expanded(child: _buildContent(context)),
                ],
              ),
              Positioned(
                bottom: 24,
                right: 20,
                child: _buildFabColumn(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(bottom: BorderSide(color: cardBorderColor)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(LucideIcons.arrowLeft, color: textPrimary),
            onPressed: () => Navigator.of(context).pop(_activity),
          ),
          const SizedBox(width: 8),
          const Text(
            'Activity',
            style: TextStyle(
              color: textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (_isLoading) {
      return const Center(child: AppLoadingIndicator());
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_error!, style: const TextStyle(color: textMuted)),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _loadActivity,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    final act = _activity;
    if (act == null) {
      return const Center(
        child: Text('Post not found.', style: TextStyle(color: textMuted)),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
      child: UserActivityCard(
        activity: act,
        isFeedMode: false,
        isTogglingLike: _isTogglingLike,
        onToggleLike: _handleToggleLike,
        showFooterActions: false,
      ),
    );
  }

  Widget _buildFabColumn(BuildContext context) {
    final act = _activity;
    final isLiked = act?.isLiked ?? false;
    final likeCount = act?.likeCount ?? 0;
    final replyCount = act?.replyCount ?? 0;
    final double iconSize = getResponsiveSize(context, 18.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AppFab.stat(
          onTap: _isTogglingLike ? null : _handleToggleLike,
          tooltip: isLiked ? 'Unlike' : 'Like',
          icon: LucideHeartIcon(
            isFilled: isLiked,
            color: isLiked ? paletteRed : textPrimary,
            size: iconSize,
          ),
          count: likeCount,
          countColor: isLiked ? paletteRed : null,
        ),
        const SizedBox(height: 8),
        AppFab.stat(
          onTap: act != null
              ? () => ActivityCommentsSheet.show(
                  context,
                  activityId: act.id,
                  initialReplyCount: act.replyCount,
                  onReplyCountChanged: (newCount) {
                    setState(() {
                      _activity = _activity?.copyWith(replyCount: newCount);
                    });
                  },
                )
              : null,
          tooltip: 'Comments',
          icon: Icon(
            LucideIcons.messageSquare,
            size: iconSize,
            color: textPrimary,
          ),
          count: replyCount,
        ),
        const SizedBox(height: 8),
        FloatingNav(
          selectedIndex: -1,
          onTap: (index) => AppNavigation.handleNavTap(context, index),
        ),
      ],
    );
  }
}
