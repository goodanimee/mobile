import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mix/mix.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/button.dart';
import '../../theme/theme.dart';
import '../../utils/app_navigation.dart';

/// A page for user authentication via AniList
class LoginPage extends StatelessWidget {
  /// Callback when authentication is successful
  final void Function(String token) onAuthenticated;

  /// Creates a login page
  const LoginPage({super.key, required this.onAuthenticated});

  /// Launches the AniList OAuth authorization page
  Future<void> _launchAnilistAuth() async {
    final Uri url = Uri.parse(
      'https://anilist.co/api/v2/oauth/authorize?client_id=${dotenv.env['ANILIST_CLIENT_ID']}&response_type=token',
    );

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      AppNavigation.showSnackBar('Could not launch AniList login page.');
    }
  }

  @override
  /// Builds the login page widget
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Button(
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
