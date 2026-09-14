import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../theme/theme.dart';
import 'app_network_image.dart';

/// Card for related media entries
class AppRelationCard extends StatelessWidget {
  /// The cover image URL
  final String imageUrl;

  /// The English/Main title
  final String title;

  /// The native title
  final String? nativeTitle;

  /// The format and relation type string
  final String subtitle;

  /// Optional icon next to subtitle
  final Widget? subtitleIcon;

  /// Optional format string (renders as Line 3)
  final String? format;

  /// Optional image URL to render on the right side
  final String? rightImageUrl;

  /// Whether the subtitle should be right-aligned
  final bool rightAlignSubtitle;

  /// The accent color for theme
  final Color? color;

  /// Optional widget in the bottom right
  final Widget? trailing;

  /// Callback when tapped
  final VoidCallback? onTap;

  /// Optional callback when the right image is tapped
  final VoidCallback? onRightTap;

  /// Creates a relation card
  const AppRelationCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    this.nativeTitle,
    this.format,
    this.rightImageUrl,
    this.rightAlignSubtitle = false,
    this.subtitleIcon,
    this.color,
    this.trailing,
    this.onTap,
    this.onRightTap,
  });

  Widget _buildLeftImage() {
    return AppNetworkImage(
      imageUrl: imageUrl,
      width: 85,
      height: double.infinity,
      fallbackIcon: LucideIcons.clapperboard,
      checkDefault: true,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(11),
        bottomLeft: Radius.circular(11),
      ),
    );
  }

  Widget _buildRightImage() {
    return AppNetworkImage(
      imageUrl: rightImageUrl!,
      width: 85,
      height: double.infinity,
      fallbackIcon: LucideIcons.clapperboard,
      checkDefault: true,
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(11),
        bottomRight: Radius.circular(11),
      ),
    );
  }

  Widget _buildTextColumn() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                maxLines: format != null ? 1 : 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              if (nativeTitle != null &&
                  nativeTitle!.isNotEmpty &&
                  nativeTitle != title) ...[
                const SizedBox(height: 2),
                Text(
                  nativeTitle!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 15,
                    height: 1.2,
                  ),
                ),
              ],
              if (format != null && format!.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  format!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                  ),
                ),
              ],
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: rightAlignSubtitle
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: rightAlignSubtitle
                      ? TextAlign.end
                      : TextAlign.start,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                  ),
                ),
              ),
              if (subtitleIcon != null) ...[
                const SizedBox(width: 4),
                subtitleIcon!,
              ],
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasRightImage = rightImageUrl != null && rightImageUrl!.isNotEmpty;
    final isDualTap = onRightTap != null && hasRightImage;

    final cardDecoration = BoxDecoration(
      gradient: color != null
          ? LinearGradient(
              colors: [
                color!.withValues(alpha: 0.15),
                Color.lerp(color!.withValues(alpha: 0.15), hoverBgColor, 0.75)!,
              ],
            )
          : null,
      color: color == null ? Colors.white.withValues(alpha: 0.03) : null,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: color != null ? color!.withValues(alpha: 0.2) : Colors.white12,
      ),
    );

    if (isDualTap) {
      return Container(
        decoration: cardDecoration,
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onTap,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(11),
                        bottomLeft: Radius.circular(11),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildLeftImage(),
                          const SizedBox(width: 12),
                          Expanded(child: _buildTextColumn()),
                          const SizedBox(width: 12),
                        ],
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onRightTap,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(11),
                      bottomRight: Radius.circular(11),
                    ),
                    child: _buildRightImage(),
                  ),
                ),
              ],
            ),
            if (trailing != null)
              Positioned(bottom: 8, right: 8, child: trailing!),
          ],
        ),
      );
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: cardDecoration,
        child: Stack(
          children: [
            Row(
              children: [
                _buildLeftImage(),
                const SizedBox(width: 12),
                Expanded(child: _buildTextColumn()),
                if (hasRightImage) ...[
                  const SizedBox(width: 12),
                  _buildRightImage(),
                ],
              ],
            ),
            if (trailing != null)
              Positioned(bottom: 8, right: 8, child: trailing!),
          ],
        ),
      ),
    );
  }
}
