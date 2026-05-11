import 'package:flutter/material.dart';

/// A standardized section title widget for consistent headings
class SectionTitle extends StatelessWidget {
  /// The title text to display
  final String title;

  /// The bottom padding after the title
  final double bottomPadding;

  /// The font size of the title
  final double fontSize;

  /// Creates a section title
  const SectionTitle({
    super.key,
    required this.title,
    this.bottomPadding = 16,
    this.fontSize = 18,
  });

  @override
  /// Builds the section title widget
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Text(
        title,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
