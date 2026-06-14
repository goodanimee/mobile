import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../api/media_details_api.dart';
import '../models/media.dart';
import '../models/media_activity.dart';
import '../models/media_character.dart';
import '../models/media_recommendation.dart';
import '../models/media_review.dart';
import '../models/media_staff.dart';
import '../models/media_studio.dart';
import '../proto/api.pb.dart';
import '../proto/media.pb.dart' as pb_media;
import '../proto/media_review.pb.dart' as pb_review;
import '../utils/utils.dart';
import 'auth_service.dart';

/// Service for managing media details and favorites.
class MediaService {
  static const String _cachePrefix = 'media_cache_';
  static const String _cacheKeysPref = 'media_cache_keys';
  static const int _cacheCapacity = 50;

  /// Fetches media details from cache or network.
  static Future<Media?> getMediaDetails(
    int mediaId, {
    bool forceRefresh = false,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    if (!forceRefresh) {
      final cachedMedia = await _getFromDiskCache(prefs, mediaId);
      if (cachedMedia != null) return cachedMedia;
    } else {
      await prefs.remove('$_cachePrefix$mediaId');
    }

    final token = await AuthService.getRawToken() ?? '';
    final req = FetchMediaDetailsRequest(mediaId: mediaId);
    final media = await MediaApi.fetchMediaDetails(req, token);

    final rawData = base64Encode(media.toProto().writeToBuffer());
    await _saveToDiskCache(prefs, mediaId, rawData);
    return media;
  }

  /// Toggles the favorite status of an anime.
  static Future<void> toggleFavouriteAnime(
    int mediaId,
    Media currentMedia,
  ) async {
    final token = await AuthService.getRawToken() ?? '';
    final req = ToggleFavouriteAnimeRequest()..animeId = mediaId;

    await MediaApi.toggleFavouriteAnime(req, token);

    final updatedMedia = currentMedia.copyWith(
      isFavourite: !currentMedia.isFavourite,
    );

    final prefs = await SharedPreferences.getInstance();
    await _saveToDiskCache(
      prefs,
      mediaId,
      base64Encode(updatedMedia.toProto().writeToBuffer()),
    );

    await CacheUtils.invalidateMedia(mediaId);
    CacheUtils.animeListNeedsRefresh.value = true;
  }

  /// Toggles the favorite status of a manga.
  static Future<void> toggleFavouriteManga(
    int mediaId,
    Media currentMedia,
  ) async {
    final token = await AuthService.getRawToken() ?? '';
    final req = ToggleFavouriteMangaRequest()..mangaId = mediaId;

    await MediaApi.toggleFavouriteManga(req, token);

    final updatedMedia = currentMedia.copyWith(
      isFavourite: !currentMedia.isFavourite,
    );

    final prefs = await SharedPreferences.getInstance();
    await _saveToDiskCache(
      prefs,
      mediaId,
      base64Encode(updatedMedia.toProto().writeToBuffer()),
    );

    await CacheUtils.invalidateMedia(mediaId);
    CacheUtils.mangaListNeedsRefresh.value = true;
  }

  /// Toggles the like status of an activity.
  static Future<ToggleActivityLikeResponse> toggleActivityLike(
    int activityId,
  ) async {
    final token = await AuthService.getRawToken() ?? '';
    final req = ToggleActivityLikeRequest()..activityId = activityId;
    return MediaApi.toggleActivityLike(req, token);
  }

  /// Fetches character pagination results for a media.
  static Future<CharacterConnection> getCharacters(
    int mediaId,
    int page,
  ) async {
    final token = await AuthService.getRawToken() ?? '';
    final req = FetchMediaCharactersRequest(
      mediaId: mediaId,
      page: page,
      perPage: 25,
    );
    return MediaApi.fetchMediaCharacters(req, token);
  }

  /// Fetches staff pagination results for a media.
  static Future<StaffConnection> getStaff(int mediaId, int page) async {
    final token = await AuthService.getRawToken() ?? '';
    final req = FetchMediaStaffRequest(
      mediaId: mediaId,
      page: page,
      perPage: 25,
    );
    return MediaApi.fetchMediaStaff(req, token);
  }

  /// Fetches recommendation pagination results for a media.
  static Future<RecommendationConnection> getRecommendations(
    int mediaId,
    int page,
  ) async {
    final token = await AuthService.getRawToken() ?? '';
    final req = FetchMediaRecommendationsRequest(
      mediaId: mediaId,
      page: page,
      perPage: 25,
    );
    return MediaApi.fetchMediaRecommendations(req, token);
  }

  /// Fetches reviews pagination results for a media.
  static Future<ReviewConnection> getReviews(int mediaId, int page) async {
    final token = await AuthService.getRawToken() ?? '';
    final req = FetchMediaReviewsRequest(
      mediaId: mediaId,
      page: page,
      perPage: 25,
    );
    return MediaApi.fetchMediaReviews(req, token);
  }

  /// Rates a review on AniList.
  static Future<ReviewNode> rateReview(
    int reviewId,
    ReviewUserRating rating,
  ) async {
    final token = await AuthService.getRawToken() ?? '';
    pb_review.ReviewUserRating protoRating;
    switch (rating) {
      case ReviewUserRating.upVote:
        protoRating = pb_review.ReviewUserRating.REVIEW_USER_RATING_UP_VOTE;
        break;
      case ReviewUserRating.downVote:
        protoRating = pb_review.ReviewUserRating.REVIEW_USER_RATING_DOWN_VOTE;
        break;
      case ReviewUserRating.noVote:
        protoRating =
            pb_review.ReviewUserRating.REVIEW_USER_RATING_NO_VOTE_UNSPECIFIED;
        break;
    }
    final req = RateReviewRequest(reviewId: reviewId, rating: protoRating);
    return MediaApi.rateReview(req, token);
  }

  /// Fetches media activities pagination results.
  static Future<ListActivityConnection> getActivities(
    int mediaId,
    int page,
  ) async {
    final token = await AuthService.getRawToken() ?? '';
    final req = FetchMediaActivitiesRequest(
      mediaId: mediaId,
      page: page,
      perPage: 25,
    );
    return MediaApi.fetchMediaActivities(req, token);
  }

  /// Fetches details of a studio by its ID.
  static Future<Studio> getStudio(int studioId, int page) async {
    final token = await AuthService.getRawToken() ?? '';
    final req = FetchStudioDetailsRequest(studioId: studioId, page: page);
    return MediaApi.fetchStudioDetails(req, token);
  }

  /// Toggles the favorite status of a studio.
  static Future<void> toggleFavouriteStudio(int studioId) async {
    final token = await AuthService.getRawToken() ?? '';
    final req = ToggleFavouriteStudioRequest()..studioId = studioId;
    await MediaApi.toggleFavouriteStudio(req, token);
  }

  static Future<void> _saveToDiskCache(
    SharedPreferences prefs,
    int mediaId,
    String rawData,
  ) async {
    final List<String> keys = prefs.getStringList(_cacheKeysPref) ?? [];
    final idStr = mediaId.toString();
    keys.remove(idStr);
    keys.add(idStr);

    if (keys.length > _cacheCapacity) {
      final oldestKey = keys.removeAt(0);
      await prefs.remove('$_cachePrefix$oldestKey');
    }

    await prefs.setStringList(_cacheKeysPref, keys);
    await prefs.setString('$_cachePrefix$idStr', rawData);
  }

  static Future<Media?> _getFromDiskCache(
    SharedPreferences prefs,
    int mediaId,
  ) async {
    final cachedStr = prefs.getString('$_cachePrefix$mediaId');
    if (cachedStr == null) return null;

    final List<String> keys = prefs.getStringList(_cacheKeysPref) ?? [];
    keys.remove(mediaId.toString());
    keys.add(mediaId.toString());
    await prefs.setStringList(_cacheKeysPref, keys);

    try {
      return Media.fromProto(
        pb_media.Media.fromBuffer(base64Decode(cachedStr)),
      );
    } catch (_) {
      return null;
    }
  }
}
