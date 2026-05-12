import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../components/app_network_image.dart';
import '../../../utils/utils.dart';

class AnimePageHeader extends StatelessWidget {
  final Map<String, dynamic> media;
  final VoidCallback onBack;

  const AnimePageHeader({super.key, required this.media, required this.onBack});

  @override
  Widget build(BuildContext context) {
    final title = media.titleText;
    final imageUrl = media.coverImage;
    final bannerUrl = media.bannerImage ?? '';

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
            Positioned(
              top: MediaQuery.of(context).padding.top + 8,
              left: 16,
              child: GestureDetector(
                onTap: onBack,
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: textPrimary,
                  size: 28,
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
                      '${media['format'] ?? 'TV'}',
                    ),
                    const SizedBox(height: 8),
                    _buildInfoRow(
                      Icons.timer_outlined,
                      '${media['episodes'] ?? '?'} Episodes',
                    ),
                    const SizedBox(height: 8),
                    _buildInfoRow(
                      Icons.rss_feed_rounded,
                      '${media['status'] ?? 'FINISHED'}',
                    ),
                    if (media['season'] != null &&
                        media['seasonYear'] != null) ...[
                      const SizedBox(height: 8),
                      _buildInfoRow(
                        Icons.calendar_today_rounded,
                        '${media['season']} ${media['seasonYear']}'
                            .toUpperCase(),
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
