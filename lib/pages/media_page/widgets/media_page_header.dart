import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../components/app_network_image.dart';
import '../../../models/media.dart';
import '../../../theme/theme.dart';

/// Header component for the media details page
class MediaPageHeader extends StatelessWidget {
  /// The media data
  final Media media;

  /// Creates a media page header
  const MediaPageHeader({super.key, required this.media});

  @override
  /// Builds the media page header widget
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
                      _getFormatIcon(media.format),
                      media.format.isNotEmpty
                          ? media.format.replaceAll('_', ' ')
                          : 'TV',
                    ),
                    const SizedBox(height: 8),
                    if (media.type == 'ANIME') ...[
                      _buildInfoRow(
                        LucideIcons.timer,
                        '${media.episodes > 0 ? media.episodes.toString() : '?'} Episodes',
                      ),
                      const SizedBox(height: 8),
                      _buildInfoRow(
                        LucideIcons.rss,
                        media.status.isNotEmpty ? media.status : 'FINISHED',
                      ),
                      if (media.season.isNotEmpty && media.seasonYear > 0) ...[
                        const SizedBox(height: 8),
                        _buildInfoRow(
                          LucideIcons.calendarDays,
                          '${media.season} ${media.seasonYear}'.toUpperCase(),
                        ),
                      ],
                    ] else ...[
                      _buildInfoRow(
                        LucideIcons.bookOpenText,
                        '${media.chapters != null && media.chapters! > 0 ? media.chapters.toString() : '?'} Chapters',
                      ),
                      if (media.volumes != null && media.volumes! > 0) ...[
                        const SizedBox(height: 8),
                        _buildInfoRow(
                          LucideIcons.bookCopy,
                          '${media.volumes} Volumes',
                        ),
                      ],
                      const SizedBox(height: 8),
                      _buildInfoRow(
                        LucideIcons.rss,
                        media.status.isNotEmpty ? media.status : 'FINISHED',
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

  /// Returns the corresponding Lucide icon for a media format.
  IconData _getFormatIcon(String format) {
    switch (format.toUpperCase()) {
      case 'TV':
      case 'TV_SHORT':
        return LucideIcons.monitor;
      case 'MOVIE':
        return LucideIcons.clapperboard;
      case 'SPECIAL':
        return LucideIcons.ticket;
      case 'OVA':
        return LucideIcons.disc;
      case 'ONA':
        return LucideIcons.globe;
      case 'MUSIC':
        return LucideIcons.music;
      case 'MANGA':
        return LucideIcons.bookImage;
      case 'NOVEL':
        return LucideIcons.book;
      case 'ONE_SHOT':
        return LucideIcons.fileText;
      default:
        return LucideIcons.monitor;
    }
  }
}
