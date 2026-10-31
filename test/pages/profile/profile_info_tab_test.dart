import 'package:flutter/material.dart' hide Title;
import 'package:flutter_test/flutter_test.dart';
import 'package:goodanime/models/common.dart';
import 'package:goodanime/models/media_list.dart';
import 'package:goodanime/models/media_min.dart';
import 'package:goodanime/models/user_profile.dart';
import 'package:goodanime/pages/media_list/widgets/list_view.dart';
import 'package:goodanime/pages/profile/tabs/info_tab.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Widget tests for [ProfileInfoTab].
void main() {
  const sampleProfile = UserProfile(
    id: 42,
    name: 'thedrone7',
    animeCount: 215,
    mangaCount: 1,
    about:
        '<p>Hello world! <span class="markdown_spoiler"><span>Secret ending</span></span></p>'
        '<div class="markdown_spoiler"><p>Hidden block spoiler</p></div>',
  );

  Widget buildInfoTab({
    UserProfile profile = sampleProfile,
    VoidCallback? onOpenAnimeList,
    VoidCallback? onOpenMangaList,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: ProfileInfoTab(
            profile: profile,
            onOpenAnimeList: onOpenAnimeList ?? () {},
            onOpenMangaList: onOpenMangaList ?? () {},
          ),
        ),
      ),
    );
  }

  testWidgets('renders shortcut cards with entry counts and triggers taps', (
    tester,
  ) async {
    var animeTapped = false;
    var mangaTapped = false;

    await tester.pumpWidget(
      buildInfoTab(
        onOpenAnimeList: () => animeTapped = true,
        onOpenMangaList: () => mangaTapped = true,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Anime List'), findsOneWidget);
    expect(find.text('215 entries'), findsOneWidget);
    expect(find.text('Manga List'), findsOneWidget);
    expect(find.text('1 entry'), findsOneWidget);

    await tester.tap(find.text('Anime List'));
    await tester.pump();
    expect(animeTapped, isTrue);

    await tester.tap(find.text('Manga List'));
    await tester.pump();
    expect(mangaTapped, isTrue);
  });

  testWidgets('hides inline and block spoilers until tapped', (tester) async {
    await tester.pumpWidget(buildInfoTab());
    await tester.pumpAndSettle();

    expect(find.text('About'), findsOneWidget);
    expect(find.textContaining('Hello world!'), findsOneWidget);
    expect(find.text('Spoiler'), findsNWidgets(2));
    expect(find.text('Hidden block spoiler'), findsNothing);

    await tester.tap(find.text('Spoiler').last);
    await tester.pumpAndSettle();

    expect(find.text('Hidden block spoiler'), findsOneWidget);
    expect(find.text('Spoiler'), findsOneWidget);

    await tester.tap(find.text('Spoiler').first);
    await tester.pumpAndSettle();

    expect(find.textContaining('Secret ending'), findsOneWidget);
    expect(find.text('Spoiler'), findsNothing);
  });

  testWidgets('renders empty state when bio is empty or whitespace', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildInfoTab(profile: sampleProfile.copyWith(about: '   ')),
    );
    await tester.pumpAndSettle();

    expect(find.text('About'), findsOneWidget);
    expect(find.text('No bio available.'), findsOneWidget);
  });

  testWidgets('read-only MediaListView hides progress increment button', (
    tester,
  ) async {
    final scrollController = ScrollController();
    addTearDown(scrollController.dispose);

    const entry = MediaListEntryWithMedia(
      id: 1,
      status: MediaListStatus.current,
      progress: 3,
      score: 8.5,
      repeat: 0,
      progressVolumes: 0,
      media: MediaMin(
        id: 101,
        type: 'ANIME',
        title: Title(
          english: 'Cowboy Bebop',
          native: 'Cowboy Bebop',
          romaji: 'Cowboy Bebop',
          userPreferred: 'Cowboy Bebop',
        ),
        averageScore: 86,
        coverImage: CoverImage(
          medium: '',
          large: '',
          extraLarge: '',
          color: '#32668C',
        ),
        episodes: 26,
        chapters: 0,
        volumes: 0,
        format: 'TV',
        isAdult: false,
        isFavourite: false,
        siteUrl: 'https://anilist.co/anime/101',
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MediaListView(
            activeName: 'WATCHING',
            entries: const [entry],
            scrollController: scrollController,
            onRefresh: () {},
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Cowboy Bebop'), findsOneWidget);
    expect(find.byIcon(LucideIcons.play), findsNothing);
  });
}
