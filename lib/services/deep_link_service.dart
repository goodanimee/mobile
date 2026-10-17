import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/widgets.dart';

import '../utils/anilist_url_parser.dart';
import '../utils/app_navigation.dart';
import 'auth_service.dart';

/// Centralized service for handling cold-start and warm-start OS deep links.
class DeepLinkService {
  /// Singleton instance of [DeepLinkService].
  static final DeepLinkService instance = DeepLinkService._();

  DeepLinkService._();

  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _linkSubscription;
  void Function(String token)? _onAuthenticated;
  bool _isInitialized = false;
  bool _isReady = false;
  Uri? _pendingUri;
  String? _handledInitialUri;

  /// Initializes the deep link listener and checks for an initial launch link.
  Future<void> init({
    required void Function(String token) onAuthenticated,
  }) async {
    _onAuthenticated = onAuthenticated;
    if (_isInitialized) return;
    _isInitialized = true;

    try {
      final initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) {
        _handledInitialUri = initialUri.toString();
        await _handleIncomingUri(initialUri);
      }
    } catch (err) {
      debugPrint('Initial Deep Link Error: $err');
    }

    _linkSubscription = _appLinks.uriLinkStream.listen(
      (uri) {
        if (_handledInitialUri != null &&
            uri.toString() == _handledInitialUri) {
          _handledInitialUri = null;
          return;
        }
        _handleIncomingUri(uri);
      },
      onError: (Object err) {
        debugPrint('Deep Link Stream Error: $err');
      },
    );
  }

  /// Marks authentication and initial caches as ready and flushes queued links.
  void markReady() {
    _isReady = true;
    final pending = _pendingUri;
    _pendingUri = null;
    if (pending != null) {
      _dispatchAnilistUri(pending);
    }
  }

  /// Marks the session as unauthenticated so incoming links are queued.
  void markUnauthenticated() {
    _isReady = false;
  }

  /// Cancels the active deep link stream subscription.
  void dispose() {
    _linkSubscription?.cancel();
    _linkSubscription = null;
    _isInitialized = false;
  }

  Future<void> _handleIncomingUri(Uri uri) async {
    if (uri.scheme == 'org.goodanime.app' && uri.host == 'callback') {
      final params = uri.hasFragment
          ? Uri.splitQueryString(uri.fragment)
          : uri.queryParameters;

      final token = params['access_token'] ?? params['code'];
      if (token != null) {
        final expiresIn = params['expires_in'] != null
            ? int.tryParse(params['expires_in']!)
            : null;

        await AuthService.saveToken(token, expiresInSeconds: expiresIn);
        _onAuthenticated?.call(token);
      }
      return;
    }

    if (!_isReady) {
      _pendingUri = uri;
      return;
    }

    _dispatchAnilistUri(uri);
  }

  void _dispatchAnilistUri(Uri uri) {
    final rawUrl = uri.toString();
    final target = AnilistUrlParser.parse(rawUrl);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (target != null) {
        AppNavigation.openAnilistTarget(target);
      } else {
        AppNavigation.showSnackBar('Invalid or unsupported AniList link.');
      }
    });
  }
}
