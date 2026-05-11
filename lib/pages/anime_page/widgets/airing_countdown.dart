import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../utils/utils.dart';

/// A widget that displays a countdown until the next episode airs
class AiringCountdown extends StatelessWidget {
  /// The anime media data
  final Map<String, dynamic> media;

  /// Creates an airing countdown widget
  const AiringCountdown({super.key, required this.media});

  @override
  /// Builds the airing countdown widget
  Widget build(BuildContext context) {
    final nextAiring = media['nextAiringEpisode'] as Map<String, dynamic>?;
    final schedule = media['airingSchedule'] as Map<String, dynamic>?;

    int? airingAt;
    if (nextAiring != null && nextAiring['airingAt'] != null) {
      airingAt = (nextAiring['airingAt'] as num).toInt();
    } else if (schedule != null &&
        schedule['edges'] != null &&
        (schedule['edges'] as List).isNotEmpty) {
      final firstEdge = (schedule['edges'] as List)[0] as Map<String, dynamic>;
      if (firstEdge['node'] != null && firstEdge['node']['airingAt'] != null) {
        airingAt = (firstEdge['node']['airingAt'] as num).toInt();
      }
    }

    if (airingAt == null) return const SizedBox.shrink();

    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final remainingSeconds = airingAt - now;

    if (remainingSeconds <= 0 || remainingSeconds > 604800) {
      return const SizedBox.shrink();
    }

    final timeStr = StringUtils.formatAiringDuration(remainingSeconds);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: borderColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.timer_outlined, color: borderColor, size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Next episode will air in $timeStr',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
