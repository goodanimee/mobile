import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' show parse;
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/theme.dart';

const _blockElements = {'p', 'div', 'h1', 'h2', 'h3', 'ul', 'ol', 'li'};
const _nestedBlocksOrImages = {
  'p',
  'div',
  'h1',
  'h2',
  'h3',
  'ul',
  'ol',
  'li',
  'img',
};
const _parentBlockElements = {'body', 'div', 'ul', 'ol'};

/// A widget that parses HTML and displays it with consistent styling.
class HtmlDescription extends StatefulWidget {
  /// The HTML content to parse and display
  final String html;

  /// The text style for the description
  final TextStyle? style;

  /// Creates an HTML description
  const HtmlDescription({super.key, required this.html, this.style});

  @override
  State<HtmlDescription> createState() => _HtmlDescriptionState();
}

class _HtmlDescriptionState extends State<HtmlDescription> {
  final List<TapGestureRecognizer> _recognizers = [];

  void _clearRecognizers() {
    for (final r in _recognizers) {
      r.dispose();
    }
    _recognizers.clear();
  }

  @override
  void dispose() {
    _clearRecognizers();
    super.dispose();
  }

  void _trimWhitespace(dom.Node node) {
    dom.Node? findFirstTextNode(dom.Node n) {
      if (n.nodeType == dom.Node.TEXT_NODE) {
        return n;
      }
      for (final child in n.nodes) {
        final res = findFirstTextNode(child);
        if (res != null) return res;
      }
      return null;
    }

    dom.Node? findLastTextNode(dom.Node n) {
      if (n.nodeType == dom.Node.TEXT_NODE) {
        return n;
      }
      for (final child in n.nodes.reversed) {
        final res = findLastTextNode(child);
        if (res != null) return res;
      }
      return null;
    }

    final first = findFirstTextNode(node);
    if (first != null && first.text != null) {
      first.text = first.text!.trimLeft();
    }

    final last = findLastTextNode(node);
    if (last != null && last.text != null) {
      last.text = last.text!.trimRight();
    }
  }

  String _processTextNode(dom.Node node) {
    String text = node.text ?? '';
    text = text.replaceAll(RegExp(r'[\r\n]\s*'), ' ');

    final parent = node.parent;
    if (parent != null) {
      final index = parent.nodes.indexOf(node);
      if (index > 0) {
        final prev = parent.nodes[index - 1];
        if (prev is dom.Element && prev.localName == 'br') {
          text = text.trimLeft();
        }
      }
    }
    return text;
  }

  InlineSpan _buildInlineSpan(
    dom.Node node,
    TextStyle parentStyle, {
    GestureRecognizer? recognizer,
  }) {
    if (node.nodeType == dom.Node.TEXT_NODE) {
      final text = _processTextNode(node);
      return TextSpan(text: text, style: parentStyle, recognizer: recognizer);
    }

    if (node.nodeType == dom.Node.ELEMENT_NODE && node is dom.Element) {
      if (node.localName == 'br') {
        return const TextSpan(text: '\n');
      }

      TextStyle currentStyle = parentStyle;
      if (node.localName == 'b' || node.localName == 'strong') {
        currentStyle = currentStyle.copyWith(fontWeight: FontWeight.bold);
      } else if (node.localName == 'i' || node.localName == 'em') {
        currentStyle = currentStyle.copyWith(fontStyle: FontStyle.italic);
      }

      GestureRecognizer? currentRecognizer = recognizer;
      if (node.localName == 'a') {
        final href = node.attributes['href'];
        if (href != null && href.isNotEmpty) {
          final tapRecognizer = TapGestureRecognizer()
            ..onTap = () async {
              final uri = Uri.tryParse(href);
              if (uri != null) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
            };
          _recognizers.add(tapRecognizer);
          currentRecognizer = tapRecognizer;
          currentStyle = currentStyle.copyWith(color: borderColor);
        }
      }

      if (node.localName == 'span' && node.className == 'markdown_spoiler') {
        _trimWhitespace(node);

        final spoilerStyle = currentStyle.copyWith(
          fontSize: fontLarge(context),
        );

        final childrenSpans = node.nodes
            .map(
              (child) => _buildInlineSpan(
                child,
                spoilerStyle,
                recognizer: currentRecognizer,
              ),
            )
            .toList();

        return WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: _InlineSpoiler(
            childrenSpans: childrenSpans,
            style: currentStyle,
            revealedStyle: spoilerStyle,
          ),
        );
      }

      final childrenSpans = node.nodes
          .map(
            (child) => _buildInlineSpan(
              child,
              currentStyle,
              recognizer: currentRecognizer,
            ),
          )
          .toList();
      return TextSpan(
        children: childrenSpans,
        style: currentStyle,
        recognizer: currentRecognizer,
      );
    }

    return const TextSpan();
  }

  @override
  Widget build(BuildContext context) {
    _clearRecognizers();

    final document = parse(widget.html);
    final body = document.body;
    if (body == null) return const SizedBox.shrink();

    final baseStyle =
        widget.style ??
        TextStyle(
          color: Colors.white70,
          fontSize: fontMedium(context),
          height: 1.5,
        );

    final List<Widget> widgets = [];
    final List<InlineSpan> currentSpans = [];

    void flushSpans() {
      if (currentSpans.isNotEmpty) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Text.rich(
              TextSpan(children: List.from(currentSpans)),
              style: baseStyle,
            ),
          ),
        );
        currentSpans.clear();
      }
    }

    void traverse(dom.Node node) {
      if (node.nodeType == dom.Node.ELEMENT_NODE && node is dom.Element) {
        if (node.localName == 'img') {
          final src = node.attributes['src'];
          if (src != null && src.isNotEmpty) {
            flushSpans();
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
          currentSpans.add(const TextSpan(text: '\n'));
        } else if (_blockElements.contains(node.localName)) {
          flushSpans();

          final hasNestedBlocksOrImages = node.nodes.any(
            (n) =>
                n is dom.Element && _nestedBlocksOrImages.contains(n.localName),
          );

          if (hasNestedBlocksOrImages) {
            for (final child in node.nodes) {
              traverse(child);
            }
          } else {
            _trimWhitespace(node);

            TextStyle blockStyle = baseStyle;
            if (node.localName == 'h1') {
              blockStyle = blockStyle.copyWith(
                fontSize: fontTitle(context),
                fontWeight: FontWeight.bold,
              );
            } else if (node.localName == 'h2') {
              blockStyle = blockStyle.copyWith(
                fontSize: fontLarge(context),
                fontWeight: FontWeight.bold,
              );
            } else if (node.localName == 'h3') {
              blockStyle = blockStyle.copyWith(
                fontSize: fontBody(context),
                fontWeight: FontWeight.bold,
              );
            }

            final inlineSpans = node.nodes
                .map((child) => _buildInlineSpan(child, blockStyle))
                .toList();

            String prefix = '';
            if (node.localName == 'li') {
              final parent = node.parent;
              if (parent != null) {
                if (parent.localName == 'ul') {
                  prefix = '•  ';
                } else if (parent.localName == 'ol') {
                  final liSiblings = parent.children
                      .where((c) => c.localName == 'li')
                      .toList();
                  final index = liSiblings.indexOf(node) + 1;
                  prefix = '$index. ';
                }
              }
            }

            widgets.add(
              Padding(
                padding: EdgeInsets.only(
                  left: node.localName == 'li' ? 16 : 0,
                  bottom: node.localName == 'p' ? 12 : 2,
                ),
                child: Text.rich(
                  TextSpan(
                    children: [
                      if (prefix.isNotEmpty)
                        TextSpan(
                          text: prefix,
                          style: blockStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            color: textMuted,
                          ),
                        ),
                      ...inlineSpans,
                    ],
                  ),
                  style: blockStyle,
                ),
              ),
            );
          }
        } else {
          currentSpans.add(_buildInlineSpan(node, baseStyle));
        }
      } else if (node.nodeType == dom.Node.TEXT_NODE) {
        final text = _processTextNode(node);

        if (text.trim().isEmpty) {
          final parent = node.parent;
          if (parent != null &&
              _parentBlockElements.contains(parent.localName)) {
            return;
          }
        }

        currentSpans.add(TextSpan(text: text, style: baseStyle));
      }
    }

    for (final child in body.nodes) {
      traverse(child);
    }
    flushSpans();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: widgets,
    );
  }
}

class _InlineSpoiler extends StatefulWidget {
  final List<InlineSpan> childrenSpans;
  final TextStyle style;
  final TextStyle revealedStyle;

  const _InlineSpoiler({
    required this.childrenSpans,
    required this.style,
    required this.revealedStyle,
  });

  @override
  State<_InlineSpoiler> createState() => _InlineSpoilerState();
}

class _InlineSpoilerState extends State<_InlineSpoiler> {
  bool _isRevealed = false;

  @override
  Widget build(BuildContext context) {
    final spoilerBtnTextSize = widget.style.fontSize ?? fontMedium(context);

    if (!_isRevealed) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            setState(() {
              _isRevealed = true;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: spoilerColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: spoilerColor.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  LucideIcons.eye,
                  size: spoilerBtnTextSize,
                  color: spoilerColor,
                ),
                const SizedBox(width: 4),
                Text(
                  'Spoiler',
                  style: widget.style.copyWith(
                    color: spoilerColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            setState(() {
              _isRevealed = false;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: spoilerColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: spoilerColor.withValues(alpha: 0.3)),
            ),
            child: Text.rich(
              TextSpan(children: widget.childrenSpans),
              style: widget.revealedStyle.copyWith(color: spoilerColor),
            ),
          ),
        ),
      );
    }
  }
}
