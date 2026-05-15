import 'dart:ffi' as ffi;
import 'dart:isolate';
import 'package:ffi/ffi.dart';
import '../proto/medialist.pb.dart';
import 'ffi_core.dart';

/// Native function signature for fetching viewer information
typedef _FetchViewerC =
    ffi.Pointer<ffi.Uint8> Function(ffi.Pointer<Utf8>, ffi.Pointer<ffi.Int32>);
/// Dart function signature for fetching viewer information
typedef _FetchViewerDart =
    ffi.Pointer<ffi.Uint8> Function(ffi.Pointer<Utf8>, ffi.Pointer<ffi.Int32>);

/// API class for user-related operations
class UserApi {
  static late _FetchViewerDart _fetchViewer;
  static bool _initialized = false;

  static void _init() {
    if (_initialized) return;
    FfiCore.init();
    _fetchViewer = FfiCore.lib.lookupFunction<_FetchViewerC, _FetchViewerDart>(
      'FetchViewer',
    );
    _initialized = true;
  }

  /// Fetches viewer information using the provided token
  static Future<FetchViewerResponse> fetchViewer(String token) async {
    return Isolate.run(() {
      _init();
      final tokenPtr = token.toNativeUtf8();
      try {
        final bytes = FfiCore.executeNativeCall(
          (outLenPtr) => _fetchViewer(tokenPtr, outLenPtr),
        );
        final response = FetchViewerResponse.fromBuffer(bytes);
        if (response.error.isNotEmpty) {
          throw Exception('Error fetching viewer: ${response.error}');
        }
        return response;
      } finally {
        calloc.free(tokenPtr);
      }
    });
  }
}
