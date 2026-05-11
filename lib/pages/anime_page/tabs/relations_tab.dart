import 'package:flutter/material.dart';
import '../../../components/app_relation_card.dart';
import '../../../components/app_section.dart';
import '../../../utils/app_navigation.dart';
import '../../../utils/utils.dart';

/// Tab displaying related media
class AnimeRelationsTab extends StatelessWidget {
  /// Initial data for relations
  final Map<String, dynamic>? data;

  /// Whether this tab is nested within another scroll view
  final bool isNested;

  /// Creates a relations tab
  const AnimeRelationsTab({super.key, this.data, this.isNested = false});

  @override
  Widget build(BuildContext context) {
    final edges = data?['edges'] as List? ?? [];

    if (edges.isEmpty) {
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
                'No relations found',
                style: TextStyle(color: Colors.white54, fontSize: 15),
              ),
            ],
          ),
        ),
      );

      if (isNested) return emptyContent;
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
                itemCount: edges.length,
                itemBuilder: (context, index) {
                  final edge = edges[index] as Map<String, dynamic>;
                  final node = edge['node'] as Map<String, dynamic>;
                  final title = node['title'];

                  final name =
                      title['english'] ??
                      title['romaji'] ??
                      title['userPreferred'] ??
                      'Unknown';
                  final nativeName = title['native'] ?? '';
                  final format = node['format'] ?? '';
                  final relation = StringUtils.capitalize(
                    edge['relationType']?.toString().replaceAll('_', ' ') ?? '',
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
                        ? () =>
                              AppNavigation.toAnime(context, node['id'] as int)
                        : null,
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );

    if (isNested) {
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
