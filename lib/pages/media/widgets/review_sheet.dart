import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../components/app_network_image.dart';
import '../../../components/html_description.dart';
import '../../../components/lucide_icons_helper.dart';
import '../../../models/media_review.dart';
import '../../../services/media_service.dart';
import '../../../theme/theme.dart';

/// A bottom sheet displaying details about a review
class ReviewSheet extends StatefulWidget {
  /// The review data to display
  final ReviewNode review;

  /// The media/anime title
  final String mediaTitle;

  /// Callback when the review is updated
  final ValueChanged<ReviewNode>? onReviewUpdated;

  /// Creates a review sheet
  const ReviewSheet({
    super.key,
    required this.review,
    required this.mediaTitle,
    this.onReviewUpdated,
  });

  @override
  State<ReviewSheet> createState() => _ReviewSheetState();
}

class _ReviewSheetState extends State<ReviewSheet> {
  late ReviewUserRating _userRating;
  late int _rating;
  late int _ratingAmount;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _userRating = widget.review.userRating;
    _rating = widget.review.rating;
    _ratingAmount = widget.review.ratingAmount;
  }

  Future<void> _onVoteTapped(ReviewUserRating targetVote) async {
    if (_isLoading) return;
    ReviewUserRating finalVote;
    if (targetVote == ReviewUserRating.upVote) {
      finalVote = _userRating == ReviewUserRating.upVote
          ? ReviewUserRating.noVote
          : ReviewUserRating.upVote;
    } else {
      finalVote = _userRating == ReviewUserRating.downVote
          ? ReviewUserRating.noVote
          : ReviewUserRating.downVote;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      final responseReview = await MediaService.rateReview(
        widget.review.id,
        finalVote,
      );
      if (mounted) {
        setState(() {
          _userRating = responseReview.userRating;
          _rating = responseReview.rating;
          _ratingAmount = responseReview.ratingAmount;
        });
        final updatedReview = widget.review.copyWith(
          rating: responseReview.rating,
          ratingAmount: responseReview.ratingAmount,
          userRating: responseReview.userRating,
        );
        widget.onReviewUpdated?.call(updatedReview);
      }
    } catch (_) {
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        '${widget.mediaTitle} review',
                        style: const TextStyle(
                          color: textPrimary,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: AppNetworkImage(
                              imageUrl: widget.review.user?.avatarMedium ?? '',
                              width: 30,
                              height: 30,
                              fallbackIcon: LucideIcons.user,
                              checkDefault: true,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              widget.review.user?.name ?? 'Anonymous',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: textSecondary,
                                fontSize: 20,
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
                                const LucideStarIcon(
                                  isFilled: true,
                                  size: 18,
                                  color: scoreStar,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  (widget.review.score / 10.0).toStringAsFixed(
                                    1,
                                  ),
                                  style: const TextStyle(
                                    color: textPrimary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          _isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: () => _onVoteTapped(
                                        ReviewUserRating.upVote,
                                      ),
                                      behavior: HitTestBehavior.opaque,
                                      child: Icon(
                                        LucideIcons.thumbsUp,
                                        color:
                                            _userRating ==
                                                ReviewUserRating.upVote
                                            ? Colors.white
                                            : textHint,
                                        size: 26,
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    GestureDetector(
                                      onTap: () => _onVoteTapped(
                                        ReviewUserRating.downVote,
                                      ),
                                      behavior: HitTestBehavior.opaque,
                                      child: Icon(
                                        LucideIcons.thumbsDown,
                                        color:
                                            _userRating ==
                                                ReviewUserRating.downVote
                                            ? Colors.white
                                            : textHint,
                                        size: 26,
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(
                            LucideIcons.thumbsUp,
                            color: textHint.withValues(alpha: 0.6),
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '$_rating of $_ratingAmount people upvoted this review',
                            style: const TextStyle(
                              color: textHint,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      HtmlDescription(html: widget.review.body),
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
