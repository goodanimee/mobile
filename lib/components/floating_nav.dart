import 'package:flutter/material.dart';
import '../theme/theme.dart';

class QuickNavSection {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const QuickNavSection({
    required this.icon,
    required this.label,
    required this.onTap,
  });
}

const _navItems = [
  (icon: Icons.home_rounded, label: 'Home'),
  (icon: Icons.explore_rounded, label: 'Discover'),
  (icon: Icons.download_rounded, label: 'Downloads'),
  (icon: Icons.settings_rounded, label: 'Settings'),
];

const _fabSize = 52.0;
const _navBarWidth = 240.0;
const _gap = 8.0;
const _duration = Duration(milliseconds: 300);

final _boxDecoration = BoxDecoration(
  color: bgColor,
  borderRadius: BorderRadius.circular(16),
  border: Border.all(color: cardBorderColor, width: 1.0),
);

class FloatingNav extends StatefulWidget {
  final int selectedIndex;
  final void Function(int index) onTap;
  final List<QuickNavSection>? quickNavSections;
  final bool? isGridMode;
  final VoidCallback? onToggleGridMode;

  const FloatingNav({
    super.key,
    required this.selectedIndex,
    required this.onTap,
    this.quickNavSections,
    this.isGridMode,
    this.onToggleGridMode,
  });

  @override
  State<FloatingNav> createState() => _FloatingNavState();
}

class _FloatingNavState extends State<FloatingNav>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;
  late final AnimationController _controller;
  late final Animation<double> _widthFactor;
  late final Animation<double> _iconsFade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
    _widthFactor = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _iconsFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _expanded = !_expanded);
    _expanded ? _controller.forward() : _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final hasQuickNav =
            widget.quickNavSections != null &&
            widget.quickNavSections!.isNotEmpty;
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (_widthFactor.value == 0.0 &&
                widget.onToggleGridMode != null) ...[
              _buildViewToggleFab(),
              const SizedBox(height: _gap),
            ],
            if (_widthFactor.value > 0.0 && hasQuickNav) ...[
              _buildQuickNavBar(),
              const SizedBox(height: _gap),
            ],
            Row(
              mainAxisSize: MainAxisSize.min,
              textDirection: TextDirection.rtl,
              children: [
                _buildFab(),
                if (_widthFactor.value > 0.0) ...[
                  const SizedBox(width: _gap),
                  _buildNavBar(),
                ],
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildFab() {
    return Container(
      width: _fabSize,
      height: _fabSize,
      decoration: _boxDecoration,
      child: GestureDetector(
        onTap: _toggle,
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (child, anim) =>
                ScaleTransition(scale: anim, child: child),
            child: Icon(
              _expanded ? Icons.close_rounded : Icons.menu_rounded,
              key: ValueKey(_expanded),
              color: Colors.white,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildViewToggleFab() {
    final isGrid = widget.isGridMode ?? false;
    return Container(
      width: _fabSize,
      height: _fabSize,
      decoration: _boxDecoration,
      child: GestureDetector(
        onTap: widget.onToggleGridMode,
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (child, anim) =>
                ScaleTransition(scale: anim, child: child),
            child: Icon(
              isGrid ? Icons.list_rounded : Icons.grid_view_rounded,
              key: ValueKey(isGrid),
              color: Colors.white,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavBar() {
    return Container(
      width: _navBarWidth * _widthFactor.value,
      height: _fabSize,
      decoration: _boxDecoration,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Opacity(
          opacity: _iconsFade.value,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: OverflowBox(
              minWidth: _navBarWidth,
              maxWidth: _navBarWidth,
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(_navItems.length, (i) {
                  final item = _navItems[i];
                  final selected = widget.selectedIndex == i;
                  return Tooltip(
                    message: item.label,
                    child: GestureDetector(
                      onTap: () {
                        widget.onTap(i);
                        _toggle();
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        child: Icon(
                          item.icon,
                          size: 22,
                          color: selected
                              ? borderColor
                              : Colors.white.withValues(alpha: 0.55),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickNavBar() {
    final sections = widget.quickNavSections!;
    final totalHeight = sections.length.toDouble() * _fabSize;

    return Container(
      width: _fabSize,
      height: totalHeight * _widthFactor.value,
      decoration: _boxDecoration,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Opacity(
          opacity: _iconsFade.value,
          child: OverflowBox(
            minHeight: totalHeight,
            maxHeight: totalHeight,
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: sections.map((section) {
                return Tooltip(
                  message: section.label,
                  child: GestureDetector(
                    onTap: () {
                      section.onTap();
                      _toggle();
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      child: Icon(
                        section.icon,
                        size: 20,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
