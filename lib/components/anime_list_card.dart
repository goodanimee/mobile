import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../theme/theme.dart';
import '../utils/backend_helper.dart';
import '../services/auth_service.dart';
import '../proto/medialist.pb.dart';

Widget _buildRepeatBadge(int repeat) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: const BoxDecoration(
      color: Colors.black38,
      borderRadius: BorderRadius.all(Radius.circular(6)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.repeat_rounded, size: 14, color: Colors.white70),
        const SizedBox(width: 4),
        Text(
          repeat.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget _buildProgressBadge(String status, int progress, dynamic episodes) {
  const badgeDecoration = BoxDecoration(
    color: Colors.black38,
    borderRadius: BorderRadius.all(Radius.circular(6)),
  );
  const badgePadding = EdgeInsets.symmetric(horizontal: 6, vertical: 2);
  const labelStyle = TextStyle(
    color: Colors.white,
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  if (status == 'PLANNING') {
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
    'COMPLETED' => Icons.check_circle_rounded,
    'PAUSED' => Icons.pause_circle_rounded,
    'DROPPED' => Icons.cancel_rounded,
    _ => Icons.play_circle_fill_rounded,
  };

  return Container(
    padding: badgePadding,
    decoration: badgeDecoration,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Colors.white70),
        const SizedBox(width: 4),
        Text('$progress / $episodes', style: labelStyle),
      ],
    ),
  );
}

Widget _buildScoreBadge(num score) {
  final display = score % 1 == 0
      ? score.toInt().toString()
      : score.toStringAsFixed(1);
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Icon(Icons.star_rounded, size: 14, color: Colors.amber),
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

Widget _buildPlayButton({VoidCallback? onTap, bool isLoading = false}) {
  return GestureDetector(
    onTap: onTap,
    behavior: HitTestBehavior.opaque,
    child: Container(
      width: 55,
      height: 55,
      decoration: const BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Center(
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white70,
                  strokeWidth: 2,
                ),
              )
            : const Icon(
                Icons.play_arrow_rounded,
                size: 28,
                color: Colors.white70,
              ),
      ),
    ),
  );
}

class AnimeListCard extends StatefulWidget {
  final Map<String, dynamic> entry;
  final void Function(int mediaId, Map<String, dynamic> updates)?
  onEntryUpdated;
  final VoidCallback? onLongPress;

  const AnimeListCard({
    super.key,
    required this.entry,
    this.onEntryUpdated,
    this.onLongPress,
  });

  @override
  State<AnimeListCard> createState() => _AnimeListCardState();
}

class _AnimeListCardState extends State<AnimeListCard> {
  late int _progress;
  late String _status;
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    _progress = widget.entry['progress'] as int? ?? 0;
    _status = widget.entry['status'] as String? ?? '';
  }

  @override
  void didUpdateWidget(AnimeListCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.entry != widget.entry) {
      _progress = widget.entry['progress'] as int? ?? 0;
      _status = widget.entry['status'] as String? ?? '';
    }
  }

  Future<void> _incrementProgress() async {
    if (_isUpdating) return;

    final media = widget.entry['media'] as Map<String, dynamic>? ?? {};
    final mediaId = media['id'] as int?;
    if (mediaId == null) return;

    final epCount = media['episodes'] as int?;
    final newProgress = _progress + 1;
    final newStatus = (epCount != null && newProgress >= epCount)
        ? 'COMPLETED'
        : 'CURRENT';

    setState(() {
      _progress = newProgress;
      _status = newStatus;
      _isUpdating = true;
    });

    try {
      final token = await AuthService.getRawToken() ?? '';
      final req = SaveMediaListEntryRequest(
        mediaId: mediaId,
        progress: newProgress,
        status: newStatus,
      );
      await BackendHelper.saveMediaListEntry(req, token);
      widget.onEntryUpdated?.call(mediaId, {
        'progress': newProgress,
        'status': newStatus,
      });
    } catch (e) {
      setState(() {
        _progress = widget.entry['progress'] as int? ?? 0;
        _status = widget.entry['status'] as String? ?? '';
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
    final media = widget.entry['media'] as Map<String, dynamic>? ?? {};
    final title = media['title']?['userPreferred'] ?? 'Unknown';
    final coverImage = media['coverImage']?['large'];
    final imageColorHex = media['coverImage']?['color'];
    final color = imageColorHex != null
        ? Color(int.parse(imageColorHex.replaceAll('#', '0xFF')))
        : borderColor;
    final labelColor = Color.lerp(const Color(0xFFEEEEEE), color, 0.35)!;

    final format = media['format']?.toString().replaceAll('_', ' ') ?? '';
    final averageScore = media['averageScore'] as int?;
    final episodes = media['episodes'] ?? '?';
    final repeat = widget.entry['repeat'] as int? ?? 0;
    final score = (widget.entry['score'] as num?) ?? 0;

    final showPlayButton =
        _status == 'CURRENT' || _status == 'PLANNING' || _status == 'PAUSED';

    return GestureDetector(
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
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.2), width: 1.0),
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
                    if (coverImage != null)
                      CachedNetworkImage(
                        imageUrl: coverImage,
                        fit: BoxFit.cover,
                        errorWidget: (_, _, _) => const Icon(
                          Icons.broken_image,
                          color: Colors.white54,
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                color: Colors.white,
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
                                  if (averageScore != null &&
                                      averageScore > 0) ...[
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
                                      color: Colors.amber,
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
                                  ],
                                ),
                                if ((_status == 'COMPLETED' ||
                                        _status == 'DROPPED') &&
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
