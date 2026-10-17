import 'package:flutter/material.dart';

import '../../../components/loading_indicator.dart';
import '../../../components/relation_card.dart';
import '../../../models/media_character.dart';
import '../../../models/media_staff.dart';
import '../../../theme/theme.dart';
import '../../../utils/app_navigation.dart';
import '../../../utils/utils.dart';

/// Tab displaying media appearances and voice actor roles for a character.
class CharacterMediaTab extends StatelessWidget {
  /// The character data.
  final Character character;

  /// Whether more media items are currently loading.
  final bool isLoadingMore;

  /// Selected voice actor language filter.
  final String selectedLanguage;

  /// Creates a character media tab.
  const CharacterMediaTab({
    super.key,
    required this.character,
    required this.isLoadingMore,
    this.selectedLanguage = 'Japanese',
  });

  @override
  Widget build(BuildContext context) {
    final edges = character.media?.edges ?? [];
    if (edges.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Center(
          child: Text(
            'No media appearances found for this character',
            style: TextStyle(color: textMuted, fontSize: fontLarge(context)),
          ),
        ),
      );
    }

    final flatList = flattenCharacterMediaByYear(edges);

    if (flatList.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Center(
          child: Text(
            'No media appearances found for this character',
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

        final edge = element as CharacterMediaEdge;
        final media = edge.node!;

        final mediaTitle = media.title.userPreferred.isNotEmpty
            ? media.title.userPreferred
            : media.title.romaji.isNotEmpty
            ? media.title.romaji
            : 'Unknown';

        final role = formatCharacterRole(edge.characterRole);
        final format = media.format.replaceAll('_', ' ');

        final colorHex = media.coverImage.color;
        final color = ColorUtils.fromHex(
          colorHex,
          fallback: Colors.transparent,
        );

        final va = resolveCharacterVoiceActor(
          edge.voiceActors,
          selectedLanguage,
        );
        final hasVa = va != null;

        final formatText = role.isNotEmpty && format.isNotEmpty
            ? '$format \u00B7 $role'
            : role.isNotEmpty
            ? role
            : format;

        final subtitle = hasVa
            ? (va.name?.userPreferred ?? va.name?.full ?? '')
            : role;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: SizedBox(
            height: 110,
            child: RelationCard(
              imageUrl: media.coverImage.large,
              title: mediaTitle,
              nativeTitle: media.title.native,
              format: hasVa ? formatText : format,
              subtitle: subtitle,
              rightImageUrl: hasVa
                  ? (va.image?.large ?? va.image?.medium)
                  : null,
              rightAlignSubtitle: hasVa,
              color: color != Colors.transparent ? color : null,
              onTap: () => AppNavigation.toMedia(context, media.id),
              onRightTap: hasVa
                  ? () => AppNavigation.toStaff(context, va)
                  : null,
            ),
          ),
        );
      },
    );
  }
}

/// Groups character media appearances by release year and orders entries by role priority.
Map<String, List<CharacterMediaEdge>> groupCharacterMediaByYear(
  List<CharacterMediaEdge> edges,
) {
  final grouped = <String, List<CharacterMediaEdge>>{};
  for (final edge in edges) {
    if (edge.node == null) continue;
    final year = edge.node!.startYear?.toString() ?? 'TBA';
    grouped.putIfAbsent(year, () => []).add(edge);
  }

  for (final entry in grouped.entries) {
    final indexed = entry.value.asMap().entries.toList();
    indexed.sort((a, b) {
      final pA = characterRolePriority(a.value.characterRole);
      final pB = characterRolePriority(b.value.characterRole);
      if (pA != pB) return pA.compareTo(pB);
      return a.key.compareTo(b.key);
    });
    grouped[entry.key] = indexed.map((e) => e.value).toList();
  }

  return grouped;
}

/// Flattens grouped character media appearances into alternating year headers and edges.
List<Object> flattenCharacterMediaByYear(List<CharacterMediaEdge> edges) {
  final grouped = groupCharacterMediaByYear(edges);
  final flatList = <Object>[];
  grouped.forEach((year, items) {
    flatList.add(year);
    flatList.addAll(items);
  });
  return flatList;
}

/// Returns numeric sort priority for a character role (`MAIN` < `SUPPORTING` < `BACKGROUND`).
int characterRolePriority(String? role) {
  switch (role?.toUpperCase()) {
    case 'MAIN':
      return 0;
    case 'SUPPORTING':
      return 1;
    case 'BACKGROUND':
      return 2;
    default:
      return 3;
  }
}

/// Resolves the matching voice actor for [language] from [voiceActors].
StaffMin? resolveCharacterVoiceActor(
  List<StaffMin> voiceActors,
  String language,
) {
  if (voiceActors.isEmpty) return null;
  for (final va in voiceActors) {
    if (va.languageV2?.toLowerCase() == language.toLowerCase()) {
      return va;
    }
  }
  if (voiceActors.length == 1 && voiceActors.first.languageV2 == null) {
    return voiceActors.first;
  }
  return null;
}

/// Formats a raw AniList character role enum into display text.
String formatCharacterRole(String? role) {
  if (role == null || role.isEmpty) return '';
  switch (role.toUpperCase()) {
    case 'MAIN':
      return 'Main';
    case 'SUPPORTING':
      return 'Supporting';
    case 'BACKGROUND':
      return 'Background';
    default:
      return role[0].toUpperCase() + role.substring(1).toLowerCase();
  }
}
