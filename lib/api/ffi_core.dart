import 'dart:ffi' as ffi;
import 'dart:io' show Platform;
import 'dart:isolate';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';

/// Native function signature for freeing buffers allocated by the backend
typedef _FreeBufferC = ffi.Void Function(ffi.Pointer<ffi.Uint8> ptr);

/// Dart function signature for freeing buffers allocated by the backend
typedef _FreeBufferDart = void Function(ffi.Pointer<ffi.Uint8> ptr);

/// Core FFI utilities for interacting with the native backend
class FfiCore {
  /// The dynamic library instance for the backend
  static late ffi.DynamicLibrary lib;
  static late _FreeBufferDart _freeBuffer;
  static bool _initialized = false;

  /// Resolves the platform-specific dynamic library path
  static String getLibraryPath() {
    if (Platform.isWindows) {
      return 'backend/libbackend.dll';
    } else if (Platform.isAndroid) {
      return 'libbackend.so';
    } else if (Platform.isLinux) {
      return 'backend/libbackend.so';
    } else if (Platform.isMacOS || Platform.isIOS) {
      return 'backend/libbackend.dylib';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  /// Initializes the FFI core by loading the dynamic library and setting up function pointers
  static void init() {
    if (_initialized) return;
    lib = ffi.DynamicLibrary.open(getLibraryPath());
    _freeBuffer = lib.lookupFunction<_FreeBufferC, _FreeBufferDart>(
      'FreeBuffer',
    );
    _initialized = true;
  }

  /// Executes a native call that returns a pointer to a byte buffer and its length
  static Uint8List executeNativeCall(
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

  /// Executes a proto-based request with an auth token in a background isolate
  static Future<Uint8List> executeProtoCall(
    String functionName,
    Uint8List requestBytes,
    String token,
  ) {
    return Isolate.run(() {
      init();
      final fn = lib.lookupFunction<
        ffi.Pointer<ffi.Uint8> Function(
          ffi.Pointer<ffi.Uint8>,
          ffi.Int32,
          ffi.Pointer<Utf8>,
          ffi.Pointer<ffi.Int32>,
        ),
        ffi.Pointer<ffi.Uint8> Function(
          ffi.Pointer<ffi.Uint8>,
          int,
          ffi.Pointer<Utf8>,
          ffi.Pointer<ffi.Int32>,
        )
      >(functionName);

      final reqPtr = calloc<ffi.Uint8>(requestBytes.length);
      final tokenPtr = token.toNativeUtf8();
      try {
        reqPtr.asTypedList(requestBytes.length).setAll(0, requestBytes);
        return executeNativeCall(
          (outLenPtr) => fn(reqPtr, requestBytes.length, tokenPtr, outLenPtr),
        );
      } finally {
        calloc.free(reqPtr);
        calloc.free(tokenPtr);
      }
    });
  }

  /// Executes a token-only request in a background isolate
  static Future<Uint8List> executeTokenCall(
    String functionName,
    String token,
  ) {
    return Isolate.run(() {
      init();
      final fn = lib.lookupFunction<
        ffi.Pointer<ffi.Uint8> Function(
          ffi.Pointer<Utf8>,
          ffi.Pointer<ffi.Int32>,
        ),
        ffi.Pointer<ffi.Uint8> Function(
          ffi.Pointer<Utf8>,
          ffi.Pointer<ffi.Int32>,
        )
      >(functionName);

      final tokenPtr = token.toNativeUtf8();
      try {
        return executeNativeCall((outLenPtr) => fn(tokenPtr, outLenPtr));
      } finally {
        calloc.free(tokenPtr);
      }
    });
  }

  /// Executes a fetch media list request in a background isolate
  static Future<Uint8List> executeMediaListCall(
    int userId,
    String token,
    String mediaType,
  ) {
    return Isolate.run(() {
      init();
      final fn = lib.lookupFunction<
        ffi.Pointer<ffi.Uint8> Function(
          ffi.Int32,
          ffi.Pointer<Utf8>,
          ffi.Pointer<Utf8>,
          ffi.Pointer<ffi.Int32>,
        ),
        ffi.Pointer<ffi.Uint8> Function(
          int,
          ffi.Pointer<Utf8>,
          ffi.Pointer<Utf8>,
          ffi.Pointer<ffi.Int32>,
        )
      >('FetchMediaList');

      final tokenPtr = token.toNativeUtf8();
      final typePtr = mediaType.toNativeUtf8();
      try {
        return executeNativeCall(
          (outLenPtr) => fn(userId, tokenPtr, typePtr, outLenPtr),
        );
      } finally {
        calloc.free(tokenPtr);
        calloc.free(typePtr);
      }
    });
  }
}
