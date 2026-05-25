import 'package:flutter/material.dart';

/// A placeholder tab for content that is not yet implemented
class PlaceholderTab extends StatelessWidget {
  /// The title to display in the center
  final String title;

  /// Creates a placeholder tab
  const PlaceholderTab({super.key, required this.title});

  @override
  /// Builds the placeholder tab widget
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
