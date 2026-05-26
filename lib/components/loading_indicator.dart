import 'package:flutter/material.dart';
import '../theme/theme.dart';

/// A standardized loading indicator for consistent state displays
class AppLoadingIndicator extends StatelessWidget {
  /// The top padding for the indicator
  final double topPadding;

  /// The color of the indicator
  final Color color;

  /// Creates a loading indicator
  const AppLoadingIndicator({
    super.key,
    this.topPadding = 40,
    this.color = borderColor,
  });

  @override
  /// Builds the loading indicator widget
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: topPadding),
        child: CircularProgressIndicator(color: color),
      ),
    );
  }
}
