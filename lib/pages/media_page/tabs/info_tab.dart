import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/app_pill.dart';
import '../../../components/app_section.dart';
import '../../../components/html_description.dart';
import '../../../components/stat_item.dart';
import '../../../models/media.dart';
import '../../../models/media_misc.dart';
import '../../../theme/theme.dart';
import '../../../utils/utils.dart';
import '../widgets/airing_countdown.dart';

/// A tab displaying general information and synopsis for a media item
class MediaInfoTab extends StatelessWidget {
  /// The media data
  final Media media;

  /// Whether to show spoiler-tagged tags
  final bool showSpoilers;

  /// Callback when the spoiler visibility is toggled
  final VoidCallback onToggleSpoilers;

  /// Whether this tab is nested within another scroll view
  final bool isNested;

  /// Creates an info tab
  const MediaInfoTab({
    super.key,
    required this.media,
    required this.showSpoilers,
    required this.onToggleSpoilers,
    this.isNested = false,
  });

  @override
  /// Builds the info tab widget
  Widget build(BuildContext context) {
    final tags = media.tags;
    final externalLinks = media.externalLinks;

    final bool hasSpoilers = tags.any((tag) => tag.isMediaSpoiler);
    final List<MediaTag> visibleTags = showSpoilers
        ? tags
        : tags.where((tag) => !tag.isMediaSpoiler).toList();

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
                value: media.averageScore > 0
                    ? '${(media.averageScore / 10).toStringAsFixed(1)}/10'
                    : 'N/A',
              ),
            ),
            Expanded(
              child: StatItem(
                label: 'Mean Score',
                value: media.meanScore != null && media.meanScore! > 0
                    ? '${(media.meanScore! / 10).toStringAsFixed(1)}/10'
                    : 'N/A',
              ),
            ),
            Expanded(
              child: StatItem(
                label: 'Favorites',
                value: media.favourites != null
                    ? media.favourites!.toString()
                    : 'N/A',
              ),
            ),
            Expanded(
              child: StatItem(
                label: 'Popularity',
                value: media.popularity > 0
                    ? media.popularity.toString()
                    : 'N/A',
              ),
            ),
          ],
        ),
        if (media.description.isNotEmpty)
          AppSection(
            title: 'Synopsis',
            children: [HtmlDescription(html: media.description)],
          ),
        if (media.genres.isNotEmpty) ...[
          const SizedBox(height: 12),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: media.genres.map((genre) {
              return AppPill(
                label: genre,
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
                ? GestureDetector(
                    onTap: onToggleSpoilers,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: spoilerColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: spoilerColor.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            showSpoilers ? LucideIcons.eyeOff : LucideIcons.eye,
                            size: 14,
                            color: spoilerColor,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            showSpoilers ? 'Hide spoilers' : 'Show spoilers',
                            style: TextStyle(
                              color: spoilerColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : null,
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: visibleTags.map((tag) {
                  return AppPill(
                    label: tag.name,
                    leadingText: '${tag.rank}%',
                    isSpoiler: tag.isMediaSpoiler,
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
                  final site = link.site;
                  final url = link.url;
                  final language = link.language;
                  final rawAbbr = language.isNotEmpty
                      ? StringUtils.getLanguageAbbreviation(language)
                      : 'Link';
                  final leadingText = rawAbbr != 'Link' ? rawAbbr : null;

                  return AppPill(
                    label: site,
                    leadingText: leadingText,
                    trailing: const Icon(
                      LucideIcons.arrowUpRight,
                      size: 12,
                      color: Colors.white38,
                    ),
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
    final studioEdges = media.studios;

    if (studioEdges.isEmpty) {
      return const SizedBox.shrink();
    }

    return AppSection(
      title: 'Studios',
      children: [
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: (() {
            final uniqueStudios = <int, ({int id, String name, bool isMain})>{};
            for (final edge in studioEdges) {
              final isMain = edge.isMain;
              final node = edge.node;
              final studioId = node.id;
              if (!uniqueStudios.containsKey(studioId) || isMain) {
                uniqueStudios[studioId] = (
                  id: studioId,
                  name: node.name,
                  isMain: isMain,
                );
              }
            }
            final sortedStudios = uniqueStudios.values.toList()
              ..sort((a, b) {
                final aMain = a.isMain ? 1 : 0;
                final bMain = b.isMain ? 1 : 0;
                return bMain.compareTo(aMain);
              });
            return sortedStudios.map((studio) {
              return AppPill(
                label: studio.name,
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
    final titleObj = media.title;
    final synonyms = media.synonyms;
    final rows = <MapEntry<String, String>>[];

    if (titleObj.romaji.isNotEmpty) {
      rows.add(MapEntry('Romaji', titleObj.romaji));
    }
    if (titleObj.english.isNotEmpty) {
      rows.add(MapEntry('English', titleObj.english));
    }
    if (titleObj.native.isNotEmpty) {
      rows.add(MapEntry('Native', titleObj.native));
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
