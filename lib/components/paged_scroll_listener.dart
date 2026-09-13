import 'package:flutter/material.dart';

/// A widget that listens to scroll notifications and invokes a callback when reaching the end of the content.
class PagedScrollListener extends StatelessWidget {
  /// The scrollable child widget.
  final Widget child;

  /// Callback invoked to load more items.
  final VoidCallback onLoadMore;

  /// Whether there are more items to fetch.
  final bool hasMore;

  /// Whether a fetch operation is currently in progress.
  final bool isLoading;

  /// Distance in pixels from the bottom extent where loading should trigger.
  final double threshold;

  /// Creates a paged scroll listener.
  const PagedScrollListener({
    super.key,
    required this.child,
    required this.onLoadMore,
    required this.hasMore,
    required this.isLoading,
    this.threshold = 400.0,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (!hasMore || isLoading) return false;
        final metrics = notification.metrics;
        if (metrics.maxScrollExtent > 0 &&
            metrics.pixels >= metrics.maxScrollExtent - threshold) {
          onLoadMore();
        }
        return false;
      },
      child: child,
    );
  }
}
