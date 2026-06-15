import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../components/app_network_image.dart';
import '../components/floating_nav.dart';
import '../components/html_description.dart';
import '../components/lucide_icons_helper.dart';
import '../models/media_staff.dart';
import '../theme/theme.dart';
import '../utils/app_navigation.dart';
import '../utils/utils.dart';

/// A page displaying details for a staff member
class StaffPage extends StatefulWidget {
  /// The staff data
  final StaffMin staff;

  /// Creates a staff page
  const StaffPage({super.key, required this.staff});

  @override
  State<StaffPage> createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  final ScrollController _scrollController = ScrollController();
  int _selectedTabIndex = 0;
  bool _isFavourite = false;
  int _favouritesCount = 1420;

  void _toggleFavourite() {
    setState(() {
      _isFavourite = !_isFavourite;
      if (_isFavourite) {
        _favouritesCount++;
      } else {
        _favouritesCount--;
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleNavTap(int index) {
    AppNavigation.currentTab.value = index;
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  Widget _buildActiveTab() {
    switch (_selectedTabIndex) {
      case 0:
        return _StaffInfoTab(staff: widget.staff);
      case 1:
        return const _StaffMediaTab();
      case 2:
        return const _StaffCharactersTab();
      default:
        return const _StaffInfoTab(staff: null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final staffName =
        widget.staff.name?.userPreferred ??
        widget.staff.name?.full ??
        'Staff Member';

    final quickNavItems = [
      QuickNavSection(
        icon: LucideIcons.info,
        label: 'Info',
        isSelected: _selectedTabIndex == 0,
        onTap: () {
          setState(() => _selectedTabIndex = 0);
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        },
      ),
      QuickNavSection(
        icon: LucideIcons.film,
        label: 'Media',
        isSelected: _selectedTabIndex == 1,
        onTap: () {
          setState(() => _selectedTabIndex = 1);
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        },
      ),
      QuickNavSection(
        icon: LucideIcons.users,
        label: 'Characters',
        isSelected: _selectedTabIndex == 2,
        onTap: () {
          setState(() => _selectedTabIndex = 2);
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        },
      ),
    ];

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).padding.top + 56 + 16,
                ),
              ),
              SliverToBoxAdapter(child: _buildActiveTab()),
              const SliverToBoxAdapter(child: SizedBox(height: 128)),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _StaffStickyHeader(
              staffName: staffName,
              onBack: () => Navigator.of(context).pop(),
              isFavourite: _isFavourite,
              favouritesCount: _favouritesCount,
              onToggleFavourite: _toggleFavourite,
            ),
          ),
          Positioned(
            bottom: 24,
            right: 20,
            child: FloatingNav(
              selectedIndex: -1,
              onTap: _handleNavTap,
              quickNavSections: quickNavItems,
            ),
          ),
        ],
      ),
    );
  }
}

class _StaffStickyHeader extends StatelessWidget {
  final String staffName;
  final VoidCallback onBack;
  final bool isFavourite;
  final int favouritesCount;
  final VoidCallback onToggleFavourite;

  const _StaffStickyHeader({
    required this.staffName,
    required this.onBack,
    required this.isFavourite,
    required this.favouritesCount,
    required this.onToggleFavourite,
  });

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Container(
      height: topPadding + 56,
      padding: EdgeInsets.only(top: topPadding),
      decoration: const BoxDecoration(
        color: bgColor,
        border: Border(bottom: BorderSide(color: cardBorderColor)),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 8,
            top: 0,
            bottom: 0,
            child: Center(
              child: IconButton(
                icon: const Icon(LucideIcons.arrowLeft, color: textPrimary),
                onPressed: onBack,
              ),
            ),
          ),
          Positioned.fill(
            left: 56,
            right: 120,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                staffName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: textPrimary,
                ),
              ),
            ),
          ),
          Positioned(
            right: 16,
            top: 0,
            bottom: 0,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '(${StringUtils.formatCompactNumber(favouritesCount)})',
                    style: const TextStyle(
                      color: textSecondary,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: onToggleFavourite,
                    child: LucideHeartIcon(
                      isFilled: isFavourite,
                      color: isFavourite
                          ? Colors.redAccent.shade400
                          : textPrimary,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StaffInfoTab extends StatelessWidget {
  final StaffMin? staff;

  const _StaffInfoTab({required this.staff});

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: textMuted, fontSize: 14)),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                color: textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final name =
        staff?.name?.userPreferred ?? staff?.name?.full ?? 'Lorem Ipsum';
    final nativeName = staff?.name?.native ?? 'Dolor Sit';
    final imageUrl = staff?.image?.large ?? '';

    final alternativeNames = const ['Lorem', 'Ipsum', 'Dolor'];
    final birthday = 'Lorem Ipsum';
    final yearsActive = 'Sit Amet';
    final age = 'Consectetur';
    final gender = 'Adipiscing';
    final bloodType = 'Elit';
    final hometown = 'Pellentesque';
    final occupations = 'Vestibulum, Lacinia';
    final descriptionHtml =
        '<b>Lorem Ipsum</b> dolor sit amet, consectetur adipiscing elit. Proin elementum justo ac leo consequat, eget commodo ex vestibulum. Etiam id tempor arcu, sit amet cursus nulla. Praesent accumsan tincidunt libero eu interdum.<br><br>Duis ultrices egestas turpis, a sodales mi facilisis vel. Vivamus ac risus sed tellus pellentesque aliquam. Curabitur sed luctus diam. Cras nec efficitur turpis. In a elit ac augue tincidunt luctus vitae a justo.';

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
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textPrimary,
                      ),
                    ),
                    if (nativeName.isNotEmpty && nativeName != name) ...[
                      const SizedBox(height: 4),
                      Text(
                        nativeName,
                        style: const TextStyle(fontSize: 14, color: textMuted),
                      ),
                    ],
                    if (alternativeNames.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      const Text(
                        'Also Known As',
                        style: TextStyle(
                          fontSize: 12,
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
                              style: const TextStyle(
                                color: textSecondary,
                                fontSize: 11,
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
          const SizedBox(height: 28),
          const Text(
            'Information',
            style: TextStyle(
              fontSize: 18,
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
              children: [
                _buildStatRow('Birthday', birthday),
                const Divider(color: cardBorderColor, height: 16),
                _buildStatRow('Years Active', yearsActive),
                const Divider(color: cardBorderColor, height: 16),
                _buildStatRow('Age', age),
                const Divider(color: cardBorderColor, height: 16),
                _buildStatRow('Gender', gender),
                const Divider(color: cardBorderColor, height: 16),
                _buildStatRow('Blood Type', bloodType),
                const Divider(color: cardBorderColor, height: 16),
                _buildStatRow('Hometown', hometown),
                const Divider(color: cardBorderColor, height: 16),
                _buildStatRow('Occupations', occupations),
              ],
            ),
          ),
          const SizedBox(height: 28),
          const Text(
            'Biography',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          HtmlDescription(html: descriptionHtml),
        ],
      ),
    );
  }
}

class _StaffMediaTab extends StatelessWidget {
  const _StaffMediaTab();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Center(
        child: Text(
          'Media roles will be shown here.',
          style: TextStyle(color: textMuted, fontSize: 16),
        ),
      ),
    );
  }
}

class _StaffCharactersTab extends StatelessWidget {
  const _StaffCharactersTab();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Center(
        child: Text(
          'Voiced characters will be shown here.',
          style: TextStyle(color: textMuted, fontSize: 16),
        ),
      ),
    );
  }
}
