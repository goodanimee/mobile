import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../components/app_fab.dart';
import '../../../../theme/theme.dart';

/// Floating action button to trigger entry editing
class EditEntryFab extends StatelessWidget {
  /// Callback when the FAB is tapped
  final VoidCallback onTap;

  /// Whether we are editing an existing entry or adding a new one
  final bool isEdit;

  /// Creates an edit entry floating action button
  const EditEntryFab({super.key, required this.onTap, this.isEdit = true});

  @override
  Widget build(BuildContext context) {
    final double iconSize = getResponsiveSize(context, 22.0);
    return AppFab(
      onTap: onTap,
      tooltip: isEdit ? 'Edit entry' : 'Add to list',
      child: Icon(
        isEdit ? LucideIcons.pencil : LucideIcons.plus,
        color: textPrimary,
        size: iconSize,
      ),
    );
  }
}
