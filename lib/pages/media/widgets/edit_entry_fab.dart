import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../theme/theme.dart';

/// Floating action button to trigger entry editing
class EditEntryFab extends StatelessWidget {
  /// Callback when the FAB is tapped
  final VoidCallback onTap;

  /// Whether we are editing an existing entry or adding a new one
  final bool isEdit;

  /// Creates an edit entry floating action button
  const EditEntryFab({super.key, required this.onTap, this.isEdit = true});

  @override
  /// Builds the FAB widget
  Widget build(BuildContext context) {
    final double fabSize = getResponsiveSize(context, 52.0);
    final double iconSize = getResponsiveSize(context, 22.0);
    return Container(
      width: fabSize,
      height: fabSize,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cardBorderColor),
      ),
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: Icon(
            isEdit ? LucideIcons.pencil : LucideIcons.plus,
            color: textPrimary,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}
