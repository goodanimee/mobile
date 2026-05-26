import 'package:flutter/material.dart';

/// A standardized statistic item for displaying metadata
class StatItem extends StatelessWidget {
  /// The label for the statistic
  final String label;

  /// The value of the statistic
  final String value;

  /// Creates a statistic item
  const StatItem({super.key, required this.label, required this.value});

  @override
  /// Builds the statistic item widget
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white54, fontSize: 12),
        ),
      ],
    );
  }
}
