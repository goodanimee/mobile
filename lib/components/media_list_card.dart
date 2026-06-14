import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../models/common.dart';
import '../models/media_list.dart';
import '../services/media_list_service.dart';
import '../theme/theme.dart';
import '../utils/app_options.dart';
import '../utils/media_list_mutations.dart';
import '../utils/utils.dart';
import 'app_badges.dart';
import 'app_network_image.dart';
import 'lucide_icons_helper.dart';

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
        const Icon(LucideIcons.rotateCcw, size: 14, color: textSecondary),
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
  dynamic maximum,
  String type,
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
          const Icon(LucideIcons.timer, size: 14, color: Colors.white70),
          const SizedBox(width: 4),
          Text(
            type == 'ANIME'
                ? '$maximum ${maximum is int ? StringUtils.pluralize(maximum, 'ep', 'eps') : 'eps'}'
                : '$maximum ${maximum is int ? StringUtils.pluralize(maximum, 'ch', 'chs') : 'chs'}',
            style: labelStyle,
          ),
        ],
      ),
    );
  }

  final icon = switch (status) {
    MediaListStatus.completed => LucideIcons.badgeCheck,
    MediaListStatus.paused => LucideIcons.circlePause,
    MediaListStatus.dropped => LucideIcons.ban,
    _ => type == 'ANIME' ? LucideIcons.playCircle : LucideIcons.bookOpenText,
  };

  return Container(
    padding: badgePadding,
    decoration: badgeDecoration,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: textSecondary),
        const SizedBox(width: 4),
        Text('$progress / $maximum', style: labelStyle),
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
      const LucideStarIcon(isFilled: true, size: 14, color: scoreStar),
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
Widget _buildPlayButton({
  VoidCallback? onTap,
  bool isLoading = false,
  bool isManga = false,
}) {
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
            : Icon(
                isManga ? LucideIcons.bookMarked : LucideIcons.play,
                size: 28,
                color: textSecondary,
              ),
      ),
    ),
  );
}

/// A card widget displaying an media entry in a list
class MediaListCard extends StatefulWidget {
  /// The media list entry data
  final MediaListEntryWithMedia entry;

  /// Callback when the entry is updated
  final void Function(int mediaId, MediaOptionsResult result)? onEntryUpdated;

  /// Callback for long press
  final VoidCallback? onLongPress;

  /// Callback for tap
  final VoidCallback? onTap;

  /// Creates an anime list card
  const MediaListCard({
    super.key,
    required this.entry,
    this.onEntryUpdated,
    this.onLongPress,
    this.onTap,
  });

  @override
  State<MediaListCard> createState() => _MediaListCardState();
}

/// State for MediaListCard
class _MediaListCardState extends State<MediaListCard> {
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
  void didUpdateWidget(MediaListCard oldWidget) {
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
    final updatedEntry = widget.entry.incrementProgress();

    setState(() {
      _progress = updatedEntry.progress;
      _status = updatedEntry.status;
      _isUpdating = true;
    });

    DateTime? parseFuzzyDate(FuzzyDate? fuzzyDate) {
      if (fuzzyDate == null) return null;
      final y = fuzzyDate.year;
      final m = fuzzyDate.month;
      final d = fuzzyDate.day;
      if (y != null && m != null && d != null) {
        return DateTime(y, m, d);
      }
      return null;
    }

    try {
      await MediaListService.saveEntry(
        mediaId: mediaId,
        progress: updatedEntry.progress,
        status: updatedEntry.status,
        startDate: parseFuzzyDate(updatedEntry.startedAt),
        finishDate: parseFuzzyDate(updatedEntry.completedAt),
        progressVolumes: updatedEntry.progressVolumes,
        repeat: updatedEntry.repeat,
      );
      widget.onEntryUpdated?.call(
        mediaId,
        MediaOptionsResult(entry: updatedEntry),
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
    final maximum = widget.entry.media.type == 'ANIME'
        ? (widget.entry.media.episodes > 0 ? widget.entry.media.episodes : '?')
        : (widget.entry.media.chapters > 0 ? widget.entry.media.chapters : '?');
    final repeat = widget.entry.repeat;
    final score = widget.entry.score;

    final isAdult = widget.entry.media.isAdult;
    final isFavourite = widget.entry.media.isFavourite;

    final showPlayButton =
        _status == MediaListStatus.current ||
        _status == MediaListStatus.repeating ||
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
                                    const LucideStarIcon(
                                      isFilled: true,
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
                                      maximum,
                                      widget.entry.media.type,
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
                          isManga: widget.entry.media.type == 'MANGA',
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
