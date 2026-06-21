import 'package:flutter/material.dart';
import 'package:goodanime/utils/app_navigation.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/floating_nav.dart';
import '../components/loading_indicator.dart';
import '../models/common.dart';
import '../services/auth_service.dart';
import '../theme/theme.dart';
import 'anime_list_tab.dart';
import 'login_page.dart';
import 'manga_list_tab.dart';
import 'profile_page.dart';
import 'search_page.dart';

/// The main container page for the application
class HomePage extends StatefulWidget {
  /// Creates the home page
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

/// Returns an icon corresponding to a list status
IconData _statusIcon(MediaListStatus status, {bool isManga = false}) =>
    switch (status) {
      MediaListStatus.current =>
        isManga ? LucideIcons.bookOpenText : LucideIcons.playCircle,
      MediaListStatus.planning => LucideIcons.bookmark,
      MediaListStatus.completed => LucideIcons.badgeCheck,
      MediaListStatus.repeating => LucideIcons.rotateCcw,
      MediaListStatus.paused => LucideIcons.circlePause,
      MediaListStatus.dropped => LucideIcons.ban,
    };

/// State for HomePage
class _HomePageState extends State<HomePage> {
  String? _token;
  bool _isLoading = true;
  int _navIndex = 1;
  bool _isGridMode = true;
  List<QuickNavSection> _quickNavSections = [];

  @override
  void initState() {
    super.initState();
    _loadTokenAndPreferences();
    AppNavigation.currentTab.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (mounted && _navIndex != AppNavigation.currentTab.value) {
      setState(() => _navIndex = AppNavigation.currentTab.value);
    }
  }

  @override
  void dispose() {
    AppNavigation.currentTab.removeListener(_onTabChanged);
    super.dispose();
  }

  /// Loads the auth token and user preferences from storage
  Future<void> _loadTokenAndPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final isGridMode = prefs.getBool('cached_is_grid_mode') ?? true;
    final token = await AuthService.getRawToken();
    if (mounted) {
      setState(() {
        _isGridMode = isGridMode;
        _token = token;
        _isLoading = false;
      });
    }
  }

  /// Toggles between grid and list display modes
  Future<void> _toggleGridMode() async {
    final newValue = !_isGridMode;
    setState(() => _isGridMode = newValue);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('cached_is_grid_mode', newValue);
  }

  /// Updates state with a new auth token
  void _handleAuthenticated(String token) {
    setState(() => _token = token);
  }

  /// Resets state on sign out
  void _handleSignOut() {
    setState(() {
      _token = null;
      _navIndex = 1;
    });
  }

  /// Updates the quick navigation sections based on visible list categories
  void _handleSectionsChanged(
    List<MediaListStatus> statuses,
    MediaListStatus activeStatus,
    void Function(MediaListStatus) scrollTo,
  ) {
    if (!mounted) return;
    setState(() {
      _quickNavSections = statuses
          .map(
            (s) => QuickNavSection(
              icon: _statusIcon(s, isManga: _navIndex == 2),
              label: s.displayName(isManga: _navIndex == 2),
              onTap: () => scrollTo(s),
              isSelected: s == activeStatus,
            ),
          )
          .toList();
    });
  }

  /// Builds the body content based on the selected navigation index
  Widget _buildBody() {
    switch (_navIndex) {
      case 1:
        return AnimeListTab(
          isGridMode: _isGridMode,
          onSignOut: _handleSignOut,
          onSectionsChanged: _handleSectionsChanged,
        );
      case 2:
        return MangaListTab(
          isGridMode: _isGridMode,
          onSignOut: _handleSignOut,
          onSectionsChanged: _handleSectionsChanged,
        );
      case 3:
        return const SearchPage();
      case 4:
        return ProfilePage(onSignOut: _handleSignOut);
      default:
        return Center(
          child: Text(
            'Tab $_navIndex',
            style: const TextStyle(color: textColor),
          ),
        );
    }
  }

  @override
  /// Builds the main home page widget
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: AppLoadingIndicator());
    }

    if (_token == null) {
      return LoginPage(onAuthenticated: _handleAuthenticated);
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _buildBody(),
            Positioned(
              bottom: 24,
              right: 20,
              child: FloatingNav(
                selectedIndex: _navIndex,
                onTap: (i) => AppNavigation.currentTab.value = i,
                quickNavSections: (_navIndex == 1 || _navIndex == 2)
                    ? _quickNavSections
                    : null,
                isGridMode: (_navIndex == 1 || _navIndex == 2)
                    ? _isGridMode
                    : null,
                onToggleGridMode: (_navIndex == 1 || _navIndex == 2)
                    ? _toggleGridMode
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
