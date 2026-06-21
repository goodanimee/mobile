import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../theme/theme.dart';

/// The selection dropdown panel for advanced status filters.
class StatusFilterPanel extends StatelessWidget {
  /// Current selected status.
  final String? selectedStatus;

  /// Callback when a status option is tapped.
  final void Function(String? status) onChanged;

  /// Creates a status filter panel.
  const StatusFilterPanel({
    super.key,
    required this.selectedStatus,
    required this.onChanged,
  });

  IconData _getIcon(String key) {
    switch (key) {
      case 'FINISHED':
        return LucideIcons.badgeCheck;
      case 'RELEASING':
        return LucideIcons.activity;
      case 'NOT_YET_RELEASED':
        return LucideIcons.calendar;
      case 'CANCELLED':
        return LucideIcons.badgeX;
      case 'HIATUS':
        return LucideIcons.circlePause;
      default:
        return LucideIcons.helpCircle;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> statusKeys = [
      'FINISHED',
      'RELEASING',
      'NOT_YET_RELEASED',
      'CANCELLED',
      'HIATUS',
    ];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF161616),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: cardBorderColor),
      ),
      padding: EdgeInsets.all(getResponsiveSize(context, 12.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < statusKeys.length; i++) ...[
            if (i > 0)
              const Divider(
                color: cardBorderColor,
                height: 1.0,
                thickness: 1.0,
              ),
            _buildOption(context, statusKeys[i]),
          ],
        ],
      ),
    );
  }

  /// Builds a single option item widget.
  Widget _buildOption(BuildContext context, String key) {
    final isSelected = selectedStatus == key;
    final double paddingVal = getResponsiveSize(context, 12.0);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: () {
          onChanged(isSelected ? null : key);
        },
        borderRadius: BorderRadius.circular(6.0),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: paddingVal,
            vertical: getResponsiveSize(context, 10.0),
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? borderColor.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(
              color: isSelected
                  ? borderColor.withValues(alpha: 0.3)
                  : Colors.transparent,
            ),
          ),
          child: Row(
            children: [
              Icon(
                _getIcon(key),
                color: isSelected ? borderColor : textMuted,
                size: getResponsiveSize(context, 18.0),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  key.replaceAll('_', ' '),
                  style: TextStyle(
                    color: isSelected ? textPrimary : textMuted,
                    fontSize: fontBody(context),
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
              if (isSelected)
                Icon(
                  LucideIcons.check,
                  color: borderColor,
                  size: getResponsiveSize(context, 18.0),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
