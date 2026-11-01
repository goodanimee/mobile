import 'package:flutter/material.dart' hide Title;
import 'package:flutter_test/flutter_test.dart';
import 'package:goodanime/models/media_character.dart';
import 'package:goodanime/models/media_min.dart';
import 'package:goodanime/models/media_staff.dart';
import 'package:goodanime/models/media_studio.dart';
import 'package:goodanime/models/user_favourites.dart';
import 'package:goodanime/pages/profile/tabs/favourites_tab.dart';

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
      averageScore: 87,
      coverImage: const CoverImage(
        medium: '',
        large: '',
        extraLarge: '',
        color: '#4e8cff',
      ),
      episodes: type == 'ANIME' ? 12 : 0,
      chapters: type == 'MANGA' ? 60 : 0,
      volumes: type == 'MANGA' ? 6 : 0,
      format: type == 'ANIME' ? 'TV' : 'MANGA',
      isAdult: false,
      isFavourite: false,
      siteUrl: 'https://anilist.co/${type.toLowerCase()}/$id',
    );
  }

  Character buildCharacter({required int id, required String name}) {
    return Character(
      id: id,
      name: CharacterName(
        full: name,
        userPreferred: name,
        alternative: const [],
        alternativeSpoiler: const [],
      ),
      favourites: 2400,
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
      yearsActive: const [],
      primaryOccupations: occupations,
      favourites: 900,
    );
  }

  Studio buildStudio({required int id, required String name, int favs = 5400}) {
    return Studio(
      id: id,
      name: name,
      favourites: favs,
      isFavourite: false,
      media: null,
    );
  }

  Widget wrapSubject(Widget child) {
    return MaterialApp(
      home: Scaffold(body: SingleChildScrollView(child: child)),
    );
  }

  testWidgets(
    'renders only non-empty category carousels and dispatches card tap callbacks',
    (tester) async {
      int? openedMediaId;
      int? openedCharacterId;
      int? openedStaffId;
      int? openedStudioId;

      final sample = UserFavourites(
        anime: PagedFavourites<MediaMin>(
          items: [buildMedia(id: 21, type: 'ANIME', title: 'One Piece')],
          total: 14,
        ),
        characters: PagedFavourites<Character>(
          items: [buildCharacter(id: 40, name: 'Monkey D. Luffy')],
          total: 1,
        ),
        staff: PagedFavourites<Staff>(
          items: [
            buildStaff(
              id: 96879,
              name: 'Eiichiro Oda',
              occupations: const ['Mangaka'],
            ),
          ],
          total: 1,
        ),
        studios: PagedFavourites<Studio>(
          items: [buildStudio(id: 18, name: 'Toei Animation')],
          total: 1,
        ),
      );

      await tester.pumpWidget(
        wrapSubject(
          ProfileFavouritesTab(
            userId: 10,
            fetchFavourites: ({required userId, category, page = 1}) async =>
                sample,
            onOpenMedia: (id) => openedMediaId = id,
            onOpenCharacter: (c) => openedCharacterId = c.id,
            onOpenStaff: (s) => openedStaffId = s.id,
            onOpenStudio: (id) => openedStudioId = id,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Anime'), findsOneWidget);
      expect(find.text('14'), findsOneWidget);
      expect(find.text('Manga'), findsNothing);
      expect(find.text('Characters'), findsOneWidget);
      expect(find.text('Staff'), findsOneWidget);
      expect(find.text('Studios'), findsOneWidget);

      expect(find.text('One Piece'), findsOneWidget);
      expect(find.text('Monkey D. Luffy'), findsOneWidget);
      expect(find.text('Eiichiro Oda'), findsOneWidget);
      expect(find.text('Mangaka'), findsOneWidget);
      expect(find.text('Toei Animation'), findsOneWidget);

      await tester.tap(find.text('One Piece'));
      await tester.pump();
      expect(openedMediaId, 21);

      await tester.tap(find.text('Monkey D. Luffy'));
      await tester.pump();
      expect(openedCharacterId, 40);

      await tester.tap(find.text('Eiichiro Oda'));
      await tester.pump();
      expect(openedStaffId, 96879);

      await tester.ensureVisible(find.text('Toei Animation'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Toei Animation'));
      await tester.pump();
      expect(openedStudioId, 18);
    },
  );

  testWidgets('renders empty state when all 5 categories are empty', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrapSubject(
        ProfileFavouritesTab(
          userId: 10,
          fetchFavourites: ({required userId, category, page = 1}) async =>
              const UserFavourites(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('No favourites added yet.'), findsOneWidget);
    expect(find.text('Anime'), findsNothing);
  });

  testWidgets(
    'horizontal scroll near end triggers single-category pagination and appends items',
    (tester) async {
      final calls = <(FavouriteCategory?, int)>[];

      final page1 = UserFavourites(
        anime: PagedFavourites<MediaMin>(
          items: [
            for (var i = 1; i <= 8; i++)
              buildMedia(id: i, type: 'ANIME', title: 'Anime Item $i'),
          ],
          hasNextPage: true,
          total: 9,
        ),
      );

      final page2 = UserFavourites(
        anime: PagedFavourites<MediaMin>(
          items: [buildMedia(id: 9, type: 'ANIME', title: 'Anime Item 9')],
          currentPage: 2,
          total: 9,
        ),
      );

      await tester.pumpWidget(
        wrapSubject(
          ProfileFavouritesTab(
            userId: 10,
            fetchFavourites: ({required userId, category, page = 1}) async {
              calls.add((category, page));
              return category == FavouriteCategory.anime && page == 2
                  ? page2
                  : page1;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(calls, [(null, 1)]);

      final animeList = find.byKey(const ValueKey('favourites_ANIME'));
      await tester.drag(animeList, const Offset(-700, 0));
      await tester.pumpAndSettle();

      expect(calls, [(null, 1), (FavouriteCategory.anime, 2)]);

      await tester.drag(animeList, const Offset(-400, 0));
      await tester.pumpAndSettle();
      expect(find.text('Anime Item 9'), findsOneWidget);
    },
  );

  testWidgets(
    'scales cleanly on compact 320px viewports with elevated text scale and multi-line names',
    (tester) async {
      tester.view.physicalSize = const Size(320, 568);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final denseSample = UserFavourites(
        anime: PagedFavourites<MediaMin>(
          items: [
            buildMedia(
              id: 1,
              type: 'ANIME',
              title: 'Very Long Anime Title That Wraps Across Two Lines',
            ),
            buildMedia(id: 2, type: 'ANIME', title: 'Second Compact Anime'),
            buildMedia(id: 3, type: 'ANIME', title: 'Third Compact Anime'),
          ],
          total: 3,
        ),
        characters: PagedFavourites<Character>(
          items: [
            for (var i = 1; i <= 4; i++)
              Character(
                id: 100 + i,
                name: CharacterName(
                  full: 'Kiss-Shot Acerola-Orion Heart-Under-Blade $i',
                  native: '\u30AD\u30B9\u30B7\u30E7\u30C3\u30C8',
                  userPreferred: 'Kiss-Shot Acerola-Orion Heart-Under-Blade $i',
                  alternative: const [],
                  alternativeSpoiler: const [],
                ),
                favourites: 12400,
              ),
          ],
          total: 4,
        ),
        staff: PagedFavourites<Staff>(
          items: [
            for (var i = 1; i <= 4; i++)
              Staff(
                id: 200 + i,
                name: StaffName(
                  full: 'Very Long Production Staff Member Name $i',
                  native: '\u30B9\u30BF\u30C3\u30D5',
                  userPreferred: 'Very Long Production Staff Member Name $i',
                ),
                yearsActive: const [],
                primaryOccupations: const [
                  'Director',
                  'Character Designer',
                  'Chief Animation Director',
                ],
                favourites: 4800,
              ),
          ],
          total: 4,
        ),
        studios: PagedFavourites<Studio>(
          items: [
            for (var i = 1; i <= 4; i++)
              buildStudio(
                id: 300 + i,
                name: 'Extended Animation Production Studio Name $i',
                favs: 98500,
              ),
          ],
          total: 4,
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(
              size: Size(320, 568),
              textScaler: TextScaler.linear(1.25),
            ),
            child: Scaffold(
              body: SingleChildScrollView(
                child: ProfileFavouritesTab(
                  userId: 10,
                  fetchFavourites:
                      ({required userId, category, page = 1}) async =>
                          denseSample,
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(
        find.text('Kiss-Shot Acerola-Orion Heart-Under-Blade 1'),
        findsOneWidget,
      );
      expect(
        find.text('Extended Animation Production Studio Name 1'),
        findsOneWidget,
      );
    },
  );
}
