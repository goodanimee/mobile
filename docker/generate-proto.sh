#!/bin/sh
set -e

echo "Generating bindings..."
buf generate

if [ -d lib/proto/proto ]; then
    mv lib/proto/proto/*.dart lib/proto/
    rm -rf lib/proto/proto
fi
echo "Done."
