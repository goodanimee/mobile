import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import '../theme/theme.dart';
import 'app_button.dart';

/// A widget displaying user profile information
class UserProfile extends StatelessWidget {
  /// The user data to display
  final Map<String, dynamic> userData;

  /// Callback for signing out
  final VoidCallback onSignOut;

  /// Creates a user profile widget
  const UserProfile({
    super.key,
    required this.userData,
    required this.onSignOut,
  });

  @override
  /// Builds the user profile component
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 45,
          backgroundColor: borderColor,
          backgroundImage: NetworkImage(userData['avatar']['medium']),
        ),
        const SizedBox(height: 16),
        Text(
          'Welcome, ${userData['name']}',
          style: const TextStyle(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'ID: ${userData['id']}',
          style: TextStyle(
            color: textColor.withValues(alpha: 0.6),
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 40),
        AppButton(
          onPress: onSignOut,
          style: BoxStyler()
              .color(Colors.transparent)
              .padding(EdgeInsetsMix.symmetric(horizontal: 16, vertical: 8))
              .borderRadius(BorderRadiusMix.circular(6))
              .border(
                BorderMix.all(
                  BorderSideMix(
                    color: Colors.redAccent.withValues(alpha: 0.5),
                    width: 1.0,
                  ),
                ),
              )
              .onHovered(
                BoxStyler().color(Colors.redAccent.withValues(alpha: 0.1)),
              ),
          child: StyledText(
            'Sign Out',
            style: TextStyler().color(Colors.redAccent).fontSize(13),
          ),
        ),
      ],
    );
  }
}
