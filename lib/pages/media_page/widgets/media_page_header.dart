import 'package:flutter/material.dart';

import '../../../components/app_network_image.dart';
import '../../../models/media.dart';
import '../../../theme/theme.dart';

/// Header component for the anime details page
class MediaPageHeader extends StatelessWidget {
  /// The anime media data
  final Media media;

  /// Creates an anime page header
  const MediaPageHeader({super.key, required this.media});

  @override
  /// Builds the anime page header widget
  Widget build(BuildContext context) {
    final title = media.title.userPreferred.isNotEmpty
        ? media.title.userPreferred
        : media.title.romaji.isNotEmpty
        ? media.title.romaji
        : media.title.english.isNotEmpty
        ? media.title.english
        : 'Unknown';
    final imageUrl = media.coverImage.large;
    final bannerUrl = media.bannerImage;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: 280,
              width: double.infinity,
              color: shadowColor,
              child: bannerUrl.isNotEmpty
                  ? AppNetworkImage(
                      imageUrl: bannerUrl,
                      width: double.infinity,
                      height: 280,
                    )
                  : const SizedBox.shrink(),
            ),
            Container(
              height: 281,
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
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (imageUrl.isNotEmpty)
                AppNetworkImage(
                  imageUrl: imageUrl,
                  width: 120,
                  height: 180,
                  borderRadius: BorderRadius.circular(12),
                ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: textPrimary,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow(
                      Icons.tv_outlined,
                      media.format.isNotEmpty ? media.format : 'TV',
                    ),
                    const SizedBox(height: 8),
                    _buildInfoRow(
                      Icons.timer_outlined,
                      '${media.episodes > 0 ? media.episodes.toString() : '?'} Episodes',
                    ),
                    const SizedBox(height: 8),
                    _buildInfoRow(
                      Icons.rss_feed_rounded,
                      media.status.isNotEmpty ? media.status : 'FINISHED',
                    ),
                    if (media.season.isNotEmpty && media.seasonYear > 0) ...[
                      const SizedBox(height: 8),
                      _buildInfoRow(
                        Icons.calendar_today_rounded,
                        '${media.season} ${media.seasonYear}'.toUpperCase(),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds a single information row with an icon and label
  Widget _buildInfoRow(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: textSecondary, size: 18),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
