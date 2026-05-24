import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../components/section_title.dart';
import '../../../components/app_network_image.dart';
import '../../../components/html_description.dart';
import '../../../models/media_character.dart';
import '../../../models/common.dart';

/// A bottom sheet displaying detailed information about a character
class CharacterSheet extends StatefulWidget {
  /// The character data to display
  final CharacterEdge character;

  /// Creates a character sheet
  const CharacterSheet({super.key, required this.character});

  @override
  State<CharacterSheet> createState() => _CharacterSheetState();
}

/// State for CharacterSheet
class _CharacterSheetState extends State<CharacterSheet> {
  bool _isSpoilerVisible = false;

  @override
  /// Builds the character sheet widget
  Widget build(BuildContext context) {
    final charNode = widget.character.node;
    final name = charNode?.name;
    final fullName = name?.userPreferred ?? name?.full ?? 'Unknown';
    final nativeName = name?.native ?? '';
    final altNames = name?.alternative ?? [];
    final altSpoiler = name?.alternativeSpoiler ?? [];
    final description = charNode?.description ?? 'No description available.';
    final imageUrl = charNode?.image?.large ?? '';
    final role = widget.character.role;
    final age = charNode?.age ?? '';
    final gender = charNode?.gender ?? '';
    final dob = charNode?.dateOfBirth;

    final birthInfo = _formatBirthInfo(dob, age.toString());

    final voiceActors = widget.character.voiceActors;

    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF161616),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            border: Border.all(color: cardBorderColor, width: 1.0),
          ),
          child: Column(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onVerticalDragUpdate: (details) {},
                child: Container(
                  height: 32,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppNetworkImage(
                            imageUrl: imageUrl,
                            width: 100,
                            height: 140,
                            borderRadius: BorderRadius.circular(12),
                            checkDefault: true,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  fullName,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (nativeName.isNotEmpty) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    nativeName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white54,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                                const SizedBox(height: 12),
                                _buildInfoRow(Icons.person_outline, role),
                                if (birthInfo.isNotEmpty) ...[
                                  const SizedBox(height: 6),
                                  _buildInfoRow(Icons.cake_outlined, birthInfo),
                                ],
                                if (gender.toString().isNotEmpty) ...[
                                  const SizedBox(height: 6),
                                  _buildInfoRow(
                                    gender.toString().toLowerCase() == 'male'
                                        ? Icons.male
                                        : gender.toString().toLowerCase() ==
                                              'female'
                                        ? Icons.female
                                        : Icons.transgender,
                                    gender.toString(),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      HtmlDescription(html: description),
                      if (altNames.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: altNames.map<Widget>((n) {
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
                                  color: Colors.white38,
                                  fontSize: 12,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                      if (altSpoiler.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        if (!_isSpoilerVisible)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isSpoilerVisible = true;
                              });
                            },
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: Icon(
                                      Icons.warning_amber_rounded,
                                      size: 14,
                                      color: spoilerColor,
                                    ),
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
                            children: altSpoiler.map<Widget>((name) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isSpoilerVisible = false;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: spoilerColor.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: spoilerColor.withValues(
                                        alpha: 0.3,
                                      ),
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
                      const SizedBox(height: 32),

                      if (voiceActors.isNotEmpty) ...[
                        const SectionTitle(
                          title: 'Voice Actors',
                          fontSize: 16,
                          bottomPadding: 16,
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: voiceActors.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final va = voiceActors[index];
                            final vaName = va.name?.full ?? 'Unknown';
                            final vaLang = va.languageV2 ?? '';
                            final vaImageUrl = va.image?.large ?? '';

                            return Row(
                              children: [
                                AppNetworkImage(
                                  imageUrl: vaImageUrl,
                                  width: 50,
                                  height: 50,
                                  borderRadius: BorderRadius.circular(8),
                                  fallbackIcon: Icons.person,
                                  checkDefault: true,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        vaName,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        vaLang,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.white54,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 40),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Formats birth date and age into a readable string
  String _formatBirthInfo(FuzzyDate? dob, String age) {
    if (dob == null) {
      if (age.isNotEmpty && age != 'null') {
        return age;
      }
      return '';
    }
    final day = dob.day;
    final month = dob.month;
    final year = dob.year;

    String dateStr = '';
    if (day != null && month != null) {
      final months = [
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

    String finalStr = dateStr;
    if (age.isNotEmpty && age != 'null') {
      if (finalStr.isNotEmpty) {
        finalStr += ' ($age)';
      } else {
        finalStr = age;
      }
    }

    return finalStr;
  }

  /// Builds a row of information with an icon and label
  Widget _buildInfoRow(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: 14),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ),
      ],
    );
  }
}
