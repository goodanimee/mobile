import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import '../section_title.dart';

/// Editor component for editing start and finish dates of a list entry
class DateEditor extends StatelessWidget {
  /// The optional start date of the entry
  final DateTime? startDate;

  /// The optional finish date of the entry
  final DateTime? finishDate;

  /// Callback when start date changes
  final ValueChanged<DateTime?> onStartDateChanged;

  /// Callback when finish date changes
  final ValueChanged<DateTime?> onFinishDateChanged;

  /// Creates a date editor widget
  const DateEditor({
    super.key,
    this.startDate,
    this.finishDate,
    required this.onStartDateChanged,
    required this.onFinishDateChanged,
  });

  @override
  /// Builds the date editor widget
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: 'Dates', fontSize: 14, bottomPadding: 12),
          Row(
            children: [
              Expanded(
                child: _buildDateBox(context, 'Start Date', startDate, onStartDateChanged),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDateBox(context, 'Finish Date', finishDate, onFinishDateChanged),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Formats a DateTime into a string
  String _formatDate(DateTime? date) {
    if (date == null) return '--/--/----';
    return '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// Builds a clickable date box
  Widget _buildDateBox(
    BuildContext context,
    String label,
    DateTime? date,
    ValueChanged<DateTime?> onChanged,
  ) {
    return InkWell(
      onTap: () async {
        final selected = await showDatePicker(
          context: context,
          initialDate: date ?? DateTime.now(),
          firstDate: DateTime(1970),
          lastDate: DateTime(2100),
          builder: (context, child) {
            return Theme(
              data: ThemeData.dark().copyWith(
                colorScheme: const ColorScheme.dark(
                  primary: borderColor,
                  surface: bgColor,
                ),
              ),
              child: child!,
            );
          },
        );
        if (selected != null) onChanged(selected);
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _formatDate(date),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
