import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import '../section_title.dart';

class StatusSelector extends StatelessWidget {
  final String currentStatus;
  final ValueChanged<String> onStatusChanged;

  const StatusSelector({
    super.key,
    required this.currentStatus,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    const statuses = [
      ('CURRENT', Icons.play_circle_rounded),
      ('PLANNING', Icons.bookmark_rounded),
      ('COMPLETED', Icons.check_circle_rounded),
      ('REPEATING', Icons.repeat_rounded),
      ('PAUSED', Icons.pause_circle_rounded),
      ('DROPPED', Icons.cancel_rounded),
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
