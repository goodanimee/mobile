import 'package:flutter/material.dart';

import '../models/common.dart';
import '../models/media_list.dart';
import '../services/anime_list_service.dart';
import '../theme/theme.dart';
import '../utils/app_options.dart';
import 'app_badges.dart';
import 'app_network_image.dart';

/// Builds a badge showing repeat count
Widget _buildRepeatBadge(int repeat) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: const BoxDecoration(
      color: surfaceBackground,
      borderRadius: BorderRadius.all(Radius.circular(6)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.repeat_rounded, size: 14, color: textSecondary),
        const SizedBox(width: 4),
        Text(
          repeat.toString(),
          style: const TextStyle(
            color: textPrimary,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

/// Builds a badge showing progress and status
Widget _buildProgressBadge(
  MediaListStatus? status,
  int progress,
  dynamic episodes,
) {
  const badgeDecoration = BoxDecoration(
    color: Colors.black38,
    borderRadius: BorderRadius.all(Radius.circular(6)),
  );
  const badgePadding = EdgeInsets.symmetric(horizontal: 6, vertical: 2);
  const labelStyle = TextStyle(
    color: textPrimary,
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  if (status == MediaListStatus.planning) {
    return Container(
      padding: badgePadding,
      decoration: badgeDecoration,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.format_list_bulleted_rounded,
            size: 14,
            color: Colors.white70,
          ),
          const SizedBox(width: 4),
          Text('$episodes eps', style: labelStyle),
        ],
      ),
    );
  }

  final icon = switch (status) {
    MediaListStatus.completed => Icons.check_circle_rounded,
    MediaListStatus.paused => Icons.pause_circle_rounded,
    MediaListStatus.dropped => Icons.cancel_rounded,
    _ => Icons.play_circle_fill_rounded,
  };

  return Container(
    padding: badgePadding,
    decoration: badgeDecoration,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: textSecondary),
        const SizedBox(width: 4),
        Text('$progress / $episodes', style: labelStyle),
      ],
    ),
  );
}

/// Builds a badge showing the score
Widget _buildScoreBadge(num score) {
  final display = score % 1 == 0
      ? score.toInt().toString()
      : score.toStringAsFixed(1);
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Icon(Icons.star_rounded, size: 14, color: scoreStar),
      const SizedBox(width: 4),
      Text(
        display,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

/// Builds a button to increment progress
Widget _buildPlayButton({VoidCallback? onTap, bool isLoading = false}) {
  return GestureDetector(
    onTap: onTap,
    behavior: HitTestBehavior.opaque,
    child: Container(
      width: 55,
      height: 55,
      decoration: const BoxDecoration(
        color: surfaceBackground,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Center(
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: textSecondary,
                  strokeWidth: 2,
                ),
              )
            : const Icon(
                Icons.play_arrow_rounded,
                size: 28,
                color: textSecondary,
              ),
      ),
    ),
  );
}

/// A card widget displaying an anime entry in a list
class AnimeListCard extends StatefulWidget {
  /// The anime list entry data
  final MediaListEntryWithMedia entry;

  /// Callback when the entry is updated
  final void Function(int mediaId, AnimeOptionsResult result)? onEntryUpdated;

  /// Callback for long press
  final VoidCallback? onLongPress;

  /// Callback for tap
  final VoidCallback? onTap;

  /// Creates an anime list card
  const AnimeListCard({
    super.key,
    required this.entry,
    this.onEntryUpdated,
    this.onLongPress,
    this.onTap,
  });

  @override
  State<AnimeListCard> createState() => _AnimeListCardState();
}

/// State for AnimeListCard
class _AnimeListCardState extends State<AnimeListCard> {
  late int _progress;
  late MediaListStatus? _status;
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    _progress = widget.entry.progress;
    _status = widget.entry.status;
  }

  @override
  /// Updates state when widget properties change
  void didUpdateWidget(AnimeListCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.entry != widget.entry) {
      _progress = widget.entry.progress;
      _status = widget.entry.status;
    }
  }

  /// Increments the progress of the anime entry
  Future<void> _incrementProgress() async {
    if (_isUpdating) return;

    final mediaId = widget.entry.media.id;
    final epCount = widget.entry.media.episodes;
    final newProgress = _progress + 1;
    final newStatus = (epCount > 0 && newProgress >= epCount)
        ? MediaListStatus.completed
        : MediaListStatus.current;

    setState(() {
      _progress = newProgress;
      _status = newStatus;
      _isUpdating = true;
    });

    try {
      await AnimeListService.saveEntry(
        mediaId: mediaId,
        progress: newProgress,
        status: newStatus,
      );
      widget.onEntryUpdated?.call(
        mediaId,
        AnimeOptionsResult(
          entry: widget.entry.copyWith(
            progress: newProgress,
            status: newStatus,
          ),
        ),
      );
    } catch (e) {
      setState(() {
        _progress = widget.entry.progress;
        _status = widget.entry.status;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update progress: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isUpdating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.entry.media.title.userPreferred;
    final coverImage = widget.entry.media.coverImage.large;
    final imageColorHex = widget.entry.media.coverImage.color;
    final color = imageColorHex.isNotEmpty
        ? Color(int.parse(imageColorHex.replaceAll('#', '0xFF')))
        : borderColor;
    final labelColor = Color.lerp(neutralLight, color, 0.35)!;

    final format = widget.entry.media.format.replaceAll('_', ' ');
    final averageScore = widget.entry.media.averageScore;
    final episodes = widget.entry.media.episodes > 0
        ? widget.entry.media.episodes
        : '?';
    final repeat = widget.entry.repeat;
    final score = widget.entry.score;

    final isAdult = widget.entry.media.isAdult;
    final isFavourite = widget.entry.media.isFavourite;

    final showPlayButton =
        _status == MediaListStatus.current ||
        _status == MediaListStatus.planning ||
        _status == MediaListStatus.paused;

    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        height: 110,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.15),
              Color.lerp(color.withValues(alpha: 0.15), hoverBgColor, 0.75)!,
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Row(
            children: [
              SizedBox(
                width: 80,
                height: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(color: color.withValues(alpha: 0.2)),
                    AppNetworkImage(
                      imageUrl: coverImage,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: textPrimary,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 4),
                            if (format.isNotEmpty)
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    format,
                                    style: TextStyle(
                                      color: labelColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  if (averageScore > 0) ...[
                                    Text(
                                      ' · ',
                                      style: TextStyle(
                                        color: labelColor,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.star_rounded,
                                      size: 12,
                                      color: scoreStar,
                                    ),
                                    const SizedBox(width: 3),
                                    Text(
                                      (averageScore / 10).toStringAsFixed(1),
                                      style: TextStyle(
                                        color: labelColor,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _buildProgressBadge(
                                      _status,
                                      _progress,
                                      episodes,
                                    ),
                                    if (repeat > 0) ...[
                                      const SizedBox(width: 6),
                                      _buildRepeatBadge(repeat),
                                    ],
                                    if (isAdult) ...[
                                      const SizedBox(width: 6),
                                      const AppAdultBadge(),
                                    ],
                                    if (isFavourite) ...[
                                      const SizedBox(width: 6),
                                      const AppFavouriteBadge(size: 16),
                                    ],
                                  ],
                                ),
                                if ((_status == MediaListStatus.completed ||
                                        _status == MediaListStatus.dropped) &&
                                    score > 0)
                                  _buildScoreBadge(score),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (showPlayButton) ...[
                        const SizedBox(width: 8),
                        _buildPlayButton(
                          onTap: _isUpdating ? null : _incrementProgress,
                          isLoading: _isUpdating,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
