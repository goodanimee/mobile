import 'dart:ffi' as ffi;
import 'dart:isolate';

import 'package:ffi/ffi.dart';

import '../models/common.dart';
import '../models/media.dart';
import '../models/media_activity.dart';
import '../models/media_character.dart';
import '../models/media_recommendation.dart';
import '../models/media_review.dart';
import '../models/media_staff.dart';
import '../proto/api.pb.dart';
import 'ffi_core.dart';

/// Native function signature for fetching media details
typedef _FetchMediaDetailsC =
    ffi.Pointer<ffi.Uint8> Function(
      ffi.Pointer<ffi.Uint8> reqPtr,
      ffi.Int32 reqLen,
      ffi.Pointer<Utf8> token,
      ffi.Pointer<ffi.Int32> outLen,
    );

/// Dart function signature for fetching media details
typedef _FetchMediaDetailsDart =
    ffi.Pointer<ffi.Uint8> Function(
      ffi.Pointer<ffi.Uint8> reqPtr,
      int reqLen,
      ffi.Pointer<Utf8> token,
      ffi.Pointer<ffi.Int32> outLen,
    );

/// Native function signature for fetching media characters
typedef _FetchMediaCharactersC =
    ffi.Pointer<ffi.Uint8> Function(
      ffi.Pointer<ffi.Uint8> reqPtr,
      ffi.Int32 reqLen,
      ffi.Pointer<Utf8> token,
      ffi.Pointer<ffi.Int32> outLen,
    );

/// Dart function signature for fetching media characters
typedef _FetchMediaCharactersDart =
    ffi.Pointer<ffi.Uint8> Function(
      ffi.Pointer<ffi.Uint8> reqPtr,
      int reqLen,
      ffi.Pointer<Utf8> token,
      ffi.Pointer<ffi.Int32> outLen,
    );

/// Native function signature for fetching media staff
typedef _FetchMediaStaffC =
    ffi.Pointer<ffi.Uint8> Function(
      ffi.Pointer<ffi.Uint8> reqPtr,
      ffi.Int32 reqLen,
      ffi.Pointer<Utf8> token,
      ffi.Pointer<ffi.Int32> outLen,
    );

/// Dart function signature for fetching media staff
typedef _FetchMediaStaffDart =
    ffi.Pointer<ffi.Uint8> Function(
      ffi.Pointer<ffi.Uint8> reqPtr,
      int reqLen,
      ffi.Pointer<Utf8> token,
      ffi.Pointer<ffi.Int32> outLen,
    );

/// Native function signature for fetching media recommendations
typedef _FetchMediaRecommendationsC =
    ffi.Pointer<ffi.Uint8> Function(
      ffi.Pointer<ffi.Uint8> reqPtr,
      ffi.Int32 reqLen,
      ffi.Pointer<Utf8> token,
      ffi.Pointer<ffi.Int32> outLen,
    );

/// Dart function signature for fetching media recommendations
typedef _FetchMediaRecommendationsDart =
    ffi.Pointer<ffi.Uint8> Function(
      ffi.Pointer<ffi.Uint8> reqPtr,
      int reqLen,
      ffi.Pointer<Utf8> token,
      ffi.Pointer<ffi.Int32> outLen,
    );

/// Native function signature for fetching media reviews
typedef _FetchMediaReviewsC =
    ffi.Pointer<ffi.Uint8> Function(
      ffi.Pointer<ffi.Uint8> reqPtr,
      ffi.Int32 reqLen,
      ffi.Pointer<Utf8> token,
      ffi.Pointer<ffi.Int32> outLen,
    );

/// Dart function signature for fetching media reviews
typedef _FetchMediaReviewsDart =
    ffi.Pointer<ffi.Uint8> Function(
      ffi.Pointer<ffi.Uint8> reqPtr,
      int reqLen,
      ffi.Pointer<Utf8> token,
      ffi.Pointer<ffi.Int32> outLen,
    );

/// Native function signature for toggling favourite anime
typedef _ToggleFavouriteAnimeC =
    ffi.Pointer<ffi.Uint8> Function(
      ffi.Pointer<ffi.Uint8> reqPtr,
      ffi.Int32 reqLen,
      ffi.Pointer<Utf8> token,
      ffi.Pointer<ffi.Int32> outLen,
    );

/// Dart function signature for toggling favourite anime
typedef _ToggleFavouriteAnimeDart =
    ffi.Pointer<ffi.Uint8> Function(
      ffi.Pointer<ffi.Uint8> reqPtr,
      int reqLen,
      ffi.Pointer<Utf8> token,
      ffi.Pointer<ffi.Int32> outLen,
    );

/// Native function signature for toggling activity like status
typedef _ToggleActivityLikeC =
    ffi.Pointer<ffi.Uint8> Function(
      ffi.Pointer<ffi.Uint8> reqPtr,
      ffi.Int32 reqLen,
      ffi.Pointer<Utf8> token,
      ffi.Pointer<ffi.Int32> outLen,
    );

/// Dart function signature for toggling activity like status
typedef _ToggleActivityLikeDart =
    ffi.Pointer<ffi.Uint8> Function(
      ffi.Pointer<ffi.Uint8> reqPtr,
      int reqLen,
      ffi.Pointer<Utf8> token,
      ffi.Pointer<ffi.Int32> outLen,
    );

/// Native function signature for rating media reviews
typedef _RateReviewC =
    ffi.Pointer<ffi.Uint8> Function(
      ffi.Pointer<ffi.Uint8> reqPtr,
      ffi.Int32 reqLen,
      ffi.Pointer<Utf8> token,
      ffi.Pointer<ffi.Int32> outLen,
    );

/// Dart function signature for rating media reviews
typedef _RateReviewDart =
    ffi.Pointer<ffi.Uint8> Function(
      ffi.Pointer<ffi.Uint8> reqPtr,
      int reqLen,
      ffi.Pointer<Utf8> token,
      ffi.Pointer<ffi.Int32> outLen,
    );

/// Native function signature for fetching media activities
typedef _FetchMediaActivitiesC =
    ffi.Pointer<ffi.Uint8> Function(
      ffi.Pointer<ffi.Uint8> reqPtr,
      ffi.Int32 reqLen,
      ffi.Pointer<Utf8> token,
      ffi.Pointer<ffi.Int32> outLen,
    );

/// Dart function signature for fetching media activities
typedef _FetchMediaActivitiesDart =
    ffi.Pointer<ffi.Uint8> Function(
      ffi.Pointer<ffi.Uint8> reqPtr,
      int reqLen,
      ffi.Pointer<Utf8> token,
      ffi.Pointer<ffi.Int32> outLen,
    );

/// API class for media-related operations
class MediaApi {
  static late _FetchMediaDetailsDart _fetchMediaDetails;
  static late _FetchMediaCharactersDart _fetchMediaCharacters;
  static late _FetchMediaStaffDart _fetchMediaStaff;
  static late _FetchMediaRecommendationsDart _fetchMediaRecommendations;
  static late _FetchMediaReviewsDart _fetchMediaReviews;
  static late _ToggleFavouriteAnimeDart _toggleFavouriteAnime;
  static late _ToggleActivityLikeDart _toggleActivityLike;
  static late _RateReviewDart _rateReview;
  static late _FetchMediaActivitiesDart _fetchMediaActivities;
  static bool _initialized = false;

  static void _init() {
    if (_initialized) return;
    FfiCore.init();
    _fetchMediaDetails = FfiCore.lib
        .lookupFunction<_FetchMediaDetailsC, _FetchMediaDetailsDart>(
          'FetchMediaDetails',
        );

    _fetchMediaCharacters = FfiCore.lib
        .lookupFunction<_FetchMediaCharactersC, _FetchMediaCharactersDart>(
          'FetchMediaCharacters',
        );
    _fetchMediaStaff = FfiCore.lib
        .lookupFunction<_FetchMediaStaffC, _FetchMediaStaffDart>(
          'FetchMediaStaff',
        );
    _fetchMediaRecommendations = FfiCore.lib
        .lookupFunction<
          _FetchMediaRecommendationsC,
          _FetchMediaRecommendationsDart
        >('FetchMediaRecommendations');
    _fetchMediaReviews = FfiCore.lib
        .lookupFunction<_FetchMediaReviewsC, _FetchMediaReviewsDart>(
          'FetchMediaReviews',
        );
    _toggleFavouriteAnime = FfiCore.lib
        .lookupFunction<_ToggleFavouriteAnimeC, _ToggleFavouriteAnimeDart>(
          'ToggleFavouriteAnime',
        );
    _toggleActivityLike = FfiCore.lib
        .lookupFunction<_ToggleActivityLikeC, _ToggleActivityLikeDart>(
          'ToggleActivityLike',
        );
    _rateReview = FfiCore.lib
        .lookupFunction<_RateReviewC, _RateReviewDart>(
          'RateReview',
        );
    _fetchMediaActivities = FfiCore.lib
        .lookupFunction<_FetchMediaActivitiesC, _FetchMediaActivitiesDart>(
          'FetchMediaActivities',
        );
    _initialized = true;
  }


  /// Fetches full anime details by using a media ID
  static Future<Media> fetchMediaDetails(
    FetchMediaDetailsRequest request,
    String token,
  ) async {
    final reqBytes = request.writeToBuffer();
    return Isolate.run(() {
      _init();
      final reqPtr = calloc<ffi.Uint8>(reqBytes.length);
      final tokenPtr = token.toNativeUtf8();
      try {
        for (var i = 0; i < reqBytes.length; i++) {
          reqPtr[i] = reqBytes[i];
        }
        final bytes = FfiCore.executeNativeCall(
          (outLenPtr) =>
              _fetchMediaDetails(reqPtr, reqBytes.length, tokenPtr, outLenPtr),
        );
        final response = FetchMediaDetailsResponse.fromBuffer(bytes);
        if (response.error.isNotEmpty) throw Exception(response.error);
        return Media.fromProto(response.media);
      } finally {
        calloc.free(reqPtr);
        calloc.free(tokenPtr);
      }
    });
  }

  /// Fetches media characters
  static Future<CharacterConnection> fetchMediaCharacters(
    FetchMediaCharactersRequest request,
    String token,
  ) async {
    final reqBytes = request.writeToBuffer();
    return Isolate.run(() {
      _init();
      final reqPtr = calloc<ffi.Uint8>(reqBytes.length);
      final tokenPtr = token.toNativeUtf8();
      try {
        for (var i = 0; i < reqBytes.length; i++) {
          reqPtr[i] = reqBytes[i];
        }
        final bytes = FfiCore.executeNativeCall(
          (outLenPtr) => _fetchMediaCharacters(
            reqPtr,
            reqBytes.length,
            tokenPtr,
            outLenPtr,
          ),
        );
        final response = FetchMediaCharactersResponse.fromBuffer(bytes);
        if (response.error.isNotEmpty) throw Exception(response.error);
        return CharacterConnection.fromProto(response.media.characters);
      } finally {
        calloc.free(reqPtr);
        calloc.free(tokenPtr);
      }
    });
  }

  /// Fetches media staff
  static Future<StaffConnection> fetchMediaStaff(
    FetchMediaStaffRequest request,
    String token,
  ) async {
    final reqBytes = request.writeToBuffer();
    return Isolate.run(() {
      _init();
      final reqPtr = calloc<ffi.Uint8>(reqBytes.length);
      final tokenPtr = token.toNativeUtf8();
      try {
        for (var i = 0; i < reqBytes.length; i++) {
          reqPtr[i] = reqBytes[i];
        }
        final bytes = FfiCore.executeNativeCall(
          (outLenPtr) =>
              _fetchMediaStaff(reqPtr, reqBytes.length, tokenPtr, outLenPtr),
        );
        final response = FetchMediaStaffResponse.fromBuffer(bytes);
        if (response.error.isNotEmpty) throw Exception(response.error);
        return StaffConnection.fromProto(response.media.staff);
      } finally {
        calloc.free(reqPtr);
        calloc.free(tokenPtr);
      }
    });
  }

  /// Fetches media recommendations
  static Future<RecommendationConnection> fetchMediaRecommendations(
    FetchMediaRecommendationsRequest request,
    String token,
  ) async {
    final reqBytes = request.writeToBuffer();
    return Isolate.run(() {
      _init();
      final reqPtr = calloc<ffi.Uint8>(reqBytes.length);
      final tokenPtr = token.toNativeUtf8();
      try {
        for (var i = 0; i < reqBytes.length; i++) {
          reqPtr[i] = reqBytes[i];
        }
        final bytes = FfiCore.executeNativeCall(
          (outLenPtr) => _fetchMediaRecommendations(
            reqPtr,
            reqBytes.length,
            tokenPtr,
            outLenPtr,
          ),
        );
        final response = FetchMediaRecommendationsResponse.fromBuffer(bytes);
        if (response.error.isNotEmpty) throw Exception(response.error);
        return RecommendationConnection.fromProto(
          response.media.recommendations,
        );
      } finally {
        calloc.free(reqPtr);
        calloc.free(tokenPtr);
      }
    });
  }

  /// Fetches media reviews
  static Future<ReviewConnection> fetchMediaReviews(
    FetchMediaReviewsRequest request,
    String token,
  ) async {
    final reqBytes = request.writeToBuffer();
    return Isolate.run(() {
      _init();
      final reqPtr = calloc<ffi.Uint8>(reqBytes.length);
      final tokenPtr = token.toNativeUtf8();
      try {
        for (var i = 0; i < reqBytes.length; i++) {
          reqPtr[i] = reqBytes[i];
        }
        final bytes = FfiCore.executeNativeCall(
          (outLenPtr) =>
              _fetchMediaReviews(reqPtr, reqBytes.length, tokenPtr, outLenPtr),
        );
        final response = FetchMediaReviewsResponse.fromBuffer(bytes);
        if (response.error.isNotEmpty) throw Exception(response.error);
        return ReviewConnection.fromProto(response.media.reviews);
      } finally {
        calloc.free(reqPtr);
        calloc.free(tokenPtr);
      }
    });
  }

  /// Toggles the favourite status of an anime
  static Future<ToggleFavouriteAnimeResponse> toggleFavouriteAnime(
    ToggleFavouriteAnimeRequest request,
    String token,
  ) async {
    final reqBytes = request.writeToBuffer();
    return Isolate.run(() {
      _init();
      final reqPtr = calloc<ffi.Uint8>(reqBytes.length);
      final tokenPtr = token.toNativeUtf8();
      try {
        for (var i = 0; i < reqBytes.length; i++) {
          reqPtr[i] = reqBytes[i];
        }
        final bytes = FfiCore.executeNativeCall(
          (outLenPtr) => _toggleFavouriteAnime(
            reqPtr,
            reqBytes.length,
            tokenPtr,
            outLenPtr,
          ),
        );
        final response = ToggleFavouriteAnimeResponse.fromBuffer(bytes);
        if (response.error.isNotEmpty) throw Exception(response.error);
        return response;
      } finally {
        calloc.free(reqPtr);
        calloc.free(tokenPtr);
      }
    });
  }

  /// Toggles the like status of an activity
  static Future<ToggleActivityLikeResponse> toggleActivityLike(
    ToggleActivityLikeRequest request,
    String token,
  ) async {
    final reqBytes = request.writeToBuffer();
    return Isolate.run(() {
      _init();
      final reqPtr = calloc<ffi.Uint8>(reqBytes.length);
      final tokenPtr = token.toNativeUtf8();
      try {
        for (var i = 0; i < reqBytes.length; i++) {
          reqPtr[i] = reqBytes[i];
        }
        final bytes = FfiCore.executeNativeCall(
          (outLenPtr) => _toggleActivityLike(
            reqPtr,
            reqBytes.length,
            tokenPtr,
            outLenPtr,
          ),
        );
        final response = ToggleActivityLikeResponse.fromBuffer(bytes);
        if (response.error.isNotEmpty) throw Exception(response.error);
        return response;
      } finally {
        calloc.free(reqPtr);
        calloc.free(tokenPtr);
      }
    });
  }

  /// Rates a media review.
  static Future<ReviewNode> rateReview(
    RateReviewRequest request,
    String token,
  ) async {
    final reqBytes = request.writeToBuffer();
    return Isolate.run(() {
      _init();
      final reqPtr = calloc<ffi.Uint8>(reqBytes.length);
      final tokenPtr = token.toNativeUtf8();
      try {
        for (var i = 0; i < reqBytes.length; i++) {
          reqPtr[i] = reqBytes[i];
        }
        final bytes = FfiCore.executeNativeCall(
          (outLenPtr) =>
              _rateReview(reqPtr, reqBytes.length, tokenPtr, outLenPtr),
        );
        final response = RateReviewResponse.fromBuffer(bytes);
        if (response.error.isNotEmpty) throw Exception(response.error);
        return ReviewNode.fromProto(response.review);
      } finally {
        calloc.free(reqPtr);
        calloc.free(tokenPtr);
      }
    });
  }

  /// Fetches paginated recent activities for a media ID.
  static Future<ListActivityConnection> fetchMediaActivities(
    FetchMediaActivitiesRequest request,
    String token,
  ) async {
    final reqBytes = request.writeToBuffer();
    return Isolate.run(() {
      _init();
      final reqPtr = calloc<ffi.Uint8>(reqBytes.length);
      final tokenPtr = token.toNativeUtf8();
      try {
        for (var i = 0; i < reqBytes.length; i++) {
          reqPtr[i] = reqBytes[i];
        }
        final bytes = FfiCore.executeNativeCall(
          (outLenPtr) => _fetchMediaActivities(
            reqPtr,
            reqBytes.length,
            tokenPtr,
            outLenPtr,
          ),
        );
        final response = FetchMediaActivitiesResponse.fromBuffer(bytes);
        if (response.error.isNotEmpty) throw Exception(response.error);
        return ListActivityConnection(
          pageInfo: PageInfo.fromProto(response.pageInfo),
          nodes: response.activities.map(ListActivity.fromProto).toList(),
        );
      } finally {
        calloc.free(reqPtr);
        calloc.free(tokenPtr);
      }
    });
  }
}

