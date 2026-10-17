import 'package:flutter_test/flutter_test.dart';
import 'package:goodanime/utils/anilist_url_parser.dart';

/// Unit tests for [AnilistUrlParser] and [AnilistRouteTarget].
void main() {
  group('AnilistUrlParser.parse', () {
    test(
      'parses standard entity URLs across anime, manga, character, staff, and studio',
      () {
        expect(
          AnilistUrlParser.parse('https://anilist.co/anime/21'),
          const AnilistRouteTarget(type: AnilistEntityType.anime, id: 21),
        );
        expect(
          AnilistUrlParser.parse('https://anilist.co/manga/30013'),
          const AnilistRouteTarget(type: AnilistEntityType.manga, id: 30013),
        );
        expect(
          AnilistUrlParser.parse('https://anilist.co/character/40'),
          const AnilistRouteTarget(type: AnilistEntityType.character, id: 40),
        );
        expect(
          AnilistUrlParser.parse('https://anilist.co/staff/95065'),
          const AnilistRouteTarget(type: AnilistEntityType.staff, id: 95065),
        );
        expect(
          AnilistUrlParser.parse('https://anilist.co/studio/2'),
          const AnilistRouteTarget(type: AnilistEntityType.studio, id: 2),
        );
      },
    );

    test(
      'parses URLs with trailing slugs, subpaths, query params, and fragments',
      () {
        expect(
          AnilistUrlParser.parse(
            'https://anilist.co/anime/9253/SteinsGate/characters?sort=role#top',
          ),
          const AnilistRouteTarget(type: AnilistEntityType.anime, id: 9253),
        );
        expect(
          AnilistUrlParser.parse(
            'http://www.anilist.co/character/34470/Kurisu-Makise/',
          ),
          const AnilistRouteTarget(
            type: AnilistEntityType.character,
            id: 34470,
          ),
        );
      },
    );

    test('parses scheme-less anilist.co and www.anilist.co URLs', () {
      expect(
        AnilistUrlParser.parse('anilist.co/manga/105778/Chainsaw-Man'),
        const AnilistRouteTarget(type: AnilistEntityType.manga, id: 105778),
      );
      expect(
        AnilistUrlParser.parse('  www.anilist.co/staff/118173  '),
        const AnilistRouteTarget(type: AnilistEntityType.staff, id: 118173),
      );
    });

    test('handles relative paths only when allowRelative is true', () {
      expect(AnilistUrlParser.parse('/anime/21/One-Piece'), isNull);
      expect(
        AnilistUrlParser.parse('/anime/21/One-Piece', allowRelative: true),
        const AnilistRouteTarget(type: AnilistEntityType.anime, id: 21),
      );
      expect(
        AnilistUrlParser.parse('/character/40', allowRelative: true),
        const AnilistRouteTarget(type: AnilistEntityType.character, id: 40),
      );
    });

    test(
      'returns null for unsupported paths, non-positive IDs, and external hosts',
      () {
        expect(AnilistUrlParser.parse(''), isNull);
        expect(AnilistUrlParser.parse('   '), isNull);
        expect(
          AnilistUrlParser.parse('https://anilist.co/user/thedrone7'),
          isNull,
        );
        expect(
          AnilistUrlParser.parse('https://anilist.co/forum/thread/123'),
          isNull,
        );
        expect(AnilistUrlParser.parse('https://anilist.co/anime'), isNull);
        expect(AnilistUrlParser.parse('https://anilist.co/anime/0'), isNull);
        expect(AnilistUrlParser.parse('https://anilist.co/anime/-15'), isNull);
        expect(
          AnilistUrlParser.parse('https://anilist.co/anime/not-an-id'),
          isNull,
        );
        expect(
          AnilistUrlParser.parse('https://myanimelist.net/anime/21'),
          isNull,
        );
        expect(AnilistUrlParser.parse('ftp://anilist.co/anime/21'), isNull);
      },
    );
  });

  group('AnilistUrlParser.isAnilistEntityPath', () {
    test(
      'identifies entity path prefixes even when ID segment is invalid or missing',
      () {
        expect(
          AnilistUrlParser.isAnilistEntityPath('https://anilist.co/anime/21'),
          isTrue,
        );
        expect(
          AnilistUrlParser.isAnilistEntityPath('https://anilist.co/anime/abc'),
          isTrue,
        );
        expect(
          AnilistUrlParser.isAnilistEntityPath(
            '/manga/invalid',
            allowRelative: true,
          ),
          isTrue,
        );
        expect(
          AnilistUrlParser.isAnilistEntityPath('https://anilist.co/user/test'),
          isFalse,
        );
        expect(
          AnilistUrlParser.isAnilistEntityPath('https://example.com/anime/21'),
          isFalse,
        );
      },
    );
  });
}
