import 'package:flutter/material.dart';

import '../../../components/app_entity_card.dart';
import '../../../components/app_section.dart';
import '../../../components/error_view.dart';
import '../../../components/loading_indicator.dart';
import '../../../models/media_staff.dart';
import '../../../services/media_service.dart';

/// A tab displaying the production staff for an anime
class MediaStaffTab extends StatefulWidget {
  /// The media ID of the anime
  final int mediaId;

  /// Optional scroll controller for shared scrolling
  final ScrollController? scrollController;

  /// Whether this tab is nested within another scroll view
  final bool isNested;

  /// Initial data for the first page
  final StaffConnection? initialData;

  /// Creates a staff tab
  const MediaStaffTab({
    super.key,
    required this.mediaId,
    this.scrollController,
    this.isNested = false,
    this.initialData,
  });

  @override
  State<MediaStaffTab> createState() => _MediaStaffTabState();
}

/// State for AnimeStaffTab
class _MediaStaffTabState extends State<MediaStaffTab> {
  bool _isLoading = true;
  bool _isFetchingMore = false;
  final List<StaffEdge> _staff = [];
  int _currentPage = 1;
  bool _hasNextPage = false;
  String? _error;

  ScrollController? _activeScrollController;

  @override
  void initState() {
    super.initState();

    if (widget.initialData != null) {
      _staff.addAll(widget.initialData!.edges);
      _hasNextPage = widget.initialData!.pageInfo.hasNextPage;
      _isLoading = false;
    } else {
      _fetchStaff();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newController =
        widget.scrollController ?? PrimaryScrollController.maybeOf(context);
    if (_activeScrollController != newController) {
      _activeScrollController?.removeListener(_scrollListener);
      _activeScrollController = newController;
      _activeScrollController?.addListener(_scrollListener);
    }
  }

  @override
  void dispose() {
    _activeScrollController?.removeListener(_scrollListener);
    super.dispose();
  }

  /// Listener for infinite scroll pagination
  void _scrollListener() {
    if (_activeScrollController == null ||
        !_activeScrollController!.hasClients ||
        !_hasNextPage ||
        _isFetchingMore ||
        _isLoading) {
      return;
    }

    final threshold = _activeScrollController!.position.maxScrollExtent - 200;
    if (_activeScrollController!.offset >= threshold) {
      _loadMore();
    }
  }

  /// Fetches staff data from the backend
  Future<void> _fetchStaff() async {
    try {
      final connection = await MediaService.getStaff(
        widget.mediaId,
        _currentPage,
      );

      if (mounted) {
        setState(() {
          _staff.addAll(connection.edges);
          _hasNextPage = connection.pageInfo.hasNextPage;
          _isLoading = false;
          _isFetchingMore = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
          _isFetchingMore = false;
        });
      }
    }
  }

  /// Increments page count and triggers a fetch for more staff members
  void _loadMore() {
    if (_hasNextPage && !_isFetchingMore) {
      setState(() {
        _isFetchingMore = true;
        _currentPage++;
      });
      _fetchStaff();
    }
  }

  @override
  /// Builds the staff tab widget
  Widget build(BuildContext context) {
    if (_isLoading && _staff.isEmpty) {
      return const AppLoadingIndicator();
    }

    if (_error != null && _staff.isEmpty) {
      return AppErrorView(message: _error!, onRetry: _fetchStaff);
    }

    if (_staff.isEmpty) {
      return const AppErrorView(message: 'No staff information available');
    }

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSection(
          title: 'Staff Members',
          topSpacing: 0,
          children: [
            GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.8,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _staff.length,
              itemBuilder: (context, index) {
                final edge = _staff[index];
                final node = edge.node;
                final fullName = node?.name?.full ?? '';
                final nativeName = node?.name?.native ?? '';
                final role = edge.role.isNotEmpty ? edge.role : 'Unknown Role';
                final imageUrl = node?.image?.large ?? '';

                return AppEntityCard(
                  imageUrl: imageUrl,
                  name: fullName,
                  nativeName: nativeName,
                  subtitle: role,
                );
              },
            ),
          ],
        ),
        if (_isFetchingMore)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: AppLoadingIndicator(topPadding: 0),
          ),
      ],
    );

    if (widget.isNested) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: content,
      );
    }

    return SingleChildScrollView(
      controller: _activeScrollController,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: content,
    );
  }
}
