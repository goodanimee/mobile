import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide Title;
import 'package:flutter_test/flutter_test.dart';
import 'package:goodanime/components/html_anilist_link_card.dart';
import 'package:goodanime/components/html_description.dart';
import 'package:goodanime/components/html_description_widgets.dart';
import 'package:goodanime/components/relation_card.dart';
import 'package:goodanime/models/media_character.dart';
import 'package:goodanime/models/media_min.dart';
import 'package:goodanime/models/media_staff.dart';
import 'package:goodanime/models/media_studio.dart';
import 'package:goodanime/models/user_profile.dart';
import 'package:goodanime/utils/anilist_url_parser.dart';

/// Widget tests for [HtmlDescription] AniList HTML, markdown, and entity cards.
void main() {
  tearDown(() {
    HtmlAnilistLinkCard.debugResolverOverride = null;
    HtmlAnilistLinkCard.debugBatchResolverOverride = null;
    HtmlAnilistLinkCard.clearCache();
  });

  Widget buildSubject(String html) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(child: HtmlDescription(html: html)),
      ),
    );
  }

  MediaMin buildMediaFixture({
    required int id,
    required String type,
    required String title,
    required String format,
    int episodes = 0,
    int chapters = 0,
    int averageScore = 85,
  }) {
    return MediaMin(
      id: id,
      type: type,
      title: Title(
        english: title,
        native: '',
        romaji: title,
        userPreferred: title,
      ),
      averageScore: averageScore,
      coverImage: const CoverImage(
        medium: '',
        large: '',
        extraLarge: '',
        color: '#4F9DDE',
      ),
      episodes: episodes,
      chapters: chapters,
      volumes: 0,
      format: format,
      isAdult: false,
      isFavourite: false,
      siteUrl: 'https://anilist.co/${type.toLowerCase()}/$id',
    );
  }

  testWidgets(
    'renders multi-section bio with center blocks, hr dividers, newlines, entity cards, and sized image',
    (tester) async {
      HtmlAnilistLinkCard.debugResolverOverride = (target) async => null;

      const multiSectionLoremHtml =
          '<center>_"Lorem ipsum dolor sit amet, consectetur adipiscing elit."_</center> \n'
          '<p>lorem | 23 | ipsum | dolor/sit | amet consectetur</p>\n'
          '<p>first item: lorem ipsum (2001)<br />\n'
          'second item: dolor sit </p>\n'
          '<p>third item: ut enim ad minim veniam. </p>\n'
          '<hr>\n'
          '<center>Lorem Section</center>\n'
          '<center>consectetur adipiscing elit\n'
          '100 - sed do eiusmod tempor incididunt\n'
          '91-99 - ut labore et dolore magna aliqua\n'
          '<=50 ut enim ad minim veniam. </center>\n'
          '<center>[lorem badges](https://example.com/lorem)</center>\n'
          '<hr>\n'
          '<center>adipiscing theme\n'
          'https://anilist.co/anime/1/Lorem-Ipsum/\n'
          'https://anilist.co/manga/2/Dolor-Sit/\n'
          ' </center>\n'
          "<center><img width='350' src='https://example.com/lorem.jpg'> </center>";

      await tester.pumpWidget(buildSubject(multiSectionLoremHtml));
      await tester.pump();

      expect(find.byType(Divider), findsNWidgets(2));

      expect(
        find.text('"Lorem ipsum dolor sit amet, consectetur adipiscing elit."'),
        findsOneWidget,
      );
      expect(find.textContaining('_"Lorem'), findsNothing);

      expect(find.text('Lorem Section'), findsOneWidget);

      final multiLineCentered = tester.widget<Text>(
        find.byWidgetPredicate(
          (w) =>
              w is Text &&
              (w.textSpan?.toPlainText().contains(
                    '100 - sed do eiusmod tempor incididunt\n91-99',
                  ) ??
                  false),
        ),
      );
      expect(multiLineCentered.textAlign, TextAlign.center);
      expect(
        multiLineCentered.textSpan!.toPlainText(),
        contains('<=50 ut enim ad minim veniam.'),
      );

      expect(find.text('lorem badges'), findsOneWidget);

      final themeHeading = tester.widget<Text>(find.text('adipiscing theme'));
      expect(themeHeading.textAlign, TextAlign.center);

      expect(find.byType(HtmlAnilistLinkCard), findsNWidgets(2));
      expect(find.text('Lorem Ipsum'), findsOneWidget);
      expect(find.text('Dolor Sit'), findsOneWidget);
      expect(find.text('ANIME'), findsOneWidget);
      expect(find.text('MANGA'), findsOneWidget);

      final imgEmbed = tester.widget<HtmlImageEmbed>(
        find.byType(HtmlImageEmbed),
      );
      expect(imgEmbed.src, 'https://example.com/lorem.jpg');
      expect(imgEmbed.widthAttr, '350');
    },
  );

  testWidgets(
    'renders rich RelationCard and Studio boxes for all 6 AniList entity types',
    (tester) async {
      HtmlAnilistLinkCard.debugResolverOverride = (target) async {
        return switch (target.type) {
          AnilistEntityType.anime => AnilistMediaPreview(
            buildMediaFixture(
              id: 101,
              type: 'ANIME',
              title: 'Lorem Anime',
              format: 'TV',
              episodes: 12,
              averageScore: 86,
            ),
          ),
          AnilistEntityType.manga => AnilistMediaPreview(
            buildMediaFixture(
              id: 202,
              type: 'MANGA',
              title: 'Dolor Manga',
              format: 'MANGA',
              chapters: 48,
              averageScore: 91,
            ),
          ),
          AnilistEntityType.character => const AnilistCharacterPreview(
            Character(
              id: 303,
              name: CharacterName(
                full: 'Amet Character',
                userPreferred: 'Amet Character',
                alternative: [],
                alternativeSpoiler: [],
              ),
              favourites: 1200,
            ),
          ),
          AnilistEntityType.staff => const AnilistStaffPreview(
            Staff(
              id: 404,
              name: StaffName(full: 'Elit Staff', userPreferred: 'Elit Staff'),
              yearsActive: [],
              primaryOccupations: ['Director'],
              favourites: 450,
            ),
          ),
          AnilistEntityType.studio => const AnilistStudioPreview(
            Studio(
              id: 505,
              name: 'Tempor Studio',
              favourites: 3400,
              isFavourite: false,
              media: null,
            ),
          ),
          AnilistEntityType.user => const AnilistUserPreview(
            UserProfile(
              id: 606,
              name: 'lorem_viewer',
              animeCount: 120,
              mangaCount: 45,
              followersCount: 89,
            ),
          ),
        };
      };

      const allEntitiesHtml =
          '<p>https://anilist.co/anime/101/Lorem-Anime/</p>'
          '<p><a href="https://anilist.co/manga/202">Dolor Label</a></p>'
          '<center>[Character Label](https://anilist.co/character/303)</center>'
          '<p>https://anilist.co/staff/404/Elit-Staff/</p>'
          '<p>https://anilist.co/studio/505/Tempor-Studio/</p>'
          '<p>https://anilist.co/user/lorem_viewer/</p>';

      await tester.pumpWidget(buildSubject(allEntitiesHtml));
      await tester.pump();

      expect(find.byType(HtmlAnilistLinkCard), findsNWidgets(6));
      expect(find.byType(RelationCard), findsNWidgets(5));

      expect(find.text('Lorem Anime'), findsOneWidget);
      expect(find.text('TV \u00B7 12 Episodes'), findsOneWidget);
      expect(find.text('8.6'), findsOneWidget);

      expect(find.text('Dolor Manga'), findsOneWidget);
      expect(find.text('MANGA \u00B7 48 Chapters'), findsOneWidget);
      expect(find.text('9.1'), findsOneWidget);

      expect(find.text('Amet Character'), findsOneWidget);
      expect(find.text('CHARACTER'), findsOneWidget);

      expect(find.text('Elit Staff'), findsOneWidget);
      expect(find.text('Director'), findsOneWidget);
      expect(find.text('STAFF'), findsOneWidget);

      expect(find.text('Tempor Studio'), findsOneWidget);
      expect(find.text('STUDIO'), findsOneWidget);

      expect(find.text('lorem_viewer'), findsOneWidget);
      expect(find.text('120 Anime \u00B7 45 Manga'), findsOneWidget);
      expect(find.text('USER'), findsOneWidget);
    },
  );

  testWidgets(
    'keeps mid-sentence named AniList links and linked images inline without breaking sentences',
    (tester) async {
      HtmlAnilistLinkCard.debugResolverOverride = (target) async => null;

      const inlineLinksHtml =
          '<p>Currently watching <a href="https://anilist.co/anime/10">Lorem Title</a> every week.</p>'
          '<center>Reading [Dolor Title](https://anilist.co/manga/20) right now</center>'
          '<center><a href="https://anilist.co/anime/30"><img width="140" src="https://example.com/banner.png"></a></center>';

      await tester.pumpWidget(buildSubject(inlineLinksHtml));
      await tester.pump();

      expect(find.byType(HtmlAnilistLinkCard), findsNothing);
      expect(find.byType(HtmlImageEmbed), findsOneWidget);

      final proseParagraph = tester.widget<Text>(
        find.byWidgetPredicate(
          (w) =>
              w is Text &&
              (w.textSpan?.toPlainText().contains(
                    'Currently watching Lorem Title every week.',
                  ) ??
                  false),
        ),
      );
      final rootSpan = proseParagraph.textSpan! as TextSpan;
      final recognizers = <GestureRecognizer>[];
      rootSpan.visitChildren((span) {
        if (span is TextSpan && span.recognizer != null) {
          recognizers.add(span.recognizer!);
        }
        return true;
      });
      expect(recognizers, isNotEmpty);

      expect(find.text('Reading Dolor Title right now'), findsOneWidget);
    },
  );

  testWidgets(
    'supports headings h4-h6, blockquote, pre/code, strikethrough, and inline markdown',
    (tester) async {
      const richHtml =
          '<h4>Heading Four</h4>'
          '<h5>Heading Five</h5>'
          '<h6>Heading Six</h6>'
          '<blockquote><p>Lorem quoted text</p></blockquote>'
          '<pre><code>const lorem = 42;\nprint(lorem);</code></pre>'
          '<p>Inline <del>deleted</del> and <code>snippet</code> text</p>'
          '<center>**bold lorem** and ~~struck lorem~~ and ~!hidden lorem!~</center>';

      await tester.pumpWidget(buildSubject(richHtml));
      await tester.pump();

      expect(find.text('Heading Four'), findsOneWidget);
      expect(find.text('Heading Five'), findsOneWidget);
      expect(find.text('Heading Six'), findsOneWidget);
      expect(find.text('Lorem quoted text'), findsOneWidget);
      expect(
        find.textContaining('const lorem = 42;\nprint(lorem);'),
        findsOneWidget,
      );
      expect(find.textContaining('deleted'), findsOneWidget);

      expect(find.text('Spoiler'), findsOneWidget);
      expect(find.text('hidden lorem'), findsNothing);

      await tester.tap(find.text('Spoiler'));
      await tester.pump();

      expect(find.text('hidden lorem'), findsOneWidget);
    },
  );

  testWidgets(
    'renders tappable YouTube and Video link cards and clickable linked images',
    (tester) async {
      const mediaHtml =
          '<div class="youtube" id="dQw4w9WgXcQ"></div>'
          '<video><source src="https://files.example.com/demo.webm" type="video/webm"></video>'
          '<center><a href="https://example.com/target"><img width="120" src="https://example.com/badge.png"></a></center>';

      await tester.pumpWidget(buildSubject(mediaHtml));
      await tester.pump();

      expect(find.byType(HtmlYoutubeCard), findsOneWidget);
      expect(find.text('Watch on YouTube'), findsOneWidget);

      expect(find.byType(HtmlVideoCard), findsOneWidget);
      expect(find.text('Open Video'), findsOneWidget);
      expect(find.text('files.example.com - demo.webm'), findsOneWidget);

      final badgeEmbed = tester.widget<HtmlImageEmbed>(
        find.byType(HtmlImageEmbed),
      );
      expect(badgeEmbed.linkUrl, 'https://example.com/target');
      expect(badgeEmbed.widthAttr, '120');
    },
  );

  testWidgets(
    'coalesces uncached links across multiple HtmlDescriptions into a single batch call and negative-caches 404s',
    (tester) async {
      final batchCalls = <List<AnilistRouteTarget>>[];

      HtmlAnilistLinkCard.debugBatchResolverOverride = (targets) async {
        batchCalls.add(List<AnilistRouteTarget>.of(targets));
        return {
          const AnilistRouteTarget(
            type: AnilistEntityType.anime,
            id: 11,
          ): AnilistMediaPreview(
            buildMediaFixture(
              id: 11,
              type: 'ANIME',
              title: 'Batched Alpha',
              format: 'TV',
            ),
          ),
          const AnilistRouteTarget(
            type: AnilistEntityType.manga,
            id: 22,
          ): AnilistMediaPreview(
            buildMediaFixture(
              id: 22,
              type: 'MANGA',
              title: 'Batched Beta',
              format: 'MANGA',
            ),
          ),
        };
      };

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  HtmlDescription(
                    html:
                        '<p>https://anilist.co/anime/11/Alpha/</p>'
                        '<p>https://anilist.co/manga/22/Beta/</p>',
                  ),
                  HtmlDescription(
                    html:
                        '<p>https://anilist.co/anime/11/Alpha/</p>'
                        '<p>https://anilist.co/anime/999/Missing-Show/</p>',
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();

      expect(batchCalls.length, 1);
      expect(batchCalls.single.length, 3);
      expect(find.text('Batched Alpha'), findsNWidgets(2));
      expect(find.text('Batched Beta'), findsOneWidget);
      expect(find.text('Missing Show'), findsOneWidget);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpWidget(
        buildSubject(
          '<p>https://anilist.co/anime/11/Alpha/</p>'
          '<p>https://anilist.co/anime/999/Missing-Show/</p>',
        ),
      );
      await tester.pump();

      expect(batchCalls.length, 1);
      expect(find.text('Batched Alpha'), findsOneWidget);
      expect(find.text('Missing Show'), findsOneWidget);
    },
  );

  testWidgets(
    'transient batch errors render fallback cards without negative-caching failed targets',
    (tester) async {
      var callCount = 0;
      var shouldThrow = true;

      HtmlAnilistLinkCard.debugBatchResolverOverride = (targets) async {
        callCount++;
        if (shouldThrow) {
          throw Exception('HTTP 429 Too Many Requests');
        }
        return {
          const AnilistRouteTarget(
            type: AnilistEntityType.anime,
            id: 55,
          ): AnilistMediaPreview(
            buildMediaFixture(
              id: 55,
              type: 'ANIME',
              title: 'Recovered Gamma',
              format: 'TV',
            ),
          ),
        };
      };

      await tester.pumpWidget(
        buildSubject('<p>https://anilist.co/anime/55/Fallback-Slug/</p>'),
      );
      await tester.pump();
      await tester.pump();

      expect(callCount, 1);
      expect(find.text('Fallback Slug'), findsOneWidget);

      shouldThrow = false;
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpWidget(
        buildSubject('<p>https://anilist.co/anime/55/Fallback-Slug/</p>'),
      );
      await tester.pump();
      await tester.pump();

      expect(callCount, 2);
      expect(find.text('Recovered Gamma'), findsOneWidget);
    },
  );
}
