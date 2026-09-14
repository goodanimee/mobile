import 'package:flutter/material.dart';

import '../theme/theme.dart';

class _SkeletonScope extends InheritedWidget {
  final Animation<double> animation;

  const _SkeletonScope({required this.animation, required super.child});

  static _SkeletonScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_SkeletonScope>();
  }

  @override
  bool updateShouldNotify(_SkeletonScope oldWidget) => true;
}

/// Shimmer controller wrapping skeleton elements
class SkeletonShimmer extends StatefulWidget {
  /// The child subtree containing skeleton elements
  final Widget child;

  /// Creates a shimmer wrapper
  const SkeletonShimmer({super.key, required this.child});

  @override
  State<SkeletonShimmer> createState() => _SkeletonShimmerState();
}

class _SkeletonShimmerState extends State<SkeletonShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SkeletonScope(animation: _controller, child: widget.child);
  }
}

/// Basic placeholder block with shimmer effect
class SkeletonBox extends StatelessWidget {
  /// Width of the skeleton element
  final double? width;

  /// Height of the skeleton element
  final double? height;

  /// Corner radius of the element
  final double borderRadius;

  /// Optional margin around the element
  final EdgeInsetsGeometry? margin;

  /// Creates a skeleton box
  const SkeletonBox({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 8,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final scope = _SkeletonScope.of(context);

    if (scope == null) {
      return Container(
        width: width,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      );
    }

    return AnimatedBuilder(
      animation: scope.animation,
      builder: (context, _) {
        final val = scope.animation.value;
        return Container(
          width: width,
          height: height,
          margin: margin,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            gradient: LinearGradient(
              begin: const Alignment(-1.5, -0.5),
              end: const Alignment(1.5, 0.5),
              stops: [
                (val - 0.3).clamp(0.0, 1.0),
                val.clamp(0.0, 1.0),
                (val + 0.3).clamp(0.0, 1.0),
              ],
              colors: const [
                Color(0xFF1A1A1A),
                Color(0xFF282828),
                Color(0xFF1A1A1A),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Pre-composed skeleton layouts for common screens
class Skeleton extends StatelessWidget {
  /// The skeleton layout widget
  final Widget _content;

  const Skeleton._(this._content);

  /// Detail page skeleton layout with banner, cover, title and bio lines
  factory Skeleton.detailPage() {
    return Skeleton._(
      SkeletonShimmer(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SkeletonBox(width: double.infinity, height: 240, borderRadius: 0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkeletonBox(width: 100, height: 140, borderRadius: 12),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 8),
                              SkeletonBox(width: double.infinity, height: 22),
                              SizedBox(height: 12),
                              SkeletonBox(width: 140, height: 16),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  SkeletonBox(
                                    width: 60,
                                    height: 24,
                                    borderRadius: 12,
                                  ),
                                  SizedBox(width: 8),
                                  SkeletonBox(
                                    width: 70,
                                    height: 24,
                                    borderRadius: 12,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 28),
                    SkeletonBox(width: 120, height: 18),
                    SizedBox(height: 14),
                    SkeletonBox(width: double.infinity, height: 14),
                    SizedBox(height: 8),
                    SkeletonBox(width: double.infinity, height: 14),
                    SizedBox(height: 8),
                    SkeletonBox(width: 220, height: 14),
                    SizedBox(height: 28),
                    Row(
                      children: [
                        SkeletonBox(width: 80, height: 32, borderRadius: 16),
                        SizedBox(width: 12),
                        SkeletonBox(width: 80, height: 32, borderRadius: 16),
                        SizedBox(width: 12),
                        SkeletonBox(width: 80, height: 32, borderRadius: 16),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Tab content skeleton layout for biography and info sections
  factory Skeleton.tabContent() {
    return Skeleton._(
      SkeletonShimmer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonBox(width: 100, height: 140, borderRadius: 12),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkeletonBox(width: 160, height: 22),
                        SizedBox(height: 8),
                        SkeletonBox(width: 100, height: 14),
                        SizedBox(height: 16),
                        SkeletonBox(width: 80, height: 12),
                        SizedBox(height: 8),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: [
                            SkeletonBox(width: 50, height: 20, borderRadius: 4),
                            SkeletonBox(width: 65, height: 20, borderRadius: 4),
                            SkeletonBox(width: 45, height: 20, borderRadius: 4),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 28),
              SkeletonBox(width: 100, height: 18),
              SizedBox(height: 14),
              SkeletonBox(width: double.infinity, height: 36),
              SizedBox(height: 8),
              SkeletonBox(width: double.infinity, height: 36),
              SizedBox(height: 8),
              SkeletonBox(width: double.infinity, height: 36),
              SizedBox(height: 28),
              SkeletonBox(width: 120, height: 18),
              SizedBox(height: 14),
              SkeletonBox(width: double.infinity, height: 14),
              SizedBox(height: 8),
              SkeletonBox(width: double.infinity, height: 14),
              SizedBox(height: 8),
              SkeletonBox(width: 220, height: 14),
            ],
          ),
        ),
      ),
    );
  }

  /// List skeleton layout with repeated card rows
  factory Skeleton.list({int count = 6}) {
    return Skeleton._(
      SkeletonShimmer(
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          itemCount: count,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: SizedBox(
                height: 110,
                child: Container(
                  decoration: BoxDecoration(
                    color: surfaceBackground,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: cardBorderColor),
                  ),
                  child: Row(
                    children: const [
                      SkeletonBox(
                        width: 80,
                        height: double.infinity,
                        borderRadius: 11,
                      ),
                      SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SkeletonBox(width: double.infinity, height: 16),
                            SizedBox(height: 8),
                            SkeletonBox(width: 120, height: 12),
                            SizedBox(height: 10),
                            SkeletonBox(
                              width: 70,
                              height: 20,
                              borderRadius: 10,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 14),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Profile page skeleton layout with avatar and profile stats
  factory Skeleton.profile() {
    return Skeleton._(
      SkeletonShimmer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 48),
          child: Column(
            children: const [
              SkeletonBox(width: 84, height: 84, borderRadius: 42),
              SizedBox(height: 16),
              SkeletonBox(width: 150, height: 20),
              SizedBox(height: 8),
              SkeletonBox(width: 100, height: 14),
              SizedBox(height: 32),
              SkeletonBox(width: double.infinity, height: 60, borderRadius: 12),
              SizedBox(height: 16),
              SkeletonBox(width: double.infinity, height: 60, borderRadius: 12),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _content;
  }
}
