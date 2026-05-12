import 'package:flutter/material.dart';
import 'dart:convert';
import '../../../components/app_relation_card.dart';
import '../../../components/app_section.dart';
import '../../../components/loading_indicator.dart';
import '../../../utils/app_navigation.dart';
import '../../../utils/utils.dart';
import '../../../utils/backend_helper.dart';
import '../../../services/auth_service.dart';
import '../../../proto/medialist.pb.dart';

/// Tab displaying related and recommended media
class AnimeRelationsTab extends StatefulWidget {
  /// The media ID of the anime
  final int mediaId;

  /// Initial data for relations
  final Map<String, dynamic>? relationsData;

  /// Initial data for recommendations
  final Map<String, dynamic>? initialRecommendations;

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
  final List<dynamic> _recommendations = [];
  int _recommendationPage = 1;
  bool _hasNextRecommendationPage = false;
  bool _isFetchingMore = false;

  ScrollController? _activeScrollController;
  final ScrollController _recommendationsScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (widget.initialRecommendations != null) {
      final edges = widget.initialRecommendations!['edges'] as List? ?? [];
      final pageInfo = widget.initialRecommendations!['pageInfo'];
      _recommendations.addAll(edges);
      _hasNextRecommendationPage = pageInfo?['hasNextPage'] ?? false;
    }
    _recommendationsScrollController.addListener(_recommendationsScrollListener);
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

  void _recommendationsScrollListener() {
    if (!_hasNextRecommendationPage || _isFetchingMore) return;

    final threshold =
        _recommendationsScrollController.position.maxScrollExtent - 400;
    if (_recommendationsScrollController.offset >= threshold) {
      _loadMoreRecommendations();
    }
  }

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
      final response = await BackendHelper.fetchMediaRecommendations(req, token);
      final data = json.decode(response.rawJson);
      final recommendations = data['recommendations'];
      final edges = recommendations['edges'] as List? ?? [];
      final pageInfo = recommendations['pageInfo'];

      if (mounted) {
        setState(() {
          _recommendations.addAll(edges);
          _recommendationPage++;
          _hasNextRecommendationPage = pageInfo['hasNextPage'] ?? false;
          _isFetchingMore = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isFetchingMore = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final relationEdges = widget.relationsData?['edges'] as List? ?? [];
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
                color: Colors.white.withValues(alpha: 0.1),
              ),
              const SizedBox(height: 16),
              const Text(
                'No relations or recommendations found',
                style: TextStyle(color: Colors.white54, fontSize: 15),
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
                    final edge = relationEdges[index] as Map<String, dynamic>;
                    final node = edge['node'] as Map<String, dynamic>;
                    final title = node['title'];

                    final name = title['english'] ??
                        title['romaji'] ??
                        title['userPreferred'] ??
                        'Unknown';
                    final nativeName = title['native'] ?? '';
                    final format = node['format'] ?? '';
                    final relation = StringUtils.capitalize(
                      edge['relationType']?.toString().replaceAll('_', ' ') ??
                          '',
                    );
                    final imageUrl = node['coverImage']?['large'] ?? '';
                    final colorHex = node['coverImage']?['color'];
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
                        color: Colors.white.withValues(alpha: 0.25),
                      ),
                      onTap: canNavigate
                          ? () => AppNavigation.toAnime(
                                context,
                                node['id'] as int,
                              )
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
                child: GridView.builder(
                  controller: _recommendationsScrollController,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / childAspectRatio,
                    crossAxisSpacing: spacing,
                    mainAxisSpacing: spacing,
                  ),
                  itemCount: _recommendations.length,
                  itemBuilder: (context, index) {
                    final edge = _recommendations[index] as Map<String, dynamic>;
                    final node = edge['node'] as Map<String, dynamic>;
                    final media =
                        node['mediaRecommendation'] as Map<String, dynamic>;
                    final title = media['title'];

                    final name = title['english'] ??
                        title['romaji'] ??
                        title['userPreferred'] ??
                        'Unknown';
                    final nativeName = title['native'] ?? '';
                    final format = media['format'] ?? '';
                    final rating = node['rating']?.toString() ?? '0';
                    final imageUrl = media['coverImage']?['large'] ?? '';
                    final colorHex = media['coverImage']?['color'];
                    final color = ColorUtils.fromHex(
                      colorHex,
                      fallback: Colors.transparent,
                    );

                    return AppRelationCard(
                      imageUrl: imageUrl,
                      title: name,
                      nativeTitle: nativeName,
                      subtitle: '$format \u00B7 $rating',
                      subtitleIcon: Icon(
                        Icons.thumb_up_rounded,
                        size: 12,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                      color: color != Colors.transparent ? color : null,
                      trailing: Icon(
                        Icons.chevron_right_rounded,
                        size: 16,
                        color: Colors.white.withValues(alpha: 0.25),
                      ),
                      onTap: () => AppNavigation.toAnime(
                        context,
                        media['id'] as int,
                      ),
                    );
                  },
                ),
              ),
              if (_isFetchingMore)
                const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Center(child: AppLoadingIndicator(topPadding: 0)),
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
}
