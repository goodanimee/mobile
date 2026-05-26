import 'dart:ffi' as ffi;
import 'dart:isolate';

import 'package:ffi/ffi.dart';

import '../models/media_list.dart';
import '../models/media_list_entry.dart';
import '../proto/api.pb.dart';
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

/// Native function signature for deleting media list entries
typedef _DeleteMediaListEntryC =
    ffi.Pointer<ffi.Uint8> Function(
      ffi.Pointer<ffi.Uint8> reqPtr,
      ffi.Int32 reqLen,
      ffi.Pointer<Utf8> token,
      ffi.Pointer<ffi.Int32> outLen,
    );

/// Dart function signature for deleting media list entries
typedef _DeleteMediaListEntryDart =
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
  static late _DeleteMediaListEntryDart _deleteMediaListEntry;
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
    _deleteMediaListEntry = FfiCore.lib
        .lookupFunction<_DeleteMediaListEntryC, _DeleteMediaListEntryDart>(
          'DeleteMediaListEntry',
        );
    _initialized = true;
  }

  /// Fetches the media list for a given user ID and authentication token.
  static Future<MediaListCollection> fetchMediaList(
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
          throw Exception('Error fetching media list: ${response.error}');
        }
        return MediaListCollection.fromProto(response.collection);
      } finally {
        calloc.free(tokenPtr);
      }
    });
  }

  /// Saves or updates a media list entry
  static Future<MediaListEntry> saveMediaListEntry(
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
        return MediaListEntry.fromProto(response.entry);
      } finally {
        calloc.free(reqPtr);
        calloc.free(tokenPtr);
      }
    });
  }

  /// Deletes a media list entry
  static Future<DeleteMediaListEntryResponse> deleteMediaListEntry(
    DeleteMediaListEntryRequest request,
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
          (outLenPtr) => _deleteMediaListEntry(
            reqPtr,
            reqBytes.length,
            tokenPtr,
            outLenPtr,
          ),
        );
        final response = DeleteMediaListEntryResponse.fromBuffer(bytes);
        if (response.error.isNotEmpty) throw Exception(response.error);
        return response;
      } finally {
        calloc.free(reqPtr);
        calloc.free(tokenPtr);
      }
    });
  }
}
