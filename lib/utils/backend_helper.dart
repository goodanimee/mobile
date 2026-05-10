import 'dart:ffi' as ffi;
import 'dart:isolate';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';
import '../proto/medialist.pb.dart';

typedef _FetchMediaListC =
    ffi.Pointer<ffi.Uint8> Function(
      ffi.Int32 userId,
      ffi.Pointer<Utf8> token,
      ffi.Pointer<ffi.Int32> outLen,
    );
typedef _FetchMediaListDart =
    ffi.Pointer<ffi.Uint8> Function(
      int userId,
      ffi.Pointer<Utf8> token,
      ffi.Pointer<ffi.Int32> outLen,
    );

typedef _FetchViewerC =
    ffi.Pointer<ffi.Uint8> Function(
      ffi.Pointer<Utf8> token,
      ffi.Pointer<ffi.Int32> outLen,
    );
typedef _FetchViewerDart =
    ffi.Pointer<ffi.Uint8> Function(
      ffi.Pointer<Utf8> token,
      ffi.Pointer<ffi.Int32> outLen,
    );

typedef _FetchMediaDetailsC =
    ffi.Pointer<ffi.Uint8> Function(
      ffi.Pointer<ffi.Uint8> reqPtr,
      ffi.Int32 reqLen,
      ffi.Pointer<Utf8> token,
      ffi.Pointer<ffi.Int32> outLen,
    );
typedef _FetchMediaDetailsDart =
    ffi.Pointer<ffi.Uint8> Function(
      ffi.Pointer<ffi.Uint8> reqPtr,
      int reqLen,
      ffi.Pointer<Utf8> token,
      ffi.Pointer<ffi.Int32> outLen,
    );

typedef _SaveMediaListEntryC =
    ffi.Pointer<ffi.Uint8> Function(
      ffi.Pointer<ffi.Uint8> reqPtr,
      ffi.Int32 reqLen,
      ffi.Pointer<Utf8> token,
      ffi.Pointer<ffi.Int32> outLen,
    );
typedef _SaveMediaListEntryDart =
    ffi.Pointer<ffi.Uint8> Function(
      ffi.Pointer<ffi.Uint8> reqPtr,
      int reqLen,
      ffi.Pointer<Utf8> token,
      ffi.Pointer<ffi.Int32> outLen,
    );

typedef _FreeBufferC = ffi.Void Function(ffi.Pointer<ffi.Uint8> ptr);
typedef _FreeBufferDart = void Function(ffi.Pointer<ffi.Uint8> ptr);

/// Bridges Dart to the Go-compiled native backend via C FFI.
///
/// All AniList GraphQL operations are executed inside the native library,
/// which communicates back through protobuf-encoded byte buffers.
/// Call [init] once at startup (or rely on the lazy initialisation built into
/// each public method) before using any of the static API methods.
class BackendHelper {
  static late ffi.DynamicLibrary _lib;
  static late _FetchMediaListDart _fetchMediaList;
  static late _FetchViewerDart _fetchViewer;
  static late _FetchMediaDetailsDart _fetchMediaDetails;
  static late _SaveMediaListEntryDart _saveMediaListEntry;
  static late _FreeBufferDart _freeBuffer;
  static bool _initialized = false;

  /// Loads the native backend shared library and resolves all symbols.
  ///
  /// Safe to call multiple times — subsequent calls are no-ops.
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
    _freeBuffer = _lib.lookupFunction<_FreeBufferC, _FreeBufferDart>(
      'FreeBuffer',
    );
    _initialized = true;
  }

  /// Calls [fn] with a stack-allocated outLen pointer, reads the resulting
  /// byte buffer from the native heap, frees it, and returns a Dart copy.
  ///
  /// Throws if the native side returns a null pointer or zero length.
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

  /// Fetches the authenticated user's anime list from AniList.
  ///
  /// [userId] is the AniList user ID; [token] is the Bearer access token.
  /// Throws if the native call fails or if the response contains an error.
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

  /// Fetches the authenticated user's profile (id, name, avatar, createdAt).
  ///
  /// [token] is the Bearer access token.
  /// Throws if the native call fails or if the response contains an error.
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

  /// Saves or updates an anime list entry on AniList.
  ///
  /// [request] carries only the fields that changed (optional proto fields).
  /// [token] is the Bearer access token.
  /// Throws if the native call fails or if the response contains an error.
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
}
