import 'package:flutter/material.dart';
import 'dart:convert';
import '../../../components/loading_indicator.dart';
import '../../../components/error_view.dart';
import '../../../utils/app_navigation.dart';
import '../../../components/app_entity_card.dart';
import '../../../components/app_section.dart';
import '../../../api/media_details_api.dart';
import '../../../services/auth_service.dart';
import '../../../proto/medialist.pb.dart';
import '../../../models/media.dart';

/// A tab displaying characters and cast for an anime
class AnimeCharactersTab extends StatefulWidget {
  /// The media ID of the anime
  final int mediaId;

  /// Optional scroll controller for shared scrolling
  final ScrollController? scrollController;

  /// Whether this tab is nested within another scroll view
  final bool isNested;

  /// Initial data for the first page
  final CharacterConnection? initialData;

  /// Creates a characters tab
  const AnimeCharactersTab({
    super.key,
    required this.mediaId,
    this.scrollController,
    this.isNested = false,
    this.initialData,
  });

  @override
  State<AnimeCharactersTab> createState() => _AnimeCharactersTabState();
}

/// State for AnimeCharactersTab
class _AnimeCharactersTabState extends State<AnimeCharactersTab> {
  bool _isLoading = true;
  bool _isFetchingMore = false;
  final List<CharacterEdge> _characters = [];
  int _currentPage = 1;
  bool _hasNextPage = false;
  String? _error;

  ScrollController? _activeScrollController;

  @override
  void initState() {
    super.initState();

    if (widget.initialData != null) {
      _characters.addAll(widget.initialData!.edges);
      _hasNextPage = widget.initialData!.pageInfo.hasNextPage;
      _isLoading = false;
    } else {
      _fetchCharacters();
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

  /// Fetches character data from the backend
  Future<void> _fetchCharacters() async {
    try {
      final token = await AuthService.getRawToken() ?? '';
      final req = FetchMediaCharactersRequest(
        mediaId: widget.mediaId,
        page: _currentPage,
        perPage: 25,
      );
      final response = await MediaApi.fetchMediaCharacters(req, token);

      final data = json.decode(response.rawJson);
      final charData = data['characters'] as Map<String, dynamic>;
      final connection = CharacterConnection.fromJson(charData);

      if (mounted) {
        setState(() {
          _characters.addAll(connection.edges);
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

  /// Increments page count and triggers a fetch for more characters
  void _loadMore() {
    if (_hasNextPage && !_isFetchingMore) {
      setState(() {
        _isFetchingMore = true;
        _currentPage++;
      });
      _fetchCharacters();
    }
  }

  @override
  /// Builds the characters tab widget
  Widget build(BuildContext context) {
    if (_isLoading && _characters.isEmpty) {
      return const AppLoadingIndicator();
    }

    if (_error != null && _characters.isEmpty) {
      return AppErrorView(message: _error!, onRetry: _fetchCharacters);
    }

    if (_characters.isEmpty) {
      return const AppErrorView(message: 'No character information available');
    }

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSection(
          title: 'Characters & Cast',
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
              itemCount: _characters.length,
              itemBuilder: (context, index) {
                final edge = _characters[index];
                final node = edge.node;
                final fullName = node?.name?.full ?? edge.name;
                final nativeName = node?.name?.native ?? '';
                final role = edge.role;
                final charImageUrl = node?.image?.large ?? '';

                return AppEntityCard(
                  imageUrl: charImageUrl,
                  name: fullName,
                  nativeName: nativeName,
                  subtitle: role,
                  trailing: Icon(
                    Icons.info_outline_rounded,
                    size: 14,
                    color: Colors.white.withValues(alpha: 0.25),
                  ),
                  onTap: () => AppNavigation.toCharacter(context, edge),
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
