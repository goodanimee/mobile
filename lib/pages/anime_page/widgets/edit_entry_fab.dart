import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

class EditEntryFab extends StatelessWidget {
  final VoidCallback onTap;

  const EditEntryFab({super.key, required this.onTap});

  @override
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
