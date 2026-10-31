import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' show parse;

import '../theme/theme.dart';
import '../utils/anilist_url_parser.dart';
import '../utils/app_navigation.dart';
import 'html_anilist_link_card.dart';
import 'html_description_widgets.dart';

final _lonePunctuationPattern = RegExp(r'^[\s.,;:!?]+$');

class _CardLinkCandidate {
  final AnilistRouteTarget target;
  final String rawUrl;
  final String? fallbackLabel;
  final bool isUrlLabel;
  final InlineSpan inlineFallback;

  const _CardLinkCandidate({
    required this.target,
    required this.rawUrl,
    required this.fallbackLabel,
    required this.isUrlLabel,
    required this.inlineFallback,
  });
}

class _AnilistLinkCandidateMarker extends StatelessWidget {
  final _CardLinkCandidate candidate;

  const _AnilistLinkCandidateMarker(this.candidate);

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}

sealed class _FlatInlineToken {
  const _FlatInlineToken();
}

class _TextToken extends _FlatInlineToken {
  final String text;
  final TextStyle? style;
  final GestureRecognizer? recognizer;

  const _TextToken(this.text, this.style, this.recognizer);
}

class _SpanToken extends _FlatInlineToken {
  final InlineSpan span;

  const _SpanToken(this.span);
}

class _NewlineToken extends _FlatInlineToken {
  const _NewlineToken();
}

class _CandidateToken extends _FlatInlineToken {
  final _CardLinkCandidate candidate;

  const _CandidateToken(this.candidate);
}

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

  InlineSpan _maybeWrapAnilistCandidate({
    required String rawUrl,
    required String? visibleLabel,
    required InlineSpan inlineFallback,
    required bool allowBlockCards,
  }) {
    if (!allowBlockCards) return inlineFallback;
    final target = AnilistUrlParser.parse(rawUrl, allowRelative: true);
    if (target == null) return inlineFallback;

    final trimmedLabel = visibleLabel?.trim();
    final isUrlLabel =
        trimmedLabel == null ||
        trimmedLabel.isEmpty ||
        trimmedLabel == rawUrl.trim() ||
        AnilistUrlParser.parse(trimmedLabel) != null;

    return WidgetSpan(
      child: _AnilistLinkCandidateMarker(
        _CardLinkCandidate(
          target: target,
          rawUrl: rawUrl.trim(),
          fallbackLabel: isUrlLabel ? null : trimmedLabel,
          isUrlLabel: isUrlLabel,
          inlineFallback: inlineFallback,
        ),
      ),
    );
  }

  InlineSpan _buildRichTextSpans(
    String text,
    TextStyle style, {
    GestureRecognizer? recognizer,
    bool allowBlockCards = true,
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
        final inlineSpan = _buildRichTextSpans(
          mdLabel,
          style.copyWith(color: borderColor),
          recognizer: linkRecognizer,
          allowBlockCards: false,
        );
        spans.add(
          _maybeWrapAnilistCandidate(
            rawUrl: mdUrl,
            visibleLabel: mdLabel,
            inlineFallback: inlineSpan,
            allowBlockCards:
                allowBlockCards &&
                recognizer == null &&
                !mdLabel.contains('\n'),
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
        final inlineSpan = TextSpan(
          text: cleanUrl,
          style: style.copyWith(color: borderColor),
          recognizer: linkRecognizer,
        );
        spans.add(
          _maybeWrapAnilistCandidate(
            rawUrl: cleanUrl,
            visibleLabel: null,
            inlineFallback: inlineSpan,
            allowBlockCards: allowBlockCards && recognizer == null,
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
                  allowBlockCards: false,
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
            allowBlockCards: allowBlockCards,
          ),
        );
      } else if (strikeText != null) {
        spans.add(
          _buildRichTextSpans(
            strikeText,
            style.copyWith(decoration: TextDecoration.lineThrough),
            recognizer: recognizer,
            allowBlockCards: allowBlockCards,
          ),
        );
      } else if (italicText != null) {
        spans.add(
          _buildRichTextSpans(
            italicText,
            style.copyWith(fontStyle: FontStyle.italic),
            recognizer: recognizer,
            allowBlockCards: allowBlockCards,
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
    bool allowBlockCards = true,
  }) {
    if (node.nodeType == dom.Node.TEXT_NODE) {
      final text = _processTextNode(node, preserveNewlines: preserveNewlines);
      return _buildRichTextSpans(
        text,
        parentStyle,
        recognizer: recognizer,
        allowBlockCards: allowBlockCards,
      );
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
      String? anchorHref;
      if (node.localName == 'a') {
        final href = node.attributes['href'];
        if (href != null && href.isNotEmpty) {
          anchorHref = href;
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
                allowBlockCards: false,
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
              allowBlockCards: allowBlockCards,
            ),
          )
          .toList();
      final textSpan = TextSpan(
        children: childrenSpans,
        style: currentStyle,
        recognizer: currentRecognizer,
      );

      if (anchorHref != null) {
        final hasEmbeddedMedia = node.querySelector('img, video') != null;
        final hasLineBreak =
            node.querySelector('br') != null || node.text.trim().contains('\n');
        if (!hasEmbeddedMedia && !hasLineBreak) {
          return _maybeWrapAnilistCandidate(
            rawUrl: anchorHref,
            visibleLabel: node.text,
            inlineFallback: textSpan,
            allowBlockCards: allowBlockCards && recognizer == null,
          );
        }
      }

      return textSpan;
    }

    return const TextSpan();
  }

  bool _containsCardCandidate(List<InlineSpan> spans) {
    for (final span in spans) {
      if (span is WidgetSpan && span.child is _AnilistLinkCandidateMarker) {
        return true;
      }
      if (span is TextSpan &&
          span.children != null &&
          _containsCardCandidate(span.children!)) {
        return true;
      }
    }
    return false;
  }

  void _flattenSpans(
    List<InlineSpan> spans,
    TextStyle? parentStyle,
    GestureRecognizer? parentRecognizer,
    List<_FlatInlineToken> out,
  ) {
    for (final span in spans) {
      if (span is WidgetSpan) {
        final child = span.child;
        if (child is _AnilistLinkCandidateMarker) {
          out.add(_CandidateToken(child.candidate));
        } else {
          out.add(_SpanToken(span));
        }
      } else if (span is TextSpan) {
        final mergedStyle = parentStyle == null
            ? span.style
            : (span.style == null
                  ? parentStyle
                  : parentStyle.merge(span.style));
        final effectiveRecognizer = span.recognizer ?? parentRecognizer;
        final text = span.text;
        if (text != null && text.isNotEmpty) {
          final parts = text.split('\n');
          for (int i = 0; i < parts.length; i++) {
            if (i > 0) out.add(const _NewlineToken());
            if (parts[i].isNotEmpty) {
              out.add(_TextToken(parts[i], mergedStyle, effectiveRecognizer));
            }
          }
        }
        if (span.children != null) {
          _flattenSpans(span.children!, mergedStyle, effectiveRecognizer, out);
        }
      }
    }
  }

  InlineSpan _tokenToInlineSpan(_FlatInlineToken token) {
    return switch (token) {
      _TextToken(:final text, :final style, :final recognizer) => TextSpan(
        text: text,
        style: style,
        recognizer: recognizer,
      ),
      _SpanToken(:final span) => span,
      _CandidateToken(:final candidate) => candidate.inlineFallback,
      _NewlineToken() => const TextSpan(text: '\n'),
    };
  }

  void _trimLeadingSpanSpaces(List<InlineSpan> segment) {
    while (segment.isNotEmpty) {
      final first = segment.first;
      if (first is! TextSpan || first.children != null) break;
      final trimmed = (first.text ?? '').trimLeft();
      if (trimmed.isEmpty) {
        segment.removeAt(0);
      } else {
        segment[0] = TextSpan(
          text: trimmed,
          style: first.style,
          recognizer: first.recognizer,
        );
        break;
      }
    }
  }

  void _trimTrailingSpanSpaces(List<InlineSpan> segment) {
    while (segment.isNotEmpty) {
      final last = segment.last;
      if (last is! TextSpan || last.children != null) break;
      final trimmed = (last.text ?? '').trimRight();
      if (trimmed.isEmpty) {
        segment.removeLast();
      } else {
        segment[segment.length - 1] = TextSpan(
          text: trimmed,
          style: last.style,
          recognizer: last.recognizer,
        );
        break;
      }
    }
  }

  bool _isIgnorableRemainder(List<InlineSpan> spans) {
    if (_isBlankSpanList(spans)) return true;
    final buffer = StringBuffer();
    for (final span in spans) {
      if (span is! TextSpan) return false;
      buffer.write(span.toPlainText());
    }
    return _lonePunctuationPattern.hasMatch(buffer.toString());
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

    void emitSpans(
      List<InlineSpan> spans, {
      required TextStyle blockStyle,
      required TextAlign align,
      required double bottomPadding,
      double leftPadding = 0,
      InlineSpan? prefixSpan,
    }) {
      if (spans.isEmpty) return;

      if (!_containsCardCandidate(spans)) {
        if (_isBlankSpanList(spans)) return;
        final richText = Text.rich(
          TextSpan(children: [?prefixSpan, ...spans]),
          style: blockStyle,
          textAlign: align,
        );
        widgets.add(
          Padding(
            padding: EdgeInsets.only(left: leftPadding, bottom: bottomPadding),
            child: alignBlock(richText, align),
          ),
        );
        return;
      }

      final flatTokens = <_FlatInlineToken>[];
      _flattenSpans(spans, null, null, flatTokens);

      final lines = <List<_FlatInlineToken>>[<_FlatInlineToken>[]];
      for (final token in flatTokens) {
        if (token is _NewlineToken) {
          lines.add(<_FlatInlineToken>[]);
        } else {
          lines.last.add(token);
        }
      }

      final pendingLines = <List<InlineSpan>>[];
      bool prefixUsed = false;

      void flushPendingLines({required double padBottom}) {
        while (pendingLines.isNotEmpty &&
            _isBlankSpanList(pendingLines.first)) {
          pendingLines.removeAt(0);
        }
        while (pendingLines.isNotEmpty && _isBlankSpanList(pendingLines.last)) {
          pendingLines.removeLast();
        }
        if (pendingLines.isEmpty) return;

        final combined = <InlineSpan>[];
        if (!prefixUsed && prefixSpan != null) {
          combined.add(prefixSpan);
          prefixUsed = true;
        }
        for (int i = 0; i < pendingLines.length; i++) {
          if (i > 0) {
            combined.add(const TextSpan(text: '\n'));
          }
          combined.addAll(pendingLines[i]);
        }
        pendingLines.clear();

        final richText = Text.rich(
          TextSpan(children: combined),
          style: blockStyle,
          textAlign: align,
        );
        widgets.add(
          Padding(
            padding: EdgeInsets.only(left: leftPadding, bottom: padBottom),
            child: alignBlock(richText, align),
          ),
        );
      }

      for (final line in lines) {
        int nonBlankCount = 0;
        for (final token in line) {
          final isNonBlank = switch (token) {
            _TextToken(:final text) => text.trim().isNotEmpty,
            _SpanToken() => true,
            _CandidateToken() => true,
            _NewlineToken() => false,
          };
          if (isNonBlank) nonBlankCount++;
        }

        final hasPromotedCard = line.any(
          (t) =>
              t is _CandidateToken &&
              (t.candidate.isUrlLabel || nonBlankCount == 1),
        );

        if (!hasPromotedCard) {
          pendingLines.add(line.map(_tokenToInlineSpan).toList());
          continue;
        }

        var currentSegment = <InlineSpan>[];
        bool trimLeadingOnNext = false;

        for (final token in line) {
          if (token is _CandidateToken &&
              (token.candidate.isUrlLabel || nonBlankCount == 1)) {
            _trimTrailingSpanSpaces(currentSegment);
            if (!_isBlankSpanList(currentSegment)) {
              pendingLines.add(currentSegment);
            }
            currentSegment = <InlineSpan>[];
            flushPendingLines(padBottom: 4);

            widgets.add(
              Padding(
                padding: EdgeInsets.only(left: leftPadding, top: 4, bottom: 8),
                child: HtmlAnilistLinkCard(
                  target: token.candidate.target,
                  rawUrl: token.candidate.rawUrl,
                  fallbackLabel: token.candidate.fallbackLabel,
                ),
              ),
            );
            trimLeadingOnNext = true;
          } else {
            currentSegment.add(_tokenToInlineSpan(token));
            if (trimLeadingOnNext) {
              _trimLeadingSpanSpaces(currentSegment);
              if (currentSegment.isNotEmpty) {
                trimLeadingOnNext = false;
              }
            }
          }
        }

        if (!_isIgnorableRemainder(currentSegment)) {
          pendingLines.add(currentSegment);
        }
      }

      flushPendingLines(padBottom: bottomPadding);
    }

    void flushSpans({double bottomPadding = 2}) {
      if (currentSpans.isEmpty) return;
      final copy = List<InlineSpan>.from(currentSpans);
      currentSpans.clear();
      emitSpans(
        copy,
        blockStyle: baseStyle,
        align: currentAlign,
        bottomPadding: bottomPadding,
      );
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

            final prefixSpan = prefix.isNotEmpty
                ? TextSpan(
                    text: prefix,
                    style: blockStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: textMuted,
                    ),
                  )
                : null;

            emitSpans(
              inlineSpans,
              blockStyle: blockStyle,
              align: effectiveAlign,
              bottomPadding: tag == 'p' ? 12 : 4,
              leftPadding: tag == 'li' ? 16 : 0,
              prefixSpan: prefixSpan,
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
