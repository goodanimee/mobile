import 'dart:ffi' as ffi;
import 'dart:isolate';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';
import '../proto/medialist.pb.dart';

/// Native function signature for fetching media list
typedef _FetchMediaListC =
    ffi.Pointer<ffi.Uint8> Function(
      ffi.Int32 userId,
      ffi.Pointer<Utf8> token,
      ffi.Pointer<ffi.Int32> outLen,
    );

/// Dart function signature for fetching media list
typedef _FetchMediaListDart =
    ffi.Pointer<ffi.Uint8> Function(
      int userId,
      ffi.Pointer<Utf8> token,
      ffi.Pointer<ffi.Int32> outLen,
    );

/// Native function signature for fetching viewer profile
typedef _FetchViewerC =
    ffi.Pointer<ffi.Uint8> Function(
      ffi.Pointer<Utf8> token,
      ffi.Pointer<ffi.Int32> outLen,
    );

/// Dart function signature for fetching viewer profile
typedef _FetchViewerDart =
    ffi.Pointer<ffi.Uint8> Function(
      ffi.Pointer<Utf8> token,
      ffi.Pointer<ffi.Int32> outLen,
    );

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

/// Native function signature for saving media list entries
typedef _SaveMediaListEntryC =
    ffi.Pointer<ffi.Uint8> Function(
      ffi.Pointer<ffi.Uint8> reqPtr,
      ffi.Int32 reqLen,
      ffi.Pointer<Utf8> token,
      ffi.Pointer<ffi.Int32> outLen,
    );

/// Dart function signature for saving media list entries
typedef _SaveMediaListEntryDart =
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

/// Native function signature for freeing buffers
typedef _FreeBufferC = ffi.Void Function(ffi.Pointer<ffi.Uint8> ptr);

/// Dart function signature for freeing buffers
typedef _FreeBufferDart = void Function(ffi.Pointer<ffi.Uint8> ptr);

/// Bridges Dart to the Go-compiled native backend via C FFI
class BackendHelper {
  static late ffi.DynamicLibrary _lib;
  static late _FetchMediaListDart _fetchMediaList;
  static late _FetchViewerDart _fetchViewer;
  static late _FetchMediaDetailsDart _fetchMediaDetails;
  static late _SaveMediaListEntryDart _saveMediaListEntry;
  static late _FetchMediaCharactersDart _fetchMediaCharacters;
  static late _FetchMediaStaffDart _fetchMediaStaff;
  static late _FetchMediaRecommendationsDart _fetchMediaRecommendations;
  static late _FreeBufferDart _freeBuffer;
  static late _ToggleFavouriteAnimeDart _toggleFavouriteAnime;
  static bool _initialized = false;

  /// Loads the native backend shared library and resolves symbols
  static void init() {
    if (_initialized) return;

    _lib = ffi.DynamicLibrary.open('libbackend.so');

    _fetchMediaList = _lib
        .lookupFunction<_FetchMediaListC, _FetchMediaListDart>(
          'FetchMediaList',
        );
    _fetchViewer = _lib.lookupFunction<_FetchViewerC, _FetchViewerDart>(
      'FetchViewer',
    );
    _fetchMediaDetails = _lib
        .lookupFunction<_FetchMediaDetailsC, _FetchMediaDetailsDart>(
          'FetchMediaDetails',
        );
    _saveMediaListEntry = _lib
        .lookupFunction<_SaveMediaListEntryC, _SaveMediaListEntryDart>(
          'SaveMediaListEntry',
        );
    _fetchMediaCharacters = _lib
        .lookupFunction<_FetchMediaCharactersC, _FetchMediaCharactersDart>(
          'FetchMediaCharacters',
        );
    _fetchMediaStaff = _lib
        .lookupFunction<_FetchMediaStaffC, _FetchMediaStaffDart>(
          'FetchMediaStaff',
        );
    _fetchMediaRecommendations = _lib
        .lookupFunction<
          _FetchMediaRecommendationsC,
          _FetchMediaRecommendationsDart
        >('FetchMediaRecommendations');
    _freeBuffer = _lib.lookupFunction<_FreeBufferC, _FreeBufferDart>(
      'FreeBuffer',
    );
    _toggleFavouriteAnime = _lib
        .lookupFunction<_ToggleFavouriteAnimeC, _ToggleFavouriteAnimeDart>(
          'ToggleFavouriteAnime',
        );
    _initialized = true;
  }

  /// Executes a native call and handles buffer memory
  static Uint8List _call(
    ffi.Pointer<ffi.Uint8> Function(ffi.Pointer<ffi.Int32> outLen) fn,
  ) {
    init();
    final outLenPtr = calloc<ffi.Int32>();
    try {
      final ptr = fn(outLenPtr);
      final len = outLenPtr.value;
      if (ptr == ffi.nullptr || len == 0) {
        throw Exception('Backend returned empty response');
      }
      final bytes = Uint8List.fromList(ptr.asTypedList(len));
      _freeBuffer(ptr);
      return bytes;
    } finally {
      calloc.free(outLenPtr);
    }
  }

  /// Fetches the authenticated user's anime list
  static Future<FetchMediaListResponse> fetchMediaList(
    int userId,
    String token,
  ) async {
    return Isolate.run(() {
      init();
      final tokenPtr = token.toNativeUtf8();
      try {
        final bytes = _call(
          (outLenPtr) => _fetchMediaList(userId, tokenPtr, outLenPtr),
        );
        final response = FetchMediaListResponse.fromBuffer(bytes);
        if (response.error.isNotEmpty) throw Exception(response.error);
        return response;
      } finally {
        calloc.free(tokenPtr);
      }
    });
  }

  /// Fetches the authenticated user's profile
  static Future<FetchViewerResponse> fetchViewer(String token) async {
    return Isolate.run(() {
      init();
      final tokenPtr = token.toNativeUtf8();
      try {
        final bytes = _call((outLenPtr) => _fetchViewer(tokenPtr, outLenPtr));
        final response = FetchViewerResponse.fromBuffer(bytes);
        if (response.error.isNotEmpty) throw Exception(response.error);
        return response;
      } finally {
        calloc.free(tokenPtr);
      }
    });
  }

  /// Saves or updates an anime list entry
  static Future<SaveMediaListEntryResponse> saveMediaListEntry(
    SaveMediaListEntryRequest request,
    String token,
  ) async {
    final reqBytes = request.writeToBuffer();
    return Isolate.run(() {
      init();
      final reqPtr = calloc<ffi.Uint8>(reqBytes.length);
      final tokenPtr = token.toNativeUtf8();
      try {
        for (var i = 0; i < reqBytes.length; i++) {
          reqPtr[i] = reqBytes[i];
        }
        final bytes = _call(
          (outLenPtr) =>
              _saveMediaListEntry(reqPtr, reqBytes.length, tokenPtr, outLenPtr),
        );
        final response = SaveMediaListEntryResponse.fromBuffer(bytes);
        if (response.error.isNotEmpty) throw Exception(response.error);
        return response;
      } finally {
        calloc.free(reqPtr);
        calloc.free(tokenPtr);
      }
    });
  }

  /// Fetches full anime details by using a media ID
  static Future<FetchMediaDetailsResponse> fetchMediaDetails(
    FetchMediaDetailsRequest request,
    String token,
  ) async {
    final reqBytes = request.writeToBuffer();
    return Isolate.run(() {
      init();
      final reqPtr = calloc<ffi.Uint8>(reqBytes.length);
      final tokenPtr = token.toNativeUtf8();
      try {
        for (var i = 0; i < reqBytes.length; i++) {
          reqPtr[i] = reqBytes[i];
        }
        final bytes = _call(
          (outLenPtr) =>
              _fetchMediaDetails(reqPtr, reqBytes.length, tokenPtr, outLenPtr),
        );
        final response = FetchMediaDetailsResponse.fromBuffer(bytes);
        if (response.error.isNotEmpty) throw Exception(response.error);
        return response;
      } finally {
        calloc.free(reqPtr);
        calloc.free(tokenPtr);
      }
    });
  }

  /// Fetches media characters
  static Future<FetchMediaCharactersResponse> fetchMediaCharacters(
    FetchMediaCharactersRequest request,
    String token,
  ) async {
    final reqBytes = request.writeToBuffer();
    return Isolate.run(() {
      init();
      final reqPtr = calloc<ffi.Uint8>(reqBytes.length);
      final tokenPtr = token.toNativeUtf8();
      try {
        for (var i = 0; i < reqBytes.length; i++) {
          reqPtr[i] = reqBytes[i];
        }
        final bytes = _call(
          (outLenPtr) => _fetchMediaCharacters(
            reqPtr,
            reqBytes.length,
            tokenPtr,
            outLenPtr,
          ),
        );
        final response = FetchMediaCharactersResponse.fromBuffer(bytes);
        if (response.error.isNotEmpty) throw Exception(response.error);
        return response;
      } finally {
        calloc.free(reqPtr);
        calloc.free(tokenPtr);
      }
    });
  }

  /// Fetches media staff
  static Future<FetchMediaStaffResponse> fetchMediaStaff(
    FetchMediaStaffRequest request,
    String token,
  ) async {
    final reqBytes = request.writeToBuffer();
    return Isolate.run(() {
      init();
      final reqPtr = calloc<ffi.Uint8>(reqBytes.length);
      final tokenPtr = token.toNativeUtf8();
      try {
        for (var i = 0; i < reqBytes.length; i++) {
          reqPtr[i] = reqBytes[i];
        }
        final bytes = _call(
          (outLenPtr) =>
              _fetchMediaStaff(reqPtr, reqBytes.length, tokenPtr, outLenPtr),
        );
        final response = FetchMediaStaffResponse.fromBuffer(bytes);
        if (response.error.isNotEmpty) throw Exception(response.error);
        return response;
      } finally {
        calloc.free(reqPtr);
        calloc.free(tokenPtr);
      }
    });
  }

  /// Fetches media recommendations
  static Future<FetchMediaRecommendationsResponse> fetchMediaRecommendations(
    FetchMediaRecommendationsRequest request,
    String token,
  ) async {
    final reqBytes = request.writeToBuffer();
    return Isolate.run(() {
      init();
      final reqPtr = calloc<ffi.Uint8>(reqBytes.length);
      final tokenPtr = token.toNativeUtf8();
      try {
        for (var i = 0; i < reqBytes.length; i++) {
          reqPtr[i] = reqBytes[i];
        }
        final bytes = _call(
          (outLenPtr) => _fetchMediaRecommendations(
            reqPtr,
            reqBytes.length,
            tokenPtr,
            outLenPtr,
          ),
        );
        final response = FetchMediaRecommendationsResponse.fromBuffer(bytes);
        if (response.error.isNotEmpty) throw Exception(response.error);
        return response;
      } finally {
        calloc.free(reqPtr);
        calloc.free(tokenPtr);
      }
    });
  }

  static Future<ToggleFavouriteAnimeResponse> toggleFavouriteAnime(
    ToggleFavouriteAnimeRequest request,
    String token,
  ) async {
    final reqBytes = request.writeToBuffer();
    return Isolate.run(() {
      init();
      final reqPtr = calloc<ffi.Uint8>(reqBytes.length);
      final tokenPtr = token.toNativeUtf8();
      try {
        for (var i = 0; i < reqBytes.length; i++) {
          reqPtr[i] = reqBytes[i];
        }
        final bytes = _call(
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
