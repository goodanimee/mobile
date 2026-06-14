import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../components/app_relation_card.dart';
import '../components/error_view.dart';
import '../components/loading_indicator.dart';
import '../components/lucide_icons_helper.dart';
import '../models/media_min.dart';
import '../models/media_studio.dart';
import '../services/media_service.dart';
import '../theme/theme.dart';
import '../utils/app_navigation.dart';
import '../utils/utils.dart';

/// A page displaying details for a production studio
class StudioPage extends StatefulWidget {
  /// The ID of the studio to display
  final int studioId;

  /// Creates a studio page
  const StudioPage({super.key, required this.studioId});

  @override
  State<StudioPage> createState() => _StudioPageState();
}

class _StudioPageState extends State<StudioPage> {
  final ScrollController _scrollController = ScrollController();
  final List<MediaMin> _mediaNodes = [];
  int _currentPage = 1;
  bool _hasNextPage = false;
  bool _isFetchingMore = false;
  bool _isFavouriteLoading = false;
  bool _isLoading = true;
  Studio? _studio;
  String? _error;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _fetchStudioDetails();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (!_hasNextPage || _isFetchingMore || _isLoading) return;

    final threshold = _scrollController.position.maxScrollExtent - 400;
    if (_scrollController.offset >= threshold) {
      _loadMore();
    }
  }

  Future<void> _fetchStudioDetails() async {
    try {
      final data = await MediaService.getStudio(widget.studioId, 1);
      if (mounted) {
        setState(() {
          _studio = data;
          _mediaNodes.clear();
          _mediaNodes.addAll(data.media?.nodes ?? []);
          _hasNextPage = data.media?.pageInfo.hasNextPage ?? false;
          _currentPage = 1;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Failed to load studio: $e';
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _toggleFavourite() async {
    if (_studio == null || _isFavouriteLoading) return;

    setState(() {
      _isFavouriteLoading = true;
    });

    try {
      await MediaService.toggleFavouriteStudio(_studio!.id);
      if (mounted) {
        setState(() {
          final wasFav = _studio!.isFavourite ?? false;
          final currentCount = _studio!.favourites ?? 0;
          _studio = _studio!.copyWith(
            isFavourite: !wasFav,
            favourites: !wasFav
                ? currentCount + 1
                : (currentCount > 0 ? currentCount - 1 : 0),
          );
          _isFavouriteLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isFavouriteLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update favourite: $e')),
        );
      }
    }
  }

  Future<void> _loadMore() async {
    if (_isFetchingMore || !_hasNextPage) return;

    setState(() {
      _isFetchingMore = true;
    });

    try {
      final data = await MediaService.getStudio(
        widget.studioId,
        _currentPage + 1,
      );
      if (mounted) {
        setState(() {
          final newNodes = data.media?.nodes ?? [];
          _mediaNodes.addAll(newNodes);
          _currentPage++;
          _hasNextPage = data.media?.pageInfo.hasNextPage ?? false;
          _isFetchingMore = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isFetchingMore = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    Widget body;
    if (_isLoading) {
      body = const AppLoadingIndicator();
    } else if (_error != null || _studio == null) {
      body = AppErrorView(
        message: _error ?? 'Studio not found',
        onRetry: () {
          setState(() {
            _isLoading = true;
            _error = null;
          });
          _fetchStudioDetails();
        },
      );
    } else {
      if (_mediaNodes.isEmpty) {
        body = Center(
          child: Text(
            'No media found for this studio',
            style: TextStyle(color: textMuted, fontSize: fontBody(context)),
          ),
        );
      } else {
        final grouped = <String, List<MediaMin>>{};
        for (final media in _mediaNodes) {
          final year = media.seasonYear?.toString() ?? 'TBA';
          grouped.putIfAbsent(year, () => []).add(media);
        }

        final flatList = <dynamic>[];
        grouped.forEach((year, items) {
          flatList.add(year);
          flatList.addAll(items);
        });

        int itemCount = flatList.length;
        if (_isFetchingMore) {
          itemCount += 1;
        } else if (!_hasNextPage) {
          itemCount += 1;
        }

        body = ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          itemCount: itemCount,
          itemBuilder: (context, index) {
            if (index == flatList.length) {
              if (_isFetchingMore) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(child: AppLoadingIndicator(topPadding: 0)),
                );
              } else {
                return const SizedBox(height: 80);
              }
            }

            final element = flatList[index];

            if (element is String) {
              return Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 8),
                child: Text(
                  element,
                  style: TextStyle(
                    color: textSecondary,
                    fontSize: fontLarge(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }

            final media = element as MediaMin;
            final titleText = media.title.userPreferred.isNotEmpty
                ? media.title.userPreferred
                : media.title.romaji.isNotEmpty
                ? media.title.romaji
                : media.title.english.isNotEmpty
                ? media.title.english
                : 'Unknown';

            final format = media.format.replaceAll('_', ' ');
            String subtitle = format;
            if (media.type == 'ANIME') {
              if (media.episodes > 0) {
                subtitle += ' \u00B7 ${media.episodes} Episodes';
              }
            } else if (media.type == 'MANGA') {
              if (media.chapters > 0) {
                subtitle += ' \u00B7 ${media.chapters} Chapters';
              }
            }

            final colorHex = media.coverImage.color;
            final color = ColorUtils.fromHex(
              colorHex,
              fallback: Colors.transparent,
            );

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: SizedBox(
                height: 110,
                child: AppRelationCard(
                  imageUrl: media.coverImage.large,
                  title: titleText,
                  nativeTitle: media.title.native,
                  subtitle: subtitle,
                  color: color != Colors.transparent ? color : null,
                  onTap: () => AppNavigation.toMedia(context, media.id),
                ),
              ),
            );
          },
        );
      }
    }

    final isFav = _studio?.isFavourite ?? false;
    final studioName = _studio?.name ?? 'Studio';

    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          Container(
            height: topPadding + 56,
            padding: EdgeInsets.only(top: topPadding),
            decoration: const BoxDecoration(
              color: bgColor,
              border: Border(bottom: BorderSide(color: cardBorderColor)),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 8,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: IconButton(
                      icon: const Icon(
                        LucideIcons.arrowLeft,
                        color: textPrimary,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
                Positioned.fill(
                  left: 56,
                  right: 110,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _isLoading ? 'Loading...' : studioName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: fontTitle(context),
                        fontWeight: FontWeight.bold,
                        color: textPrimary,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 16,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: _isLoading
                        ? const SizedBox.shrink()
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '(${StringUtils.formatCompactNumber(_studio?.favourites ?? 0)})',
                                style: TextStyle(
                                  color: textSecondary,
                                  fontSize: fontBody(context),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: _isFavouriteLoading
                                    ? null
                                    : _toggleFavourite,
                                child: _isFavouriteLoading
                                    ? const SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.5,
                                          color: textPrimary,
                                        ),
                                      )
                                    : LucideHeartIcon(
                                        isFilled: isFav,
                                        color: isFav
                                            ? Colors.redAccent.shade400
                                            : textPrimary,
                                      ),
                              ),
                            ],
                          ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: body),
        ],
      ),
    );
  }
}
