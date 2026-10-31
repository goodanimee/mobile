import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' show parse;

import '../theme/theme.dart';
import '../utils/app_navigation.dart';
import 'html_description_widgets.dart';

final _inlineTokenPattern = RegExp(
  r'\[([^\]]+)\]\(([^)\s]+)\)'
  r'|(https?:\/\/[^\s<>()]+)'
  r'|~!(.+?)!~'
  r'|\*\*(?!\s)(.+?)(?<!\s)\*\*'
  r'|(?<!\w)__(?!\s)(.+?)(?<!\s)__(?!\w)'
  r'|~~(?!\s)(.+?)(?<!\s)~~'
  r'|(?<!\*)\*(?!\s|\*)(.+?)(?<!\s|\*)\*(?!\*)'
  r'|(?<!\w)_(?!\s|_)(.+?)(?<!\s|_)_(?!\w)',
);

final _trailingUrlPunctuation = RegExp(r'[.,;:!?]+$');

const _blockElements = {
  'p',
  'div',
  'center',
  'h1',
  'h2',
  'h3',
  'h4',
  'h5',
  'h6',
  'ul',
  'ol',
  'li',
  'blockquote',
  'pre',
};

const _nestedBlockTriggers = {
  'p',
  'div',
  'center',
  'h1',
  'h2',
  'h3',
  'h4',
  'h5',
  'h6',
  'ul',
  'ol',
  'li',
  'blockquote',
  'pre',
  'hr',
  'video',
  'img',
};

const _parentBlockElements = {'body', 'div', 'center', 'ul', 'ol'};

/// A widget that parses HTML and displays it with consistent styling.
class HtmlDescription extends StatefulWidget {
  /// The HTML content to parse and display.
  final String html;

  /// The text style for the description.
  final TextStyle? style;

  /// Creates an HTML description.
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

  String _processTextNode(dom.Node node, {required bool preserveNewlines}) {
    String text = node.text ?? '';
    final parent = node.parent;
    dom.Node? prev;
    dom.Node? next;
    if (parent != null) {
      final index = parent.nodes.indexOf(node);
      if (index > 0) prev = parent.nodes[index - 1];
      if (index >= 0 && index + 1 < parent.nodes.length) {
        next = parent.nodes[index + 1];
      }
    }

    if (preserveNewlines) {
      text = text.replaceAll('\r\n', '\n').replaceAll('\r', '\n');
      text = text.replaceAll(RegExp(r'[ \t]*\n[ \t]*'), '\n');
      if (prev is dom.Element &&
          prev.localName == 'br' &&
          text.startsWith('\n')) {
        text = text.substring(1).trimLeft();
      }
      if (next is dom.Element &&
          next.localName == 'br' &&
          text.endsWith('\n')) {
        text = text.substring(0, text.length - 1);
      }
      return text;
    }

    text = text.replaceAll(RegExp(r'[\r\n]\s*'), ' ');
    if (prev is dom.Element && prev.localName == 'br') {
      text = text.trimLeft();
    }
    return text;
  }

  TapGestureRecognizer _createLinkRecognizer(String url) {
    final tapRecognizer = TapGestureRecognizer()
      ..onTap = () async {
        await AppNavigation.handleLinkTap(context, url);
      };
    _recognizers.add(tapRecognizer);
    return tapRecognizer;
  }

  InlineSpan _buildRichTextSpans(
    String text,
    TextStyle style, {
    GestureRecognizer? recognizer,
  }) {
    if (text.isEmpty || !_inlineTokenPattern.hasMatch(text)) {
      return TextSpan(text: text, style: style, recognizer: recognizer);
    }

    final spans = <InlineSpan>[];
    int lastEnd = 0;

    for (final match in _inlineTokenPattern.allMatches(text)) {
      if (match.start > lastEnd) {
        spans.add(
          TextSpan(
            text: text.substring(lastEnd, match.start),
            style: style,
            recognizer: recognizer,
          ),
        );
      }

      final mdLabel = match.group(1);
      final mdUrl = match.group(2);
      final bareUrl = match.group(3);
      final spoilerText = match.group(4);
      final boldText = match.group(5) ?? match.group(6);
      final strikeText = match.group(7);
      final italicText = match.group(8) ?? match.group(9);

      if (mdLabel != null && mdUrl != null) {
        final linkRecognizer = recognizer ?? _createLinkRecognizer(mdUrl);
        spans.add(
          _buildRichTextSpans(
            mdLabel,
            style.copyWith(color: borderColor),
            recognizer: linkRecognizer,
          ),
        );
      } else if (bareUrl != null) {
        String cleanUrl = bareUrl;
        String trailing = '';
        final punctMatch = _trailingUrlPunctuation.firstMatch(cleanUrl);
        if (punctMatch != null) {
          trailing = punctMatch.group(0)!;
          cleanUrl = cleanUrl.substring(0, punctMatch.start);
        }
        final linkRecognizer = recognizer ?? _createLinkRecognizer(cleanUrl);
        spans.add(
          TextSpan(
            text: cleanUrl,
            style: style.copyWith(color: borderColor),
            recognizer: linkRecognizer,
          ),
        );
        if (trailing.isNotEmpty) {
          spans.add(
            TextSpan(text: trailing, style: style, recognizer: recognizer),
          );
        }
      } else if (spoilerText != null) {
        final spoilerStyle = style.copyWith(fontSize: fontLarge(context));
        spans.add(
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: HtmlInlineSpoiler(
              childrenSpans: [
                _buildRichTextSpans(
                  spoilerText.trim(),
                  spoilerStyle,
                  recognizer: recognizer,
                ),
              ],
              style: style,
              revealedStyle: spoilerStyle,
            ),
          ),
        );
      } else if (boldText != null) {
        spans.add(
          _buildRichTextSpans(
            boldText,
            style.copyWith(fontWeight: FontWeight.bold),
            recognizer: recognizer,
          ),
        );
      } else if (strikeText != null) {
        spans.add(
          _buildRichTextSpans(
            strikeText,
            style.copyWith(decoration: TextDecoration.lineThrough),
            recognizer: recognizer,
          ),
        );
      } else if (italicText != null) {
        spans.add(
          _buildRichTextSpans(
            italicText,
            style.copyWith(fontStyle: FontStyle.italic),
            recognizer: recognizer,
          ),
        );
      }

      lastEnd = match.end;
    }

    if (lastEnd < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(lastEnd),
          style: style,
          recognizer: recognizer,
        ),
      );
    }

    return TextSpan(children: spans, style: style);
  }

  InlineSpan _buildInlineSpan(
    dom.Node node,
    TextStyle parentStyle, {
    GestureRecognizer? recognizer,
    String? activeLinkUrl,
    bool preserveNewlines = false,
  }) {
    if (node.nodeType == dom.Node.TEXT_NODE) {
      final text = _processTextNode(node, preserveNewlines: preserveNewlines);
      return _buildRichTextSpans(text, parentStyle, recognizer: recognizer);
    }

    if (node.nodeType == dom.Node.ELEMENT_NODE && node is dom.Element) {
      if (node.localName == 'br') {
        return const TextSpan(text: '\n');
      }

      if (node.localName == 'img') {
        final src = node.attributes['src'];
        if (src == null || src.isEmpty) return const TextSpan();
        return WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: HtmlImageEmbed(
              src: src,
              widthAttr: node.attributes['width'],
              linkUrl: activeLinkUrl,
            ),
          ),
        );
      }

      TextStyle currentStyle = parentStyle;
      if (node.localName == 'b' || node.localName == 'strong') {
        currentStyle = currentStyle.copyWith(fontWeight: FontWeight.bold);
      } else if (node.localName == 'i' || node.localName == 'em') {
        currentStyle = currentStyle.copyWith(fontStyle: FontStyle.italic);
      } else if (node.localName == 'del' ||
          node.localName == 's' ||
          node.localName == 'strike') {
        currentStyle = currentStyle.copyWith(
          decoration: TextDecoration.lineThrough,
        );
      } else if (node.localName == 'code') {
        currentStyle = currentStyle.copyWith(
          fontFamily: 'monospace',
          backgroundColor: hoverBgColor,
          color: textPrimary,
        );
      }

      GestureRecognizer? currentRecognizer = recognizer;
      String? nextLinkUrl = activeLinkUrl;
      if (node.localName == 'a') {
        final href = node.attributes['href'];
        if (href != null && href.isNotEmpty) {
          currentRecognizer = _createLinkRecognizer(href);
          currentStyle = currentStyle.copyWith(color: borderColor);
          nextLinkUrl = href;
        }
      }

      if (node.localName == 'span' &&
          node.classes.contains('markdown_spoiler')) {
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
                activeLinkUrl: nextLinkUrl,
                preserveNewlines: preserveNewlines,
              ),
            )
            .toList();

        return WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: HtmlInlineSpoiler(
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
              activeLinkUrl: nextLinkUrl,
              preserveNewlines: preserveNewlines,
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

  bool _isBlankSpanList(List<InlineSpan> spans) {
    if (spans.isEmpty) return true;
    for (final span in spans) {
      if (span is! TextSpan) return false;
      if (span.children != null && !_isBlankSpanList(span.children!)) {
        return false;
      }
      if ((span.text ?? '').trim().isNotEmpty) return false;
    }
    return true;
  }

  String? _extractVideoSrc(dom.Element videoNode) {
    final direct = videoNode.attributes['src'];
    if (direct != null && direct.trim().isNotEmpty) return direct.trim();
    for (final child in videoNode.children) {
      if (child.localName == 'source') {
        final src = child.attributes['src'];
        if (src != null && src.trim().isNotEmpty) return src.trim();
      }
    }
    return null;
  }

  TextStyle _headingStyle(BuildContext context, String tag, TextStyle base) {
    return switch (tag) {
      'h1' => base.copyWith(
        fontSize: fontTitle(context),
        fontWeight: FontWeight.bold,
        color: textPrimary,
      ),
      'h2' => base.copyWith(
        fontSize: fontLarge(context),
        fontWeight: FontWeight.bold,
        color: textPrimary,
      ),
      'h3' => base.copyWith(
        fontSize: fontBody(context),
        fontWeight: FontWeight.bold,
        color: textPrimary,
      ),
      'h4' => base.copyWith(
        fontSize: fontMedium(context),
        fontWeight: FontWeight.bold,
        color: textPrimary,
      ),
      'h5' => base.copyWith(
        fontSize: fontSmall(context),
        fontWeight: FontWeight.bold,
        color: textSecondary,
      ),
      'h6' => base.copyWith(
        fontSize: fontSmall(context),
        fontWeight: FontWeight.bold,
        color: textMuted,
      ),
      _ => base,
    };
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
    TextAlign currentAlign = TextAlign.start;

    Widget alignBlock(Widget child, TextAlign align) {
      if (align == TextAlign.center) {
        return Align(child: child);
      }
      return child;
    }

    void flushSpans({double bottomPadding = 2}) {
      if (currentSpans.isEmpty) return;
      if (_isBlankSpanList(currentSpans)) {
        currentSpans.clear();
        return;
      }
      final align = currentAlign;
      final textWidget = Text.rich(
        TextSpan(children: List.from(currentSpans)),
        style: baseStyle,
        textAlign: align,
      );
      widgets.add(
        Padding(
          padding: EdgeInsets.only(bottom: bottomPadding),
          child: alignBlock(textWidget, align),
        ),
      );
      currentSpans.clear();
    }

    void traverse(
      dom.Node node, {
      TextAlign textAlign = TextAlign.start,
      bool preserveNewlines = false,
    }) {
      if (node.nodeType == dom.Node.ELEMENT_NODE && node is dom.Element) {
        final tag = node.localName ?? '';
        final alignAttr = node.attributes['align']?.toLowerCase();
        final effectiveAlign = (tag == 'center' || alignAttr == 'center')
            ? TextAlign.center
            : textAlign;
        final effectivePreserveNewlines =
            preserveNewlines || tag == 'center' || alignAttr == 'center';

        if (tag == 'hr') {
          flushSpans();
          widgets.add(
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(color: cardBorderColor, height: 1, thickness: 1),
            ),
          );
          return;
        }

        if (tag == 'img') {
          final src = node.attributes['src'];
          if (src != null && src.isNotEmpty) {
            flushSpans();
            widgets.add(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Align(
                  child: HtmlImageEmbed(
                    src: src,
                    widthAttr: node.attributes['width'],
                  ),
                ),
              ),
            );
          }
          return;
        }

        if (tag == 'div' && node.classes.contains('youtube')) {
          final rawId = node.attributes['id'] ?? '';
          if (rawId.trim().isNotEmpty) {
            flushSpans();
            widgets.add(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: alignBlock(
                  HtmlYoutubeCard(rawId: rawId),
                  effectiveAlign,
                ),
              ),
            );
          }
          return;
        }

        if (tag == 'video') {
          final src = _extractVideoSrc(node);
          if (src != null) {
            flushSpans();
            widgets.add(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: alignBlock(HtmlVideoCard(src: src), effectiveAlign),
              ),
            );
          }
          return;
        }

        if (tag == 'br') {
          currentAlign = effectiveAlign;
          currentSpans.add(const TextSpan(text: '\n'));
          return;
        }

        if (_blockElements.contains(tag) &&
            node.classes.contains('markdown_spoiler')) {
          flushSpans();
          widgets.add(
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: alignBlock(
                HtmlBlockSpoiler(
                  style: baseStyle,
                  revealedBuilder: (spoilerStyle) => HtmlDescription(
                    html: node.innerHtml,
                    style: spoilerStyle,
                  ),
                ),
                effectiveAlign,
              ),
            ),
          );
          return;
        }

        if (tag == 'blockquote') {
          flushSpans();
          widgets.add(
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(12, 6, 10, 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.03),
                  border: const Border(
                    left: BorderSide(color: borderColor, width: 3),
                  ),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                  ),
                ),
                child: HtmlDescription(
                  html: node.innerHtml,
                  style: baseStyle.copyWith(color: textSecondary),
                ),
              ),
            ),
          );
          return;
        }

        if (tag == 'pre') {
          flushSpans();
          final codeText = node.text.trimRight();
          if (codeText.isNotEmpty) {
            widgets.add(
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: hoverBgColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: cardBorderColor),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      codeText,
                      style: baseStyle.copyWith(
                        fontFamily: 'monospace',
                        fontSize: fontSmall(context),
                        color: textPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return;
        }

        if (tag == 'center') {
          flushSpans();
          _trimWhitespace(node);
          currentAlign = TextAlign.center;
          for (final child in node.nodes) {
            traverse(
              child,
              textAlign: TextAlign.center,
              preserveNewlines: true,
            );
          }
          flushSpans(bottomPadding: 8);
          currentAlign = textAlign;
          return;
        }

        if (_blockElements.contains(tag)) {
          flushSpans();

          final hasNestedBlocks = node.nodes.any(
            (n) =>
                n is dom.Element &&
                (_nestedBlockTriggers.contains(n.localName) ||
                    (n.localName == 'div' && n.classes.contains('youtube'))),
          );

          if (hasNestedBlocks) {
            for (final child in node.nodes) {
              traverse(
                child,
                textAlign: effectiveAlign,
                preserveNewlines: effectivePreserveNewlines,
              );
            }
            flushSpans();
          } else {
            _trimWhitespace(node);
            final blockStyle = _headingStyle(context, tag, baseStyle);

            final inlineSpans = node.nodes
                .map(
                  (child) => _buildInlineSpan(
                    child,
                    blockStyle,
                    preserveNewlines: effectivePreserveNewlines,
                  ),
                )
                .toList();

            if (_isBlankSpanList(inlineSpans)) return;

            String prefix = '';
            if (tag == 'li') {
              final parent = node.parent;
              if (parent != null) {
                if (parent.localName == 'ul') {
                  prefix = '\u2022  ';
                } else if (parent.localName == 'ol') {
                  final liSiblings = parent.children
                      .where((c) => c.localName == 'li')
                      .toList();
                  final index = liSiblings.indexOf(node) + 1;
                  prefix = '$index. ';
                }
              }
            }

            final richText = Text.rich(
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
              textAlign: effectiveAlign,
            );

            widgets.add(
              Padding(
                padding: EdgeInsets.only(
                  left: tag == 'li' ? 16 : 0,
                  bottom: tag == 'p' ? 12 : 4,
                ),
                child: alignBlock(richText, effectiveAlign),
              ),
            );
          }
          return;
        }

        currentAlign = effectiveAlign;
        currentSpans.add(
          _buildInlineSpan(
            node,
            baseStyle,
            preserveNewlines: effectivePreserveNewlines,
          ),
        );
      } else if (node.nodeType == dom.Node.TEXT_NODE) {
        final text = _processTextNode(node, preserveNewlines: preserveNewlines);

        if (text.trim().isEmpty) {
          final parent = node.parent;
          if (parent != null &&
              _parentBlockElements.contains(parent.localName)) {
            return;
          }
        }

        currentAlign = textAlign;
        currentSpans.add(_buildRichTextSpans(text, baseStyle));
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
