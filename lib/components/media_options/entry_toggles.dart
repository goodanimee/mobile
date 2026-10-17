import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../theme/theme.dart';

/// Card containing visibility and privacy toggles for a media list entry
class EntryToggles extends StatelessWidget {
  /// Whether the entry is marked as private
  final bool isPrivate;

  /// Whether the entry is hidden from status lists
  final bool isHiddenFromStatusLists;

  /// Callback when private toggle changes
  final ValueChanged<bool> onPrivateChanged;

  /// Callback when hiddenFromStatusLists toggle changes
  final ValueChanged<bool> onHiddenFromStatusListsChanged;

  /// Creates an entry toggles widget
  const EntryToggles({
    super.key,
    required this.isPrivate,
    required this.isHiddenFromStatusLists,
    required this.onPrivateChanged,
    required this.onHiddenFromStatusListsChanged,
  });

  Widget _buildToggleRow({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        child: Row(
          children: [
            Icon(icon, size: 20, color: value ? borderColor : textMuted),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(color: textMuted, fontSize: 12),
                  ),
                ],
              ),
            ),
            Switch(
              value: value,
              onChanged: onChanged,
              activeTrackColor: borderColor,
              activeThumbColor: Colors.white,
              inactiveTrackColor: Colors.white.withValues(alpha: 0.08),
              inactiveThumbColor: textMuted,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
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
              'VISIBILITY',
              style: TextStyle(
                color: textMuted,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 8),
            _buildToggleRow(
              context: context,
              icon: LucideIcons.lock,
              title: 'Private',
              subtitle: 'Hide entry from your public profile',
              value: isPrivate,
              onChanged: onPrivateChanged,
            ),
            const Divider(color: cardBorderColor, height: 16),
            _buildToggleRow(
              context: context,
              icon: LucideIcons.eyeOff,
              title: 'Hide from Status Lists',
              subtitle: 'Exclude entry from standard status lists',
              value: isHiddenFromStatusLists,
              onChanged: onHiddenFromStatusListsChanged,
            ),
          ],
        ),
      ),
    );
  }
}
