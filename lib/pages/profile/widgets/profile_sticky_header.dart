import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:share_plus/share_plus.dart';

import '../../../models/user_profile.dart';
import '../../../theme/theme.dart';

/// A sticky top bar widget for the user profile page.
class ProfileStickyHeader extends StatelessWidget {
  /// User profile data to display.
  final UserProfile profile;

  /// Whether the sticky bar background and title are visible.
  final bool showStickyBar;

  /// Optional callback when navigating back.
  final VoidCallback? onBack;

  /// Creates a sticky header for the user profile page.
  const ProfileStickyHeader({
    super.key,
    required this.profile,
    required this.showStickyBar,
    this.onBack,
  });

  void _handleShare() {
    if (profile.name.isEmpty) return;
    final shareUrl = 'https://anilist.co/user/${profile.name}/';
    SharePlus.instance.share(ShareParams(text: shareUrl));
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: kAnimFast,
          height: topPadding + 56,
          padding: EdgeInsets.only(top: topPadding),
          decoration: BoxDecoration(
            color: showStickyBar ? bgColor : Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: showStickyBar ? cardBorderColor : Colors.transparent,
              ),
            ),
          ),
          child: Stack(
            children: [
              if (onBack != null)
                Positioned(
                  left: 16,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: GestureDetector(
                      onTap: onBack,
                      child: _buildGlassCircle(
                        child: const Icon(
                          LucideIcons.arrowLeft,
                          color: textPrimary,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              Positioned.fill(
                left: onBack != null ? 72 : 20,
                right: 72,
                child: AnimatedOpacity(
                  opacity: showStickyBar ? 1.0 : 0.0,
                  duration: kAnimFast,
                  child: Center(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            profile.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 16,
                top: 0,
                bottom: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: _handleShare,
                    child: _buildGlassCircle(
                      child: const Icon(
                        LucideIcons.share2,
                        color: textPrimary,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGlassCircle({required Widget child}) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: showStickyBar ? 0 : 10,
          sigmaY: showStickyBar ? 0 : 10,
        ),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: showStickyBar
                ? Colors.transparent
                : shadowColor.withValues(alpha: 0.4),
            shape: BoxShape.circle,
          ),
          child: child,
        ),
      ),
    );
  }
}
