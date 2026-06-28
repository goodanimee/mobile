import 'dart:ffi' as ffi;
import 'dart:isolate';

import 'package:ffi/ffi.dart';

import '../proto/api.pb.dart';
import 'ffi_core.dart';

typedef _FetchMediaSearchC =
    ffi.Pointer<ffi.Uint8> Function(
      ffi.Pointer<ffi.Uint8> reqPtr,
      ffi.Int32 reqLen,
      ffi.Pointer<Utf8> token,
      ffi.Pointer<ffi.Int32> outLen,
    );

typedef _FetchMediaSearchDart =
    ffi.Pointer<ffi.Uint8> Function(
      ffi.Pointer<ffi.Uint8> reqPtr,
      int reqLen,
      ffi.Pointer<Utf8> token,
      ffi.Pointer<ffi.Int32> outLen,
    );

typedef _FetchStudioSearchC =
    ffi.Pointer<ffi.Uint8> Function(
      ffi.Pointer<ffi.Uint8> reqPtr,
      ffi.Int32 reqLen,
      ffi.Pointer<Utf8> token,
      ffi.Pointer<ffi.Int32> outLen,
    );

typedef _FetchStudioSearchDart =
    ffi.Pointer<ffi.Uint8> Function(
      ffi.Pointer<ffi.Uint8> reqPtr,
      int reqLen,
      ffi.Pointer<Utf8> token,
      ffi.Pointer<ffi.Int32> outLen,
    );

/// API class for media search operations using native FFI bindings.
class SearchApi {
  static late _FetchMediaSearchDart _fetchMediaSearch;
  static late _FetchStudioSearchDart _fetchStudioSearch;
  static bool _initialized = false;

  static void _init() {
    if (_initialized) return;
    FfiCore.init();
    _fetchMediaSearch = FfiCore.lib
        .lookupFunction<_FetchMediaSearchC, _FetchMediaSearchDart>(
          'FetchMediaSearch',
        );
    _fetchStudioSearch = FfiCore.lib
        .lookupFunction<_FetchStudioSearchC, _FetchStudioSearchDart>(
          'FetchStudioSearch',
        );
    _initialized = true;
  }

  /// Searches for media on AniList using native FFI.
  static Future<FetchMediaSearchResponse> fetchMediaSearch(
    FetchMediaSearchRequest request,
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
              _fetchMediaSearch(reqPtr, reqBytes.length, tokenPtr, outLenPtr),
        );
        final response = FetchMediaSearchResponse.fromBuffer(bytes);
        if (response.error.isNotEmpty) {
          throw Exception(response.error);
        }
        return response;
      } finally {
        calloc.free(reqPtr);
        calloc.free(tokenPtr);
      }
    });
  }

  /// Searches for studios on AniList using native FFI.
  static Future<FetchStudioSearchResponse> fetchStudioSearch(
    FetchStudioSearchRequest request,
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
              _fetchStudioSearch(reqPtr, reqBytes.length, tokenPtr, outLenPtr),
        );
        final response = FetchStudioSearchResponse.fromBuffer(bytes);
        if (response.error.isNotEmpty) {
          throw Exception(response.error);
        }
        return response;
      } finally {
        calloc.free(reqPtr);
        calloc.free(tokenPtr);
      }
    });
  }
}
