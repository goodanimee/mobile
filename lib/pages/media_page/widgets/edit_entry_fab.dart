import 'package:flutter/material.dart';
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
    return Container(
      width: 52,
      height: 52,
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
            isEdit ? Icons.edit_rounded : Icons.add_rounded,
            color: textPrimary,
            size: 22,
          ),
        ),
      ),
    );
  }
}
