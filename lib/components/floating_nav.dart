import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../theme/theme.dart';

/// Represents a section in the quick navigation menu
class QuickNavSection {
  /// Icon for the section
  final IconData icon;

  /// Label for the section
  final String label;

  /// Callback when the section is tapped
  final VoidCallback onTap;

  /// Whether the section is currently active
  final bool isSelected;

  /// Creates a quick nav section
  const QuickNavSection({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isSelected = false,
  });
}

const _navItems = [
  (icon: LucideIcons.tv, label: 'Anime List'),
  (icon: LucideIcons.sparkles, label: 'Discover'),
  (icon: LucideIcons.circleUser, label: 'Profile'),
];

const _fabSize = 52.0;
const _navBarWidth = 240.0;
const _gap = 8.0;
const _duration = Duration(milliseconds: 300);

final _boxDecoration = BoxDecoration(
  color: bgColor,
  borderRadius: BorderRadius.circular(16),
  border: Border.all(color: cardBorderColor),
);

/// A floating navigation bar with menu and view toggles
class FloatingNav extends StatefulWidget {
  /// Index of the currently selected navigation item
  final int selectedIndex;

  /// Callback when a navigation item is tapped
  final void Function(int index) onTap;

  /// Optional quick navigation sections
  final List<QuickNavSection>? quickNavSections;

  /// Current grid mode state
  final bool? isGridMode;

  /// Callback to toggle grid mode
  final VoidCallback? onToggleGridMode;

  /// Callback when expansion state changes
  final void Function(bool expanded)? onExpandChanged;

  /// Creates a floating navigation bar
  const FloatingNav({
    super.key,
    required this.selectedIndex,
    required this.onTap,
    this.quickNavSections,
    this.isGridMode,
    this.onToggleGridMode,
    this.onExpandChanged,
  });

  @override
  State<FloatingNav> createState() => _FloatingNavState();
}

/// State for FloatingNav
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

  /// Toggles the expansion state
  void _toggle() {
    setState(() => _expanded = !_expanded);
    _expanded ? _controller.forward() : _controller.reverse();
    widget.onExpandChanged?.call(_expanded);
  }

  @override
  /// Builds the floating navigation component
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

  /// Builds the main floating action button
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
              _expanded ? LucideIcons.x : LucideIcons.menu,
              key: ValueKey(_expanded),
              color: Colors.white,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the view toggle floating action button
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
              isGrid ? LucideIcons.list : LucideIcons.grid2X2,
              key: ValueKey(isGrid),
              color: Colors.white,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the expanded horizontal navigation bar
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

  /// Builds the vertical quick navigation bar
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
                        color: section.isSelected
                            ? borderColor
                            : Colors.white.withValues(alpha: 0.8),
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
