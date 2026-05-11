import 'dart:ffi' as ffi;
import 'dart:io' show Platform;
import 'package:ffi/ffi.dart';

typedef HelloWorldFunc = ffi.Pointer<Utf8> Function();
typedef HelloWorldDartFunc = ffi.Pointer<Utf8> Function();

/// Backend interface for FFI calls
class Backend {
  late ffi.DynamicLibrary _lib;
  late HelloWorldDartFunc _helloWorld;

  /// Initializes the dynamic library based on the platform
  Backend() {
    String libraryPath;
    if (Platform.isWindows) {
      libraryPath = 'backend/libbackend.dll';
    } else if (Platform.isAndroid) {
      libraryPath = 'libbackend.so';
    } else if (Platform.isLinux) {
      libraryPath = 'backend/libbackend.so';
    } else if (Platform.isMacOS || Platform.isIOS) {
      libraryPath = 'backend/libbackend.dylib';
    } else {
      throw UnsupportedError('Unsupported platform');
    }

    _lib = ffi.DynamicLibrary.open(libraryPath);
    _helloWorld = _lib.lookupFunction<HelloWorldFunc, HelloWorldDartFunc>(
      'HelloWorld',
    );
  }

  /// Returns a hello world string from the backend
  String getHelloWorld() {
    final pointer = _helloWorld();
    return pointer.toDartString();
  }
}
