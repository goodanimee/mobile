import 'package:flutter/material.dart';

import '../models/media_review.dart';
import '../theme/theme.dart';
import 'app_network_image.dart';

/// Card to display user reviews
class AppReviewCard extends StatelessWidget {
  /// The review data to display
  final ReviewNode review;

  /// Callback when tapped
  final VoidCallback? onTap;

  /// Creates a review card
  const AppReviewCard({
    super.key,
    required this.review,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final avatarUrl = review.user?.avatarMedium ?? '';
    final username = review.user?.name ?? 'Anonymous';
    final scoreStr = (review.score / 10.0).toStringAsFixed(1);
    final ratingStr = '${review.rating}/${review.ratingAmount}';

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: cardBorderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AppNetworkImage(
                  imageUrl: avatarUrl,
                  width: 24,
                  height: 24,
                  borderRadius: BorderRadius.circular(12),
                  fallbackIcon: Icons.person,
                  checkDefault: true,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    username,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: textSecondary,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: cardBorderColor),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        size: 15,
                        color: scoreStar,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        scoreStr,
                        style: const TextStyle(
                          color: textPrimary,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Text(
                review.summary,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: textMuted,
                  fontSize: 14,
                  height: 1.3,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(
                  Icons.thumb_up_rounded,
                  size: 14,
                  color: textHint,
                ),
                const SizedBox(width: 4),
                Text(
                  ratingStr,
                  style: const TextStyle(
                    color: textHint,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
