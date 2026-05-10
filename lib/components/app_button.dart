import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import '../theme/theme.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onPress;
  final Widget child;
  final BoxStyler? style;

  const AppButton({
    super.key,
    required this.onPress,
    required this.child,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return PressableBox(
      onPress: onPress,
      style: style ?? buttonBoxStyle,
      child: child,
    );
  }
}
