import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:app_links/app_links.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/auth_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/theme.dart';
import '../components/app_button.dart';

const String _clientId = "40920";

class LoginPage extends StatefulWidget {
  final void Function(String token) onAuthenticated;

  const LoginPage({super.key, required this.onAuthenticated});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    super.initState();
    _initDeepLinks();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  Future<void> _initDeepLinks() async {
    _appLinks = AppLinks();

    _linkSubscription = _appLinks.uriLinkStream.listen(
      (uri) {
        if (uri.scheme != 'org.goodanime.app' || uri.host != 'callback') return;

        final params = uri.hasFragment
            ? Uri.splitQueryString(uri.fragment)
            : uri.queryParameters;

        final token = params['access_token'] ?? params['code'];

        if (token != null) {
          final expiresIn = params['expires_in'] != null
              ? int.tryParse(params['expires_in']!)
              : null;

          AuthService.saveToken(token, expiresInSeconds: expiresIn);
          widget.onAuthenticated(token);
        }
      },
      onError: (err) {
        debugPrint('Deep Link Error: $err');
      },
    );
  }

  Future<void> _launchAnilistAuth() async {
    final Uri url = Uri.parse(
      'https://anilist.co/api/v2/oauth/authorize?client_id=$_clientId&response_type=token',
    );

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch AniList login page.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: AppButton(
            onPress: _launchAnilistAuth,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/anilist-svgrepo-com.svg',
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    textColor,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 10),
                StyledText('Log in with AniList', style: buttonTextStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
