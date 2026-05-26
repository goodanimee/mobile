import 'package:flutter/material.dart';
import 'section_title.dart';

/// A wrapper component that provides standardized spacing and a title for sections
class AppSection extends StatelessWidget {
  /// The title of the section
  final String title;

  /// The content of the section
  final List<Widget> children;

  /// The amount of space before the section title
  final double topSpacing;

  /// The amount of space between the title and the content
  final double innerSpacing;

  /// Optional widget to display on the same line as the title
  final Widget? trailing;

  /// Creates an app section
  const AppSection({
    super.key,
    required this.title,
    required this.children,
    this.topSpacing = 24,
    this.innerSpacing = 8,
    this.trailing,
  });

  @override
  /// Builds the app section widget
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: topSpacing),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SectionTitle(title: title, bottomPadding: innerSpacing),
            ),
            if (trailing != null) ...[trailing!, const SizedBox(width: 4)],
          ],
        ),
        ...children,
      ],
    );
  }
}
