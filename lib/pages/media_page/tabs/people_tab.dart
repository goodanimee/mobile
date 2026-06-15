import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../components/app_entity_card.dart';
import '../../../components/app_section.dart';
import '../../../components/loading_indicator.dart';
import '../../../models/media_character.dart';
import '../../../models/media_staff.dart';
import '../../../services/media_service.dart';
import '../../../theme/theme.dart';
import '../../../utils/app_navigation.dart';

/// Tab combining characters and production staff carousels
class MediaPeopleTab extends StatefulWidget {
  /// The ID of the media
  final int mediaId;

  /// Whether this tab is nested
  final bool isNested;

  /// Initial characters data
  final CharacterConnection? initialCharacters;

  /// Initial staff data
  final StaffConnection? initialStaff;

  /// Creates a people tab
  const MediaPeopleTab({
    super.key,
    required this.mediaId,
    this.isNested = false,
    this.initialCharacters,
    this.initialStaff,
  });

  @override
  State<MediaPeopleTab> createState() => _MediaPeopleTabState();
}

class _MediaPeopleTabState extends State<MediaPeopleTab> {
  final List<CharacterEdge> _characters = [];
  int _characterPage = 1;
  bool _hasNextCharacterPage = false;
  bool _isFetchingMoreCharacters = false;
  final ScrollController _charactersScrollController = ScrollController();

  final List<StaffEdge> _staff = [];
  int _staffPage = 1;
  bool _hasNextStaffPage = false;
  bool _isFetchingMoreStaff = false;
  final ScrollController _staffScrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    if (widget.initialCharacters != null) {
      _characters.addAll(widget.initialCharacters!.edges);
      _hasNextCharacterPage = widget.initialCharacters!.pageInfo.hasNextPage;
    } else {
      _fetchCharacters();
    }

    if (widget.initialStaff != null) {
      _staff.addAll(widget.initialStaff!.edges);
      _hasNextStaffPage = widget.initialStaff!.pageInfo.hasNextPage;
    } else {
      _fetchStaff();
    }

    _charactersScrollController.addListener(_charactersScrollListener);
    _staffScrollController.addListener(_staffScrollListener);
  }

  @override
  void dispose() {
    _charactersScrollController.dispose();
    _staffScrollController.dispose();
    super.dispose();
  }

  void _charactersScrollListener() {
    if (!_hasNextCharacterPage || _isFetchingMoreCharacters) return;
    final threshold =
        _charactersScrollController.position.maxScrollExtent - 400;
    if (_charactersScrollController.offset >= threshold) {
      _loadMoreCharacters();
    }
  }

  void _staffScrollListener() {
    if (!_hasNextStaffPage || _isFetchingMoreStaff) return;
    final threshold = _staffScrollController.position.maxScrollExtent - 400;
    if (_staffScrollController.offset >= threshold) {
      _loadMoreStaff();
    }
  }

  Future<void> _fetchCharacters() async {
    setState(() => _isFetchingMoreCharacters = true);
    try {
      final connection = await MediaService.getCharacters(widget.mediaId, 1);
      if (mounted) {
        setState(() {
          _characters.addAll(connection.edges);
          _characterPage = 1;
          _hasNextCharacterPage = connection.pageInfo.hasNextPage;
          _isFetchingMoreCharacters = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isFetchingMoreCharacters = false);
    }
  }

  Future<void> _loadMoreCharacters() async {
    if (_isFetchingMoreCharacters || !_hasNextCharacterPage) return;
    setState(() => _isFetchingMoreCharacters = true);
    try {
      final connection = await MediaService.getCharacters(
        widget.mediaId,
        _characterPage + 1,
      );
      if (mounted) {
        setState(() {
          _characters.addAll(connection.edges);
          _characterPage++;
          _hasNextCharacterPage = connection.pageInfo.hasNextPage;
          _isFetchingMoreCharacters = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isFetchingMoreCharacters = false);
    }
  }

  Future<void> _fetchStaff() async {
    setState(() => _isFetchingMoreStaff = true);
    try {
      final connection = await MediaService.getStaff(widget.mediaId, 1);
      if (mounted) {
        setState(() {
          _staff.addAll(connection.edges);
          _staffPage = 1;
          _hasNextStaffPage = connection.pageInfo.hasNextPage;
          _isFetchingMoreStaff = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isFetchingMoreStaff = false);
    }
  }

  Future<void> _loadMoreStaff() async {
    if (_isFetchingMoreStaff || !_hasNextStaffPage) return;
    setState(() => _isFetchingMoreStaff = true);
    try {
      final connection = await MediaService.getStaff(
        widget.mediaId,
        _staffPage + 1,
      );
      if (mounted) {
        setState(() {
          _staff.addAll(connection.edges);
          _staffPage++;
          _hasNextStaffPage = connection.pageInfo.hasNextPage;
          _isFetchingMoreStaff = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isFetchingMoreStaff = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasCharacters = _characters.isNotEmpty;
    final hasStaff = _staff.isNotEmpty;

    if (!hasCharacters &&
        !hasStaff &&
        !_isFetchingMoreCharacters &&
        !_isFetchingMoreStaff) {
      final emptyContent = Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 64),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                LucideIcons.users,
                size: 48,
                color: textHint.withValues(alpha: 0.33),
              ),
              const SizedBox(height: 16),
              const Text(
                'No characters or staff found',
                style: TextStyle(color: textMuted, fontSize: 15),
              ),
            ],
          ),
        ),
      );

      if (widget.isNested) return emptyContent;
      return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: emptyContent,
      );
    }

    const cardWidth = 256.0;
    const carouselHeight = 184.0;
    const spacing = 12.0;
    final rowHeight = (carouselHeight - spacing) / 2;
    final childAspectRatio = rowHeight / cardWidth;

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasCharacters) ...[
          AppSection(
            title: 'Characters & Cast',
            topSpacing: 0,
            children: [
              SizedBox(
                height: carouselHeight,
                child: GridView.builder(
                  controller: _charactersScrollController,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: childAspectRatio,
                    crossAxisSpacing: spacing,
                    mainAxisSpacing: spacing,
                  ),
                  itemCount:
                      _characters.length + (_isFetchingMoreCharacters ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _characters.length) {
                      return const SizedBox(
                        width: 80,
                        child: Center(
                          child: AppLoadingIndicator(topPadding: 0),
                        ),
                      );
                    }

                    final edge = _characters[index];
                    final node = edge.node;
                    final fullName = node?.name?.full ?? edge.name;
                    final nativeName = node?.name?.native ?? '';
                    final role = edge.role;
                    final charImageUrl = node?.image?.large ?? '';

                    return AppEntityCard(
                      imageUrl: charImageUrl,
                      name: fullName,
                      nativeName: nativeName,
                      subtitle: role,
                      trailing: Icon(
                        LucideIcons.badgeInfo,
                        size: getResponsiveSize(context, 14.0),
                        color: Colors.white.withValues(alpha: 0.25),
                      ),
                      onTap: () => AppNavigation.toCharacter(context, edge),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
        if (hasStaff) ...[
          AppSection(
            title: 'Production Staff',
            topSpacing: hasCharacters ? 8 : 0,
            children: [
              SizedBox(
                height: carouselHeight,
                child: GridView.builder(
                  controller: _staffScrollController,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: childAspectRatio,
                    crossAxisSpacing: spacing,
                    mainAxisSpacing: spacing,
                  ),
                  itemCount: _staff.length + (_isFetchingMoreStaff ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _staff.length) {
                      return const SizedBox(
                        width: 80,
                        child: Center(
                          child: AppLoadingIndicator(topPadding: 0),
                        ),
                      );
                    }

                    final edge = _staff[index];
                    final node = edge.node;
                    final fullName = node?.name?.full ?? '';
                    final nativeName = node?.name?.native ?? '';
                    final role = edge.role.isNotEmpty
                        ? edge.role
                        : 'Unknown Role';
                    final imageUrl = node?.image?.large ?? '';

                    return AppEntityCard(
                      imageUrl: imageUrl,
                      name: fullName,
                      nativeName: nativeName,
                      subtitle: role,
                      onTap: node != null
                          ? () => AppNavigation.toStaff(context, node)
                          : null,
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ],
    );

    if (widget.isNested) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: content,
      );
    }

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: content,
    );
  }
}
