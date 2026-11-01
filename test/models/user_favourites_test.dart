import 'package:flutter_test/flutter_test.dart';
import 'package:goodanime/models/media_character.dart';
import 'package:goodanime/models/media_min.dart';
import 'package:goodanime/models/media_staff.dart';
import 'package:goodanime/models/media_studio.dart';
import 'package:goodanime/models/user_favourites.dart';

void main() {
  MediaMin buildMedia({
    required int id,
    required String type,
    required String title,
  }) {
    return MediaMin(
      id: id,
      type: type,
      title: Title(
        english: title,
        native: title,
        romaji: title,
        userPreferred: title,
      ),
      averageScore: 86,
      coverImage: const CoverImage(
        medium: 'https://img.com/m.jpg',
        large: 'https://img.com/l.jpg',
        extraLarge: 'https://img.com/xl.jpg',
        color: '#4e8cff',
      ),
      episodes: type == 'ANIME' ? 24 : 0,
      chapters: type == 'MANGA' ? 120 : 0,
      volumes: type == 'MANGA' ? 12 : 0,
      format: type == 'ANIME' ? 'TV' : 'MANGA',
      isAdult: false,
      isFavourite: true,
      siteUrl: 'https://anilist.co/${type.toLowerCase()}/$id',
      startYear: 2022,
    );
  }

  Character buildCharacter({required int id, required String name}) {
    return Character(
      id: id,
      name: CharacterName(
        full: name,
        native: name,
        userPreferred: name,
        alternative: const [],
        alternativeSpoiler: const [],
      ),
      image: const CharacterImage(large: 'https://img.com/char.jpg'),
      favourites: 1500,
      isFavourite: true,
    );
  }

  Staff buildStaff({
    required int id,
    required String name,
    List<String> occupations = const ['Director'],
  }) {
    return Staff(
      id: id,
      name: StaffName(full: name, userPreferred: name),
      image: const StaffImage(large: 'https://img.com/staff.jpg'),
      yearsActive: const [],
      primaryOccupations: occupations,
      favourites: 800,
      isFavourite: true,
    );
  }

  Studio buildStudio({required int id, required String name}) {
    return Studio(
      id: id,
      name: name,
      favourites: 3200,
      isFavourite: true,
      media: null,
    );
  }

  group('UserFavourites model & categorization (THE-182)', () {
    test('roundtrips all 5 favourite categories through protobuf', () {
      final original = UserFavourites(
        anime: PagedFavourites<MediaMin>(
          items: [buildMedia(id: 1, type: 'ANIME', title: 'Cowboy Bebop')],
          hasNextPage: true,
          total: 30,
        ),
        manga: PagedFavourites<MediaMin>(
          items: [buildMedia(id: 2, type: 'MANGA', title: 'Monster')],
          total: 1,
        ),
        characters: PagedFavourites<Character>(
          items: [buildCharacter(id: 11, name: 'Spike Spiegel')],
          total: 1,
        ),
        staff: PagedFavourites<Staff>(
          items: [
            buildStaff(
              id: 22,
              name: 'Shinichiro Watanabe',
              occupations: const ['Director', 'Screenwriter'],
            ),
          ],
          hasNextPage: true,
          total: 26,
        ),
        studios: PagedFavourites<Studio>(
          items: [buildStudio(id: 33, name: 'Sunrise')],
          total: 1,
        ),
      );

      final restored = UserFavourites.fromProto(original.toProto());

      expect(restored.isEmpty, isFalse);
      expect(restored.nonEmptyCategories, FavouriteCategory.values);

      expect(restored.anime.items.single.title.userPreferred, 'Cowboy Bebop');
      expect(restored.anime.hasNextPage, isTrue);
      expect(restored.anime.displayTotal, 30);

      expect(restored.manga.items.single.title.userPreferred, 'Monster');
      expect(
        restored.characters.items.single.name?.userPreferred,
        'Spike Spiegel',
      );
      expect(restored.characters.items.single.favourites, 1500);

      expect(restored.staff.items.single.primaryOccupations, [
        'Director',
        'Screenwriter',
      ]);
      expect(restored.staff.hasNextPage, isTrue);
      expect(restored.totalFor(FavouriteCategory.staff), 26);

      expect(restored.studios.items.single.name, 'Sunrise');
      expect(restored.studios.items.single.favourites, 3200);
    });

    test(
      'nonEmptyCategories omits empty sections while preserving canonical order',
      () {
        const empty = UserFavourites();
        expect(empty.isEmpty, isTrue);
        expect(empty.nonEmptyCategories, isEmpty);

        final sparse = UserFavourites(
          manga: PagedFavourites<MediaMin>(
            items: [buildMedia(id: 10, type: 'MANGA', title: 'Berserk')],
          ),
          studios: PagedFavourites<Studio>(
            items: [buildStudio(id: 44, name: 'Madhouse')],
          ),
        );

        expect(sparse.isEmpty, isFalse);
        expect(sparse.nonEmptyCategories, [
          FavouriteCategory.manga,
          FavouriteCategory.studios,
        ]);
      },
    );

    test(
      'mergeCategoryPage appends deduplicated items to target category without mutating siblings',
      () {
        final initial = UserFavourites(
          anime: PagedFavourites<MediaMin>(
            items: [
              buildMedia(id: 101, type: 'ANIME', title: 'Alpha'),
              buildMedia(id: 102, type: 'ANIME', title: 'Beta'),
            ],
            hasNextPage: true,
            total: 3,
          ),
          characters: PagedFavourites<Character>(
            items: [buildCharacter(id: 501, name: 'Keep Me')],
            total: 1,
          ),
        );

        final pageTwoAnime = UserFavourites(
          anime: PagedFavourites<MediaMin>(
            items: [
              buildMedia(id: 102, type: 'ANIME', title: 'Beta Duplicate'),
              buildMedia(id: 103, type: 'ANIME', title: 'Gamma'),
            ],
            currentPage: 2,
          ),
        );

        final merged = initial.mergeCategoryPage(
          FavouriteCategory.anime,
          pageTwoAnime,
        );

        expect(merged.anime.items.map((m) => m.id).toList(), [101, 102, 103]);
        expect(merged.anime.items[1].title.userPreferred, 'Beta');
        expect(merged.anime.currentPage, 2);
        expect(merged.anime.hasNextPage, isFalse);
        expect(merged.anime.displayTotal, 3);

        expect(merged.characters.items.single.id, 501);
        expect(merged.manga.isEmpty, isTrue);
      },
    );
  });
}
