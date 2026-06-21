import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

/// A reusable dropdown overlay wrapper widget.
class FilterDropdown extends StatefulWidget {
  /// The anchor widget that displays the dropdown when triggered.
  final Widget anchor;

  /// The menu overlay content.
  final Widget menu;

  /// Whether the dropdown menu is open.
  final bool isOpen;

  /// Callback when tapping outside the dropdown area.
  final VoidCallback onTapOutside;

  /// Link for positioning the follower relative to the target.
  final LayerLink layerLink;

  /// Whether to wrap the anchor in a CompositedTransformTarget.
  final bool useAnchorAsTarget;

  /// Creates a filter dropdown overlay wrapper.
  const FilterDropdown({
    super.key,
    required this.anchor,
    required this.menu,
    required this.isOpen,
    required this.onTapOutside,
    required this.layerLink,
    this.useAnchorAsTarget = true,
  });

  @override
  State<FilterDropdown> createState() => _FilterDropdownState();
}

class _FilterDropdownState extends State<FilterDropdown>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  late final Animation<double> _fadeAnimation;
  OverlayEntry? _overlayEntry;
  bool _isInserted = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
    );

    if (widget.isOpen) {
      _showOverlay();
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(FilterDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isOpen != oldWidget.isOpen) {
      if (widget.isOpen) {
        _showOverlay();
        _controller.forward();
      } else {
        _controller.reverse().then((_) {
          _hideOverlay();
        });
      }
    } else if (widget.isOpen && widget.menu != oldWidget.menu) {
      if (_isInserted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_isInserted && _overlayEntry != null) {
            _overlayEntry?.markNeedsBuild();
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _hideOverlay();
    super.dispose();
  }

  void _showOverlay() {
    if (_overlayEntry == null) {
      final entry = _createOverlayEntry();
      _overlayEntry = entry;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_overlayEntry == entry && !_isInserted) {
          Overlay.of(context).insert(entry);
          _isInserted = true;
        }
      });
    }
  }

  void _hideOverlay() {
    if (_overlayEntry != null) {
      if (_isInserted) {
        _overlayEntry!.remove();
        _isInserted = false;
      }
      _overlayEntry = null;
    }
  }

  OverlayEntry _createOverlayEntry() {
    final double paddingVal = getResponsiveSize(context, 16.0);
    return OverlayEntry(
      builder: (context) {
        final double screenWidth = MediaQuery.of(context).size.width;
        final double menuWidth = screenWidth - 2 * paddingVal;

        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: widget.onTapOutside,
                behavior: HitTestBehavior.translucent,
                child: const SizedBox(),
              ),
            ),
            CompositedTransformFollower(
              link: widget.layerLink,
              showWhenUnlinked: false,
              targetAnchor: Alignment.bottomLeft,
              offset: Offset(-paddingVal, 8.0),
              child: ClipRect(
                child: SizeTransition(
                  sizeFactor: _animation,
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: menuWidth,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: GestureDetector(
                        onTap: () {},
                        behavior: HitTestBehavior.opaque,
                        child: Material(
                          type: MaterialType.transparency,
                          child: widget.menu,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.useAnchorAsTarget) {
      return CompositedTransformTarget(
        link: widget.layerLink,
        child: widget.anchor,
      );
    } else {
      return widget.anchor;
    }
  }
}
