import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../theme/theme.dart';

/// A floating vertical sort menu overlay with expand animation
class SortMenuOverlay extends StatelessWidget {
  /// Whether the menu is currently visible
  final bool visible;

  /// The active sort option type
  final String activeSortType;

  /// Map of sorting directions for each sort option
  final Map<String, bool> sortDirections;

  /// Animation controller for open/close animation
  final AnimationController animationController;

  /// Animation for menu expand size
  final Animation<double> sizeAnimation;

  /// Animation for fading in option labels
  final Animation<double> fadeAnimation;

  /// Callback when a sort option is selected
  final ValueChanged<String> onSelected;

  /// Callback to dismiss/toggle the menu
  final VoidCallback onDismiss;

  /// Creates a sort menu overlay
  const SortMenuOverlay({
    super.key,
    required this.visible,
    required this.activeSortType,
    required this.sortDirections,
    required this.animationController,
    required this.sizeAnimation,
    required this.fadeAnimation,
    required this.onSelected,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox.shrink();

    final itemHeight = getResponsiveSize(context, 48.0);
    final totalHeight = 6 * itemHeight;
    final menuWidth = getResponsiveSize(context, 160.0);

    final options = [
      (type: 'score', label: 'Score'),
      (type: 'title', label: 'Title'),
      (type: 'progress', label: 'Progress'),
      (type: 'release_date', label: 'Release date'),
      (type: 'started_date', label: 'Started date'),
      (type: 'completed_date', label: 'Completed date'),
    ];

    return Stack(
      children: [
        GestureDetector(
          onTap: onDismiss,
          behavior: HitTestBehavior.opaque,
          child: const SizedBox.expand(),
        ),
        Positioned(
          top: 60,
          right: 16,
          child: AnimatedBuilder(
            animation: animationController,
            builder: (context, _) {
              return Container(
                width: menuWidth,
                height: totalHeight * sizeAnimation.value,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: cardBorderColor),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.5),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Opacity(
                    opacity: fadeAnimation.value,
                    child: OverflowBox(
                      minWidth: menuWidth,
                      maxWidth: menuWidth,
                      minHeight: totalHeight,
                      maxHeight: totalHeight,
                      alignment: Alignment.topCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: options.map((opt) {
                          final isActive = activeSortType == opt.type;
                          final isAscending = sortDirections[opt.type] ?? false;
                          return GestureDetector(
                            onTap: () {
                              onSelected(opt.type);
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              width: double.infinity,
                              height: itemHeight,
                              color: isActive
                                  ? hoverBgColor
                                  : Colors.transparent,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      opt.label,
                                      style: TextStyle(
                                        color: isActive
                                            ? borderColor
                                            : textPrimary,
                                        fontSize: fontBody(context),
                                        fontWeight: isActive
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  if (isActive)
                                    Icon(
                                      isAscending
                                          ? LucideIcons.arrowUp
                                          : LucideIcons.arrowDown,
                                      size: getResponsiveSize(context, 16.0),
                                      color: borderColor,
                                    ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
