import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../components/app_network_image.dart';
import '../../../components/app_review_card.dart';
import '../../../components/app_section.dart';
import '../../../components/loading_indicator.dart';
import '../../../models/media_activity.dart';
import '../../../models/media_review.dart';
import '../../../services/media_service.dart';
import '../../../theme/theme.dart';
import '../widgets/review_sheet.dart';

/// Tab displaying paginated reviews for an anime
class MediaReviewsTab extends StatefulWidget {
  /// The media ID of the anime
  final int mediaId;

  /// Initial reviews data
  final ReviewConnection? initialData;

  /// The media/anime title name
  final String mediaName;

  /// The media type - ANIME or MANGA.
  final String mediaType;

  /// Whether this tab is nested
  final bool isNested;

  /// Trigger for manual refresh updates
  final int refreshTrigger;

  /// Creates a reviews tab
  const MediaReviewsTab({
    super.key,
    required this.mediaId,
    required this.mediaName,
    required this.mediaType,
    this.initialData,
    this.isNested = false,
    this.refreshTrigger = 0,
  });

  @override
  State<MediaReviewsTab> createState() => _MediaReviewsTabState();
}

class _MediaReviewsTabState extends State<MediaReviewsTab> {
  final List<ReviewNode> _reviews = [];
  final ScrollController _scrollController = ScrollController();
  final ScrollController _activitiesScrollController = ScrollController();
  int _currentPage = 1;
  bool _hasNextPage = false;
  bool _isFetchingMore = false;

  final List<ListActivity> _activities = [];
  bool _isLoadingActivities = true;
  String? _activitiesError;
  int _activitiesCurrentPage = 1;
  bool _activitiesHasNextPage = false;
  bool _isFetchingMoreActivities = false;
  final Set<int> _togglingActivities = {};

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _reviews.addAll(widget.initialData!.nodes);
      _hasNextPage = widget.initialData!.pageInfo.hasNextPage;
    }
    _scrollController.addListener(_scrollListener);
    _activitiesScrollController.addListener(_activitiesScrollListener);
    _fetchActivities();
  }

  @override
  void didUpdateWidget(MediaReviewsTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.refreshTrigger != oldWidget.refreshTrigger) {
      _fetchActivities();
    }
  }

  Future<void> _handleToggleLike(ListActivity activity) async {
    if (_togglingActivities.contains(activity.id)) return;

    setState(() {
      _togglingActivities.add(activity.id);
    });

    try {
      await MediaService.toggleActivityLike(activity.id);
      if (mounted) {
        setState(() {
          final index = _activities.indexWhere(
            (element) => element.id == activity.id,
          );
          if (index != -1) {
            final nextLiked = !activity.isLiked;
            final nextLikeCount = nextLiked
                ? activity.likeCount + 1
                : activity.likeCount - 1;
            _activities[index] = activity.copyWith(
              isLiked: nextLiked,
              likeCount: nextLikeCount,
            );
          }
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to toggle like: $e'),
            backgroundColor: Colors.redAccent.shade700,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _togglingActivities.remove(activity.id);
        });
      }
    }
  }

  Future<void> _fetchActivities() async {
    try {
      final connection = await MediaService.getActivities(widget.mediaId, 1);
      if (mounted) {
        setState(() {
          _activities.clear();
          _activities.addAll(connection.nodes);
          _activitiesCurrentPage = 1;
          _activitiesHasNextPage = connection.pageInfo.hasNextPage;
          _isLoadingActivities = false;
          _activitiesError = null;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingActivities = false;
          _activitiesError = 'Failed to load activities: $e';
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _activitiesScrollController.dispose();
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
      final connection = await MediaService.getReviews(
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

  void _activitiesScrollListener() {
    if (!_activitiesHasNextPage || _isFetchingMoreActivities) return;

    final threshold =
        _activitiesScrollController.position.maxScrollExtent - 400;
    if (_activitiesScrollController.offset >= threshold) {
      _loadMoreActivities();
    }
  }

  Future<void> _loadMoreActivities() async {
    if (_isFetchingMoreActivities || !_activitiesHasNextPage) return;

    setState(() => _isFetchingMoreActivities = true);

    try {
      final connection = await MediaService.getActivities(
        widget.mediaId,
        _activitiesCurrentPage + 1,
      );

      if (mounted) {
        setState(() {
          _activities.addAll(connection.nodes);
          _activitiesCurrentPage++;
          _activitiesHasNextPage = connection.pageInfo.hasNextPage;
          _isFetchingMoreActivities = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() => _isFetchingMoreActivities = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.68;
    const carouselHeight = 270.0;
    const spacing = 12.0;
    final rowHeight = (carouselHeight - spacing) / 2;

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_reviews.isNotEmpty) ...[
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
                      ((_reviews.length / 2).ceil()) +
                      (_isFetchingMore ? 1 : 0),
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
          const SizedBox(height: 24),
        ],
        AppSection(
          title: 'Recent Activity',
          topSpacing: _reviews.isEmpty ? 0 : 8,
          children: [_buildActivitiesSection()],
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

  Widget _buildActivitiesSection() {
    if (_isLoadingActivities) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 32),
        child: Center(child: AppLoadingIndicator(topPadding: 0)),
      );
    }

    if (_activitiesError != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Center(
          child: Text(
            _activitiesError!,
            style: const TextStyle(color: Colors.redAccent, fontSize: 14),
          ),
        ),
      );
    }

    if (_activities.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.history_rounded,
                size: 40,
                color: textHint.withValues(alpha: 0.33),
              ),
              const SizedBox(height: 12),
              const Text(
                'No recent activities found',
                style: TextStyle(color: textMuted, fontSize: 14),
              ),
            ],
          ),
        ),
      );
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.68;
    const carouselHeight = 172.0;
    const spacing = 12.0;
    final rowHeight = (carouselHeight - spacing) / 2;

    return SizedBox(
      height: carouselHeight,
      child: ListView.builder(
        controller: _activitiesScrollController,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemCount:
            ((_activities.length / 2).ceil()) +
            (_isFetchingMoreActivities ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == (_activities.length / 2).ceil()) {
            return const Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Center(child: AppLoadingIndicator(topPadding: 0)),
            );
          }

          final firstIdx = index * 2;
          final secondIdx = firstIdx + 1;

          return Padding(
            padding: EdgeInsets.only(
              right: index == ((_activities.length / 2).ceil()) - 1
                  ? 0
                  : spacing,
            ),
            child: SizedBox(
              width: cardWidth,
              child: Column(
                children: [
                  SizedBox(
                    height: rowHeight,
                    width: double.infinity,
                    child: _buildActivityCard(_activities[firstIdx]),
                  ),
                  if (secondIdx < _activities.length) ...[
                    const SizedBox(height: spacing),
                    SizedBox(
                      height: rowHeight,
                      width: double.infinity,
                      child: _buildActivityCard(_activities[secondIdx]),
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
    );
  }

  String _getActivityActionText(String status, String progress) {
    final s = status.toLowerCase();
    final animeName = widget.mediaName;

    if (s == 'completed') {
      return 'Completed ${widget.mediaType == 'ANIME' ? 'watching' : 'reading'} $animeName';
    } else {
      final capitalizedStatus = status.isNotEmpty
          ? '${status[0].toUpperCase()}${status.substring(1)}'
          : status;
      if (progress.isNotEmpty) {
        return '$capitalizedStatus $progress of $animeName';
      }
      return '$capitalizedStatus $animeName';
    }
  }

  String _formatTimeAgo(int timestampSeconds) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestampSeconds * 1000);
    return timeago.format(date);
  }

  Widget _buildActivityCard(ListActivity activity) {
    final avatarUrl = activity.user?.avatarMedium ?? '';
    final username = activity.user?.name ?? 'Anonymous';
    final actionText = _getActivityActionText(
      activity.status,
      activity.progress,
    );
    final timeStr = _formatTimeAgo(activity.createdAt);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cardBorderColor),
      ),
      child: Row(
        children: [
          AppNetworkImage(
            imageUrl: avatarUrl,
            width: 38,
            height: 38,
            borderRadius: BorderRadius.circular(19),
            fallbackIcon: Icons.person,
            checkDefault: true,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      username,
                      style: const TextStyle(
                        color: textSecondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      timeStr,
                      style: const TextStyle(color: textHint, fontSize: 11.5),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  actionText,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: textMuted,
                    fontSize: 13.5,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () => _handleToggleLike(activity),
            behavior: HitTestBehavior.opaque,
            child: SizedBox(
              width: 48,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _togglingActivities.contains(activity.id)
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: textSecondary,
                            ),
                          ),
                        )
                      : Icon(
                          activity.isLiked
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          color: activity.isLiked ? paletteRed : textMuted,
                          size: 20,
                        ),
                  const SizedBox(height: 4),
                  Text(
                    '${activity.likeCount}',
                    style: TextStyle(
                      color: activity.isLiked ? paletteRed : textMuted,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
            onReviewUpdated: (updatedReview) {
              setState(() {
                _reviews[index] = updatedReview;
              });
            },
          ),
        );
      },
    );
  }
}
