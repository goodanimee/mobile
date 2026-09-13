import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';
import 'api/ffi_core.dart';

/// Native function signature for hello world
typedef HelloWorldFunc = ffi.Pointer<Utf8> Function();

/// Dart function signature for hello world
typedef HelloWorldDartFunc = ffi.Pointer<Utf8> Function();

/// Backend interface for FFI calls
class Backend {
  late ffi.DynamicLibrary _lib;
  late HelloWorldDartFunc _helloWorld;

  /// Initializes the dynamic library based on the platform
  Backend() {
    _lib = ffi.DynamicLibrary.open(FfiCore.getLibraryPath());
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
