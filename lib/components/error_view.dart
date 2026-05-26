import 'package:flutter/material.dart';

/// A standardized error view for consistent error displays
class AppErrorView extends StatelessWidget {
  /// The error message to display
  final String message;

  /// The top padding for the error view
  final double topPadding;

  /// Optional callback to retry the failed operation
  final VoidCallback? onRetry;

  /// Creates an error view
  const AppErrorView({
    super.key,
    required this.message,
    this.topPadding = 40,
    this.onRetry,
  });

  @override
  /// Builds the error view widget
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: topPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.redAccent),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              TextButton(
                onPressed: onRetry,
                child: const Text(
                  'Retry',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
