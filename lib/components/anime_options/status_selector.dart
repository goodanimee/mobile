import 'package:flutter/material.dart';
import '../../models/common.dart';
import '../../theme/theme.dart';
import '../section_title.dart';

class StatusSelector extends StatelessWidget {
  final MediaListStatus? currentStatus;
  final ValueChanged<MediaListStatus> onStatusChanged;

  const StatusSelector({
    super.key,
    required this.currentStatus,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    const statuses = [
      (MediaListStatus.current, Icons.play_circle_rounded),
      (MediaListStatus.planning, Icons.bookmark_rounded),
      (MediaListStatus.completed, Icons.check_circle_rounded),
      (MediaListStatus.repeating, Icons.repeat_rounded),
      (MediaListStatus.paused, Icons.pause_circle_rounded),
      (MediaListStatus.dropped, Icons.cancel_rounded),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Status', fontSize: 14, bottomPadding: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: statuses.map((status) {
              final isSelected = status.$1 == currentStatus;
              return GestureDetector(
                onTap: () => onStatusChanged(status.$1),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? borderColor.withValues(alpha: 0.2)
                        : Colors.transparent,
                    border: Border.all(
                      color: isSelected
                          ? borderColor
                          : Colors.white.withValues(alpha: 0.1),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    status.$2,
                    color: isSelected ? borderColor : Colors.white54,
                    size: 28,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
