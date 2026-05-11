import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;

/// A widget that parses HTML and displays it with consistent styling
class HtmlDescription extends StatelessWidget {
  /// The HTML content to parse and display
  final String html;

  /// The text style for the description
  final TextStyle? style;

  /// Creates an HTML description
  const HtmlDescription({
    super.key,
    required this.html,
    this.style,
  });

  @override
  /// Builds the HTML description widget
  Widget build(BuildContext context) {
    return Text(
      parse(html).body?.text ?? '',
      style: style ??
          const TextStyle(
            color: Colors.white70,
            fontSize: 14,
            height: 1.5,
          ),
    );
  }
}
