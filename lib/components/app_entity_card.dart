import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../theme/theme.dart';
import 'app_network_image.dart';

/// Card for entities (staff/characters)
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
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final cardWidth = constraints.maxWidth;
          final imageWidth = (cardWidth * 0.38).clamp(65.0, 85.0);

          return Container(
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
                      width: imageWidth,
                      height: double.infinity,
                      fallbackIcon: LucideIcons.user,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fontTitle(context),
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                            ),
                            if (nativeName != null &&
                                nativeName!.isNotEmpty) ...[
                              const SizedBox(height: 2),
                              Text(
                                nativeName!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white38,
                                  fontSize: fontMedium(context),
                                  height: 1.2,
                                ),
                              ),
                            ],
                            const SizedBox(height: 8),
                            Text(
                              subtitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: fontSmall(context),
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
                  Positioned(bottom: 8, right: 8, child: trailing!),
              ],
            ),
          );
        },
      ),
    );
  }
}
