import 'package:flutter/material.dart';

import '../../../components/app_review_card.dart';
import '../../../components/app_section.dart';
import '../../../components/loading_indicator.dart';
import '../../../models/media_review.dart';
import '../../../services/anime_service.dart';
import '../../../theme/theme.dart';
import '../widgets/review_sheet.dart';

/// Tab displaying paginated reviews for an anime
class AnimeReviewsTab extends StatefulWidget {
  /// The media ID of the anime
  final int mediaId;

  /// Initial reviews data
  final ReviewConnection? initialData;

  /// The media/anime title name
  final String mediaName;

  /// Whether this tab is nested
  final bool isNested;

  /// Creates a reviews tab
  const AnimeReviewsTab({
    super.key,
    required this.mediaId,
    required this.mediaName,
    this.initialData,
    this.isNested = false,
  });

  @override
  State<AnimeReviewsTab> createState() => _AnimeReviewsTabState();
}

class _AnimeReviewsTabState extends State<AnimeReviewsTab> {
  final List<ReviewNode> _reviews = [];
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  bool _hasNextPage = false;
  bool _isFetchingMore = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _reviews.addAll(widget.initialData!.nodes);
      _hasNextPage = widget.initialData!.pageInfo.hasNextPage;
    }
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (!_hasNextPage || _isFetchingMore) return;

    final threshold = _scrollController.position.maxScrollExtent - 400;
    if (_scrollController.offset >= threshold) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    if (_isFetchingMore || !_hasNextPage) return;

    setState(() => _isFetchingMore = true);

    try {
      final connection = await AnimeService.getReviews(
        widget.mediaId,
        _currentPage + 1,
      );

      if (mounted) {
        setState(() {
          _reviews.addAll(connection.nodes);
          _currentPage++;
          _hasNextPage = connection.pageInfo.hasNextPage;
          _isFetchingMore = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() => _isFetchingMore = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_reviews.isEmpty && !_isFetchingMore) {
      final emptyContent = Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 64),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.rate_review_outlined,
                size: 48,
                color: textHint.withValues(alpha: 0.33),
              ),
              const SizedBox(height: 16),
              const Text(
                'No reviews found',
                style: TextStyle(color: textMuted, fontSize: 15),
              ),
            ],
          ),
        ),
      );

      if (widget.isNested) return emptyContent;
      return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: emptyContent,
      );
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.68;
    const carouselHeight = 270.0;
    const spacing = 12.0;
    final rowHeight = (carouselHeight - spacing) / 2;

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSection(
          title: 'Reviews',
          topSpacing: 0,
          children: [
            SizedBox(
              height: carouselHeight,
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                itemCount:
                    ((_reviews.length / 2).ceil()) + (_isFetchingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == (_reviews.length / 2).ceil()) {
                    return const Padding(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Center(
                        child: AppLoadingIndicator(topPadding: 0),
                      ),
                    );
                  }

                  final firstIdx = index * 2;
                  final secondIdx = firstIdx + 1;

                  return Padding(
                    padding: EdgeInsets.only(
                      right: index == ((_reviews.length / 2).ceil()) - 1
                          ? 0
                          : spacing,
                    ),
                    child: SizedBox(
                      width: cardWidth,
                      child: Column(
                        children: [
                          SizedBox(
                            height: rowHeight,
                            child: _buildReviewCard(firstIdx),
                          ),
                          if (secondIdx < _reviews.length) ...[
                            const SizedBox(height: spacing),
                            SizedBox(
                              height: rowHeight,
                              child: _buildReviewCard(secondIdx),
                            ),
                          ] else ...[
                            const Spacer(),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );

    if (widget.isNested) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: content,
      );
    }

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: content,
    );
  }

  Widget _buildReviewCard(int index) {
    if (index >= _reviews.length) return const SizedBox.shrink();

    final review = _reviews[index];
    return AppReviewCard(
      review: review,
      onTap: () {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => ReviewSheet(
            review: review,
            mediaTitle: widget.mediaName,
          ),
        );
      },
    );
  }
}
