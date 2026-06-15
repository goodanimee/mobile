import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../components/app_network_image.dart';
import '../components/app_relation_card.dart';
import '../components/error_view.dart';
import '../components/floating_nav.dart';
import '../components/html_description.dart';
import '../components/loading_indicator.dart';
import '../components/lucide_icons_helper.dart';
import '../models/common.dart';
import '../models/media_min.dart';
import '../models/media_staff.dart';
import '../services/media_service.dart';
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
  bool _isFavouriteLoading = false;
  bool _isLoading = true;
  Staff? _staff;
  String? _error;

  int _staffMediaPage = 1;
  int _characterMediaPage = 1;
  bool _hasNextStaffMediaPage = false;
  bool _hasNextCharacterMediaPage = false;
  bool _isFetchingMoreStaffMedia = false;
  bool _isFetchingMoreCharacterMedia = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _fetchStaffDetails();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_staff == null || _isLoading) return;

    final threshold = _scrollController.position.maxScrollExtent - 400;
    if (_scrollController.offset >= threshold) {
      if (_selectedTabIndex == 1) {
        _loadMoreStaffMedia();
      } else if (_selectedTabIndex == 2) {
        _loadMoreCharacterMedia();
      }
    }
  }

  Future<void> _fetchStaffDetails() async {
    try {
      final data = await MediaService.getStaffDetails(widget.staff.id, 1, 1);
      if (mounted) {
        setState(() {
          _staff = data;
          _hasNextStaffMediaPage =
              data.staffMedia?.pageInfo.hasNextPage ?? false;
          _hasNextCharacterMediaPage =
              data.characterMedia?.pageInfo.hasNextPage ?? false;
          _staffMediaPage = 1;
          _characterMediaPage = 1;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Failed to load staff details: $e';
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _loadMoreStaffMedia() async {
    if (_isFetchingMoreStaffMedia ||
        !_hasNextStaffMediaPage ||
        _staff == null) {
      return;
    }

    setState(() {
      _isFetchingMoreStaffMedia = true;
    });

    try {
      final data = await MediaService.getStaffDetails(
        widget.staff.id,
        1,
        _staffMediaPage + 1,
      );

      if (mounted) {
        setState(() {
          final currentStaffMedia = _staff!.staffMedia;
          if (currentStaffMedia != null && data.staffMedia != null) {
            final newEdges = [
              ...currentStaffMedia.edges,
              ...data.staffMedia!.edges,
            ];
            _staff = _staff!.copyWith(
              staffMedia: StaffMediaConnection(
                edges: newEdges,
                pageInfo: data.staffMedia!.pageInfo,
              ),
            );
          }
          _staffMediaPage++;
          _hasNextStaffMediaPage =
              data.staffMedia?.pageInfo.hasNextPage ?? false;
          _isFetchingMoreStaffMedia = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isFetchingMoreStaffMedia = false;
        });
      }
    }
  }

  Future<void> _loadMoreCharacterMedia() async {
    if (_isFetchingMoreCharacterMedia ||
        !_hasNextCharacterMediaPage ||
        _staff == null) {
      return;
    }

    setState(() {
      _isFetchingMoreCharacterMedia = true;
    });

    try {
      final data = await MediaService.getStaffDetails(
        widget.staff.id,
        _characterMediaPage + 1,
        1,
      );

      if (mounted) {
        setState(() {
          final currentCharacterMedia = _staff!.characterMedia;
          if (currentCharacterMedia != null && data.characterMedia != null) {
            final newEdges = [
              ...currentCharacterMedia.edges,
              ...data.characterMedia!.edges,
            ];
            _staff = _staff!.copyWith(
              characterMedia: StaffCharacterMediaConnection(
                edges: newEdges,
                pageInfo: data.characterMedia!.pageInfo,
              ),
            );
          }
          _characterMediaPage++;
          _hasNextCharacterMediaPage =
              data.characterMedia?.pageInfo.hasNextPage ?? false;
          _isFetchingMoreCharacterMedia = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isFetchingMoreCharacterMedia = false;
        });
      }
    }
  }

  Future<void> _toggleFavourite() async {
    if (_staff == null || _isFavouriteLoading) return;

    setState(() {
      _isFavouriteLoading = true;
    });

    try {
      await MediaService.toggleFavouriteStaff(_staff!.id);
      if (mounted) {
        setState(() {
          final wasFav = _staff!.isFavourite ?? false;
          final currentCount = _staff!.favourites ?? 0;
          _staff = _staff!.copyWith(
            isFavourite: !wasFav,
            favourites: !wasFav
                ? currentCount + 1
                : (currentCount > 0 ? currentCount - 1 : 0),
          );
          _isFavouriteLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isFavouriteLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update favourite: $e')),
        );
      }
    }
  }

  void _handleNavTap(int index) {
    AppNavigation.currentTab.value = index;
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  Widget _buildActiveTab() {
    if (_isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 80),
        child: AppLoadingIndicator(topPadding: 0),
      );
    }

    if (_error != null || _staff == null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: AppErrorView(
          message: _error ?? 'Staff details not found',
          onRetry: () {
            setState(() {
              _isLoading = true;
              _error = null;
            });
            _fetchStaffDetails();
          },
        ),
      );
    }

    switch (_selectedTabIndex) {
      case 0:
        return _StaffInfoTab(staff: _staff!);
      case 1:
        return _StaffMediaTab(
          staff: _staff!,
          isLoadingMore: _isFetchingMoreStaffMedia,
        );
      case 2:
        return _StaffCharactersTab(
          staff: _staff!,
          isLoadingMore: _isFetchingMoreCharacterMedia,
        );
      default:
        return _StaffInfoTab(staff: _staff!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final staffName =
        _staff?.name?.userPreferred ??
        _staff?.name?.full ??
        widget.staff.name?.userPreferred ??
        widget.staff.name?.full ??
        'Staff Member';

    final isFav = _staff?.isFavourite ?? false;
    final favouritesCount = _staff?.favourites ?? 0;

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
              isFavourite: isFav,
              favouritesCount: favouritesCount,
              onToggleFavourite: _toggleFavourite,
              isFavouriteLoading: _isFavouriteLoading,
              showFavourite: !_isLoading && _staff != null,
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
  final bool isFavouriteLoading;
  final bool showFavourite;

  const _StaffStickyHeader({
    required this.staffName,
    required this.onBack,
    required this.isFavourite,
    required this.favouritesCount,
    required this.onToggleFavourite,
    required this.isFavouriteLoading,
    required this.showFavourite,
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
                style: TextStyle(
                  fontSize: fontTitle(context),
                  fontWeight: FontWeight.bold,
                  color: textPrimary,
                ),
              ),
            ),
          ),
          if (showFavourite)
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
                      style: TextStyle(
                        color: textSecondary,
                        fontSize: fontBody(context),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: isFavouriteLoading ? null : onToggleFavourite,
                      child: isFavouriteLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: textPrimary,
                              ),
                            )
                          : LucideHeartIcon(
                              isFilled: isFavourite,
                              color: isFavourite
                                  ? Colors.redAccent.shade400
                                  : textPrimary,
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
  final Staff staff;

  const _StaffInfoTab({required this.staff});

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

class _StaffMediaTab extends StatelessWidget {
  final Staff staff;
  final bool isLoadingMore;

  const _StaffMediaTab({required this.staff, required this.isLoadingMore});

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
            child: AppRelationCard(
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

class _StaffCharactersTab extends StatelessWidget {
  final Staff staff;
  final bool isLoadingMore;

  const _StaffCharactersTab({required this.staff, required this.isLoadingMore});

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
            child: AppRelationCard(
              imageUrl: char.image?.large ?? char.image?.medium ?? '',
              title: charName,
              format: role,
              subtitle: mediaTitle,
              rightImageUrl: media.coverImage.large,
              rightAlignSubtitle: true,
              color: color != Colors.transparent ? color : null,
              onTap: () {
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
