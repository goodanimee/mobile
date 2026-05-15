import 'dart:ffi' as ffi;
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

  /// Initializes the FFI core by loading the dynamic library and setting up function pointers
  static void init() {
    if (_initialized) return;
    lib = ffi.DynamicLibrary.open('libbackend.so');
    _freeBuffer = lib.lookupFunction<_FreeBufferC, _FreeBufferDart>('FreeBuffer');
    _initialized = true;
  }

  /// Executes a native call that returns a pointer to a byte buffer and its length
  static Uint8List executeNativeCall(ffi.Pointer<ffi.Uint8> Function(ffi.Pointer<ffi.Int32> outLen) fn) {
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
}