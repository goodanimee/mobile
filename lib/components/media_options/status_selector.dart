import 'package:flutter/material.dart';
import '../../models/common.dart';
import '../../theme/theme.dart';

/// Selector component for watching status.
class StatusSelector extends StatelessWidget {
  /// The current watching status.
  final MediaListStatus? currentStatus;

  /// Callback triggered on status change.
  final ValueChanged<MediaListStatus> onStatusChanged;

  /// Creates a status selector.
  const StatusSelector({
    super.key,
    required this.currentStatus,
    required this.onStatusChanged,
  });

  IconData _getIcon(MediaListStatus status) {
    switch (status) {
      case MediaListStatus.current:
        return Icons.play_circle_rounded;
      case MediaListStatus.planning:
        return Icons.bookmark_rounded;
      case MediaListStatus.completed:
        return Icons.check_circle_rounded;
      case MediaListStatus.repeating:
        return Icons.repeat_rounded;
      case MediaListStatus.paused:
        return Icons.pause_circle_rounded;
      case MediaListStatus.dropped:
        return Icons.cancel_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    const statuses = [
      MediaListStatus.current,
      MediaListStatus.planning,
      MediaListStatus.completed,
      MediaListStatus.repeating,
      MediaListStatus.paused,
      MediaListStatus.dropped,
    ];

    final int selectedIndex = currentStatus != null ? statuses.indexOf(currentStatus!) : -1;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF161616),
          border: Border.all(color: cardBorderColor),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'STATUS',
              style: TextStyle(
                color: textMuted,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.02),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final double width = constraints.maxWidth;
                  final double tabWidth = width / statuses.length;

                  return Stack(
                    children: [
                      if (selectedIndex >= 0)
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeInOutCubic,
                          left: selectedIndex * tabWidth,
                          top: 0,
                          bottom: 0,
                          width: tabWidth,
                          child: Container(
                            margin: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: borderColor.withValues(alpha: 0.2),
                              border: Border.all(
                                color: borderColor.withValues(alpha: 0.4),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      Positioned.fill(
                        child: Row(
                          children: List.generate(statuses.length, (index) {
                            final bool showDivider = index < statuses.length - 1;
                            return Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if (showDivider)
                                    Container(
                                      width: 1,
                                      height: 16,
                                      color: Colors.white.withValues(alpha: 0.08),
                                    )
                                  else
                                    const SizedBox(width: 1),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                      Positioned.fill(
                        child: Row(
                          children: List.generate(statuses.length, (index) {
                            final status = statuses[index];
                            final isSelected = selectedIndex == index;
                            return Expanded(
                              child: GestureDetector(
                                onTap: () => onStatusChanged(status),
                                behavior: HitTestBehavior.opaque,
                                child: Container(
                                  height: double.infinity,
                                  alignment: Alignment.center,
                                  child: Icon(
                                    _getIcon(status),
                                    color: isSelected ? Colors.white : Colors.white30,
                                    size: 22,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
