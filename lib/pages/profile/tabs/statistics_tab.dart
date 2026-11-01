import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../components/error_view.dart';
import '../../../components/skeleton.dart';
import '../../../models/user_statistics.dart';
import '../../../services/user_service.dart';
import '../../../theme/theme.dart';
import '../widgets/episode_distribution_chart.dart';
import '../widgets/quick_metrics_grid.dart';
import '../widgets/release_year_chart.dart';
import '../widgets/score_distribution_chart.dart';
import '../widgets/status_format_breakdown.dart';

/// Tab presenting anime and manga statistics, distributions, and analytics.
class ProfileStatisticsTab extends StatefulWidget {
  /// User identifier whose statistics to load.
  final int userId;

  /// Trigger incremented to refresh tab contents.
  final int refreshTrigger;

  /// Pre-cached statistics to display immediately.
  final UserStatistics? initialStats;

  /// Callback fired when new statistics are fetched.
  final ValueChanged<UserStatistics>? onStatsChanged;

  /// Optional statistics fetcher override for testing.
  final Future<UserStatistics> Function({required int userId})? fetcher;

  /// Creates a profile statistics tab.
  const ProfileStatisticsTab({
    super.key,
    required this.userId,
    this.refreshTrigger = 0,
    this.initialStats,
    this.onStatsChanged,
    this.fetcher,
  });

  @override
  State<ProfileStatisticsTab> createState() => _ProfileStatisticsTabState();
}

class _ProfileStatisticsTabState extends State<ProfileStatisticsTab> {
  UserStatistics _stats = const UserStatistics();
  bool _isLoading = true;
  String? _error;
  bool _isAnime = true;
  int _requestToken = 0;

  Future<UserStatistics> Function({required int userId}) get _fetcher =>
      widget.fetcher ?? UserService.getUserStatistics;

  @override
  void initState() {
    super.initState();
    if (widget.initialStats != null) {
      _stats = widget.initialStats!;
      _isLoading = false;
    } else {
      _loadStatistics();
    }
  }

  @override
  void didUpdateWidget(ProfileStatisticsTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.userId != widget.userId ||
        oldWidget.refreshTrigger != widget.refreshTrigger) {
      _loadStatistics();
    }
  }

  Future<void> _loadStatistics() async {
    final token = ++_requestToken;
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final loaded = await _fetcher(userId: widget.userId);
      if (!mounted || token != _requestToken) return;
      setState(() {
        _stats = loaded;
        _isLoading = false;
      });
      widget.onStatsChanged?.call(loaded);
    } catch (_) {
      if (!mounted || token != _requestToken) return;
      setState(() {
        _error = 'Failed to load statistics.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          _buildMediaTypeSelector(),
          const SizedBox(height: 16),
          if (_isLoading)
            _buildLoadingSkeleton()
          else if (_error != null)
            _buildErrorView()
          else
            _buildContent(),
        ],
      ),
    );
  }

  Widget _buildMediaTypeSelector() {
    return Row(
      children: [
        _buildMediaOption(
          label: 'Anime',
          icon: LucideIcons.tv,
          selected: _isAnime,
          onTap: () => setState(() => _isAnime = true),
        ),
        const SizedBox(width: 8),
        _buildMediaOption(
          label: 'Manga',
          icon: LucideIcons.bookOpen,
          selected: !_isAnime,
          onTap: () => setState(() => _isAnime = false),
        ),
      ],
    );
  }

  Widget _buildMediaOption({
    required String label,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? paletteBlue.withValues(alpha: 0.15) : hoverBgColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: selected ? borderColor : cardBorderColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: selected ? borderColor : textSecondary),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: selected ? textPrimary : textSecondary,
                fontSize: 13,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingSkeleton() {
    return const SkeletonShimmer(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: SkeletonBox(height: 80, borderRadius: 12)),
              SizedBox(width: 10),
              Expanded(child: SkeletonBox(height: 80, borderRadius: 12)),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: SkeletonBox(height: 80, borderRadius: 12)),
              SizedBox(width: 10),
              Expanded(child: SkeletonBox(height: 80, borderRadius: 12)),
            ],
          ),
          SizedBox(height: 16),
          SkeletonBox(width: double.infinity, height: 180, borderRadius: 12),
          SizedBox(height: 16),
          SkeletonBox(width: double.infinity, height: 140, borderRadius: 12),
        ],
      ),
    );
  }

  Widget _buildErrorView() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Center(
        child: AppErrorView(
          message: _error ?? 'Failed to load statistics.',
          onRetry: _loadStatistics,
        ),
      ),
    );
  }

  Widget _buildContent() {
    final currentStats = _isAnime ? _stats.anime : _stats.manga;

    if (currentStats.count == 0) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 20),
        decoration: BoxDecoration(
          color: hoverBgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: cardBorderColor),
        ),
        child: Column(
          children: [
            Icon(
              _isAnime ? LucideIcons.tv : LucideIcons.bookOpen,
              size: 32,
              color: textMuted,
            ),
            const SizedBox(height: 12),
            Text(
              'No ${_isAnime ? 'Anime' : 'Manga'} statistics found',
              style: const TextStyle(
                color: textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Add ${_isAnime ? 'anime' : 'manga'} to your list to see analytics.',
              style: const TextStyle(color: textMuted, fontSize: 12),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QuickMetricsGrid(stats: currentStats, isAnime: _isAnime),
        ScoreDistributionChart(scores: currentStats.scores, isAnime: _isAnime),
        EpisodeDistributionChart(
          lengths: currentStats.lengths,
          isAnime: _isAnime,
        ),
        StatusFormatBreakdown(
          statuses: currentStats.statuses,
          formats: currentStats.formats,
          isAnime: _isAnime,
        ),
        ReleaseYearChart(
          releaseYears: currentStats.releaseYears,
          isAnime: _isAnime,
        ),
      ],
    );
  }
}
