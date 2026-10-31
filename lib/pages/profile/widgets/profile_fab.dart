import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../theme/theme.dart';

/// Floating action button for user profile actions such as follow and sign out.
class ProfileFab extends StatelessWidget {
  /// Whether the profile belongs to the viewer.
  final bool isSelf;

  /// Whether the viewer is currently following this user.
  final bool isFollowing;

  /// Whether a follow status change is currently loading.
  final bool isFollowLoading;

  /// Callback when the follow/unfollow button is tapped.
  final VoidCallback? onToggleFollow;

  /// Callback when the sign out button is tapped.
  final VoidCallback? onSignOut;

  /// Creates a profile action floating button.
  const ProfileFab({
    super.key,
    required this.isSelf,
    this.isFollowing = false,
    this.isFollowLoading = false,
    this.onToggleFollow,
    this.onSignOut,
  });

  Future<void> _handleSignOutTap(BuildContext context) async {
    if (onSignOut == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: cardBorderColor),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sign Out',
                  style: TextStyle(
                    color: textPrimary,
                    fontSize: fontTitle(dialogContext),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Are you sure you want to sign out?',
                  style: TextStyle(
                    color: textSecondary,
                    fontSize: fontBody(dialogContext),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(dialogContext).pop(false),
                      style: TextButton.styleFrom(
                        foregroundColor: textSecondary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () => Navigator.of(dialogContext).pop(true),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.redAccent,
                        backgroundColor: Colors.redAccent.withValues(
                          alpha: 0.12,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                          side: BorderSide(
                            color: Colors.redAccent.withValues(alpha: 0.35),
                          ),
                        ),
                      ),
                      child: const Text('Sign Out'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    if (confirmed == true && onSignOut != null) {
      onSignOut!();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isSelf && onSignOut == null) {
      return const SizedBox.shrink();
    }
    if (!isSelf && onToggleFollow == null) {
      return const SizedBox.shrink();
    }

    final double fabSize = getResponsiveSize(context, 52.0);
    final double iconSize = getResponsiveSize(context, 22.0);

    if (isSelf) {
      return Container(
        width: fabSize,
        height: fabSize,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: cardBorderColor),
        ),
        child: GestureDetector(
          onTap: () => _handleSignOutTap(context),
          behavior: HitTestBehavior.opaque,
          child: Center(
            child: Icon(
              LucideIcons.logOut,
              color: Colors.redAccent,
              size: iconSize,
            ),
          ),
        ),
      );
    }

    if (isFollowLoading) {
      return Container(
        width: fabSize,
        height: fabSize,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: cardBorderColor),
        ),
        child: Center(
          child: SizedBox(
            width: iconSize * 0.85,
            height: iconSize * 0.85,
            child: const CircularProgressIndicator(
              strokeWidth: 2,
              color: paletteBlue,
            ),
          ),
        ),
      );
    }

    final boxDecoration = BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: cardBorderColor),
    );

    final iconColor = isFollowing ? paletteBlue : textPrimary;
    final iconData = isFollowing ? LucideIcons.userCheck : LucideIcons.userPlus;

    return Container(
      width: fabSize,
      height: fabSize,
      decoration: boxDecoration,
      child: GestureDetector(
        onTap: onToggleFollow,
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: Icon(iconData, color: iconColor, size: iconSize),
        ),
      ),
    );
  }
}
