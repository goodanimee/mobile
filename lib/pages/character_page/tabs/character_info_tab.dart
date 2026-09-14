import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../components/app_network_image.dart';
import '../../../components/html_description.dart';
import '../../../models/common.dart';
import '../../../models/media_character.dart';
import '../../../theme/theme.dart';

/// Tab displaying biography and personal details of a character
class CharacterInfoTab extends StatefulWidget {
  /// The character data
  final Character character;

  /// Optional fallback minimal character data
  final CharacterMin? fallbackMin;

  /// Creates a character information tab
  const CharacterInfoTab({
    super.key,
    required this.character,
    this.fallbackMin,
  });

  @override
  State<CharacterInfoTab> createState() => _CharacterInfoTabState();
}

class _CharacterInfoTabState extends State<CharacterInfoTab> {
  bool _isSpoilerVisible = false;

  Widget _buildStatRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: textMuted, fontSize: fontBody(context)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: textPrimary,
                fontSize: fontBody(context),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? _formatBirthInfo(FuzzyDate? dob) {
    if (dob == null) return null;
    final day = dob.day;
    final month = dob.month;
    final year = dob.year;

    String dateStr = '';
    if (day != null && month != null) {
      const months = [
        '',
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      final monthStr = (month > 0 && month <= 12) ? months[month] : '';
      if (monthStr.isNotEmpty) {
        dateStr = '$monthStr $day';
        if (year != null && year > 0) {
          dateStr += ', $year';
        }
      }
    } else if (year != null && year > 0) {
      dateStr = year.toString();
    }
    return dateStr.isEmpty ? null : dateStr;
  }

  @override
  Widget build(BuildContext context) {
    final character = widget.character;
    final fallbackMin = widget.fallbackMin;

    final name =
        character.name?.userPreferred ??
        character.name?.full ??
        fallbackMin?.name?.userPreferred ??
        fallbackMin?.name?.full ??
        'Character';
    final nativeName =
        character.name?.native ?? fallbackMin?.name?.native ?? '';
    final imageUrl =
        character.image?.large ??
        character.image?.medium ??
        fallbackMin?.image?.large ??
        fallbackMin?.image?.medium ??
        '';

    final alternativeNames = character.name?.alternative ?? [];
    final alternativeSpoilerNames = character.name?.alternativeSpoiler ?? [];
    final birthday = _formatBirthInfo(character.dateOfBirth);
    final age = character.age != null && character.age!.isNotEmpty
        ? character.age
        : null;
    final gender = character.gender != null && character.gender!.isNotEmpty
        ? character.gender
        : null;
    final bloodType =
        character.bloodType != null && character.bloodType!.isNotEmpty
        ? character.bloodType
        : null;
    final descriptionHtml = character.description ?? '';

    final List<MapEntry<String, String>> statRows = [];
    if (birthday != null) statRows.add(MapEntry('Birthday', birthday));
    if (age != null) statRows.add(MapEntry('Age', age));
    if (gender != null) statRows.add(MapEntry('Gender', gender));
    if (bloodType != null) statRows.add(MapEntry('Blood Type', bloodType));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (imageUrl.isNotEmpty)
                AppNetworkImage(
                  imageUrl: imageUrl,
                  width: 100,
                  height: 140,
                  borderRadius: BorderRadius.circular(12),
                )
              else
                Container(
                  width: 100,
                  height: 140,
                  decoration: BoxDecoration(
                    color: hoverBgColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: cardBorderColor),
                  ),
                  child: const Icon(
                    LucideIcons.user,
                    color: textMuted,
                    size: 36,
                  ),
                ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: fontTitle(context),
                        fontWeight: FontWeight.bold,
                        color: textPrimary,
                      ),
                    ),
                    if (nativeName.isNotEmpty && nativeName != name) ...[
                      const SizedBox(height: 4),
                      Text(
                        nativeName,
                        style: TextStyle(
                          fontSize: fontBody(context),
                          color: textMuted,
                        ),
                      ),
                    ],
                    if (alternativeNames.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Text(
                            'Also known as: ',
                            style: TextStyle(
                              color: textMuted,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          ...alternativeNames.map((n) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.05),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                n,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ],
                    if (alternativeSpoilerNames.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      if (!_isSpoilerVisible)
                        GestureDetector(
                          onTap: () => setState(() => _isSpoilerVisible = true),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: spoilerColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: spoilerColor.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  LucideIcons.triangleAlert,
                                  size: 14,
                                  color: spoilerColor,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Tap to reveal spoilers',
                                  style: TextStyle(
                                    color: spoilerColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        Wrap(
                          spacing: 8,
                          runSpacing: 6,
                          children: alternativeSpoilerNames.map((name) {
                            return GestureDetector(
                              onTap: () =>
                                  setState(() => _isSpoilerVisible = false),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: spoilerColor.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: spoilerColor.withValues(alpha: 0.3),
                                  ),
                                ),
                                child: Text(
                                  name,
                                  style: TextStyle(
                                    color: spoilerColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          if (statRows.isNotEmpty) ...[
            const SizedBox(height: 28),
            Text(
              'Information',
              style: TextStyle(
                fontSize: fontTitle(context),
                fontWeight: FontWeight.bold,
                color: textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: hoverBgColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: cardBorderColor),
              ),
              child: Column(
                children: List.generate(statRows.length, (index) {
                  final row = statRows[index];
                  final isLast = index == statRows.length - 1;
                  return Column(
                    children: [
                      _buildStatRow(context, row.key, row.value),
                      if (!isLast)
                        const Divider(color: cardBorderColor, height: 16),
                    ],
                  );
                }),
              ),
            ),
          ],
          if (descriptionHtml.isNotEmpty) ...[
            const SizedBox(height: 28),
            Text(
              'Biography',
              style: TextStyle(
                fontSize: fontTitle(context),
                fontWeight: FontWeight.bold,
                color: textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            HtmlDescription(html: descriptionHtml),
          ],
        ],
      ),
    );
  }
}
