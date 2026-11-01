import '../proto/common.pb.dart' as pb_common;
import '../proto/media_min.pb.dart' as pb_media;
import '../proto/user.pb.dart' as pb;
import 'media_character.dart';
import 'media_min.dart';
import 'media_staff.dart';
import 'media_studio.dart';

/// Canonical categories displayed on a user's favourites tab.
enum FavouriteCategory {
  /// Favourite anime series and films.
  anime(apiKey: 'ANIME', label: 'Anime'),

  /// Favourite manga, light novels, and one-shots.
  manga(apiKey: 'MANGA', label: 'Manga'),

  /// Favourite characters.
  characters(apiKey: 'CHARACTERS', label: 'Characters'),

  /// Favourite production staff and voice actors.
  staff(apiKey: 'STAFF', label: 'Staff'),

  /// Favourite animation studios.
  studios(apiKey: 'STUDIOS', label: 'Studios');

  /// Uppercase key passed to `GetUserFavouritesRequest.category`.
  final String apiKey;

  /// Section header label.
  final String label;

  const FavouriteCategory({required this.apiKey, required this.label});
}

/// Paginated slice of a single favourites category.
class PagedFavourites<T> {
  /// Loaded items in display order.
  final List<T> items;

  /// Whether another page exists on the server.
  final bool hasNextPage;

  /// Most recently loaded page index (1-based).
  final int currentPage;

  /// Server-reported total item count.
  final int total;

  /// Creates an immutable paginated favourites slice.
  const PagedFavourites({
    this.items = const [],
    this.hasNextPage = false,
    this.currentPage = 1,
    this.total = 0,
  });

  /// Whether [items] contains zero entries.
  bool get isEmpty => items.isEmpty;

  /// Whether [items] contains at least one entry.
  bool get isNotEmpty => items.isNotEmpty;

  /// Total count clamped to at least `items.length`.
  int get displayTotal => total > items.length ? total : items.length;

  /// Appends [next] onto [items], deduplicating positive IDs via [idOf].
  PagedFavourites<T> appendPage(
    PagedFavourites<T> next, {
    required int Function(T item) idOf,
  }) {
    final seenIds = <int>{};
    final merged = <T>[];

    for (final item in items) {
      final id = idOf(item);
      if (id <= 0 || seenIds.add(id)) {
        merged.add(item);
      }
    }

    for (final item in next.items) {
      final id = idOf(item);
      if (id <= 0 || seenIds.add(id)) {
        merged.add(item);
      }
    }

    final baseTotal = next.total > total ? next.total : total;
    final clampedTotal = baseTotal > merged.length ? baseTotal : merged.length;

    return PagedFavourites<T>(
      items: List<T>.unmodifiable(merged),
      hasNextPage: next.hasNextPage,
      currentPage: next.currentPage,
      total: clampedTotal,
    );
  }
}

/// Aggregated favourites across all 5 AniList entity categories.
class UserFavourites {
  /// Favourite anime connection.
  final PagedFavourites<MediaMin> anime;

  /// Favourite manga connection.
  final PagedFavourites<MediaMin> manga;

  /// Favourite characters connection.
  final PagedFavourites<Character> characters;

  /// Favourite staff connection.
  final PagedFavourites<Staff> staff;

  /// Favourite studios connection.
  final PagedFavourites<Studio> studios;

  /// Creates a user favourites container.
  const UserFavourites({
    this.anime = const PagedFavourites<MediaMin>(),
    this.manga = const PagedFavourites<MediaMin>(),
    this.characters = const PagedFavourites<Character>(),
    this.staff = const PagedFavourites<Staff>(),
    this.studios = const PagedFavourites<Studio>(),
  });

  /// Whether all 5 favourite categories are empty.
  bool get isEmpty =>
      anime.isEmpty &&
      manga.isEmpty &&
      characters.isEmpty &&
      staff.isEmpty &&
      studios.isEmpty;

  /// Categories with at least one item in canonical display order.
  List<FavouriteCategory> get nonEmptyCategories => [
    if (anime.isNotEmpty) FavouriteCategory.anime,
    if (manga.isNotEmpty) FavouriteCategory.manga,
    if (characters.isNotEmpty) FavouriteCategory.characters,
    if (staff.isNotEmpty) FavouriteCategory.staff,
    if (studios.isNotEmpty) FavouriteCategory.studios,
  ];

  /// Returns the display total count for [category].
  int totalFor(FavouriteCategory category) => switch (category) {
    FavouriteCategory.anime => anime.displayTotal,
    FavouriteCategory.manga => manga.displayTotal,
    FavouriteCategory.characters => characters.displayTotal,
    FavouriteCategory.staff => staff.displayTotal,
    FavouriteCategory.studios => studios.displayTotal,
  };

  /// Returns whether [category] has additional server pages.
  bool hasNextPageFor(FavouriteCategory category) => switch (category) {
    FavouriteCategory.anime => anime.hasNextPage,
    FavouriteCategory.manga => manga.hasNextPage,
    FavouriteCategory.characters => characters.hasNextPage,
    FavouriteCategory.staff => staff.hasNextPage,
    FavouriteCategory.studios => studios.hasNextPage,
  };

  /// Returns the 1-based current page loaded for [category].
  int currentPageFor(FavouriteCategory category) => switch (category) {
    FavouriteCategory.anime => anime.currentPage,
    FavouriteCategory.manga => manga.currentPage,
    FavouriteCategory.characters => characters.currentPage,
    FavouriteCategory.staff => staff.currentPage,
    FavouriteCategory.studios => studios.currentPage,
  };

  /// Merges a newly fetched [incoming] page for [category] into this state.
  UserFavourites mergeCategoryPage(
    FavouriteCategory category,
    UserFavourites incoming,
  ) {
    return switch (category) {
      FavouriteCategory.anime => UserFavourites(
        anime: anime.appendPage(incoming.anime, idOf: (m) => m.id),
        manga: manga,
        characters: characters,
        staff: staff,
        studios: studios,
      ),
      FavouriteCategory.manga => UserFavourites(
        anime: anime,
        manga: manga.appendPage(incoming.manga, idOf: (m) => m.id),
        characters: characters,
        staff: staff,
        studios: studios,
      ),
      FavouriteCategory.characters => UserFavourites(
        anime: anime,
        manga: manga,
        characters: characters.appendPage(
          incoming.characters,
          idOf: (c) => c.id ?? 0,
        ),
        staff: staff,
        studios: studios,
      ),
      FavouriteCategory.staff => UserFavourites(
        anime: anime,
        manga: manga,
        characters: characters,
        staff: staff.appendPage(incoming.staff, idOf: (s) => s.id),
        studios: studios,
      ),
      FavouriteCategory.studios => UserFavourites(
        anime: anime,
        manga: manga,
        characters: characters,
        staff: staff,
        studios: studios.appendPage(incoming.studios, idOf: (s) => s.id),
      ),
    };
  }

  /// Creates [UserFavourites] from a protobuf [pb.UserFavourites] message.
  factory UserFavourites.fromProto(pb.UserFavourites pbObj) {
    return UserFavourites(
      anime: pbObj.hasAnime()
          ? _mediaFromProto(pbObj.anime)
          : const PagedFavourites<MediaMin>(),
      manga: pbObj.hasManga()
          ? _mediaFromProto(pbObj.manga)
          : const PagedFavourites<MediaMin>(),
      characters: pbObj.hasCharacters()
          ? PagedFavourites<Character>(
              items: List<Character>.unmodifiable(
                pbObj.characters.nodes.map(Character.fromProto),
              ),
              hasNextPage: pbObj.characters.pageInfo.hasNextPage,
              currentPage: pbObj.characters.pageInfo.currentPage > 0
                  ? pbObj.characters.pageInfo.currentPage
                  : 1,
              total: pbObj.characters.total,
            )
          : const PagedFavourites<Character>(),
      staff: pbObj.hasStaff()
          ? PagedFavourites<Staff>(
              items: List<Staff>.unmodifiable(
                pbObj.staff.nodes.map(Staff.fromProto),
              ),
              hasNextPage: pbObj.staff.pageInfo.hasNextPage,
              currentPage: pbObj.staff.pageInfo.currentPage > 0
                  ? pbObj.staff.pageInfo.currentPage
                  : 1,
              total: pbObj.staff.total,
            )
          : const PagedFavourites<Staff>(),
      studios: pbObj.hasStudios()
          ? PagedFavourites<Studio>(
              items: List<Studio>.unmodifiable(
                pbObj.studios.nodes.map(Studio.fromProto),
              ),
              hasNextPage: pbObj.studios.pageInfo.hasNextPage,
              currentPage: pbObj.studios.pageInfo.currentPage > 0
                  ? pbObj.studios.pageInfo.currentPage
                  : 1,
              total: pbObj.studios.total,
            )
          : const PagedFavourites<Studio>(),
    );
  }

  static PagedFavourites<MediaMin> _mediaFromProto(
    pb.FavouriteMediaConnection conn,
  ) {
    return PagedFavourites<MediaMin>(
      items: List<MediaMin>.unmodifiable(conn.nodes.map(MediaMin.fromProto)),
      hasNextPage: conn.pageInfo.hasNextPage,
      currentPage: conn.pageInfo.currentPage > 0
          ? conn.pageInfo.currentPage
          : 1,
      total: conn.total,
    );
  }

  /// Converts this container to its protobuf [pb.UserFavourites] message.
  pb.UserFavourites toProto() {
    return pb.UserFavourites(
      anime: _mediaToProto(anime),
      manga: _mediaToProto(manga),
      characters: pb.FavouriteCharacterConnection(
        pageInfo: pb_common.PageInfo(
          hasNextPage: characters.hasNextPage,
          currentPage: characters.currentPage,
        ),
        total: characters.total,
        nodes: characters.items.map((c) => c.toProto()),
      ),
      staff: pb.FavouriteStaffConnection(
        pageInfo: pb_common.PageInfo(
          hasNextPage: staff.hasNextPage,
          currentPage: staff.currentPage,
        ),
        total: staff.total,
        nodes: staff.items.map((s) => s.toProto()),
      ),
      studios: pb.FavouriteStudioConnection(
        pageInfo: pb_common.PageInfo(
          hasNextPage: studios.hasNextPage,
          currentPage: studios.currentPage,
        ),
        total: studios.total,
        nodes: studios.items.map((s) => s.toProto()),
      ),
    );
  }

  static pb.FavouriteMediaConnection _mediaToProto(
    PagedFavourites<MediaMin> slice,
  ) {
    return pb.FavouriteMediaConnection(
      pageInfo: pb_common.PageInfo(
        hasNextPage: slice.hasNextPage,
        currentPage: slice.currentPage,
      ),
      total: slice.total,
      nodes: slice.items.map((m) => m.toProto() as pb_media.MediaMin),
    );
  }
}
