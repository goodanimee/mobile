import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/theme.dart';

/// A robust network image widget with consistent placeholders and error handling
class AppNetworkImage extends StatelessWidget {
  /// The URL of the image to display
  final String imageUrl;

  /// The width of the image
  final double? width;

  /// The height of the image
  final double? height;

  /// How to fit the image into the bounds
  final BoxFit fit;

  /// The border radius of the image
  final BorderRadius? borderRadius;

  /// The icon to display if the image fails to load
  final IconData fallbackIcon;

  /// Whether to check if the image is a default placeholder from the API
  final bool checkDefault;

  /// Creates a network image
  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.fallbackIcon = Icons.error,
    this.checkDefault = false,
  });

  @override
  /// Builds the network image widget
  Widget build(BuildContext context) {
    final bool isDefaultImage =
        imageUrl.isEmpty || (checkDefault && imageUrl.contains('default.jpg'));

    Widget image = isDefaultImage
        ? _buildPlaceholder()
        : CachedNetworkImage(
            imageUrl: imageUrl,
            width: width,
            height: height,
            fit: fit,
            placeholder: (context, url) => _buildPlaceholder(),
            errorWidget: (context, url, error) => _buildPlaceholder(),
          );

    if (borderRadius != null) {
      image = ClipRRect(borderRadius: borderRadius!, child: image);
    }

    return image;
  }

  Widget _buildPlaceholder() {
    return Container(
      width: width,
      height: height,
      color: Colors.white.withValues(alpha: 0.05),
      child: Center(
        child: Icon(fallbackIcon, color: borderColor.withValues(alpha: 0.5)),
      ),
    );
  }
}
