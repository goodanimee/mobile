#!/bin/sh
set -e

echo "==> Generating Go bindings..."
protoc \
    --go_out=backend \
    --go_opt=paths=source_relative \
    proto/medialist.proto

echo "==> Generating Dart bindings..."
protoc \
    --dart_out=lib/proto \
    --plugin=protoc-gen-dart="$(which protoc-gen-dart)" \
    proto/medialist.proto

if [ -d lib/proto/proto ]; then
    mv lib/proto/proto/*.dart lib/proto/
    rm -rf lib/proto/proto
fi

echo "==> Done."
