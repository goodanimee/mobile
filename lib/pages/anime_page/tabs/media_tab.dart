import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../components/section_title.dart';
import '../../../components/app_network_image.dart';
import '../../../components/error_view.dart';

/// A tab displaying trailers and streaming episodes for an anime
class AnimeMediaTab extends StatelessWidget {
  /// The anime media data
  final Map<String, dynamic> media;

  /// Whether this tab is mounted within another scroll view
  final bool isNested;

  /// Creates a media tab
  const AnimeMediaTab({super.key, required this.media, this.isNested = false});

  @override
  Widget build(BuildContext context) {
    final trailer = media['trailer'] as Map<String, dynamic>?;
    final hasYoutubeTrailer =
        trailer != null &&
        trailer['site']?.toString().toLowerCase() == 'youtube' &&
        trailer['id'] != null;

    String trailerThumbnail = trailer?['thumbnail']?.toString() ?? '';
    if (trailerThumbnail.isEmpty && hasYoutubeTrailer) {
      final id = trailer['id'].toString();
      trailerThumbnail = 'https://img.youtube.com/vi/$id/hqdefault.jpg';
    }

    final rawEpisodes = media['streamingEpisodes'] as List? ?? [];

    int getEpNum(dynamic ep) {
      final title = ep['title']?.toString() ?? '';
      final match = RegExp(r'Episode\s+(\d+)').firstMatch(title);
      if (match != null) {
        return int.tryParse(match.group(1)!) ?? 0;
      }
      return 0;
    }

    final allEpisodes = List<dynamic>.from(rawEpisodes)
      ..sort((a, b) => getEpNum(a).compareTo(getEpNum(b)));

    final mediaListEntry = media['mediaListEntry'] as Map<String, dynamic>?;
    final progress = mediaListEntry?['progress'] as int? ?? 0;
    final epCount = media['episodes'] as int?;

    final watchedEpisodes = <dynamic>[];
    final continueWatching = <dynamic>[];

    for (final ep in allEpisodes) {
      final epNum = getEpNum(ep);
      if (epNum > 0 && epNum <= progress) {
        watchedEpisodes.add(ep);
      } else {
        continueWatching.add(ep);
      }
    }

    watchedEpisodes.sort((a, b) => getEpNum(b).compareTo(getEpNum(a)));
    continueWatching.sort((a, b) => getEpNum(a).compareTo(getEpNum(b)));

    final bool showSplitView =
        progress > 0 &&
        (epCount == null || progress < epCount) &&
        continueWatching.isNotEmpty;

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasYoutubeTrailer) ...[
          const SectionTitle(title: 'Trailer', bottomPadding: 12),
          GestureDetector(
            onTap: () async {
              final url = 'https://www.youtube.com/watch?v=${trailer['id']}';
              final uri = Uri.parse(url);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
            },
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: trailerThumbnail,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.white.withValues(alpha: 0.05),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.white.withValues(alpha: 0.05),
                        child: const Icon(Icons.error, color: Colors.white24),
                      ),
                    ),
                  ),
                  Container(
                    width: 68,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF0000).withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
        if (showSplitView) ...[
          const SectionTitle(title: 'Continue Watching', bottomPadding: 12),
          SizedBox(
            height: 160,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: continueWatching.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) => _buildEpisodeCard(
                continueWatching[index],
                index,
                isWatched: false,
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (watchedEpisodes.isNotEmpty) ...[
            const SectionTitle(title: 'Watched Episodes', bottomPadding: 12),
            SizedBox(
              height: 160,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: watchedEpisodes.length,
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) => _buildEpisodeCard(
                  watchedEpisodes[index],
                  index,
                  isWatched: true,
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ] else if (allEpisodes.isNotEmpty) ...[
          const SectionTitle(title: 'All Episodes', bottomPadding: 12),
          SizedBox(
            height: 160,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: allEpisodes.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) => _buildEpisodeCard(
                allEpisodes[index],
                index,
                isWatched: false,
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
        if (!hasYoutubeTrailer && allEpisodes.isEmpty)
          const AppErrorView(message: 'No media available', topPadding: 40),
      ],
    );

    if (isNested) {
      return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 24),
        child: content,
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 128),
      child: content,
    );
  }

  Widget _buildEpisodeCard(
    Map<String, dynamic> ep,
    int index, {
    required bool isWatched,
  }) {
    final epTitle = ep['title']?.toString() ?? 'Episode ${index + 1}';
    final epThumb = ep['thumbnail']?.toString() ?? '';
    final epUrl = ep['url']?.toString() ?? '';

    return GestureDetector(
      onTap: () async {
        if (epUrl.isNotEmpty) {
          final uri = Uri.parse(epUrl);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        }
      },
      child: SizedBox(
        width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AppNetworkImage(
                    imageUrl: epThumb,
                    borderRadius: BorderRadius.circular(12),
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF47521).withValues(alpha: 0.9),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Icon(
                      isWatched ? Icons.replay : Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              epTitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
