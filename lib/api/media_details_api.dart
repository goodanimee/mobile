import 'dart:ffi' as ffi;
import 'dart:isolate';

import 'package:ffi/ffi.dart';

import '../models/media.dart';
import '../models/media_character.dart';
import '../models/media_recommendation.dart';
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

/// API class for media-related operations
class MediaApi {
  static late _FetchMediaDetailsDart _fetchMediaDetails;
  static late _FetchMediaCharactersDart _fetchMediaCharacters;
  static late _FetchMediaStaffDart _fetchMediaStaff;
  static late _FetchMediaRecommendationsDart _fetchMediaRecommendations;
  static late _ToggleFavouriteAnimeDart _toggleFavouriteAnime;
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
    _toggleFavouriteAnime = FfiCore.lib
        .lookupFunction<_ToggleFavouriteAnimeC, _ToggleFavouriteAnimeDart>(
          'ToggleFavouriteAnime',
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
}
