import 'package:flutter/material.dart';

import '../../../components/loading_indicator.dart';
import '../../../components/relation_card.dart';
import '../../../models/media_character.dart';
import '../../../models/media_min.dart';
import '../../../models/media_staff.dart';
import '../../../theme/theme.dart';
import '../../../utils/app_navigation.dart';
import '../../../utils/utils.dart';

/// Tab displaying characters voiced or portrayed by a staff member.
class StaffCharactersTab extends StatelessWidget {
  /// The staff data.
  final Staff staff;

  /// Whether more character items are currently loading.
  final bool isLoadingMore;

  /// Creates a staff characters tab.
  const StaffCharactersTab({
    super.key,
    required this.staff,
    required this.isLoadingMore,
  });

  @override
  Widget build(BuildContext context) {
    final edges = staff.characterMedia?.edges ?? [];
    if (edges.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Center(
          child: Text(
            'No voiced characters found for this staff member',
            style: TextStyle(color: textMuted, fontSize: fontLarge(context)),
          ),
        ),
      );
    }

    final grouped = <String, List<_CharacterPlayItem>>{};
    for (final edge in edges) {
      if (edge.node == null) continue;
      final year = edge.node!.startYear?.toString() ?? 'TBA';
      for (final char in edge.characters) {
        grouped
            .putIfAbsent(year, () => [])
            .add(
              _CharacterPlayItem(
                character: char,
                media: edge.node!,
                role: edge.characterRole,
              ),
            );
      }
    }

    final flatList = <dynamic>[];
    grouped.forEach((year, items) {
      flatList.add(year);
      flatList.addAll(items);
    });

    if (flatList.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Center(
          child: Text(
            'No voiced characters found for this staff member',
            style: TextStyle(color: textMuted, fontSize: fontLarge(context)),
          ),
        ),
      );
    }

    final itemCount = flatList.length + (isLoadingMore ? 1 : 0);

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (index == flatList.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(child: AppLoadingIndicator(topPadding: 0)),
          );
        }

        final element = flatList[index];

        if (element is String) {
          return Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 8),
            child: Text(
              element,
              style: TextStyle(
                color: textSecondary,
                fontSize: fontLarge(context),
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

        final item = element as _CharacterPlayItem;
        final char = item.character;
        final media = item.media;

        final charName = char.name?.userPreferred ?? 'Unknown Character';
        final mediaTitle = media.title.userPreferred.isNotEmpty
            ? media.title.userPreferred
            : media.title.romaji.isNotEmpty
            ? media.title.romaji
            : 'Unknown';

        final role = item.role ?? '';
        final colorHex = media.coverImage.color;
        final color = ColorUtils.fromHex(
          colorHex,
          fallback: Colors.transparent,
        );

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: SizedBox(
            height: 110,
            child: RelationCard(
              imageUrl: char.image?.large ?? char.image?.medium ?? '',
              title: charName,
              format: role,
              subtitle: mediaTitle,
              rightImageUrl: media.coverImage.large,
              rightAlignSubtitle: true,
              color: color != Colors.transparent ? color : null,
              onTap: () {
                AppNavigation.toCharacter(
                  context,
                  characterId: char.id,
                  character: CharacterMin(
                    id: char.id,
                    name: char.name != null
                        ? CharacterName(
                            full: char.name?.userPreferred ?? '',
                            userPreferred: char.name?.userPreferred,
                            alternative: const [],
                            alternativeSpoiler: const [],
                          )
                        : null,
                    image: char.image != null
                        ? CharacterImage(
                            large: char.image?.large,
                            medium: char.image?.medium,
                          )
                        : null,
                  ),
                );
              },
              onRightTap: () {
                AppNavigation.toMedia(context, media.id);
              },
            ),
          ),
        );
      },
    );
  }
}

class _CharacterPlayItem {
  final StaffCharacter character;
  final MediaMin media;
  final String? role;

  const _CharacterPlayItem({
    required this.character,
    required this.media,
    this.role,
  });
}
