import 'package:flutter/material.dart';
import 'dart:convert';
import '../../../components/app_relation_card.dart';
import '../../../components/app_section.dart';
import '../../../components/loading_indicator.dart';
import '../../../utils/app_navigation.dart';
import '../../../utils/utils.dart';
import '../../../api/media_details_api.dart';
import '../../../services/auth_service.dart';
import '../../../proto/medialist.pb.dart';
import '../../../theme/theme.dart';
import '../../../models/media.dart';

/// Tab displaying related and recommended media
class AnimeRelationsTab extends StatefulWidget {
  /// The media ID of the anime
  final int mediaId;

  /// Initial data for relations
  final MediaConnection? relationsData;

  /// Initial data for recommendations
  final RecommendationConnection? initialRecommendations;

  /// Whether this tab is nested within another scroll view
  final bool isNested;

  /// Creates a relations tab
  const AnimeRelationsTab({
    super.key,
    required this.mediaId,
    this.relationsData,
    this.initialRecommendations,
    this.isNested = false,
  });

  @override
  State<AnimeRelationsTab> createState() => _AnimeRelationsTabState();
}

class _AnimeRelationsTabState extends State<AnimeRelationsTab> {
  final List<RecommendationEdge> _recommendations = [];
  int _recommendationPage = 1;
  bool _hasNextRecommendationPage = false;
  bool _isFetchingMore = false;

  ScrollController? _activeScrollController;
  final ScrollController _recommendationsScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (widget.initialRecommendations != null) {
      _recommendations.addAll(widget.initialRecommendations!.edges);
      _hasNextRecommendationPage =
          widget.initialRecommendations!.pageInfo.hasNextPage;
    }
    _recommendationsScrollController.addListener(
      _recommendationsScrollListener,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newController = PrimaryScrollController.maybeOf(context);
    if (_activeScrollController != newController) {
      _activeScrollController = newController;
    }
  }

  @override
  void dispose() {
    _recommendationsScrollController.dispose();
    super.dispose();
  }

  /// Listener for recommendations scroll to trigger pagination
  void _recommendationsScrollListener() {
    if (!_hasNextRecommendationPage || _isFetchingMore) return;

    final threshold =
        _recommendationsScrollController.position.maxScrollExtent - 400;
    if (_recommendationsScrollController.offset >= threshold) {
      _loadMoreRecommendations();
    }
  }

  /// Loads more recommendations from the backend
  Future<void> _loadMoreRecommendations() async {
    if (_isFetchingMore || !_hasNextRecommendationPage) return;

    setState(() => _isFetchingMore = true);

    try {
      final token = await AuthService.getRawToken() ?? '';
      final req = FetchMediaRecommendationsRequest(
        mediaId: widget.mediaId,
        page: _recommendationPage + 1,
        perPage: 25,
      );
      final response = await MediaApi.fetchMediaRecommendations(req, token);
      final data = json.decode(response.rawJson);
      final recommendationsMap =
          data['recommendations'] as Map<String, dynamic>;
      final connection = RecommendationConnection.fromJson(recommendationsMap);

      if (mounted) {
        setState(() {
          _recommendations.addAll(connection.edges);
          _recommendationPage++;
          _hasNextRecommendationPage = connection.pageInfo.hasNextPage;
          _isFetchingMore = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isFetchingMore = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final relationEdges = widget.relationsData?.edges ?? [];
    final hasRelations = relationEdges.isNotEmpty;
    final hasRecommendations = _recommendations.isNotEmpty;

    if (!hasRelations && !hasRecommendations) {
      final emptyContent = Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 64),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.shuffle_rounded,
                size: 48,
                color: textHint.withValues(alpha: 0.33),
              ),
              const SizedBox(height: 16),
              const Text(
                'No relations or recommendations found',
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
    const carouselHeight = 245.0;
    const spacing = 12.0;
    final rowHeight = (carouselHeight - spacing) / 2;
    final childAspectRatio = cardWidth / rowHeight;

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasRelations) ...[
          AppSection(
            title: 'Relations',
            topSpacing: 0,
            children: [
              SizedBox(
                height: carouselHeight,
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / childAspectRatio,
                    crossAxisSpacing: spacing,
                    mainAxisSpacing: spacing,
                  ),
                  itemCount: relationEdges.length,
                  itemBuilder: (context, index) {
                    final edge = relationEdges[index];
                    final node = edge.node;
                    final title = node?.title;

                    final name = title != null && title.english.isNotEmpty
                        ? title.english
                        : title != null && title.romaji.isNotEmpty
                        ? title.romaji
                        : title != null && title.userPreferred.isNotEmpty
                        ? title.userPreferred
                        : 'Unknown';
                    final nativeName = title?.native ?? '';
                    final format = node?.format ?? '';
                    final relation = StringUtils.capitalize(
                      edge.relationType.replaceAll('_', ' '),
                    );
                    final imageUrl = node?.coverImage.large ?? '';
                    final colorHex = node?.coverImage.color;
                    final color = ColorUtils.fromHex(
                      colorHex,
                      fallback: Colors.transparent,
                    );

                    final canNavigate = ![
                      'MUSIC',
                      'MANGA',
                      'NOVEL',
                      'ONESHOT',
                    ].contains(format);

                    return AppRelationCard(
                      imageUrl: imageUrl,
                      title: name,
                      nativeTitle: nativeName,
                      subtitle: '$format \u00B7 $relation',
                      color: color != Colors.transparent ? color : null,
                      trailing: Icon(
                        Icons.chevron_right_rounded,
                        size: 16,
                        color: textHint,
                      ),
                      onTap: canNavigate && node != null
                          ? () => AppNavigation.toAnime(context, node.id)
                          : null,
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
        if (hasRecommendations) ...[
          AppSection(
            title: 'Recommendations',
            topSpacing: hasRelations ? 8 : 0,
            children: [
              SizedBox(
                height: carouselHeight,
                child: ListView.builder(
                  controller: _recommendationsScrollController,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  itemCount:
                      ((_recommendations.length / 2).ceil()) +
                      (_isFetchingMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == (_recommendations.length / 2).ceil()) {
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
                        right:
                            index == ((_recommendations.length / 2).ceil()) - 1
                            ? 0
                            : spacing,
                      ),
                      child: SizedBox(
                        width: cardWidth,
                        child: Column(
                          children: [
                            SizedBox(
                              height: rowHeight,
                              child: _buildRecommendationCard(firstIdx),
                            ),
                            if (secondIdx < _recommendations.length) ...[
                              SizedBox(height: spacing),
                              SizedBox(
                                height: rowHeight,
                                child: _buildRecommendationCard(secondIdx),
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

  /// Builds an individual recommendation card
  Widget _buildRecommendationCard(int index) {
    if (index >= _recommendations.length) return const SizedBox.shrink();

    final edge = _recommendations[index];
    final node = edge.node;
    final media = node.mediaRecommendation;
    final title = media?.title;

    final name = title != null && title.english.isNotEmpty
        ? title.english
        : title != null && title.romaji.isNotEmpty
        ? title.romaji
        : title != null && title.userPreferred.isNotEmpty
        ? title.userPreferred
        : 'Unknown';
    final nativeName = title?.native ?? '';
    final format = media?.format ?? '';
    final rating = node.rating.toString();
    final imageUrl = media?.coverImage.large ?? '';
    final colorHex = media?.coverImage.color;
    final color = ColorUtils.fromHex(colorHex, fallback: Colors.transparent);

    return AppRelationCard(
      imageUrl: imageUrl,
      title: name,
      nativeTitle: nativeName,
      subtitle: '$format \u00B7 $rating',
      subtitleIcon: Icon(
        Icons.thumb_up_rounded,
        size: 12,
        color: textSecondary,
      ),
      color: color != Colors.transparent ? color : null,
      trailing: Icon(Icons.chevron_right_rounded, size: 16, color: textHint),
      onTap: media != null
          ? () => AppNavigation.toAnime(context, media.id)
          : null,
    );
  }
}
