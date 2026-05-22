FROM golang:1.23-bookworm

RUN apt-get update && apt-get install -y --no-install-recommends \
        protobuf-compiler \
        apt-transport-https \
        gnupg \
    && curl -fsSL https://dl-ssl.google.com/linux/linux_signing_key.pub \
       | gpg --dearmor -o /usr/share/keyrings/dart.gpg \
    && echo 'deb [signed-by=/usr/share/keyrings/dart.gpg arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' \
       | tee /etc/apt/sources.list.d/dart_stable.list \
    && apt-get update && apt-get install -y dart \
    && rm -rf /var/lib/apt/lists/*

ENV PATH="$PATH:/usr/lib/dart/bin:/root/.pub-cache/bin"

RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@latest \
    && dart pub global activate protoc_plugin

RUN curl -sSL \
    "https://github.com/bufbuild/buf/releases/download/v1.69.0/buf-Linux-x86_64" \
    -o "/usr/local/bin/buf" && \
    chmod +x "/usr/local/bin/buf"

WORKDIR /workspace

ENTRYPOINT ["/workspace/docker/generate-proto.sh"]
