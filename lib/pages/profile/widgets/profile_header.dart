import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../components/app_network_image.dart';
import '../../../models/user_profile.dart';
import '../../../theme/theme.dart';
import '../../../utils/utils.dart';

/// Header widget displaying user cover, avatar, identity, and social stats.
class ProfileHeader extends StatelessWidget {
  /// User profile data to display.
  final UserProfile profile;

  /// Optional callback when tapping following count.
  final VoidCallback? onTapFollowing;

  /// Optional callback when tapping followers count.
  final VoidCallback? onTapFollowers;

  /// Creates a profile header.
  const ProfileHeader({
    super.key,
    required this.profile,
    this.onTapFollowing,
    this.onTapFollowers,
  });

  @override
  Widget build(BuildContext context) {
    final avatarUrl = profile.avatarLarge.isNotEmpty
        ? profile.avatarLarge
        : profile.avatarMedium;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: 180,
              width: double.infinity,
              color: shadowColor,
              child: profile.bannerImage.isNotEmpty
                  ? AppNetworkImage(
                      imageUrl: profile.bannerImage,
                      width: double.infinity,
                      height: 180,
                    )
                  : Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            paletteBlueDark.withValues(alpha: 0.4),
                            palettePurpleDark.withValues(alpha: 0.2),
                            bgColor,
                          ],
                        ),
                      ),
                    ),
            ),
            Container(
              height: 181,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    shadowColor.withValues(alpha: 0.3),
                    Colors.transparent,
                    bgColor.withValues(alpha: 0.8),
                    bgColor,
                  ],
                  stops: const [0.0, 0.4, 0.8, 1.0],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 16),
          child: Row(
            children: [
              _buildAvatar(avatarUrl),
              const SizedBox(width: 14),
              Expanded(child: _buildIdentityDetails()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar(String avatarUrl) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: cardBorderColor, width: 2.5),
        boxShadow: const [
          BoxShadow(
            color: Color(0x60000000),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipOval(
        child: AppNetworkImage(
          imageUrl: avatarUrl,
          width: 72,
          height: 72,
          fallbackIcon: LucideIcons.user,
        ),
      ),
    );
  }

  Widget _buildIdentityDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                profile.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textPrimary,
                  height: 1.2,
                ),
              ),
            ),
            if (profile.isFollower) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: paletteBlue.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: paletteBlue.withValues(alpha: 0.4)),
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
        const SizedBox(height: 6),
        Wrap(
          spacing: 16,
          runSpacing: 4,
          children: [
            _buildStat(
              count: profile.followingCount,
              label: 'Following',
              onTap: onTapFollowing,
            ),
            _buildStat(
              count: profile.followersCount,
              label: 'Followers',
              onTap: onTapFollowers,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStat({
    required int count,
    required String label,
    VoidCallback? onTap,
  }) {
    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          StringUtils.formatCompactNumber(count),
          style: const TextStyle(
            color: textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(color: textSecondary, fontSize: 13)),
      ],
    );

    if (onTap == null) return content;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: content,
      ),
    );
  }
}
