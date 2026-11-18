import 'package:material_ui/material_ui.dart';

import '../theme/theme.dart';
import '../utils/utils.dart';

/// Standard floating action button matching the application design language.
class AppFab extends StatelessWidget {
  /// Callback when tapped.
  final VoidCallback? onTap;

  /// Child widget displayed at the center.
  final Widget child;

  /// Custom background color override.
  final Color? backgroundColor;

  /// Custom border color override.
  final Color? borderColor;

  /// Accessibility tooltip text.
  final String? tooltip;

  /// Base size before responsive scaling.
  final double size;

  /// Creates a standard application floating action button.
  const AppFab({
    super.key,
    required this.onTap,
    required this.child,
    this.backgroundColor,
    this.borderColor,
    this.tooltip,
    this.size = 52.0,
  });

  /// Creates an application floating action button displaying an icon with a stat count below it.
  AppFab.stat({
    super.key,
    required this.onTap,
    required Widget icon,
    required int count,
    Color? countColor,
    this.backgroundColor,
    this.borderColor,
    this.tooltip,
    this.size = 52.0,
  }) : child = Builder(
         builder: (context) {
           return Column(
             mainAxisSize: MainAxisSize.min,
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               icon,
               const SizedBox(height: 4),
               Text(
                 StringUtils.formatCompactNumber(count),
                 style: TextStyle(
                   color: countColor ?? textSecondary,
                   fontSize: 10.5,
                   fontWeight: FontWeight.w600,
                   height: 1.1,
                 ),
               ),
             ],
           );
         },
       );

  @override
  Widget build(BuildContext context) {
    final double fabSize = getResponsiveSize(context, size);

    final button = Container(
      width: fabSize,
      height: fabSize,
      decoration: BoxDecoration(
        color: backgroundColor ?? bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor ?? cardBorderColor),
      ),
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Center(child: child),
      ),
    );

    if (tooltip != null && tooltip!.isNotEmpty) {
      return Tooltip(message: tooltip!, child: button);
    }
    return button;
  }
}
