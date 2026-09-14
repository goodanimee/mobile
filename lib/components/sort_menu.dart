import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../theme/theme.dart';

/// Floating sort menu overlay dropdown with expand animation
class SortMenuOverlay extends StatelessWidget {
  /// Whether the menu is currently visible
  final bool visible;

  /// Available sort options
  final List<({String type, String label})> options;

  /// Active sort option type
  final String activeSortType;

  /// Optional sort direction map for arrow indicators
  final Map<String, bool>? sortDirections;

  /// Animation for menu expand size
  final Animation<double> sizeAnimation;

  /// Animation for fading in option labels
  final Animation<double> fadeAnimation;

  /// Callback when a sort option is selected
  final ValueChanged<String> onSelected;

  /// Callback to dismiss or toggle the menu
  final VoidCallback onDismiss;

  /// Top offset positioning
  final double? topOffset;

  /// Right offset positioning
  final double? rightOffset;

  /// Creates a sort menu overlay
  const SortMenuOverlay({
    super.key,
    required this.visible,
    required this.options,
    required this.activeSortType,
    this.sortDirections,
    required this.sizeAnimation,
    required this.fadeAnimation,
    required this.onSelected,
    required this.onDismiss,
    this.topOffset,
    this.rightOffset,
  });

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox.shrink();

    final itemHeight = getResponsiveSize(context, 48.0);
    final totalHeight = options.length * itemHeight;
    final menuWidth = getResponsiveSize(context, 160.0);
    final top = topOffset ?? getResponsiveSize(context, 56.0);
    final right = rightOffset ?? getResponsiveSize(context, 16.0);

    return Stack(
      children: [
        GestureDetector(
          onTap: onDismiss,
          behavior: HitTestBehavior.opaque,
          child: const SizedBox.expand(),
        ),
        Positioned(
          top: top,
          right: right,
          child: AnimatedBuilder(
            animation: sizeAnimation,
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
                          final isAscending =
                              sortDirections?[opt.type] ?? false;

                          return GestureDetector(
                            onTap: () => onSelected(opt.type),
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
                                      sortDirections != null
                                          ? (isAscending
                                                ? LucideIcons.arrowUp
                                                : LucideIcons.arrowDown)
                                          : LucideIcons.check,
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
