import 'dart:ui';
import 'package:flutter/material.dart';
import 'app_network_image.dart';
import '../utils/utils.dart';

/// A specialized card for media items (Anime) with dynamic borders and status badges
class AppMediaCard extends StatelessWidget {
  /// The image URL for the media
  final String imageUrl;

  /// The title of the media
  final String title;

  /// Hex color string for the dynamic border
  final String? colorStr;

  /// Whether the media is marked as favorite
  final bool isFavourite;

  /// Whether the media is adult content
  final bool isAdult;

  /// Callback when the card is tapped
  final VoidCallback? onTap;

  /// Callback when the card is long pressed
  final VoidCallback? onLongPress;

  /// The Favorite badge widget (passed to maintain consistent styling)
  final Widget? favouriteBadge;

  /// The Adult badge widget
  final Widget? adultBadge;

  /// Creates a media card
  const AppMediaCard({
    super.key,
    required this.imageUrl,
    required this.title,
    this.colorStr,
    this.isFavourite = false,
    this.isAdult = false,
    this.onTap,
    this.onLongPress,
    this.favouriteBadge,
    this.adultBadge,
  });

  @override
  /// Builds the media card widget
  Widget build(BuildContext context) {
    final accentColor = ColorUtils.fromHex(colorStr);

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: accentColor.withValues(alpha: 0.5),
            width: 1.5,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.5),
          child: Stack(
            fit: StackFit.expand,
            children: [
              AppNetworkImage(
                imageUrl: imageUrl,
                width: double.infinity,
                height: double.infinity,
                borderRadius: BorderRadius.circular(10.5),
              ),
              if (isFavourite && favouriteBadge != null)
                Positioned(
                  top: 6,
                  right: 6,
                  child: favouriteBadge!,
                ),
              if (isAdult && adultBadge != null)
                Positioned(
                  bottom: 47,
                  right: 6,
                  child: adultBadge!,
                ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.6),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 6.0,
                      ),
                      child: SizedBox(
                        height: 29.0,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              height: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
