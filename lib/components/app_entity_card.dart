import 'package:flutter/material.dart';
import 'app_network_image.dart';

/// A wide card for entities (staff/characters) with image on the left and info on the right
class AppEntityCard extends StatelessWidget {
  /// The image URL for the entity
  final String imageUrl;

  /// The full name of the entity
  final String name;

  /// The native name of the entity
  final String? nativeName;

  /// The role or position of the entity
  final String subtitle;

  /// Optional widget to display in the bottom right corner (e.g. info icon)
  final Widget? trailing;

  /// Callback when the card is tapped
  final VoidCallback? onTap;

  /// Creates an entity card
  const AppEntityCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.subtitle,
    this.nativeName,
    this.trailing,
    this.onTap,
  });

  @override
  /// Builds the entity card widget
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white12),
        ),
        child: Stack(
          children: [
            Row(
              children: [
                AppNetworkImage(
                  imageUrl: imageUrl,
                  width: 85,
                  height: double.infinity,
                  fallbackIcon: Icons.person,
                  checkDefault: true,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(11),
                    bottomLeft: Radius.circular(11),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, right: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                        if (nativeName != null && nativeName!.isNotEmpty) ...[
                          const SizedBox(height: 2),
                          Text(
                            nativeName!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white38,
                              fontSize: 15,
                              height: 1.2,
                            ),
                          ),
                        ],
                        const SizedBox(height: 8),
                        Text(
                          subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 12,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (trailing != null)
              Positioned(
                bottom: 8,
                right: 8,
                child: trailing!,
              ),
          ],
        ),
      ),
    );
  }
}
