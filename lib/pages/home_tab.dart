import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/backend_helper.dart';
import '../services/auth_service.dart';
import '../theme/theme.dart';
import '../components/anime_list_card.dart';
import '../components/anime_options_sheet.dart';
import '../components/section_title.dart';
import '../components/loading_indicator.dart';
import '../components/error_view.dart';
import '../components/app_network_image.dart';
import '../components/app_badges.dart';
import 'anime_page.dart';

/// A tab displaying the user's anime lists
class HomeTab extends StatefulWidget {
  /// Whether to display items in a grid
  final bool isGridMode;

  /// Callback for signing out
  final VoidCallback onSignOut;

  /// Callback when the list of categories changes
  final void Function(List<String> statuses, void Function(String) scrollTo)?
  onSectionsChanged;

  /// Creates a home tab
  const HomeTab({
    super.key,
    this.isGridMode = false,
    required this.onSignOut,
    this.onSectionsChanged,
  });

  @override
  State<HomeTab> createState() => _HomeTabState();
}

/// State for HomeTab
class _HomeTabState extends State<HomeTab> {
  bool _isLoading = true;
  List<dynamic> _lists = [];
  String? _error;
  final _scrollController = ScrollController();
  String? _activeStatus;

  static bool _hasFetchedThisSession = false;

  @override
  void initState() {
    super.initState();
    _fetchLists();
  }

  @override
  /// Disposes the scroll controller
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Notifies parent of the available list sections
  void _notifySections() {
    widget.onSectionsChanged?.call(
      _lists.map((l) => l['name'] as String).toList(),
      _selectSection,
    );
  }

  /// Selects a section by name and scrolls to top
  void _selectSection(String name) {
    if (_activeStatus == name) return;
    setState(() => _activeStatus = name);
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }
  }

  /// Handles updates to an individual anime entry
  void _handleEntryUpdated(int mediaId, Map<String, dynamic> updates) {
    const orderedNames = [
      'WATCHING',
      'PLANNING',
      'COMPLETED',
      'REPEATING',
      'PAUSED',
      'DROPPED',
    ];

    String? targetName;
    if (updates.containsKey('status')) {
      final st = updates['status'] as String;
      targetName = st == 'CURRENT' ? 'WATCHING' : st;
    }

    Map<String, dynamic>? movedEntry;

    final updatedLists = _lists.map((s) {
      final section = Map<String, dynamic>.from(s as Map<String, dynamic>);
      final entries = (section['entries'] as List<dynamic>)
          .map((e) => Map<String, dynamic>.from(e as Map<String, dynamic>))
          .toList();

      final idx = entries.indexWhere(
        (e) => (e['media'] as Map<String, dynamic>?)?['id'] == mediaId,
      );

      if (idx == -1) {
        section['entries'] = entries;
        return section;
      }

      final entry = entries[idx];
      final oldStatus = entry['status'] as String?;

      updates.forEach((key, value) {
        entry[key] = value;
      });

      final newStatus = entry['status'] as String?;

      if (targetName != null && oldStatus != newStatus) {
        movedEntry = Map<String, dynamic>.from(entry);
        entries.removeAt(idx);
      }

      section['entries'] = entries;
      return section;
    }).toList();

    if (movedEntry != null && targetName != null) {
      final targetIdx = updatedLists.indexWhere((s) => s['name'] == targetName);
      if (targetIdx != -1) {
        (updatedLists[targetIdx]['entries'] as List).add(movedEntry);
      } else {
        final insertAt = updatedLists.indexWhere((s) {
          final pos = orderedNames.indexOf(s['name'] as String);
          return pos > orderedNames.indexOf(targetName!);
        });
        final newSection = {
          'name': targetName,
          'entries': <dynamic>[movedEntry],
        };
        if (insertAt == -1) {
          updatedLists.add(newSection);
        } else {
          updatedLists.insert(insertAt, newSection);
        }
      }
    }

    setState(() {
      _lists = updatedLists;
      if (_activeStatus == null) {
        final firstNonEmpty = updatedLists.firstWhere(
          (s) => (s['entries'] as List).isNotEmpty,
          orElse: () => updatedLists.first,
        );
        _activeStatus = firstNonEmpty['name'] as String;
      }
    });

    _notifySections();

    SharedPreferences.getInstance().then(
      (prefs) =>
          prefs.setString('cached_anime_lists', jsonEncode(updatedLists)),
    );
  }

  /// Retrieves the viewer's user ID from cache or network
  Future<int?> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedJson = prefs.getString('cached_viewer');
    if (cachedJson != null) {
      try {
        final data = jsonDecode(cachedJson);
        return data['id'] as int?;
      } catch (_) {}
    }

    try {
      final token = await AuthService.getRawToken() ?? '';
      final response = await BackendHelper.fetchViewer(token);
      final viewer = response.viewer;
      final viewerMap = {
        'id': viewer.id,
        'name': viewer.name,
        'createdAt': viewer.createdAt,
        'avatar': {'medium': viewer.avatarMedium},
      };
      await prefs.setString('cached_viewer', jsonEncode(viewerMap));
      await prefs.setInt(
        'cached_viewer_at',
        DateTime.now().millisecondsSinceEpoch,
      );
      return viewer.id;
    } catch (e) {
      return null;
    }
  }

  /// Fetches the user's anime lists from cache or network
  Future<void> _fetchLists({bool forceRefresh = false}) async {
    final prefs = await SharedPreferences.getInstance();

    if (!forceRefresh) {
      final cachedJson = prefs.getString('cached_anime_lists');
      if (cachedJson != null) {
        try {
          final lists = jsonDecode(cachedJson) as List<dynamic>;
          if (mounted) {
            setState(() {
              _lists = lists;
              _isLoading = false;
              if (_activeStatus == null) {
                final firstNonEmpty = lists.firstWhere(
                  (l) => (l['entries'] as List).isNotEmpty,
                  orElse: () => lists.first,
                );
                _activeStatus = firstNonEmpty['name'] as String;
              }
            });
            _notifySections();
          }
          if (_hasFetchedThisSession) {
            return;
          }
        } catch (_) {}
      }
    }

    try {
      final userId = await _getUserId();
      if (userId == null) {
        if (mounted && _lists.isEmpty) {
          setState(() {
            _error = 'Failed to get user ID';
            _isLoading = false;
          });
        }
        return;
      }

      final token = await AuthService.getRawToken() ?? '';

      final response = await BackendHelper.fetchMediaList(userId, token);
      final rawLists = response.collection.lists;

      final allEntries = <dynamic>[];
      for (final list in rawLists) {
        for (final entry in list.entries) {
          final media = entry.media;
          final entryMap = <String, dynamic>{
            'status': entry.status,
            'progress': entry.progress,
            'repeat': entry.repeat,
            'score': entry.score,
            'media': {
              'id': media.id,
              'title': {
                'userPreferred': media.title.userPreferred,
                'english': media.title.english,
                'native': media.title.native,
                'romaji': media.title.romaji,
              },
              'averageScore': media.averageScore,
              'bannerImage': media.bannerImage.isNotEmpty
                  ? media.bannerImage
                  : null,
              'coverImage': {
                'medium': media.coverImage.medium,
                'large': media.coverImage.large,
                'extraLarge': media.coverImage.extraLarge,
                'color': media.coverImage.color.isNotEmpty
                    ? media.coverImage.color
                    : null,
              },
              'description': media.description,
              'duration': media.duration,
              'episodes': media.episodes,
              'format': media.format,
              'genres': media.genres,
              'isAdult': media.isAdult,
              'isFavourite': media.isFavourite,
              'popularity': media.popularity,
              'season': media.season,
              'seasonYear': media.seasonYear,
              'status': media.status,
            },
          };

          if (entry.hasStartedAt()) {
            entryMap['startedAt'] = {
              'year': entry.startedAt.year,
              'month': entry.startedAt.month,
              'day': entry.startedAt.day,
            };
          }

          if (entry.hasCompletedAt()) {
            entryMap['completedAt'] = {
              'year': entry.completedAt.year,
              'month': entry.completedAt.month,
              'day': entry.completedAt.day,
            };
          }

          allEntries.add(entryMap);
        }
      }

      final Map<String, List<dynamic>> grouped = {
        'CURRENT': [],
        'REPEATING': [],
        'PLANNING': [],
        'COMPLETED': [],
        'PAUSED': [],
        'DROPPED': [],
      };

      for (final entry in allEntries) {
        final status = entry['status'] as String? ?? 'UNKNOWN';
        grouped[status] ??= [];
        grouped[status]!.add(entry);
      }

      final orderedStatuses = [
        'CURRENT',
        'PLANNING',
        'COMPLETED',
        'REPEATING',
        'PAUSED',
        'DROPPED',
      ];

      final processedLists = <Map<String, dynamic>>[];
      for (final status in orderedStatuses) {
        final name = status == 'CURRENT' ? 'WATCHING' : status;
        processedLists.add({'name': name, 'entries': grouped[status] ?? []});
      }

      for (final status in grouped.keys) {
        if (!orderedStatuses.contains(status) && grouped[status]!.isNotEmpty) {
          final name = status == 'CURRENT' ? 'WATCHING' : status;
          processedLists.add({'name': name, 'entries': grouped[status]});
        }
      }

      await prefs.setString('cached_anime_lists', jsonEncode(processedLists));
      _hasFetchedThisSession = true;

      if (mounted) {
        setState(() {
          _lists = processedLists;
          _isLoading = false;
          _error = null;

          if (_activeStatus == null) {
            final firstNonEmpty = processedLists.firstWhere(
              (l) => (l['entries'] as List).isNotEmpty,
              orElse: () => processedLists.first,
            );
            _activeStatus = firstNonEmpty['name'] as String;
          }
        });
        _notifySections();
      }
    } catch (e) {
      if (mounted && _lists.isEmpty) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      } else if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to refresh lists: $e')));
      }
    }
  }

  /// Shows the anime options bottom sheet
  void _showItemOptions(
    BuildContext context,
    Map<String, dynamic> entry,
  ) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.3,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return AnimeOptionsSheet(
              entry: entry,
              scrollController: scrollController,
            );
          },
        );
      },
    );

    if (result != null && mounted) {
      final mediaId = entry['media']?['id'] as int?;
      if (mediaId != null) {
        _handleEntryUpdated(mediaId, result);
      }
    }
  }

  @override
  /// Builds the main home tab widget
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const AppLoadingIndicator();
    }

    if (_error != null) {
      return AppErrorView(
        message: _error!,
        onRetry: () => _fetchLists(forceRefresh: true),
      );
    }

    if (_lists.isEmpty) {
      return const AppErrorView(message: 'No anime lists found.');
    }

    final activeList =
        _lists.firstWhere(
              (l) => l['name'] == _activeStatus,
              orElse: () => _lists.first as Map<String, dynamic>,
            )
            as Map<String, dynamic>;
    final activeName = activeList['name'] as String? ?? '';
    final activeEntries = activeList['entries'] as List<dynamic>? ?? [];

    return RefreshIndicator(
      color: borderColor,
      backgroundColor: hoverBgColor,
      onRefresh: () => _fetchLists(forceRefresh: true),
      child: widget.isGridMode
          ? CustomScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 24,
                    ),
                    child: SectionTitle(title: activeName),
                  ),
                ),
                if (activeEntries.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: AppErrorView(
                      message: 'No anime currently in $activeName',
                      topPadding: 0,
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 100,
                    ),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            childAspectRatio: 0.7,
                          ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return _buildGridItem(
                          activeEntries[index] as Map<String, dynamic>,
                        );
                      }, childCount: activeEntries.length),
                    ),
                  ),
              ],
            )
          : activeEntries.isEmpty
          ? ListView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 16, bottom: 100),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: SectionTitle(title: activeName, bottomPadding: 0),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: AppErrorView(
                    message: 'No anime currently in $activeName',
                    topPadding: 0,
                  ),
                ),
              ],
            )
          : ListView.builder(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 16, bottom: 100),
              itemCount: activeEntries.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: SectionTitle(title: activeName, bottomPadding: 0),
                  );
                }
                return AnimeListCard(
                  entry: activeEntries[index - 1] as Map<String, dynamic>,
                  onEntryUpdated: _handleEntryUpdated,
                  onTap: () async {
                    final e = activeEntries[index - 1] as Map<String, dynamic>;
                    final mediaId =
                        (e['media'] as Map<String, dynamic>?)?['id'] as int?;
                    if (mediaId != null) {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AnimePage(mediaId: mediaId),
                        ),
                      );
                      if (result == true) {
                        _fetchLists(forceRefresh: true);
                      }
                    }
                  },
                  onLongPress: () => _showItemOptions(
                    context,
                    activeEntries[index - 1] as Map<String, dynamic>,
                  ),
                );
              },
            ),
    );
  }

  /// Builds an individual item for the grid view
  Widget _buildGridItem(Map<String, dynamic> entry) {
    final media = entry['media'] as Map<String, dynamic>? ?? {};
    final title = media['title']?['userPreferred'] ?? 'Unknown';
    final coverImage = media['coverImage'] as Map<String, dynamic>? ?? {};
    final imageUrl = coverImage['large'] as String? ?? '';
    final colorStr = coverImage['color'] as String?;

    final isAdult = media['isAdult'] as bool? ?? false;
    final isFavourite = media['isFavourite'] as bool? ?? false;

    Color accentColor = borderColor;
    if (colorStr != null && colorStr.startsWith('#')) {
      final hex = colorStr.replaceAll('#', '');
      if (hex.length == 6) {
        accentColor = Color(int.parse('FF$hex', radix: 16));
      }
    }

    return GestureDetector(
      onTap: () async {
        final mediaId = media['id'] as int?;
        if (mediaId != null) {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AnimePage(mediaId: mediaId),
            ),
          );
          if (result == true) {
            _fetchLists(forceRefresh: true);
          }
        }
      },
      onLongPress: () => _showItemOptions(context, entry),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: accentColor.withValues(alpha: 0.5),
            width: 1.5,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.5),
          child: Stack(
            fit: StackFit.expand,
            children: [
              AppNetworkImage(
                imageUrl: imageUrl,
                width: double.infinity,
                height: double.infinity,
                borderRadius: BorderRadius.circular(10.5),
              ),
              if (isFavourite)
                const Positioned(
                  top: 6,
                  right: 6,
                  child: AppFavouriteBadge(hasBackground: true),
                ),
              if (isAdult)
                const Positioned(
                  bottom: 47,
                  right: 6,
                  child: AppAdultBadge(),
                ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.6),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 6.0,
                      ),
                      child: SizedBox(
                        height: 29.0,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              height: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
