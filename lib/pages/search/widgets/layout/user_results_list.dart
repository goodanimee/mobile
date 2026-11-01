import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../components/app_network_image.dart';
import '../../../../components/error_view.dart';
import '../../../../components/loading_indicator.dart';
import '../../../../components/skeleton.dart';
import '../../../../models/social_user.dart';
import '../../../../services/user_service.dart';
import '../../../../theme/theme.dart';
import '../../../../utils/app_navigation.dart';

/// A widget that displays the list of user search results.
class UserResultsList extends StatefulWidget {
  /// The list of user results to display.
  final List<SocialUser> userResults;

  /// Whether a search is currently in progress.
  final bool isSearching;

  /// Whether a paginated load more search is in progress.
  final bool isSearchingMore;

  /// Optional error message.
  final String? searchError;

  /// Callback to retry the search after an error.
  final VoidCallback onRetry;

  /// Authenticated viewer ID used to suppress follow buttons on self.
  final int? viewerId;

  /// Custom follow toggle handler for tests or overrides.
  final Future<bool> Function(int userId)? toggleFollow;

  /// Callback when a user card is tapped.
  final void Function(SocialUser user)? onUserTap;

  /// Callback invoked when a user follow status is updated.
  final void Function(SocialUser updatedUser)? onUserUpdated;

  /// Creates a user results list.
  const UserResultsList({
    super.key,
    required this.userResults,
    required this.isSearching,
    required this.isSearchingMore,
    required this.searchError,
    required this.onRetry,
    this.viewerId,
    this.toggleFollow,
    this.onUserTap,
    this.onUserUpdated,
  });

  @override
  State<UserResultsList> createState() => _UserResultsListState();
}

class _UserResultsListState extends State<UserResultsList> {
  final Set<int> _togglingUserIds = {};
  final Map<int, SocialUser> _localOverrides = {};

  Future<void> _handleToggleFollow(SocialUser user) async {
    if (_togglingUserIds.contains(user.id)) return;

    final previous = _localOverrides[user.id] ?? user;
    final optimistic = SocialMathUtils.applyOptimisticFollowToggle(previous);

    setState(() {
      _togglingUserIds.add(user.id);
      _localOverrides[user.id] = optimistic;
    });
    widget.onUserUpdated?.call(optimistic);

    try {
      final toggler = widget.toggleFollow ?? UserService.toggleFollow;
      final serverFollowing = await toggler(user.id);
      if (!mounted) return;
      final confirmed = previous.copyWith(isFollowing: serverFollowing);
      setState(() {
        _togglingUserIds.remove(user.id);
        _localOverrides[user.id] = confirmed;
      });
      widget.onUserUpdated?.call(confirmed);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _togglingUserIds.remove(user.id);
        _localOverrides[user.id] = previous;
      });
      widget.onUserUpdated?.call(previous);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update follow status: $e')),
      );
    }
  }

  void _handleOpenProfile(SocialUser user) {
    if (widget.onUserTap != null) {
      widget.onUserTap!(user);
      return;
    }
    AppNavigation.toProfile(context, userId: user.id, username: user.name);
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

  @override
  Widget build(BuildContext context) {
    final double paddingVal = getResponsiveSize(context, 16.0);
    if (widget.isSearching) {
      return Skeleton.list(
        padding: EdgeInsets.symmetric(horizontal: paddingVal),
      );
    }
    if (widget.searchError != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: AppErrorView(
            message: widget.searchError!,
            onRetry: widget.onRetry,
          ),
        ),
      );
    }
    if (widget.userResults.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Text(
            'No results found',
            style: TextStyle(color: textMuted, fontSize: fontBody(context)),
          ),
        ),
      );
    }

    final List<Widget> cards = [];
    for (final rawUser in widget.userResults) {
      final user = _localOverrides[rawUser.id] ?? rawUser;
      final isSelf = widget.viewerId != null && user.id == widget.viewerId;
      final isToggling = _togglingUserIds.contains(user.id);

      cards.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: InkWell(
            onTap: () => _handleOpenProfile(user),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.fromLTRB(14, 8, 8, 8),
              decoration: BoxDecoration(
                color: hoverBgColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: cardBorderColor),
              ),
              child: Row(
                children: [
                  Container(
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
                  const SizedBox(width: 12),
                  Expanded(
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
                  if (!isSelf) ...[
                    const SizedBox(width: 10),
                    _buildFollowButton(user, isToggling: isToggling),
                  ],
                ],
              ),
            ),
          ),
        ),
      );
    }

    if (widget.isSearchingMore) {
      cards.add(
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: AppLoadingIndicator(),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingVal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: cards,
      ),
    );
  }
}
