import 'package:flutter/material.dart';

import '../../../components/loading_indicator.dart';
import '../../../components/relation_card.dart';
import '../../../models/media_staff.dart';
import '../../../theme/theme.dart';
import '../../../utils/app_navigation.dart';
import '../../../utils/utils.dart';

/// Tab displaying media productions that a staff member worked on.
class StaffMediaTab extends StatelessWidget {
  /// The staff data.
  final Staff staff;

  /// Whether more media items are currently loading.
  final bool isLoadingMore;

  /// Creates a staff media tab.
  const StaffMediaTab({
    super.key,
    required this.staff,
    required this.isLoadingMore,
  });

  @override
  Widget build(BuildContext context) {
    final edges = staff.staffMedia?.edges ?? [];
    if (edges.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Center(
          child: Text(
            'No media roles found for this staff member',
            style: TextStyle(color: textMuted, fontSize: fontLarge(context)),
          ),
        ),
      );
    }

    final grouped = <String, List<StaffMediaEdge>>{};
    for (final edge in edges) {
      if (edge.node == null) continue;
      final year = edge.node!.startYear?.toString() ?? 'TBA';
      grouped.putIfAbsent(year, () => []).add(edge);
    }

    final flatList = <dynamic>[];
    grouped.forEach((year, items) {
      flatList.add(year);
      flatList.addAll(items);
    });

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

        final edge = element as StaffMediaEdge;
        final media = edge.node!;
        final userPreferredTitle = media.title.userPreferred.isNotEmpty
            ? media.title.userPreferred
            : media.title.romaji.isNotEmpty
            ? media.title.romaji
            : media.title.english.isNotEmpty
            ? media.title.english
            : 'Unknown';

        final role = edge.staffRole ?? '';
        final format = media.format.replaceAll('_', ' ');

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
              imageUrl: media.coverImage.large,
              title: userPreferredTitle,
              nativeTitle: media.title.native,
              format: format,
              subtitle: role,
              color: color != Colors.transparent ? color : null,
              onTap: () => AppNavigation.toMedia(context, media.id),
            ),
          ),
        );
      },
    );
  }
}
