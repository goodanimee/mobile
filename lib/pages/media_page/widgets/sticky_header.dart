import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:share_plus/share_plus.dart';

import '../../../components/lucide_icons_helper.dart';
import '../../../models/media.dart';
import '../../../theme/theme.dart';

/// A sticky app bar header widget for the media details page
class StickyHeader extends StatelessWidget {
  /// The media object
  final Media media;

  /// Whether the sticky bar should be fully visible
  final bool showStickyBar;

  /// Whether this media is marked as favourite
  final bool isFavourite;

  /// Whether the favourite toggle is currently loading
  final bool isFavouriteLoading;

  /// Callback when navigating back
  final VoidCallback onBack;

  /// Callback when toggling favourite status
  final VoidCallback onToggleFavourite;

  /// Creates a sticky header widget
  const StickyHeader({
    super.key,
    required this.media,
    required this.showStickyBar,
    required this.isFavourite,
    required this.isFavouriteLoading,
    required this.onBack,
    required this.onToggleFavourite,
  });

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final title = media.title;
    final titleText = title.userPreferred.isNotEmpty
        ? title.userPreferred
        : title.romaji.isNotEmpty
        ? title.romaji
        : title.english.isNotEmpty
        ? title.english
        : 'Unknown';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: topPadding + 56,
          padding: EdgeInsets.only(top: topPadding),
          decoration: BoxDecoration(
            color: showStickyBar ? bgColor : Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: showStickyBar ? cardBorderColor : Colors.transparent,
              ),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 16,
                top: 0,
                bottom: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: onBack,
                    child: _buildGlassCircle(
                      child: const Icon(
                        LucideIcons.arrowLeft,
                        color: textPrimary,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                left: 72,
                right: 16,
                child: AnimatedOpacity(
                  opacity: showStickyBar ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: Center(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            titleText,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 16,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: onToggleFavourite,
                        child: _buildGlassCircle(
                          child: isFavouriteLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: Padding(
                                    padding: EdgeInsets.all(2.0),
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: Colors.white70,
                                    ),
                                  ),
                                )
                              : LucideHeartIcon(
                                  isFilled: isFavourite,
                                  color: isFavourite
                                      ? Colors.redAccent.shade400
                                      : textPrimary,
                                ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          final url = media.siteUrl;
                          if (url.isNotEmpty) {
                            SharePlus.instance.share(ShareParams(text: url));
                          }
                        },
                        child: _buildGlassCircle(
                          child: Icon(
                            LucideIcons.share2,
                            color: textPrimary,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGlassCircle({required Widget child}) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: showStickyBar ? 0 : 10,
          sigmaY: showStickyBar ? 0 : 10,
        ),
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: showStickyBar
                ? Colors.transparent
                : shadowColor.withValues(alpha: 0.4),
            shape: BoxShape.circle,
          ),
          child: child,
        ),
      ),
    );
  }
}
