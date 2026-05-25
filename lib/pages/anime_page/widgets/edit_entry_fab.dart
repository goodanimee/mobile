import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

/// Floating action button to trigger entry editing
class EditEntryFab extends StatelessWidget {
  /// Callback when the FAB is tapped
  final VoidCallback onTap;

  /// Creates an edit entry floating action button
  const EditEntryFab({super.key, required this.onTap});

  @override
  /// Builds the FAB widget
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cardBorderColor, width: 1.0),
      ),
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: const Center(
          child: Icon(Icons.edit_rounded, color: textPrimary, size: 22),
        ),
      ),
    );
  }
}
