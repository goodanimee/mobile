import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../components/entity_card.dart';
import '../../../components/error_view.dart';
import '../../../components/loading_indicator.dart';
import '../../../components/lucide_icons_helper.dart';
import '../../../components/paged_scroll_listener.dart';
import '../../../components/relation_card.dart';
import '../../../components/section.dart';
import '../../../models/media_character.dart';
import '../../../models/media_min.dart';
import '../../../models/media_staff.dart';
import '../../../models/media_studio.dart';
import '../../../models/user_favourites.dart';
import '../../../services/user_service.dart';
import '../../../theme/theme.dart';
import '../../../utils/app_navigation.dart';
import '../../../utils/utils.dart';

/// Signature for fetching initial or single-category paginated favourites.
typedef FetchUserFavouritesCallback =
    Future<UserFavourites> Function({
      required int userId,
      FavouriteCategory? category,
      int page,
    });

/// Profile tab displaying a user's favourited anime, manga, characters, staff, and studios.
class ProfileFavouritesTab extends StatefulWidget {
  /// Target profile user ID.
  final int userId;

  /// Monotonic counter incremented when the parent profile refreshes.
  final int refreshTrigger;

  /// Optional cached favourites state from parent profile page.
  final UserFavourites? initialFavourites;

  /// Callback invoked whenever favourites load or paginate.
  final ValueChanged<UserFavourites>? onFavouritesChanged;

  /// Optional override for fetching favourites (used in tests).
  final FetchUserFavouritesCallback? fetchFavourites;

  /// Optional override for media card navigation.
  final ValueChanged<int>? onOpenMedia;

  /// Optional override for character card navigation.
  final ValueChanged<Character>? onOpenCharacter;

  /// Optional override for staff card navigation.
  final ValueChanged<Staff>? onOpenStaff;

  /// Optional override for studio card navigation.
  final ValueChanged<int>? onOpenStudio;

  /// Creates a profile favourites tab.
  const ProfileFavouritesTab({
    super.key,
    required this.userId,
    this.refreshTrigger = 0,
    this.initialFavourites,
    this.onFavouritesChanged,
    this.fetchFavourites,
    this.onOpenMedia,
    this.onOpenCharacter,
    this.onOpenStaff,
    this.onOpenStudio,
  });

  @override
  State<ProfileFavouritesTab> createState() => _ProfileFavouritesTabState();
}

class _ProfileFavouritesTabState extends State<ProfileFavouritesTab> {
  final Set<FavouriteCategory> _loadingCategories = {};

  UserFavourites _favourites = const UserFavourites();
  bool _isLoading = true;
  int _requestToken = 0;
  String? _error;

  FetchUserFavouritesCallback get _fetcher =>
      widget.fetchFavourites ?? UserService.getUserFavourites;

  @override
  void initState() {
    super.initState();
    if (widget.initialFavourites != null) {
      _favourites = widget.initialFavourites!;
      _isLoading = false;
    } else {
      _loadInitial();
    }
  }

  @override
  void didUpdateWidget(ProfileFavouritesTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.userId != widget.userId ||
        oldWidget.refreshTrigger != widget.refreshTrigger) {
      _loadInitial();
    }
  }

  Future<void> _loadInitial() async {
    final token = ++_requestToken;
    setState(() {
      _isLoading = true;
      _error = null;
      _loadingCategories.clear();
    });

    try {
      final loaded = await _fetcher(userId: widget.userId);
      if (!mounted || token != _requestToken) return;
      setState(() {
        _favourites = loaded;
        _isLoading = false;
      });
      widget.onFavouritesChanged?.call(loaded);
    } catch (_) {
      if (!mounted || token != _requestToken) return;
      setState(() {
        _error = 'Failed to load favourites.';
        _isLoading = false;
      });
    }
  }

  Future<void> _loadMoreCategory(FavouriteCategory category) async {
    if (_isLoading ||
        _loadingCategories.contains(category) ||
        !_favourites.hasNextPageFor(category)) {
      return;
    }

    final token = _requestToken;
    final nextPage = _favourites.currentPageFor(category) + 1;
    setState(() => _loadingCategories.add(category));

    try {
      final incoming = await _fetcher(
        userId: widget.userId,
        category: category,
        page: nextPage,
      );
      if (!mounted || token != _requestToken) return;
      final updated = _favourites.mergeCategoryPage(category, incoming);
      setState(() {
        _favourites = updated;
        _loadingCategories.remove(category);
      });
      widget.onFavouritesChanged?.call(updated);
    } catch (_) {
      if (!mounted || token != _requestToken) return;
      setState(() => _loadingCategories.remove(category));
    }
  }

  double _mediaRowHeight(BuildContext context) {
    final scaler = MediaQuery.textScalerOf(context);
    final titleHeight = scaler.scale(18) * 1.25 * 2;
    final nativeHeight = scaler.scale(15) * 1.25;
    final subHeight = scaler.scale(12) * 1.25;
    return (titleHeight + nativeHeight + subHeight + 28).clamp(110.0, 168.0);
  }

  double _cardWidth(double availableWidth, {required bool hasMultiCols}) {
    if (availableWidth <= 0) return 280.0;
    if (!hasMultiCols) {
      return math.min(availableWidth, 320.0);
    }
    return math.min(
      availableWidth,
      (availableWidth * 0.85).clamp(240.0, 320.0),
    );
  }

  double _entityRowHeight(BuildContext context) {
    final scaler = MediaQuery.textScalerOf(context);
    final titleHeight = scaler.scale(fontTitle(context)) * 1.25 * 2;
    final nativeHeight = scaler.scale(fontMedium(context)) * 1.25;
    final subHeight = scaler.scale(fontSmall(context)) * 1.25;
    return (titleHeight + nativeHeight + subHeight + 28).clamp(88.0, 156.0);
  }

  double _studioRowHeight(BuildContext context) {
    final scaler = MediaQuery.textScalerOf(context);
    final nameHeight = scaler.scale(fontBody(context)) * 1.25 * 2;
    return (nameHeight + 24).clamp(52.0, 96.0);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final horizontalPadding = screenWidth < 360 ? 14.0 : 20.0;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_isLoading) {
      return const AppLoadingIndicator(topPadding: 48);
    }

    if (_error != null) {
      return AppErrorView(
        message: _error!,
        topPadding: 36,
        onRetry: _loadInitial,
      );
    }

    final categories = _favourites.nonEmptyCategories;
    if (categories.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                LucideIcons.heart,
                size: getResponsiveSize(context, 40),
                color: textHint.withValues(alpha: 0.4),
              ),
              const SizedBox(height: 12),
              Text(
                'No favourites added yet.',
                style: TextStyle(color: textMuted, fontSize: fontBody(context)),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < categories.length; i++)
          _buildCategorySection(
            context,
            category: categories[i],
            isFirst: i == 0,
          ),
      ],
    );
  }

  Widget _buildCategorySection(
    BuildContext context, {
    required FavouriteCategory category,
    required bool isFirst,
  }) {
    final total = _favourites.totalFor(category);
    return Section(
      title: category.label,
      topSpacing: isFirst ? 4 : getResponsiveSize(context, 24),
      innerSpacing: getResponsiveSize(context, 10),
      trailing: total > 0 ? _buildCountBadge(context, total) : null,
      children: [
        switch (category) {
          FavouriteCategory.anime => _buildMediaCarousel(
            context,
            category: category,
            slice: _favourites.anime,
          ),
          FavouriteCategory.manga => _buildMediaCarousel(
            context,
            category: category,
            slice: _favourites.manga,
          ),
          FavouriteCategory.characters => _buildCharacterCarousel(
            context,
            slice: _favourites.characters,
          ),
          FavouriteCategory.staff => _buildStaffCarousel(
            context,
            slice: _favourites.staff,
          ),
          FavouriteCategory.studios => _buildStudioCarousel(
            context,
            slice: _favourites.studios,
          ),
        },
      ],
    );
  }

  Widget _buildCountBadge(BuildContext context, int count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: hoverBgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cardBorderColor),
      ),
      child: Text(
        StringUtils.formatCompactNumber(count),
        style: TextStyle(
          color: textSecondary,
          fontSize: fontMini(context),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildMediaCarousel(
    BuildContext context, {
    required FavouriteCategory category,
    required PagedFavourites<MediaMin> slice,
  }) {
    final isLoadingMore = _loadingCategories.contains(category);
    final items = slice.items;
    final crossAxisCount = items.length == 1 ? 1 : 2;
    final rowHeight = _mediaRowHeight(context);
    final spacing = getResponsiveSize(context, 12);
    final carouselHeight = crossAxisCount == 1
        ? rowHeight
        : rowHeight * 2 + spacing;

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = _cardWidth(
          constraints.maxWidth,
          hasMultiCols: items.length > crossAxisCount,
        );

        return SizedBox(
          height: carouselHeight,
          child: PagedScrollListener(
            threshold: 200,
            hasMore: slice.hasNextPage,
            isLoading: isLoadingMore,
            onLoadMore: () => _loadMoreCategory(category),
            child: GridView.builder(
              key: ValueKey('favourites_${category.apiKey}'),
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: rowHeight / cardWidth,
                crossAxisSpacing: spacing,
                mainAxisSpacing: spacing,
              ),
              itemCount: items.length + (isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == items.length) {
                  return const SizedBox(
                    width: 80,
                    child: Center(child: AppLoadingIndicator(topPadding: 0)),
                  );
                }

                final media = items[index];
                final coverUrl = media.coverImage.large.isNotEmpty
                    ? media.coverImage.large
                    : media.coverImage.medium;
                final displayTitle = media.title.userPreferred.isNotEmpty
                    ? media.title.userPreferred
                    : (media.title.english.isNotEmpty
                          ? media.title.english
                          : media.title.romaji);

                var subtitle = media.format.isNotEmpty
                    ? media.format.replaceAll('_', ' ')
                    : media.type;
                if (media.type == 'ANIME' && media.episodes > 0) {
                  subtitle +=
                      ' \u00B7 ${media.episodes} ${StringUtils.pluralize(media.episodes, "Episode", "Episodes")}';
                } else if (media.type == 'MANGA' && media.chapters > 0) {
                  subtitle +=
                      ' \u00B7 ${media.chapters} ${StringUtils.pluralize(media.chapters, "Chapter", "Chapters")}';
                }

                final color = ColorUtils.fromHex(
                  media.coverImage.color,
                  fallback: Colors.transparent,
                );

                return RelationCard(
                  imageUrl: coverUrl,
                  title: displayTitle,
                  nativeTitle: media.title.native,
                  subtitle: subtitle,
                  color: color != Colors.transparent ? color : null,
                  trailing: media.averageScore > 0
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              LucideIcons.star,
                              color: Colors.amber,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              (media.averageScore / 10).toStringAsFixed(1),
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      : null,
                  onTap: () {
                    if (media.id <= 0) return;
                    if (widget.onOpenMedia != null) {
                      widget.onOpenMedia!(media.id);
                    } else {
                      AppNavigation.toMedia(context, media.id);
                    }
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildCharacterCarousel(
    BuildContext context, {
    required PagedFavourites<Character> slice,
  }) {
    const category = FavouriteCategory.characters;
    final isLoadingMore = _loadingCategories.contains(category);
    final items = slice.items;
    final crossAxisCount = items.length == 1 ? 1 : 2;
    final rowHeight = _entityRowHeight(context);
    final spacing = getResponsiveSize(context, 12);
    final carouselHeight = crossAxisCount == 1
        ? rowHeight
        : rowHeight * 2 + spacing;

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = _cardWidth(
          constraints.maxWidth,
          hasMultiCols: items.length > crossAxisCount,
        );

        return SizedBox(
          height: carouselHeight,
          child: PagedScrollListener(
            threshold: 200,
            hasMore: slice.hasNextPage,
            isLoading: isLoadingMore,
            onLoadMore: () => _loadMoreCategory(category),
            child: GridView.builder(
              key: const ValueKey('favourites_CHARACTERS'),
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: rowHeight / cardWidth,
                crossAxisSpacing: spacing,
                mainAxisSpacing: spacing,
              ),
              itemCount: items.length + (isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == items.length) {
                  return const SizedBox(
                    width: 80,
                    child: Center(child: AppLoadingIndicator(topPadding: 0)),
                  );
                }

                final character = items[index];
                final preferred = character.name?.userPreferred ?? '';
                final full = character.name?.full ?? '';
                final displayName = preferred.isNotEmpty
                    ? preferred
                    : (full.isNotEmpty ? full : 'Unknown');
                final favCount = character.favourites ?? 0;
                final subtitle = favCount > 0
                    ? '${StringUtils.formatCompactNumber(favCount)} favourites'
                    : '';

                return EntityCard(
                  imageUrl:
                      character.image?.large ?? character.image?.medium ?? '',
                  name: displayName,
                  nativeName: character.name?.native,
                  subtitle: subtitle,
                  onTap: () {
                    if ((character.id ?? 0) <= 0) return;
                    if (widget.onOpenCharacter != null) {
                      widget.onOpenCharacter!(character);
                    } else {
                      AppNavigation.toCharacter(
                        context,
                        character: character.toMin(),
                      );
                    }
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildStaffCarousel(
    BuildContext context, {
    required PagedFavourites<Staff> slice,
  }) {
    const category = FavouriteCategory.staff;
    final isLoadingMore = _loadingCategories.contains(category);
    final items = slice.items;
    final crossAxisCount = items.length == 1 ? 1 : 2;
    final rowHeight = _entityRowHeight(context);
    final spacing = getResponsiveSize(context, 12);
    final carouselHeight = crossAxisCount == 1
        ? rowHeight
        : rowHeight * 2 + spacing;

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = _cardWidth(
          constraints.maxWidth,
          hasMultiCols: items.length > crossAxisCount,
        );

        return SizedBox(
          height: carouselHeight,
          child: PagedScrollListener(
            threshold: 200,
            hasMore: slice.hasNextPage,
            isLoading: isLoadingMore,
            onLoadMore: () => _loadMoreCategory(category),
            child: GridView.builder(
              key: const ValueKey('favourites_STAFF'),
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: rowHeight / cardWidth,
                crossAxisSpacing: spacing,
                mainAxisSpacing: spacing,
              ),
              itemCount: items.length + (isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == items.length) {
                  return const SizedBox(
                    width: 80,
                    child: Center(child: AppLoadingIndicator(topPadding: 0)),
                  );
                }

                final staff = items[index];
                final preferred = staff.name?.userPreferred ?? '';
                final full = staff.name?.full ?? '';
                final displayName = preferred.isNotEmpty
                    ? preferred
                    : (full.isNotEmpty ? full : 'Unknown');
                final favCount = staff.favourites ?? 0;
                final subtitle = staff.primaryOccupations.isNotEmpty
                    ? staff.primaryOccupations.join(', ')
                    : (favCount > 0
                          ? '${StringUtils.formatCompactNumber(favCount)} favourites'
                          : '');

                return EntityCard(
                  imageUrl: staff.image?.large ?? staff.image?.medium ?? '',
                  name: displayName,
                  nativeName: staff.name?.native,
                  subtitle: subtitle,
                  onTap: () {
                    if (staff.id <= 0) return;
                    if (widget.onOpenStaff != null) {
                      widget.onOpenStaff!(staff);
                    } else {
                      AppNavigation.toStaff(context, staff.toMin());
                    }
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildStudioCarousel(
    BuildContext context, {
    required PagedFavourites<Studio> slice,
  }) {
    const category = FavouriteCategory.studios;
    final isLoadingMore = _loadingCategories.contains(category);
    final items = slice.items;
    final crossAxisCount = items.length == 1 ? 1 : 2;
    final rowHeight = _studioRowHeight(context);
    final spacing = getResponsiveSize(context, 12);
    final iconSize = getResponsiveSize(context, 16);
    final carouselHeight = crossAxisCount == 1
        ? rowHeight
        : rowHeight * 2 + spacing;

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = _cardWidth(
          constraints.maxWidth,
          hasMultiCols: items.length > crossAxisCount,
        );

        return SizedBox(
          height: carouselHeight,
          child: PagedScrollListener(
            threshold: 200,
            hasMore: slice.hasNextPage,
            isLoading: isLoadingMore,
            onLoadMore: () => _loadMoreCategory(category),
            child: GridView.builder(
              key: const ValueKey('favourites_STUDIOS'),
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: rowHeight / cardWidth,
                crossAxisSpacing: spacing,
                mainAxisSpacing: spacing,
              ),
              itemCount: items.length + (isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == items.length) {
                  return const SizedBox(
                    width: 64,
                    child: Center(child: AppLoadingIndicator(topPadding: 0)),
                  );
                }

                final studio = items[index];
                final favCount = studio.favourites ?? 0;

                return InkWell(
                  onTap: () {
                    if (studio.id <= 0) return;
                    if (widget.onOpenStudio != null) {
                      widget.onOpenStudio!(studio.id);
                    } else {
                      AppNavigation.toStudio(context, studio.id);
                    }
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.03),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            studio.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: textPrimary,
                              fontSize: fontBody(context),
                              fontWeight: FontWeight.w600,
                              height: 1.2,
                            ),
                          ),
                        ),
                        if (favCount > 0) ...[
                          const SizedBox(width: 8),
                          Text(
                            StringUtils.formatCompactNumber(favCount),
                            style: TextStyle(
                              color: textSecondary,
                              fontSize: fontSmall(context),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: loveGradient,
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ).createShader(bounds),
                            child: LucideHeartIcon(
                              isFilled: false,
                              color: Colors.white,
                              size: iconSize,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
