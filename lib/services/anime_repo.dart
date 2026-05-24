import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/media_details_api.dart';
import '../models/media.dart';
import 'auth_service.dart';
import '../utils/utils.dart';
import '../proto/api.pb.dart';
import '../proto/media.pb.dart' as pb_media;

class AnimeRepo {
  static const String _cachePrefix = 'anime_cache_';
  static const String _cacheKeysPref = 'anime_cache_keys';
  static const int _cacheCapacity = 50;

  static Future<Media?> getAnimeDetails(
    int mediaId, {
    bool forceRefresh = false,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    if (!forceRefresh) {
      final cachedStr = prefs.getString('$_cachePrefix$mediaId');
      if (cachedStr != null) {
        List<String> keys = prefs.getStringList(_cacheKeysPref) ?? [];
        keys.remove(mediaId.toString());
        keys.add(mediaId.toString());
        await prefs.setStringList(_cacheKeysPref, keys);

        try {
          return Media.fromProto(
            pb_media.Media.fromBuffer(base64Decode(cachedStr)),
          );
        } catch (_) {}
      }
    } else {
      await prefs.remove('$_cachePrefix$mediaId');
    }

    final token = await AuthService.getRawToken() ?? '';
    final req = FetchMediaDetailsRequest(mediaId: mediaId);
    final media = await MediaApi.fetchMediaDetails(req, token);

    final rawData = base64Encode(media.toProto().writeToBuffer());
    await _saveToDiskCache(prefs, mediaId, rawData);
    return media;
  }

  static Future<void> toggleFavourite(int mediaId, Media currentMedia) async {
    final token = await AuthService.getRawToken() ?? '';
    final req = ToggleFavouriteAnimeRequest()..animeId = mediaId;

    await MediaApi.toggleFavouriteAnime(req, token);

    final updatedMedia = currentMedia.copyWith(
      isFavourite: !currentMedia.isFavourite,
    );

    final prefs = await SharedPreferences.getInstance();
    await _saveToDiskCache(
      prefs,
      mediaId,
      base64Encode(updatedMedia.toProto().writeToBuffer()),
    );

    await CacheUtils.invalidateMedia(mediaId);
    CacheUtils.animeListNeedsRefresh.value = true;
  }

  static Future<void> restoreFavouriteCache(
    int mediaId,
    Media mediaData,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await _saveToDiskCache(
      prefs,
      mediaId,
      base64Encode(mediaData.toProto().writeToBuffer()),
    );
  }

  static Future<void> _saveToDiskCache(
    SharedPreferences prefs,
    int mediaId,
    String rawData,
  ) async {
    List<String> keys = prefs.getStringList(_cacheKeysPref) ?? [];
    final idStr = mediaId.toString();
    keys.remove(idStr);
    keys.add(idStr);

    if (keys.length > _cacheCapacity) {
      final oldestKey = keys.removeAt(0);
      await prefs.remove('$_cachePrefix$oldestKey');
    }

    await prefs.setStringList(_cacheKeysPref, keys);
    await prefs.setString('$_cachePrefix$idStr', rawData);
  }
}
