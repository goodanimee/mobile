import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../theme/theme.dart';
import '../utils/app_navigation.dart';

/// An inline tap-to-reveal spoiler pill for [InlineSpan] content.
class HtmlInlineSpoiler extends StatefulWidget {
  /// The inline spans revealed when tapped.
  final List<InlineSpan> childrenSpans;

  /// Base text style for the collapsed label.
  final TextStyle style;

  /// Text style applied to revealed content.
  final TextStyle revealedStyle;

  /// Creates an inline spoiler widget.
  const HtmlInlineSpoiler({
    super.key,
    required this.childrenSpans,
    required this.style,
    required this.revealedStyle,
  });

  @override
  State<HtmlInlineSpoiler> createState() => _HtmlInlineSpoilerState();
}

class _HtmlInlineSpoilerState extends State<HtmlInlineSpoiler> {
  bool _isRevealed = false;

  @override
  Widget build(BuildContext context) {
    final spoilerBtnTextSize = widget.style.fontSize ?? fontMedium(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => setState(() => _isRevealed = !_isRevealed),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: spoilerColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: spoilerColor.withValues(alpha: 0.3)),
          ),
          child: _isRevealed
              ? Text.rich(
                  TextSpan(children: widget.childrenSpans),
                  style: widget.revealedStyle.copyWith(color: spoilerColor),
                )
              : Row(
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
  }
}

/// A block-level tap-to-reveal spoiler container.
class HtmlBlockSpoiler extends StatefulWidget {
  /// Base text style for the spoiler toggle and revealed content.
  final TextStyle style;

  /// Builder invoked with the spoiler text style when revealed.
  final Widget Function(TextStyle spoilerStyle) revealedBuilder;

  /// Creates a block spoiler widget.
  const HtmlBlockSpoiler({
    super.key,
    required this.style,
    required this.revealedBuilder,
  });

  @override
  State<HtmlBlockSpoiler> createState() => _HtmlBlockSpoilerState();
}

class _HtmlBlockSpoilerState extends State<HtmlBlockSpoiler> {
  bool _isRevealed = false;

  @override
  Widget build(BuildContext context) {
    final spoilerBtnTextSize = widget.style.fontSize ?? fontMedium(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => setState(() => _isRevealed = !_isRevealed),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: spoilerColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: spoilerColor.withValues(alpha: 0.3)),
          ),
          child: _isRevealed
              ? widget.revealedBuilder(
                  widget.style.copyWith(color: spoilerColor),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      LucideIcons.eye,
                      size: spoilerBtnTextSize,
                      color: spoilerColor,
                    ),
                    const SizedBox(width: 6),
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
  }
}

/// Renders an embedded HTML `<img>` with optional explicit width and link target.
class HtmlImageEmbed extends StatelessWidget {
  /// Image source URL.
  final String src;

  /// Optional raw `width` attribute (`350`, `350px`, or `50%`).
  final String? widthAttr;

  /// Optional destination URL if the image is wrapped in an `<a>` tag.
  final String? linkUrl;

  /// Creates an HTML image embed widget.
  const HtmlImageEmbed({
    super.key,
    required this.src,
    this.widthAttr,
    this.linkUrl,
  });

  double? _resolveTargetWidth(double maxAvailableWidth) {
    final raw = widthAttr?.trim();
    if (raw == null || raw.isEmpty) return null;

    if (raw.endsWith('%')) {
      final pct = double.tryParse(raw.substring(0, raw.length - 1).trim());
      if (pct != null && pct > 0) {
        return (maxAvailableWidth * (pct / 100.0)).clamp(
          16.0,
          maxAvailableWidth,
        );
      }
      return null;
    }

    final normalized = raw.toLowerCase().endsWith('px')
        ? raw.substring(0, raw.length - 2).trim()
        : raw;
    final px = double.tryParse(normalized);
    if (px != null && px > 0) {
      return px.clamp(16.0, maxAvailableWidth);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxAvailableWidth = (screenWidth - 40.0).clamp(
      120.0,
      double.infinity,
    );
    final explicitWidth = _resolveTargetWidth(maxAvailableWidth);

    Widget image = ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: explicitWidth ?? (maxAvailableWidth * 0.85),
      ),
      child: SizedBox(
        width: explicitWidth,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: src,
            width: explicitWidth,
            fit: BoxFit.contain,
            placeholder: (context, url) => Container(
              height: 120,
              width: explicitWidth ?? 160,
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
            ),
            errorWidget: (context, url, error) => const SizedBox.shrink(),
          ),
        ),
      ),
    );

    final href = linkUrl;
    if (href != null && href.isNotEmpty) {
      image = MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => AppNavigation.handleLinkTap(context, href),
          child: image,
        ),
      );
    }

    return image;
  }
}

/// Renders a tappable external link card for AniList `youtube(...)` embeds.
class HtmlYoutubeCard extends StatelessWidget {
  /// Raw `id` attribute from `<div class="youtube" id="...">`.
  final String rawId;

  /// Creates a YouTube link card.
  const HtmlYoutubeCard({super.key, required this.rawId});

  ({String url, String? videoId}) _parseYoutubeTarget() {
    final trimmed = rawId.trim();
    if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
      final uri = Uri.tryParse(trimmed);
      String? videoId;
      if (uri != null) {
        if (uri.host.contains('youtu.be') && uri.pathSegments.isNotEmpty) {
          videoId = uri.pathSegments.first;
        } else if (uri.queryParameters['v'] != null) {
          videoId = uri.queryParameters['v'];
        } else if ((uri.pathSegments.contains('embed') ||
                uri.pathSegments.contains('shorts')) &&
            uri.pathSegments.isNotEmpty) {
          videoId = uri.pathSegments.last;
        }
      }
      return (url: trimmed, videoId: videoId);
    }

    final cleanId = trimmed.split(RegExp(r'[?&/]')).first;
    return (
      url: 'https://www.youtube.com/watch?v=$trimmed',
      videoId: cleanId.isNotEmpty ? cleanId : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (rawId.trim().isEmpty) return const SizedBox.shrink();
    final target = _parseYoutubeTarget();
    final thumbUrl = target.videoId != null
        ? 'https://img.youtube.com/vi/${target.videoId}/hqdefault.jpg'
        : null;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 360),
      child: Material(
        color: hoverBgColor,
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => AppNavigation.handleLinkTap(context, target.url),
          splashColor: pressBgColor,
          highlightColor: pressBgColor,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: cardBorderColor),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (thumbUrl != null)
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CachedNetworkImage(
                          imageUrl: thumbUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Container(color: surfaceBackground),
                          errorWidget: (context, url, error) =>
                              Container(color: surfaceBackground),
                        ),
                        Container(color: Colors.black.withValues(alpha: 0.25)),
                        Center(
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.7),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white24),
                            ),
                            child: const Icon(
                              LucideIcons.play,
                              color: textPrimary,
                              size: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.playCircle,
                        size: 18,
                        color: Colors.redAccent,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Watch on YouTube',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: textPrimary,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Icon(
                        LucideIcons.externalLink,
                        size: 15,
                        color: textMuted,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Renders a tappable external link card for AniList `webm(...)` / `<video>` embeds.
class HtmlVideoCard extends StatelessWidget {
  /// Direct video source URL.
  final String src;

  /// Creates a video link card.
  const HtmlVideoCard({super.key, required this.src});

  String _formatSubtitle() {
    final uri = Uri.tryParse(src.trim());
    if (uri == null || uri.host.isEmpty) return src.trim();
    final fileName = uri.pathSegments.isNotEmpty ? uri.pathSegments.last : '';
    return fileName.isNotEmpty ? '${uri.host} - $fileName' : uri.host;
  }

  @override
  Widget build(BuildContext context) {
    if (src.trim().isEmpty) return const SizedBox.shrink();

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 360),
      child: Material(
        color: hoverBgColor,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () => AppNavigation.handleLinkTap(context, src.trim()),
          borderRadius: BorderRadius.circular(12),
          splashColor: pressBgColor,
          highlightColor: pressBgColor,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: cardBorderColor),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: paletteBlue.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    LucideIcons.video,
                    size: 18,
                    color: borderColor,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Open Video',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: textPrimary,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _formatSubtitle(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  LucideIcons.externalLink,
                  size: 15,
                  color: textMuted,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
