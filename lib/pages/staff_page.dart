import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../components/error_view.dart';
import '../components/floating_nav.dart';
import '../components/loading_indicator.dart';
import '../components/paged_scroll_listener.dart';
import '../models/media_staff.dart';
import '../services/media_service.dart';
import '../theme/theme.dart';
import '../utils/app_navigation.dart';
import 'staff_page/tabs/staff_characters_tab.dart';
import 'staff_page/tabs/staff_info_tab.dart';
import 'staff_page/tabs/staff_media_tab.dart';
import 'staff_page/widgets/staff_sticky_header.dart';

/// A page displaying details for a staff member.
class StaffPage extends StatefulWidget {
  /// The staff data.
  final StaffMin staff;

  /// Creates a staff page.
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
    _fetchStaffDetails();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onLoadMore() {
    if (_staff == null || _isLoading) return;

    if (_selectedTabIndex == 1) {
      _loadMoreStaffMedia();
    } else if (_selectedTabIndex == 2) {
      _loadMoreCharacterMedia();
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
        return StaffInfoTab(staff: _staff!);
      case 1:
        return StaffMediaTab(
          staff: _staff!,
          isLoadingMore: _isFetchingMoreStaffMedia,
        );
      case 2:
        return StaffCharactersTab(
          staff: _staff!,
          isLoadingMore: _isFetchingMoreCharacterMedia,
        );
      default:
        return StaffInfoTab(staff: _staff!);
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

    final hasMore = switch (_selectedTabIndex) {
      1 => _hasNextStaffMediaPage,
      2 => _hasNextCharacterMediaPage,
      _ => false,
    };
    final isFetchingMore = switch (_selectedTabIndex) {
      1 => _isFetchingMoreStaffMedia,
      2 => _isFetchingMoreCharacterMedia,
      _ => false,
    };

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          PagedScrollListener(
            hasMore: hasMore,
            isLoading: isFetchingMore,
            onLoadMore: _onLoadMore,
            child: CustomScrollView(
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
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: StaffStickyHeader(
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
