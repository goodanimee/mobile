import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../models/media_character.dart';
import '../models/media_min.dart';
import '../models/media_staff.dart';
import '../models/media_studio.dart';
import '../models/user_profile.dart';
import '../services/character_service.dart';
import '../services/media_service.dart';
import '../services/user_service.dart';
import '../theme/theme.dart';
import '../utils/anilist_url_parser.dart';
import '../utils/app_navigation.dart';
import '../utils/utils.dart';
import 'lucide_icons_helper.dart';
import 'relation_card.dart';
import 'skeleton.dart';

/// Resolved entity data for an [HtmlAnilistLinkCard].
sealed class AnilistLinkPreview {
  /// Creates an AniList link preview.
  const AnilistLinkPreview();
}

/// Preview data for an anime or manga entry.
class AnilistMediaPreview extends AnilistLinkPreview {
  /// Resolved media summary.
  final MediaMin media;

  /// Creates a media preview.
  const AnilistMediaPreview(this.media);
}

/// Preview data for a character entry.
class AnilistCharacterPreview extends AnilistLinkPreview {
  /// Resolved character details.
  final Character character;

  /// Creates a character preview.
  const AnilistCharacterPreview(this.character);
}

/// Preview data for a staff entry.
class AnilistStaffPreview extends AnilistLinkPreview {
  /// Resolved staff details.
  final Staff staff;

  /// Creates a staff preview.
  const AnilistStaffPreview(this.staff);
}

/// Preview data for a studio entry.
class AnilistStudioPreview extends AnilistLinkPreview {
  /// Resolved studio details.
  final Studio studio;

  /// Creates a studio preview.
  const AnilistStudioPreview(this.studio);
}

/// Preview data for a user profile entry.
class AnilistUserPreview extends AnilistLinkPreview {
  /// Resolved user profile details.
  final UserProfile profile;

  /// Creates a user profile preview.
  const AnilistUserPreview(this.profile);
}

/// Async resolver signature for fetching an [AnilistLinkPreview].
typedef AnilistPreviewResolver =
    Future<AnilistLinkPreview?> Function(AnilistRouteTarget target);

/// Renders an AniList entity URL as a rich preview card matching search and relation cards.
class HtmlAnilistLinkCard extends StatefulWidget {
  /// Parsed AniList route target.
  final AnilistRouteTarget target;

  /// Original link URL string.
  final String rawUrl;

  /// Optional custom link label used if remote resolution fails.
  final String? fallbackLabel;

  /// Optional resolver override for widget tests.
  @visibleForTesting
  static AnilistPreviewResolver? debugResolverOverride;

  static final Map<AnilistRouteTarget, AnilistLinkPreview> _cache = {};
  static final Map<AnilistRouteTarget, Future<AnilistLinkPreview?>> _inFlight =
      {};

  /// Clears the in-memory preview cache.
  @visibleForTesting
  static void clearCache() {
    _cache.clear();
    _inFlight.clear();
  }

  static Future<AnilistLinkPreview?> _resolveCached(
    AnilistRouteTarget target,
  ) async {
    final cached = _cache[target];
    if (cached != null) return cached;

    final existing = _inFlight[target];
    if (existing != null) return existing;

    final future = _fetchRemote(target);
    _inFlight[target] = future;
    try {
      final resolved = await future;
      if (resolved != null) {
        _cache[target] = resolved;
      }
      return resolved;
    } finally {
      unawaited(_inFlight.remove(target));
    }
  }

  static Future<AnilistLinkPreview?> _fetchRemote(
    AnilistRouteTarget target,
  ) async {
    try {
      switch (target.type) {
        case AnilistEntityType.anime:
        case AnilistEntityType.manga:
          final id = target.id;
          if (id == null) return null;
          final media = await MediaService.getMediaDetails(id);
          return media != null ? AnilistMediaPreview(media) : null;
        case AnilistEntityType.character:
          final id = target.id;
          if (id == null) return null;
          final character = await CharacterService.getCharacterDetails(id, 1);
          return AnilistCharacterPreview(character);
        case AnilistEntityType.staff:
          final id = target.id;
          if (id == null) return null;
          final staff = await MediaService.getStaffDetails(id, 1, 1);
          return AnilistStaffPreview(staff);
        case AnilistEntityType.studio:
          final id = target.id;
          if (id == null) return null;
          final studio = await MediaService.getStudio(id, 1);
          return AnilistStudioPreview(studio);
        case AnilistEntityType.user:
          final profile = await UserService.getUserProfile(
            userId: target.id,
            username: target.username,
          );
          return profile != null ? AnilistUserPreview(profile) : null;
      }
    } catch (_) {
      return null;
    }
  }

  /// Creates an AniList entity preview card.
  const HtmlAnilistLinkCard({
    super.key,
    required this.target,
    required this.rawUrl,
    this.fallbackLabel,
  });

  @override
  State<HtmlAnilistLinkCard> createState() => _HtmlAnilistLinkCardState();
}

class _HtmlAnilistLinkCardState extends State<HtmlAnilistLinkCard> {
  AnilistLinkPreview? _preview;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initLoad();
  }

  @override
  void didUpdateWidget(HtmlAnilistLinkCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.target != widget.target) {
      _initLoad();
    }
  }

  void _initLoad() {
    final override = HtmlAnilistLinkCard.debugResolverOverride;
    if (override == null) {
      final cached = HtmlAnilistLinkCard._cache[widget.target];
      if (cached != null) {
        _preview = cached;
        _isLoading = false;
        return;
      }
    }
    _preview = null;
    _isLoading = true;
    _load();
  }

  Future<void> _load() async {
    final requestedTarget = widget.target;
    final resolver =
        HtmlAnilistLinkCard.debugResolverOverride ??
        HtmlAnilistLinkCard._resolveCached;
    AnilistLinkPreview? result;
    try {
      result = await resolver(requestedTarget);
    } catch (_) {
      result = null;
    }
    if (!mounted || widget.target != requestedTarget) return;
    setState(() {
      _preview = result;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return _buildSkeleton();
    }

    final preview = _preview;
    if (preview == null) {
      return _buildFallbackCard(context);
    }

    return switch (preview) {
      AnilistMediaPreview(:final media) => _buildMediaCard(context, media),
      AnilistCharacterPreview(:final character) => _buildCharacterCard(
        context,
        character,
      ),
      AnilistStaffPreview(:final staff) => _buildStaffCard(context, staff),
      AnilistStudioPreview(:final studio) => _buildStudioCard(context, studio),
      AnilistUserPreview(:final profile) => _buildUserCard(context, profile),
    };
  }

  Widget _buildSkeleton() {
    if (widget.target.type == AnilistEntityType.studio) {
      return SkeletonShimmer(
        child: Container(
          height: 58,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: surfaceBackground,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cardBorderColor),
          ),
          child: const Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SkeletonBox(width: 140, height: 16),
                    SizedBox(height: 6),
                    SkeletonBox(width: 60, height: 11),
                  ],
                ),
              ),
              SizedBox(width: 16),
              SkeletonBox(width: 48, height: 20, borderRadius: 10),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      height: 110,
      child: SkeletonShimmer(
        child: Container(
          decoration: BoxDecoration(
            color: surfaceBackground,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cardBorderColor),
          ),
          child: const Row(
            children: [
              SkeletonBox(width: 85, height: double.infinity, borderRadius: 11),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SkeletonBox(width: double.infinity, height: 16),
                    SizedBox(height: 8),
                    SkeletonBox(width: 120, height: 12),
                    SizedBox(height: 12),
                    SkeletonBox(width: 80, height: 12),
                  ],
                ),
              ),
              SizedBox(width: 14),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMediaCard(BuildContext context, MediaMin media) {
    final titleText = media.title.userPreferred.isNotEmpty
        ? media.title.userPreferred
        : media.title.romaji.isNotEmpty
        ? media.title.romaji
        : media.title.english.isNotEmpty
        ? media.title.english
        : 'Unknown';

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

    return SizedBox(
      height: 110,
      child: RelationCard(
        imageUrl: media.coverImage.large,
        title: titleText,
        nativeTitle: media.title.native,
        subtitle: subtitle,
        color: color != Colors.transparent ? color : null,
        trailing: media.averageScore > 0
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(LucideIcons.star, color: Colors.amber, size: 14),
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
        onTap: () => AppNavigation.toMedia(context, media.id),
      ),
    );
  }

  Widget _buildCharacterCard(BuildContext context, Character character) {
    final name = character.name;
    final String titleText;
    if (name != null) {
      final preferred = name.userPreferred;
      if (preferred != null && preferred.isNotEmpty) {
        titleText = preferred;
      } else if (name.full.isNotEmpty) {
        titleText = name.full;
      } else {
        titleText = 'Unknown';
      }
    } else {
      titleText = 'Unknown';
    }

    return SizedBox(
      height: 110,
      child: RelationCard(
        imageUrl: character.image?.large ?? '',
        title: titleText,
        nativeTitle: character.name?.native,
        subtitle: 'CHARACTER',
        trailing: (character.favourites != null && character.favourites! > 0)
            ? _buildHeartCount(character.favourites!)
            : null,
        onTap: () => AppNavigation.toCharacter(
          context,
          character: character.toMin(),
          characterId: character.id,
        ),
      ),
    );
  }

  Widget _buildStaffCard(BuildContext context, Staff staff) {
    final name = staff.name;
    final String titleText;
    if (name != null) {
      final preferred = name.userPreferred;
      if (preferred != null && preferred.isNotEmpty) {
        titleText = preferred;
      } else if (name.full.isNotEmpty) {
        titleText = name.full;
      } else {
        titleText = 'Unknown';
      }
    } else {
      titleText = 'Unknown';
    }

    final primaryOccupations = staff.primaryOccupations.isNotEmpty
        ? staff.primaryOccupations.join(', ')
        : null;

    return SizedBox(
      height: 110,
      child: RelationCard(
        imageUrl: staff.image?.large ?? '',
        title: titleText,
        nativeTitle: staff.name?.native,
        format: primaryOccupations,
        subtitle: 'STAFF',
        trailing: (staff.favourites != null && staff.favourites! > 0)
            ? _buildHeartCount(staff.favourites!)
            : null,
        onTap: () => AppNavigation.toStaff(context, staff.toMin()),
      ),
    );
  }

  Widget _buildStudioCard(BuildContext context, Studio studio) {
    final formattedFavourites = StringUtils.formatCompactNumber(
      studio.favourites ?? 0,
    );

    return InkWell(
      onTap: () => AppNavigation.toStudio(context, studio.id),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    studio.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'STUDIO',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  formattedFavourites,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 6),
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Center(
                    child: ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: loveGradient,
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ).createShader(bounds),
                      child: const LucideHeartIcon(
                        isFilled: false,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserCard(BuildContext context, UserProfile profile) {
    final avatarUrl = profile.avatarLarge.isNotEmpty
        ? profile.avatarLarge
        : profile.avatarMedium;
    final countsText = (profile.animeCount > 0 || profile.mangaCount > 0)
        ? '${profile.animeCount} Anime \u00B7 ${profile.mangaCount} Manga'
        : null;

    return SizedBox(
      height: 110,
      child: RelationCard(
        imageUrl: avatarUrl,
        title: profile.name,
        format: countsText,
        subtitle: 'USER',
        trailing: profile.followersCount > 0
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(LucideIcons.users, color: borderColor, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    StringUtils.formatCompactNumber(profile.followersCount),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            : null,
        onTap: () => AppNavigation.toProfile(
          context,
          userId: profile.id,
          username: profile.name,
        ),
      ),
    );
  }

  Widget _buildHeartCount(int count) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(LucideIcons.heart, color: paletteRed, size: 14),
        const SizedBox(width: 4),
        Text(
          StringUtils.formatCompactNumber(count),
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildFallbackCard(BuildContext context) {
    final titleText = _deriveFallbackTitle();
    final typeLabel = _entityLabel(widget.target.type);
    final icon = _entityIcon(widget.target.type);

    return Material(
      color: Colors.white.withValues(alpha: 0.03),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () =>
            AppNavigation.openAnilistTarget(widget.target, context: context),
        borderRadius: BorderRadius.circular(12),
        splashColor: pressBgColor,
        highlightColor: pressBgColor,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white12),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: paletteBlue.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 18, color: borderColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      titleText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      typeLabel,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(LucideIcons.chevronRight, size: 16, color: textMuted),
            ],
          ),
        ),
      ),
    );
  }

  String _deriveFallbackTitle() {
    final customLabel = widget.fallbackLabel?.trim();
    if (customLabel != null && customLabel.isNotEmpty) {
      return customLabel;
    }

    if (widget.target.type == AnilistEntityType.user &&
        widget.target.username != null &&
        widget.target.username!.isNotEmpty) {
      return widget.target.username!;
    }

    final trimmed = widget.rawUrl.trim();
    final candidate =
        (trimmed.toLowerCase().startsWith('anilist.co/') ||
            trimmed.toLowerCase().startsWith('www.anilist.co/'))
        ? 'https://$trimmed'
        : trimmed;
    final uri = Uri.tryParse(candidate);
    if (uri != null) {
      final segments = uri.pathSegments.where((s) => s.isNotEmpty).toList();
      if (segments.length >= 3) {
        final slug = Uri.decodeComponent(
          segments[2],
        ).replaceAll('-', ' ').replaceAll('_', ' ').trim();
        if (slug.isNotEmpty) return slug;
      }
    }

    final id = widget.target.id;
    final label = _entityTitleCase(widget.target.type);
    return id != null ? '$label #$id' : label;
  }

  static String _entityLabel(AnilistEntityType type) {
    return switch (type) {
      AnilistEntityType.anime => 'ANIME',
      AnilistEntityType.manga => 'MANGA',
      AnilistEntityType.character => 'CHARACTER',
      AnilistEntityType.staff => 'STAFF',
      AnilistEntityType.studio => 'STUDIO',
      AnilistEntityType.user => 'USER',
    };
  }

  static String _entityTitleCase(AnilistEntityType type) {
    return switch (type) {
      AnilistEntityType.anime => 'Anime',
      AnilistEntityType.manga => 'Manga',
      AnilistEntityType.character => 'Character',
      AnilistEntityType.staff => 'Staff',
      AnilistEntityType.studio => 'Studio',
      AnilistEntityType.user => 'User',
    };
  }

  static IconData _entityIcon(AnilistEntityType type) {
    return switch (type) {
      AnilistEntityType.anime => LucideIcons.tv,
      AnilistEntityType.manga => LucideIcons.library,
      AnilistEntityType.character => LucideIcons.user,
      AnilistEntityType.staff => LucideIcons.clapperboard,
      AnilistEntityType.studio => LucideIcons.clapperboard,
      AnilistEntityType.user => LucideIcons.user,
    };
  }
}
