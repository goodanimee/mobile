import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/airing_countdown.dart';
import '../../../components/stat_item.dart';
import '../../../components/html_description.dart';
import '../../../components/app_pill.dart';
import '../../../components/app_section.dart';
import '../../../utils/utils.dart';

/// A tab displaying general information and synopsis for an anime
class AnimeInfoTab extends StatelessWidget {
  /// The anime media data
  final Map<String, dynamic> media;

  /// Whether to show spoiler-tagged tags
  final bool showSpoilers;

  /// Callback when the spoiler visibility is toggled
  final VoidCallback onToggleSpoilers;

  /// Whether this tab is nested within another scroll view
  final bool isNested;

  /// Creates an info tab
  const AnimeInfoTab({
    super.key,
    required this.media,
    required this.showSpoilers,
    required this.onToggleSpoilers,
    this.isNested = false,
  });

  @override
  /// Builds the info tab widget
  Widget build(BuildContext context) {
    final tags = media['tags'] as List? ?? [];
    final externalLinks = media['externalLinks'] as List? ?? [];

    bool hasSpoilers = tags.any((tag) => tag['isMediaSpoiler'] == true);
    List<dynamic> visibleTags = showSpoilers
        ? tags
        : tags.where((tag) => tag['isMediaSpoiler'] != true).toList();

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AiringCountdown(media: media),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: StatItem(
                label: 'Avg Score',
                value: media['averageScore'] != null
                    ? '${(media['averageScore'] / 10).toStringAsFixed(1)}/10'
                    : 'N/A',
              ),
            ),
            Expanded(
              child: StatItem(
                label: 'Mean Score',
                value: media['meanScore'] != null
                    ? '${(media['meanScore'] / 10).toStringAsFixed(1)}/10'
                    : 'N/A',
              ),
            ),
            Expanded(
              child: StatItem(
                label: 'Favorites',
                value: media['favourites']?.toString() ?? 'N/A',
              ),
            ),
            Expanded(
              child: StatItem(
                label: 'Popularity',
                value: media['popularity']?.toString() ?? 'N/A',
              ),
            ),
          ],
        ),
        if (media['description'] != null)
          AppSection(
            title: 'Synopsis',
            innerSpacing: 8,
            children: [HtmlDescription(html: media['description'] as String)],
          ),
        if (media['genres'] != null &&
            (media['genres'] as List).isNotEmpty) ...[
          const SizedBox(height: 12),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: (media['genres'] as List).map((genre) {
              return AppPill(
                label: genre.toString(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
              );
            }).toList(),
          ),
        ],
        _buildStudiosSection(),
        _buildTitlesSection(),
        if (tags.isNotEmpty)
          AppSection(
            title: 'Community Tags',
            trailing: hasSpoilers
                ? TextButton.icon(
                    onPressed: onToggleSpoilers,
                    icon: Icon(
                      showSpoilers ? Icons.expand_less : Icons.expand_more,
                      color: Colors.white70,
                      size: 20,
                    ),
                    label: Text(
                      showSpoilers ? 'Hide spoilers' : 'Show spoilers',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  )
                : null,
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: visibleTags.map((tag) {
                  return AppPill(
                    label: tag['name']?.toString() ?? '',
                    leadingText: '${tag['rank']}%',
                    isSpoiler: tag['isMediaSpoiler'] as bool? ?? false,
                  );
                }).toList(),
              ),
            ],
          ),
        if (externalLinks.isNotEmpty)
          AppSection(
            title: 'External Links',
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: externalLinks.map((link) {
                  final site = link['site']?.toString() ?? 'Link';
                  final url = link['url']?.toString() ?? '';
                  final language = link['language']?.toString();

                  return AppPill(
                    label: site,
                    leadingText: StringUtils.getLanguageAbbreviation(language),
                    onTap: () async {
                      if (url.isNotEmpty) {
                        final uri = Uri.parse(url);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(
                            uri,
                            mode: LaunchMode.externalApplication,
                          );
                        }
                      }
                    },
                  );
                }).toList(),
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
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: content,
    );
  }

  /// Builds the studios section
  Widget _buildStudiosSection() {
    final studiosData = media['studios'];
    List? studioEdges;
    if (studiosData is Map) {
      studioEdges = studiosData['edges'] as List?;
    }

    if (studioEdges == null || studioEdges.isEmpty) {
      return const SizedBox.shrink();
    }

    return AppSection(
      title: 'Studios',
      children: [
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: (() {
            final uniqueStudios = <int, Map<String, dynamic>>{};
            for (var edge in studioEdges!) {
              if (edge is Map) {
                final isMain = edge['isMain'] == true;
                final node = edge['node'];
                if (node is Map && node['id'] != null) {
                  final studioId = node['id'] as int;
                  if (!uniqueStudios.containsKey(studioId) || isMain) {
                    uniqueStudios[studioId] = {
                      'id': studioId,
                      'name': node['name'],
                      'isMain': isMain,
                    };
                  }
                }
              }
            }
            final sortedStudios = uniqueStudios.values.toList()
              ..sort((a, b) {
                final aMain = a['isMain'] == true ? 1 : 0;
                final bMain = b['isMain'] == true ? 1 : 0;
                return bMain.compareTo(aMain);
              });
            return sortedStudios.map((studio) {
              return AppPill(
                label: studio['name'].toString(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
              );
            }).toList();
          })(),
        ),
      ],
    );
  }

  /// Builds the titles and synonyms section
  Widget _buildTitlesSection() {
    final titleObj = media['title'] as Map<String, dynamic>? ?? {};
    final synonyms = media['synonyms'] as List? ?? [];
    final rows = <MapEntry<String, String>>[];

    if (titleObj['romaji'] != null) {
      rows.add(MapEntry('Romaji', titleObj['romaji']));
    }
    if (titleObj['english'] != null) {
      rows.add(MapEntry('English', titleObj['english']));
    }
    if (titleObj['native'] != null) {
      rows.add(MapEntry('Native', titleObj['native']));
    }

    final synonymsStr = synonyms.join(', ');
    if (synonymsStr.isNotEmpty) {
      rows.add(MapEntry('Synonyms', synonymsStr));
    }

    if (rows.isEmpty) return const SizedBox.shrink();

    return AppSection(
      title: 'Titles & Synonyms',
      children: [
        Table(
          columnWidths: const {0: IntrinsicColumnWidth(), 1: FlexColumnWidth()},
          children: rows.map((entry) {
            return TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ).copyWith(left: 0),
                  child: Text(
                    entry.key,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ).copyWith(right: 0),
                  child: Text(
                    entry.value,
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
