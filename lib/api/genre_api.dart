import 'dart:ffi' as ffi;
import 'dart:isolate';

import 'package:ffi/ffi.dart';

import '../models/media_misc.dart';
import '../proto/api.pb.dart';
import 'ffi_core.dart';

/// Native function signature for fetching genres
typedef _FetchGenresC =
    ffi.Pointer<ffi.Uint8> Function(ffi.Pointer<Utf8>, ffi.Pointer<ffi.Int32>);

/// Dart function signature for fetching genres
typedef _FetchGenresDart =
    ffi.Pointer<ffi.Uint8> Function(ffi.Pointer<Utf8>, ffi.Pointer<ffi.Int32>);

/// Native function signature for fetching tags
typedef _FetchTagsC =
    ffi.Pointer<ffi.Uint8> Function(ffi.Pointer<Utf8>, ffi.Pointer<ffi.Int32>);

/// Dart function signature for fetching tags
typedef _FetchTagsDart =
    ffi.Pointer<ffi.Uint8> Function(ffi.Pointer<Utf8>, ffi.Pointer<ffi.Int32>);

/// API class for genre and tag-related operations
class GenreApi {
  static late _FetchGenresDart _fetchGenres;
  static late _FetchTagsDart _fetchTags;
  static bool _initialized = false;

  static void _init() {
    if (_initialized) return;
    FfiCore.init();
    _fetchGenres = FfiCore.lib.lookupFunction<_FetchGenresC, _FetchGenresDart>(
      'FetchGenres',
    );
    _fetchTags = FfiCore.lib.lookupFunction<_FetchTagsC, _FetchTagsDart>(
      'FetchTags',
    );
    _initialized = true;
  }

  /// Fetches the list of all genres
  static Future<List<String>> fetchGenres(String token) async {
    return Isolate.run(() {
      _init();
      final tokenPtr = token.toNativeUtf8();
      try {
        final bytes = FfiCore.executeNativeCall(
          (outLenPtr) => _fetchGenres(tokenPtr, outLenPtr),
        );
        final response = FetchGenresResponse.fromBuffer(bytes);
        if (response.error.isNotEmpty) {
          throw Exception('Error fetching genres: ${response.error}');
        }
        return response.genres;
      } finally {
        calloc.free(tokenPtr);
      }
    });
  }

  /// Fetches the list of all media tags
  static Future<List<MediaTag>> fetchTags(String token) async {
    return Isolate.run(() {
      _init();
      final tokenPtr = token.toNativeUtf8();
      try {
        final bytes = FfiCore.executeNativeCall(
          (outLenPtr) => _fetchTags(tokenPtr, outLenPtr),
        );
        final response = FetchTagsResponse.fromBuffer(bytes);
        if (response.error.isNotEmpty) {
          throw Exception('Error fetching tags: ${response.error}');
        }
        return response.tags.map(MediaTag.fromProto).toList();
      } finally {
        calloc.free(tokenPtr);
      }
    });
  }
}
