import 'package:flutter_test/flutter_test.dart';
import 'package:goodanime/models/media_misc.dart';
import 'package:goodanime/pages/search/utils/search_request_builder.dart';
import 'package:goodanime/proto/api.pb.dart';

FetchMediaSearchRequest _buildDefaultMediaRequest({
  int page = 1,
  String query = '',
  String mediaType = 'ANIME',
  String sortBy = 'search_match',
  Map<String, bool?> formats = const {},
  String? status,
  bool? onList,
  double? scoreMin,
  double? scoreMax,
  String? season,
  int? startYearMin,
  int? startYearMax,
  int? countMin,
  int? countMax,
  int? durationMin,
  int? durationMax,
  bool? isAdult,
  Map<String, bool?> genres = const {},
  Map<int, bool?> tags = const {},
  List<MediaTag> allTags = const [],
  int minTagPercentage = 18,
}) {
  return buildSearchRequest(
    page: page,
    query: query,
    mediaType: mediaType,
    sortBy: sortBy,
    formats: formats,
    status: status,
    onList: onList,
    scoreMin: scoreMin,
    scoreMax: scoreMax,
    season: season,
    startYearMin: startYearMin,
    startYearMax: startYearMax,
    countMin: countMin,
    countMax: countMax,
    durationMin: durationMin,
    durationMax: durationMax,
    isAdult: isAdult,
    genres: genres,
    tags: tags,
    allTags: allTags,
    minTagPercentage: minTagPercentage,
  );
}

/// Unit tests for search request builders across media, characters, staff, studios, and users.
void main() {
  group('buildSearchRequest (Media)', () {
    test(
      'maps count and duration sliders to episodes and duration for ANIME',
      () {
        final req = _buildDefaultMediaRequest(
          countMin: 12,
          countMax: 24,
          durationMin: 20,
          durationMax: 45,
        );

        expect(req.type, 'ANIME');
        expect(req.minEpisodes, 12);
        expect(req.maxEpisodes, 24);
        expect(req.minDuration, 20);
        expect(req.maxDuration, 45);
        expect(req.hasMinChapters(), isFalse);
        expect(req.hasMaxChapters(), isFalse);
        expect(req.hasMinVolumes(), isFalse);
        expect(req.hasMaxVolumes(), isFalse);
      },
    );

    test(
      'maps count and duration sliders to chapters and volumes for MANGA',
      () {
        final req = _buildDefaultMediaRequest(
          mediaType: 'MANGA',
          countMin: 50,
          countMax: 200,
          durationMin: 5,
          durationMax: 25,
        );

        expect(req.type, 'MANGA');
        expect(req.minChapters, 50);
        expect(req.maxChapters, 200);
        expect(req.minVolumes, 5);
        expect(req.maxVolumes, 25);
        expect(req.hasMinEpisodes(), isFalse);
        expect(req.hasMaxEpisodes(), isFalse);
        expect(req.hasMinDuration(), isFalse);
        expect(req.hasMaxDuration(), isFalse);
      },
    );

    test('maps single format, tags, status, and sort filters accurately', () {
      final req = _buildDefaultMediaRequest(
        query: 'Steins;Gate',
        sortBy: 'score_desc',
        formats: {'TV': true, 'MOVIE': false},
        status: 'FINISHED',
        onList: true,
        tags: {10: true, 20: false},
        allTags: const [
          MediaTag(
            id: 10,
            name: 'Time Travel',
            isGeneralSpoiler: false,
            isMediaSpoiler: false,
            rank: 90,
          ),
          MediaTag(
            id: 20,
            name: 'Isekai',
            isGeneralSpoiler: false,
            isMediaSpoiler: false,
            rank: 80,
          ),
        ],
        minTagPercentage: 25,
      );

      expect(req.query, 'Steins;Gate');
      expect(req.sort, ['SCORE_DESC']);
      expect(req.format, 'TV');
      expect(req.formatNot, 'MOVIE');
      expect(req.status, 'FINISHED');
      expect(req.onList, isTrue);
      expect(req.tagIn, ['Time Travel']);
      expect(req.tagNotIn, ['Isekai']);
      expect(req.minimumTagRank, 25);
    });

    test('maps multiple included and excluded formats to In/NotIn lists', () {
      final req = _buildDefaultMediaRequest(
        formats: {'TV': true, 'OVA': true, 'MOVIE': false, 'SPECIAL': false},
      );

      expect(req.formatIn, ['TV', 'OVA']);
      expect(req.formatNotIn, ['MOVIE', 'SPECIAL']);
      expect(req.hasFormat(), isFalse);
      expect(req.hasFormatNot(), isFalse);
    });

    test('handles empty search query and null filters cleanly', () {
      final req = _buildDefaultMediaRequest();

      expect(req.hasQuery(), isFalse);
      expect(req.sort, isEmpty);
      expect(req.formatIn, isEmpty);
      expect(req.formatNotIn, isEmpty);
      expect(req.hasStatus(), isFalse);
      expect(req.hasOnList(), isFalse);
      expect(req.hasMinAverageScore(), isFalse);
      expect(req.hasMaxAverageScore(), isFalse);
      expect(req.hasSeason(), isFalse);
      expect(req.hasMinStartDate(), isFalse);
      expect(req.hasMaxStartDate(), isFalse);
      expect(req.hasMinEpisodes(), isFalse);
      expect(req.hasMaxEpisodes(), isFalse);
      expect(req.hasMinDuration(), isFalse);
      expect(req.hasMaxDuration(), isFalse);
      expect(req.hasIsAdult(), isFalse);
      expect(req.genreIn, isEmpty);
      expect(req.genreNotIn, isEmpty);
      expect(req.tagIn, isEmpty);
      expect(req.tagNotIn, isEmpty);
      expect(req.hasMinimumTagRank(), isFalse);
    });

    test('maps title and trending sorts correctly', () {
      expect(_buildDefaultMediaRequest(sortBy: 'title_romaji').sort, [
        'TITLE_ROMAJI',
      ]);
      expect(_buildDefaultMediaRequest(sortBy: 'title_romaji_desc').sort, [
        'TITLE_ROMAJI_DESC',
      ]);
      expect(_buildDefaultMediaRequest(sortBy: 'episodes_desc').sort, [
        'EPISODES_DESC',
      ]);
      expect(_buildDefaultMediaRequest(sortBy: 'chapters_desc').sort, [
        'CHAPTERS_DESC',
      ]);
      expect(_buildDefaultMediaRequest(sortBy: 'popularity_desc').sort, [
        'POPULARITY_DESC',
      ]);
      expect(_buildDefaultMediaRequest(sortBy: 'trending_desc').sort, [
        'TRENDING_DESC',
      ]);
    });

    test('ignores tag entries when tag is missing in allTags', () {
      final req = _buildDefaultMediaRequest(tags: {999: true});

      expect(req.tagIn, isEmpty);
      expect(req.tagNotIn, isEmpty);
      expect(req.hasMinimumTagRank(), isFalse);
    });

    test(
      'maps score ranges, season, start dates, adult flag, and genres correctly',
      () {
        final req = _buildDefaultMediaRequest(
          scoreMin: 70.4,
          scoreMax: 94.6,
          season: 'SPRING',
          startYearMin: 2010,
          startYearMax: 2020,
          isAdult: false,
          genres: {'Sci-Fi': true, 'Thriller': true, 'Horror': false},
        );

        expect(req.minAverageScore, 70);
        expect(req.maxAverageScore, 95);
        expect(req.season, 'SPRING');
        expect(req.minStartDate, 2010);
        expect(req.maxStartDate, 2020);
        expect(req.isAdult, isFalse);
        expect(req.genreIn, ['Sci-Fi', 'Thriller']);
        expect(req.genreNotIn, ['Horror']);
      },
    );
  });

  group('Character, Staff & Studio Search Builders', () {
    test(
      'buildCharacterSearchRequest maps query, birthday filter, and sort options',
      () {
        final defaultBrowseReq = buildCharacterSearchRequest(
          page: 1,
          query: '',
          sortBy: 'search_match',
        );
        expect(defaultBrowseReq.page, 1);
        expect(defaultBrowseReq.hasQuery(), isFalse);
        expect(defaultBrowseReq.hasIsBirthday(), isFalse);
        expect(defaultBrowseReq.sort, ['FAVOURITES_DESC']);

        final querySearchReq = buildCharacterSearchRequest(
          page: 2,
          query: 'Kurisu',
          sortBy: 'search_match',
          isBirthday: true,
        );
        expect(querySearchReq.page, 2);
        expect(querySearchReq.query, 'Kurisu');
        expect(querySearchReq.isBirthday, isTrue);
        expect(querySearchReq.sort, ['SEARCH_MATCH']);
      },
    );

    test(
      'buildStaffSearchRequest maps query, birthday filter, and favourites sort',
      () {
        final staffReq = buildStaffSearchRequest(
          page: 4,
          query: 'Mamoru Miyano',
          sortBy: 'favourites_desc',
          isBirthday: false,
        );

        expect(staffReq.page, 4);
        expect(staffReq.query, 'Mamoru Miyano');
        expect(staffReq.isBirthday, isFalse);
        expect(staffReq.sort, ['FAVOURITES_DESC']);
      },
    );

    test('buildStudioSearchRequest maps studio sort options and query', () {
      final studioSearchMatch = buildStudioSearchRequest(
        page: 1,
        query: 'Kyoto Animation',
        sortBy: 'search_match',
      );
      expect(studioSearchMatch.query, 'Kyoto Animation');
      expect(studioSearchMatch.sort, isEmpty);

      final studioFavDesc = buildStudioSearchRequest(
        page: 2,
        query: '',
        sortBy: 'favourites_desc',
      );
      expect(studioFavDesc.hasQuery(), isFalse);
      expect(studioFavDesc.sort, ['FAVOURITES_DESC']);
      expect(mapStudioSortOption('name'), 'NAME');
      expect(mapStudioSortOption('name_desc'), 'NAME_DESC');
      expect(mapStudioSortOption('favourites'), 'FAVOURITES');
    });
  });

  group('User Search Builder', () {
    test('buildUserSearchRequest maps query, page, and sort options', () {
      final browseReq = buildUserSearchRequest(
        page: 1,
        query: '',
        sortBy: 'search_match',
      );
      expect(browseReq.page, 1);
      expect(browseReq.hasQuery(), isFalse);
      expect(browseReq.sort, isEmpty);

      final searchReq = buildUserSearchRequest(
        page: 2,
        query: 'TheDrone7',
        sortBy: 'search_match',
      );
      expect(searchReq.page, 2);
      expect(searchReq.query, 'TheDrone7');
      expect(searchReq.sort, ['SEARCH_MATCH']);

      final watchedTimeReq = buildUserSearchRequest(
        page: 1,
        query: '',
        sortBy: 'watched_time_desc',
      );
      expect(watchedTimeReq.sort, ['WATCHED_TIME_DESC']);

      expect(mapUserSortOption('username', hasQuery: false), 'USERNAME');
      expect(
        mapUserSortOption('username_desc', hasQuery: false),
        'USERNAME_DESC',
      );
      expect(
        mapUserSortOption('watched_time', hasQuery: false),
        'WATCHED_TIME',
      );
      expect(
        mapUserSortOption('chapters_read_desc', hasQuery: false),
        'CHAPTERS_READ_DESC',
      );
      expect(
        mapUserSortOption('chapters_read', hasQuery: false),
        'CHAPTERS_READ',
      );
      expect(mapUserSortOption('unknown', hasQuery: false), isNull);
    });
  });
}
