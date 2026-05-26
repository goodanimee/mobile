import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' show parse;

/// A widget that parses HTML and displays it with consistent styling.
class HtmlDescription extends StatelessWidget {
  /// The HTML content to parse and display
  final String html;

  /// The text style for the description
  final TextStyle? style;

  /// Creates an HTML description
  const HtmlDescription({super.key, required this.html, this.style});

  @override
  Widget build(BuildContext context) {
    final document = parse(html);
    final body = document.body;
    if (body == null) return const SizedBox.shrink();

    final List<Widget> widgets = [];
    final StringBuffer currentTextBuffer = StringBuffer();

    void flushText() {
      if (currentTextBuffer.isNotEmpty) {
        final text = currentTextBuffer.toString().trim();
        if (text.isNotEmpty) {
          widgets.add(
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                text,
                style:
                    style ??
                    const TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                      height: 1.5,
                    ),
              ),
            ),
          );
        }
        currentTextBuffer.clear();
      }
    }

    void traverse(dom.Node node) {
      if (node.nodeType == dom.Node.TEXT_NODE) {
        currentTextBuffer.write(node.text);
      } else if (node.nodeType == dom.Node.ELEMENT_NODE &&
          node is dom.Element) {
        if (node.localName == 'img') {
          final src = node.attributes['src'];
          if (src != null && src.isNotEmpty) {
            flushText();
            widgets.add(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        src,
                        fit: BoxFit.contain,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            height: 150,
                            color: Colors.white.withValues(alpha: 0.05),
                            child: const Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) =>
                            const SizedBox.shrink(),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        } else if (node.localName == 'br') {
          flushText();
        } else {
          for (final child in node.nodes) {
            traverse(child);
          }
          if (node.localName == 'p' ||
              node.localName == 'div' ||
              node.localName == 'h1' ||
              node.localName == 'h2' ||
              node.localName == 'h3') {
            flushText();
          }
        }
      }
    }

    for (final child in body.nodes) {
      traverse(child);
    }
    flushText();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: widgets,
    );
  }
}
