# GoodAnime

An AniList anime tracking app for Android.

## Requirements

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Go 1.23+](https://go.dev/dl/)
- [Android SDK + NDK](https://developer.android.com/studio)
- [Docker](https://docs.docker.com/get-started/get-docker/) (for proto generation and release builds)

## Setup

```bash
cp .env.example .env
# then edit .env and add your AniList client ID
```

## Run

```bash
flutter run
```

## Build

```bash
docker compose -f docker/docker-compose.yml run --rm build
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

## Regenerate proto bindings

```bash
docker compose -f docker/docker-compose.yml run --rm proto
```
