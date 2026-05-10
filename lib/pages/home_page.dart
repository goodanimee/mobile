import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';
import '../theme/theme.dart';
import '../components/floating_nav.dart';
import 'login_page.dart';
import 'profile_page.dart';
import 'home_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

IconData _statusIcon(String status) => switch (status) {
  'WATCHING' => Icons.play_circle_rounded,
  'REPEATING' => Icons.repeat_rounded,
  'PLANNING' => Icons.bookmark_rounded,
  'COMPLETED' => Icons.check_circle_rounded,
  'PAUSED' => Icons.pause_circle_rounded,
  'DROPPED' => Icons.cancel_rounded,
  _ => Icons.list_rounded,
};

class _HomePageState extends State<HomePage> {
  String? _token;
  bool _isLoading = true;
  int _navIndex = 0;
  bool _isGridMode = true; // default to true
  List<QuickNavSection> _quickNavSections = [];

  @override
  void initState() {
    super.initState();
    _loadTokenAndPreferences();
  }

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

  Future<void> _toggleGridMode() async {
    final newValue = !_isGridMode;
    setState(() => _isGridMode = newValue);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('cached_is_grid_mode', newValue);
  }

  void _handleAuthenticated(String token) {
    setState(() => _token = token);
  }

  void _handleSignOut() {
    setState(() {
      _token = null;
      _navIndex = 0;
    });
  }

  void _handleSectionsChanged(
    List<String> statuses,
    void Function(String) scrollTo,
  ) {
    if (!mounted) return;
    setState(() {
      _quickNavSections = statuses
          .map(
            (s) => QuickNavSection(
              icon: _statusIcon(s),
              label: s,
              onTap: () => scrollTo(s),
            ),
          )
          .toList();
    });
  }

  Widget _buildBody() {
    switch (_navIndex) {
      case 0:
        return HomeTab(
          isGridMode: _isGridMode,
          onSignOut: _handleSignOut,
          onSectionsChanged: _handleSectionsChanged,
        );
      case 3:
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
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: borderColor)),
      );
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
                onTap: (i) => setState(() => _navIndex = i),
                quickNavSections: _navIndex == 0 ? _quickNavSections : null,
                isGridMode: _navIndex == 0 ? _isGridMode : null,
                onToggleGridMode: _navIndex == 0 ? _toggleGridMode : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
