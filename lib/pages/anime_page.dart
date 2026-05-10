import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/theme.dart';
import '../components/floating_nav.dart';
import '../utils/backend_helper.dart';
import '../services/auth_service.dart';
import '../proto/medialist.pb.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AnimePage extends StatefulWidget {
  final int mediaId;

  const AnimePage({super.key, required this.mediaId});

  @override
  State<AnimePage> createState() => _AnimePageState();
}

class _AnimePageState extends State<AnimePage> {
  bool _isLoading = true;
  Map<String, dynamic>? _mediaData;
  String? _error;

  static const int _cacheCapacity = 10;
  static const String _cacheKeysPref = 'anime_cache_keys';
  static const String _cachePrefix = 'anime_cache_';

  @override
  void initState() {
    super.initState();
    _fetchAnimeDetails();
  }

  Future<void> _fetchAnimeDetails() async {
    final prefs = await SharedPreferences.getInstance();

    // 1. Check disk cache
    final cachedStr = prefs.getString('$_cachePrefix${widget.mediaId}');
    if (cachedStr != null) {
      // Update LRU order
      List<String> keys = prefs.getStringList(_cacheKeysPref) ?? [];
      keys.remove(widget.mediaId.toString());
      keys.add(widget.mediaId.toString());
      await prefs.setStringList(_cacheKeysPref, keys);

      if (mounted) {
        setState(() {
          _mediaData = json.decode(cachedStr);
          _isLoading = false;
        });
      }
      return;
    }

    // 2. Fetch from network/backend
    try {
      final token = await AuthService.getRawToken() ?? '';
      final req = FetchMediaDetailsRequest(mediaId: widget.mediaId);
      final response = await BackendHelper.fetchMediaDetails(req, token);

      if (mounted) {
        setState(() {
          _mediaData = json.decode(response.rawJson);
          _isLoading = false;
        });

        // 3. Save to disk cache
        if (_mediaData != null) {
          _saveToDiskCache(prefs, widget.mediaId, response.rawJson);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Failed to load details: $e';
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _saveToDiskCache(
    SharedPreferences prefs,
    int mediaId,
    String rawJson,
  ) async {
    List<String> keys = prefs.getStringList(_cacheKeysPref) ?? [];
    final idStr = mediaId.toString();

    keys.remove(idStr);
    keys.add(idStr);

    // Evict oldest if capacity exceeded
    if (keys.length > _cacheCapacity) {
      final oldestKey = keys.removeAt(0);
      await prefs.remove('$_cachePrefix$oldestKey');
    }

    await prefs.setStringList(_cacheKeysPref, keys);
    await prefs.setString('$_cachePrefix$idStr', rawJson);
  }

  void _handleNavTap(int index) {
    // If the user taps a nav item, we pop the anime page and return the index.
    Navigator.of(context).pop(index);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: bgColor,
        body: Center(child: CircularProgressIndicator(color: borderColor)),
      );
    }

    if (_error != null || _mediaData == null) {
      return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: bgColor,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Center(
          child: Text(
            _error ?? 'Anime not found',
            style: const TextStyle(color: Colors.redAccent),
          ),
        ),
      );
    }

    final media = _mediaData!;
    final title = media['title']?['userPreferred'] ?? 'Unknown';
    final coverImage = media['coverImage'] as Map<String, dynamic>? ?? {};
    final imageUrl =
        coverImage['extraLarge'] ?? coverImage['large'] as String? ?? '';
    final description =
        media['description'] as String? ?? 'No description available.';

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0).copyWith(bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (imageUrl.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    description.replaceAll(
                      RegExp(r'<[^>]*>'),
                      '',
                    ), // Strip HTML tags
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 24,
              right: 20,
              child: FloatingNav(
                selectedIndex: 0,
                onTap: _handleNavTap,
                quickNavSections: null,
                isGridMode: null,
                onToggleGridMode: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
