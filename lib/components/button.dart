import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import '../theme/theme.dart';

/// A custom button widget using the mix library
class Button extends StatelessWidget {
  /// Callback for button press
  final VoidCallback onPress;

  /// The button content
  final Widget child;

  /// Optional style for the button
  final BoxStyler? style;

  /// Creates an app button
  const Button({
    super.key,
    required this.onPress,
    required this.child,
    this.style,
  });

  @override
  /// Builds the button widget
  Widget build(BuildContext context) {
    return PressableBox(
      onPress: onPress,
      style: style ?? buttonBoxStyle,
      child: child,
    );
  }
}
