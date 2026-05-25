import 'package:flutter/material.dart';

import '../../../components/app_network_image.dart';
import '../../../components/html_description.dart';
import '../../../models/media_review.dart';
import '../../../theme/theme.dart';

/// A bottom sheet displaying details about a review
class ReviewSheet extends StatelessWidget {
  /// The review data to display
  final ReviewNode review;

  /// The media/anime title
  final String mediaTitle;

  /// Creates a review sheet
  const ReviewSheet({
    super.key,
    required this.review,
    required this.mediaTitle,
  });

  @override
  Widget build(BuildContext context) {
    final bool isUpVoted = review.userRating == ReviewUserRating.upVote;
    final bool isDownVoted = review.userRating == ReviewUserRating.downVote;

    return DraggableScrollableSheet(
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF161616),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            border: Border.all(color: cardBorderColor),
          ),
          child: Column(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onVerticalDragUpdate: (details) {},
                child: Container(
                  height: 32,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$mediaTitle review',
                        style: const TextStyle(
                          color: textPrimary,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: AppNetworkImage(
                              imageUrl: review.user?.avatarMedium ?? '',
                              width: 30,
                              height: 30,
                              fallbackIcon: Icons.person,
                              checkDefault: true,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              review.user?.name ?? 'Anonymous',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: textSecondary,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
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
                                  size: 16,
                                  color: scoreStar,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  (review.score / 10.0).toStringAsFixed(1),
                                  style: const TextStyle(
                                    color: textPrimary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Icon(
                            isUpVoted
                                ? Icons.thumb_up_rounded
                                : Icons.thumb_up_outlined,
                            color: isUpVoted ? Colors.white : textHint,
                            size: 22,
                          ),
                          const SizedBox(width: 14),
                          Icon(
                            isDownVoted
                                ? Icons.thumb_down_rounded
                                : Icons.thumb_down_outlined,
                            color: isDownVoted ? Colors.white : textHint,
                            size: 22,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      HtmlDescription(html: review.body),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
