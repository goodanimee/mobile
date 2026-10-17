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

/// Unit tests for search request builders across media, characters, staff, and studios.
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

    test(
      'uses singular format and formatNot when exactly one format is selected',
      () {
        final req = _buildDefaultMediaRequest(
          formats: {'TV': true, 'MOVIE': false, 'OVA': null},
        );

        expect(req.format, 'TV');
        expect(req.formatIn, isEmpty);
        expect(req.formatNot, 'MOVIE');
        expect(req.formatNotIn, isEmpty);
      },
    );

    test(
      'uses formatIn and formatNotIn when multiple formats are selected',
      () {
        final req = _buildDefaultMediaRequest(
          formats: {
            'TV': true,
            'TV_SHORT': true,
            'MOVIE': false,
            'SPECIAL': false,
          },
        );

        expect(req.hasFormat(), isFalse);
        expect(req.formatIn, ['TV', 'TV_SHORT']);
        expect(req.hasFormatNot(), isFalse);
        expect(req.formatNotIn, ['MOVIE', 'SPECIAL']);
      },
    );

    test(
      'resolves tag IDs to tag names and sets minimumTagRank only when tags active',
      () {
        const catalog = [
          MediaTag(
            id: 101,
            name: 'Time Manipulation',
            isGeneralSpoiler: false,
            isMediaSpoiler: false,
            rank: 80,
          ),
          MediaTag(
            id: 202,
            name: 'Cyberpunk',
            isGeneralSpoiler: false,
            isMediaSpoiler: false,
            rank: 70,
          ),
        ];

        final reqWithTags = _buildDefaultMediaRequest(
          tags: {101: true, 202: false, 999: true},
          allTags: catalog,
          minTagPercentage: 35,
        );

        expect(reqWithTags.tagIn, ['Time Manipulation']);
        expect(reqWithTags.tagNotIn, ['Cyberpunk']);
        expect(reqWithTags.minimumTagRank, 35);

        final reqWithoutTags = _buildDefaultMediaRequest(
          allTags: catalog,
          minTagPercentage: 35,
        );

        expect(reqWithoutTags.tagIn, isEmpty);
        expect(reqWithoutTags.tagNotIn, isEmpty);
        expect(reqWithoutTags.hasMinimumTagRank(), isFalse);
      },
    );

    test(
      'populates genres, score range, years, season, status, onList, and sort',
      () {
        final req = _buildDefaultMediaRequest(
          page: 3,
          query: 'Steins;Gate',
          sortBy: 'score_desc',
          status: 'FINISHED',
          onList: true,
          scoreMin: 74.6,
          scoreMax: 95.2,
          season: 'SPRING',
          startYearMin: 2010,
          startYearMax: 2020,
          isAdult: false,
          genres: {'Sci-Fi': true, 'Thriller': true, 'Horror': false},
        );

        expect(req.page, 3);
        expect(req.query, 'Steins;Gate');
        expect(req.sort, ['SCORE_DESC']);
        expect(req.status, 'FINISHED');
        expect(req.onList, isTrue);
        expect(req.minAverageScore, 75);
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
}
