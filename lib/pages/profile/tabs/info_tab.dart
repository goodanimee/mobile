import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../components/html_description.dart';
import '../../../components/section.dart';
import '../../../models/user_profile.dart';
import '../../../theme/theme.dart';
import '../../../utils/utils.dart';

/// Info tab displaying list shortcuts and the user's HTML bio.
class ProfileInfoTab extends StatelessWidget {
  /// User profile data to display.
  final UserProfile profile;

  /// Callback triggered when the Anime List shortcut card is tapped.
  final VoidCallback onOpenAnimeList;

  /// Callback triggered when the Manga List shortcut card is tapped.
  final VoidCallback onOpenMangaList;

  /// Creates a profile info tab.
  const ProfileInfoTab({
    super.key,
    required this.profile,
    required this.onOpenAnimeList,
    required this.onOpenMangaList,
  });

  @override
  Widget build(BuildContext context) {
    final hasBio = profile.about.trim().isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: _ListShortcutCard(
                  icon: LucideIcons.tv,
                  label: 'Anime List',
                  count: profile.animeCount,
                  onTap: onOpenAnimeList,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ListShortcutCard(
                  icon: LucideIcons.library,
                  label: 'Manga List',
                  count: profile.mangaCount,
                  onTap: onOpenMangaList,
                ),
              ),
            ],
          ),
          Section(
            title: 'About',
            topSpacing: 20,
            children: [
              if (hasBio)
                HtmlDescription(html: profile.about)
              else
                const Text(
                  'No bio available.',
                  style: TextStyle(color: textMuted, fontSize: 14),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ListShortcutCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final int count;
  final VoidCallback onTap;

  const _ListShortcutCard({
    required this.icon,
    required this.label,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final formattedCount = StringUtils.formatCompactNumber(count);
    final unit = StringUtils.pluralize(count, 'entry', 'entries');

    return Material(
      color: hoverBgColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
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
                child: Icon(icon, size: 18, color: borderColor),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: textPrimary,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$formattedCount $unit',
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
              const Icon(LucideIcons.chevronRight, size: 16, color: textMuted),
            ],
          ),
        ),
      ),
    );
  }
}
