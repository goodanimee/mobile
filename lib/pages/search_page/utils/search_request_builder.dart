import '../../../models/media_misc.dart';
import '../../../proto/api.pb.dart';

/// Builds a FetchMediaSearchRequest from search and filter states.
FetchMediaSearchRequest buildSearchRequest({
  required int page,
  required String query,
  required String mediaType,
  required String sortBy,
  required Map<String, bool?> formats,
  required String? status,
  required bool? onList,
  required double? scoreMin,
  required double? scoreMax,
  required String? season,
  required int? startYearMin,
  required int? startYearMax,
  required int? countMin,
  required int? countMax,
  required int? durationMin,
  required int? durationMax,
  required bool? isAdult,
  required Map<String, bool?> genres,
  required Map<int, bool?> tags,
  required List<MediaTag> allTags,
  required int minTagPercentage,
}) {
  final req = FetchMediaSearchRequest(page: page);
  if (query.isNotEmpty) {
    req.query = query;
  }
  req.type = mediaType;

  final mappedSort = _mapSortOption(sortBy);
  if (mappedSort != null) {
    req.sort.add(mappedSort);
  }

  final includedFormats = formats.entries
      .where((e) => e.value == true)
      .map((e) => e.key)
      .toList();
  final excludedFormats = formats.entries
      .where((e) => e.value == false)
      .map((e) => e.key)
      .toList();

  if (includedFormats.length == 1) {
    req.format = includedFormats.first;
  } else if (includedFormats.length > 1) {
    req.formatIn.addAll(includedFormats);
  }

  if (excludedFormats.length == 1) {
    req.formatNot = excludedFormats.first;
  } else if (excludedFormats.length > 1) {
    req.formatNotIn.addAll(excludedFormats);
  }

  if (status != null) {
    req.status = status;
  }
  if (onList != null) {
    req.onList = onList;
  }

  if (scoreMin != null) {
    req.minAverageScore = scoreMin.round();
  }
  if (scoreMax != null) {
    req.maxAverageScore = scoreMax.round();
  }

  if (season != null) {
    req.season = season;
  }

  if (startYearMin != null) {
    req.minStartDate = startYearMin;
  }
  if (startYearMax != null) {
    req.maxStartDate = startYearMax;
  }

  if (mediaType == 'ANIME') {
    if (countMin != null) {
      req.minEpisodes = countMin;
    }
    if (countMax != null) {
      req.maxEpisodes = countMax;
    }
    if (durationMin != null) {
      req.minDuration = durationMin;
    }
    if (durationMax != null) {
      req.maxDuration = durationMax;
    }
  } else if (mediaType == 'MANGA') {
    if (countMin != null) {
      req.minChapters = countMin;
    }
    if (countMax != null) {
      req.maxChapters = countMax;
    }
    if (durationMin != null) {
      req.minVolumes = durationMin;
    }
    if (durationMax != null) {
      req.maxVolumes = durationMax;
    }
  }

  if (isAdult != null) {
    req.isAdult = isAdult;
  }

  final includedGenres = genres.entries
      .where((e) => e.value == true)
      .map((e) => e.key)
      .toList();
  final excludedGenres = genres.entries
      .where((e) => e.value == false)
      .map((e) => e.key)
      .toList();

  if (includedGenres.isNotEmpty) {
    req.genreIn.addAll(includedGenres);
  }
  if (excludedGenres.isNotEmpty) {
    req.genreNotIn.addAll(excludedGenres);
  }

  final tagInNames = <String>[];
  final tagNotInNames = <String>[];
  tags.forEach((tagId, value) {
    if (value != null) {
      final tag = allTags.firstWhere(
        (t) => t.id == tagId,
        orElse: () => const MediaTag(
          id: 0,
          name: '',
          isGeneralSpoiler: false,
          isMediaSpoiler: false,
          rank: 0,
        ),
      );
      if (tag.name.isNotEmpty) {
        if (value == true) {
          tagInNames.add(tag.name);
        } else {
          tagNotInNames.add(tag.name);
        }
      }
    }
  });

  if (tagInNames.isNotEmpty) {
    req.tagIn.addAll(tagInNames);
  }
  if (tagNotInNames.isNotEmpty) {
    req.tagNotIn.addAll(tagNotInNames);
  }

  if (tagInNames.isNotEmpty || tagNotInNames.isNotEmpty) {
    req.minimumTagRank = minTagPercentage;
  }

  return req;
}

String? _mapSortOption(String sortBy) {
  switch (sortBy) {
    case 'title_romaji':
      return 'TITLE_ROMAJI';
    case 'title_romaji_desc':
      return 'TITLE_ROMAJI_DESC';
    case 'score_desc':
      return 'SCORE_DESC';
    case 'episodes_desc':
      return 'EPISODES_DESC';
    case 'chapters_desc':
      return 'CHAPTERS_DESC';
    case 'popularity_desc':
      return 'POPULARITY_DESC';
    case 'trending_desc':
      return 'TRENDING_DESC';
    case 'search_match':
    default:
      return null;
  }
}
