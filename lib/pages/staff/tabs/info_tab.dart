import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../components/app_network_image.dart';
import '../../../components/html_description.dart';
import '../../../models/common.dart';
import '../../../models/media_staff.dart';
import '../../../theme/theme.dart';

/// Tab displaying biography and personal details of a staff member.
class StaffInfoTab extends StatelessWidget {
  /// The staff data.
  final Staff staff;

  /// Creates a staff information tab.
  const StaffInfoTab({super.key, required this.staff});

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

  String? _formatBirthInfo(FuzzyDate? dob, int? age) {
    if (dob == null) {
      return age?.toString();
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

    if (dateStr.isEmpty) {
      return age?.toString();
    }
    return dateStr;
  }

  @override
  Widget build(BuildContext context) {
    final name =
        staff.name?.userPreferred ?? staff.name?.full ?? 'Staff Member';
    final nativeName = staff.name?.native ?? '';
    final imageUrl = staff.image?.large ?? staff.image?.medium ?? '';

    final alternativeNames = staff.name?.alternative ?? [];
    final birthday = _formatBirthInfo(staff.dateOfBirth, staff.age);
    final deathday = _formatBirthInfo(staff.dateOfDeath, null);
    final yearsActive = staff.yearsActive.isNotEmpty
        ? staff.yearsActive.join(' - ')
        : null;
    final age = staff.age?.toString();
    final gender = staff.gender != null && staff.gender!.isNotEmpty
        ? staff.gender
        : null;
    final bloodType = staff.bloodType != null && staff.bloodType!.isNotEmpty
        ? staff.bloodType
        : null;
    final hometown = staff.homeTown != null && staff.homeTown!.isNotEmpty
        ? staff.homeTown
        : null;
    final occupations = staff.primaryOccupations.isNotEmpty
        ? staff.primaryOccupations.join(', ')
        : null;
    final descriptionHtml = staff.description ?? '';

    final List<MapEntry<String, String>> statRows = [];
    if (birthday != null) statRows.add(MapEntry('Birthday', birthday));
    if (deathday != null) statRows.add(MapEntry('Death', deathday));
    if (yearsActive != null) {
      statRows.add(MapEntry('Years Active', yearsActive));
    }
    if (age != null) statRows.add(MapEntry('Age', age));
    if (gender != null) statRows.add(MapEntry('Gender', gender));
    if (bloodType != null) statRows.add(MapEntry('Blood Type', bloodType));
    if (hometown != null) statRows.add(MapEntry('Hometown', hometown));
    if (occupations != null) statRows.add(MapEntry('Occupations', occupations));

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
                      Text(
                        'Also Known As',
                        style: TextStyle(
                          fontSize: fontSmall(context),
                          fontWeight: FontWeight.w600,
                          color: textMuted,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: alternativeNames.map((n) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.05),
                              ),
                            ),
                            child: Text(
                              n,
                              style: TextStyle(
                                color: textSecondary,
                                fontSize: fontMini(context),
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
