import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';
import 'dart:isolate';
import '../proto/medialist.pb.dart';
import 'ffi_core.dart';

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

/// API class for media list operations
class MediaListApi {
  static late _FetchMediaListDart _fetchMediaList;
  static late _SaveMediaListEntryDart _saveMediaListEntry;
  static bool _initialized = false;

  static void _init() {
    if (_initialized) return;
    FfiCore.init();
    _fetchMediaList = FfiCore.lib
        .lookupFunction<_FetchMediaListC, _FetchMediaListDart>(
          'FetchMediaList',
        );
    _saveMediaListEntry = FfiCore.lib
        .lookupFunction<_SaveMediaListEntryC, _SaveMediaListEntryDart>(
          'SaveMediaListEntry',
        );
    _initialized = true;
  }

  /// Fetches the media list for a given user ID and authentication token.
  static Future<FetchMediaListResponse> fetchMediaList(
    int userId,
    String token,
  ) async {
    return Isolate.run(() {
      _init();
      final tokenPtr = token.toNativeUtf8();
      try {
        final bytes = FfiCore.executeNativeCall(
          (outLenPtr) => _fetchMediaList(userId, tokenPtr, outLenPtr),
        );
        final response = FetchMediaListResponse.fromBuffer(bytes);
        if (response.error.isNotEmpty) {
          throw Exception('Error fetching viewer: ${response.error}');
        }
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
      _init();
      final reqPtr = calloc<ffi.Uint8>(reqBytes.length);
      final tokenPtr = token.toNativeUtf8();
      try {
        for (var i = 0; i < reqBytes.length; i++) {
          reqPtr[i] = reqBytes[i];
        }
        final bytes = FfiCore.executeNativeCall(
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
}
