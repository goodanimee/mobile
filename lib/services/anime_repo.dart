import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/media_details_api.dart';
import '../proto/medialist.pb.dart';
import 'auth_service.dart';
import '../utils/utils.dart';

class AnimeRepo {
  static const String _cachePrefix = 'anime_cache_';
  static const String _cacheKeysPref = 'anime_cache_keys';
  static const int _cacheCapacity = 50;

  static Future<Map<String, dynamic>?> getAnimeDetails(
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

        return json.decode(cachedStr);
      }
    } else {
      await prefs.remove('$_cachePrefix$mediaId');
    }

    final token = await AuthService.getRawToken() ?? '';
    final req = FetchMediaDetailsRequest(mediaId: mediaId);
    final response = await MediaApi.fetchMediaDetails(req, token);

    final decoded = json.decode(response.rawJson);
    if (decoded != null) {
      await _saveToDiskCache(prefs, mediaId, response.rawJson);
    }
    return decoded;
  }

  static Future<void> toggleFavourite(
    int mediaId,
    Map<String, dynamic> currentMediaData,
  ) async {
    final token = await AuthService.getRawToken() ?? '';
    final req = ToggleFavouriteAnimeRequest()..animeId = mediaId;

    await MediaApi.toggleFavouriteAnime(req, token);

    final currentFav = currentMediaData['isFavourite'] == true;
    currentMediaData['isFavourite'] = !currentFav;

    final prefs = await SharedPreferences.getInstance();
    await _saveToDiskCache(prefs, mediaId, json.encode(currentMediaData));

    await CacheUtils.invalidateMedia(mediaId);
    CacheUtils.animeListNeedsRefresh.value = true;
  }

  static Future<void> restoreFavouriteCache(
    int mediaId,
    Map<String, dynamic> mediaData,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await _saveToDiskCache(prefs, mediaId, json.encode(mediaData));
  }

  static Future<void> _saveToDiskCache(
    SharedPreferences prefs,
    int mediaId,
    String rawJson,
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
    await prefs.setString('$_cachePrefix$idStr', rawJson);
  }
}
