import 'package:flutter/material.dart' hide Title;
import 'package:flutter_test/flutter_test.dart';
import 'package:goodanime/models/common.dart';
import 'package:goodanime/models/media_list.dart';
import 'package:goodanime/models/media_min.dart';
import 'package:goodanime/pages/profile/user_media_list_page.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

MediaMin _media(int id, String title) {
  return MediaMin(
    id: id,
    type: 'ANIME',
    title: Title(
      english: title,
      native: title,
      romaji: title,
      userPreferred: title,
    ),
    averageScore: 80,
    coverImage: const CoverImage(
      medium: '',
      large: '',
      extraLarge: '',
      color: '#1a1a1a',
    ),
    episodes: 24,
    chapters: 0,
    volumes: 0,
    format: 'TV',
    isAdult: false,
    isFavourite: false,
    siteUrl: 'https://anilist.co/anime/$id',
  );
}

MediaListEntryWithMedia _entry({
  required int id,
  required int mediaId,
  required String title,
  required MediaListStatus status,
  List<String> customLists = const [],
}) {
  return MediaListEntryWithMedia(
    id: id,
    status: status,
    progress: 5,
    score: 8.5,
    repeat: 0,
    progressVolumes: 0,
    customLists: customLists,
    media: _media(mediaId, title),
  );
}

void main() {
  group('UserMediaListPage Custom Lists & QuickNav', () {
    final sampleLists = [
      MediaList(
        name: 'Watching',
        status: MediaListStatus.current,
        entries: [
          _entry(
            id: 1,
            mediaId: 10,
            title: 'Steins;Gate',
            status: MediaListStatus.current,
          ),
        ],
      ),
      MediaList(
        name: 'Completed',
        status: MediaListStatus.completed,
        entries: [
          _entry(
            id: 2,
            mediaId: 20,
            title: 'Frieren',
            status: MediaListStatus.completed,
          ),
        ],
      ),
      MediaList(
        name: 'Favorites',
        isCustomList: true,
        entries: [
          _entry(
            id: 3,
            mediaId: 30,
            title: 'Monster',
            status: MediaListStatus.completed,
            customLists: ['Favorites'],
          ),
        ],
      ),
      MediaList(
        name: 'Tier S',
        isCustomList: true,
        entries: [
          _entry(
            id: 4,
            mediaId: 40,
            title: 'Vinland Saga',
            status: MediaListStatus.completed,
            customLists: ['Tier S'],
          ),
        ],
      ),
    ];

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      final binding = TestWidgetsFlutterBinding.ensureInitialized();
      binding.platformDispatcher.views.first.physicalSize =
          const Size(1080, 1920);
      binding.platformDispatcher.views.first.devicePixelRatio = 1.0;
    });

    tearDown(() {
      final binding = TestWidgetsFlutterBinding.ensureInitialized();
      binding.platformDispatcher.views.first.resetPhysicalSize();
      binding.platformDispatcher.views.first.resetDevicePixelRatio();
    });

    testWidgets(
      'quick nav renders only status sections and custom lists button below divider',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: UserMediaListPage(
              userId: 99,
              username: 'anime_fan',
              mediaType: 'ANIME',
              fetchLists: (userId, mediaType) async => sampleLists,
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Tap FAB (menu icon) to open floating nav
        await tester.tap(find.byIcon(LucideIcons.menu));
        await tester.pumpAndSettle();

        // Status sections are rendered in quick nav
        expect(find.byIcon(LucideIcons.playCircle), findsOneWidget); // Current/Watching
        expect(find.byIcon(LucideIcons.badgeCheck), findsOneWidget); // Completed

        // Custom lists should NOT be individual quick nav section icons
        expect(find.byIcon(LucideIcons.folder), findsNothing);

        // Custom list button is rendered
        expect(find.byIcon(LucideIcons.folderCog), findsOneWidget);
      },
    );

    testWidgets(
      'tapping custom lists button opens read-only panel and selecting updates view',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: UserMediaListPage(
              userId: 99,
              username: 'anime_fan',
              mediaType: 'ANIME',
              fetchLists: (userId, mediaType) async => sampleLists,
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Initially shows 'Steins;Gate' (first item in Watching)
        expect(find.text('Steins;Gate'), findsOneWidget);

        // Tap FAB (menu icon) to open floating nav
        await tester.tap(find.byIcon(LucideIcons.menu));
        await tester.pumpAndSettle();

        // Tap Custom Lists button to open panel
        await tester.tap(find.byIcon(LucideIcons.folderCog));
        await tester.pumpAndSettle();

        // Panel opens with custom list names
        expect(find.text('Custom Lists'), findsOneWidget);
        expect(find.text('Favorites'), findsOneWidget);
        expect(find.text('Tier S'), findsOneWidget);

        // Management controls are hidden
        expect(find.byIcon(LucideIcons.plus), findsNothing);
        expect(find.byIcon(LucideIcons.trash2), findsNothing);

        // Tap 'Tier S' custom list
        await tester.tap(find.text('Tier S'));
        await tester.pumpAndSettle();

        // Header shows 'Tier S' and subtitle
        expect(find.text('Tier S'), findsOneWidget);
        expect(find.text("anime_fan's Anime List"), findsOneWidget);

        // Main content shows Vinland Saga
        expect(find.text('Vinland Saga'), findsOneWidget);
      },
    );
  });
}
