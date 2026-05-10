import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../utils/backend_helper.dart';
import '../services/auth_service.dart';
import '../theme/theme.dart';
import '../components/anime_list_card.dart';
import '../components/anime_options_sheet.dart';

class HomeTab extends StatefulWidget {
  final bool isGridMode;
  final VoidCallback onSignOut;
  final void Function(List<String> statuses, void Function(String) scrollTo)?
  onSectionsChanged;

  const HomeTab({
    super.key,
    this.isGridMode = false,
    required this.onSignOut,
    this.onSectionsChanged,
  });

  @override
  State<HomeTab> createState() => _HomeTabState();
}

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
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _notifySections() {
    widget.onSectionsChanged?.call(
      _lists.map((l) => l['name'] as String).toList(),
      _selectSection,
    );
  }

  void _selectSection(String name) {
    if (_activeStatus == name) return;
    setState(() => _activeStatus = name);
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }
  }

  void _handleEntryUpdated(int mediaId, Map<String, dynamic> updates) {
    const orderedNames = [
      'WATCHING',
      'REPEATING',
      'PLANNING',
      'COMPLETED',
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

    updatedLists.removeWhere((s) => (s['entries'] as List).isEmpty);

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

    final validNames = updatedLists.map((s) => s['name'] as String).toSet();

    setState(() {
      _lists = updatedLists;
      if (_activeStatus == null || !validNames.contains(_activeStatus)) {
        _activeStatus = updatedLists.isNotEmpty
            ? updatedLists.first['name'] as String
            : null;
      }
    });

    _notifySections();

    SharedPreferences.getInstance().then(
      (prefs) =>
          prefs.setString('cached_anime_lists', jsonEncode(updatedLists)),
    );
  }

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
              _activeStatus ??= lists.isNotEmpty
                  ? lists.first['name'] as String
                  : null;
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
        'REPEATING',
        'PLANNING',
        'COMPLETED',
        'PAUSED',
        'DROPPED',
      ];

      final processedLists = <Map<String, dynamic>>[];
      for (final status in orderedStatuses) {
        if (grouped[status] != null && grouped[status]!.isNotEmpty) {
          final name = status == 'CURRENT' ? 'WATCHING' : status;
          processedLists.add({'name': name, 'entries': grouped[status]});
        }
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
        final validNames = processedLists
            .map((l) => l['name'] as String)
            .toSet();
        setState(() {
          _lists = processedLists;
          _isLoading = false;
          _error = null;
          if (_activeStatus == null || !validNames.contains(_activeStatus)) {
            _activeStatus = processedLists.isNotEmpty
                ? processedLists.first['name'] as String
                : null;
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

  void _showItemOptions(
    BuildContext context,
    Map<String, dynamic> entry,
  ) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor:
          Colors.transparent, // Use transparent so we can draw our own border
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
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator(color: borderColor));
    }

    if (_error != null) {
      return Center(
        child: Text(
          'Error: $_error',
          style: const TextStyle(color: Colors.redAccent),
          textAlign: TextAlign.center,
        ),
      );
    }

    if (_lists.isEmpty) {
      return const Center(
        child: Text(
          'No anime lists found.',
          style: TextStyle(color: textColor),
        ),
      );
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
                      bottom: 16,
                    ),
                    child: Text(
                      activeName,
                      style: const TextStyle(
                        color: sectionTitleColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
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
                          childAspectRatio:
                              0.7, // Portrait aspect ratio (usually ~2/3 or 0.7)
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
                    child: Text(
                      activeName,
                      style: const TextStyle(
                        color: sectionTitleColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
                return AnimeListCard(
                  entry: activeEntries[index - 1] as Map<String, dynamic>,
                  onEntryUpdated: _handleEntryUpdated,
                  onLongPress: () => _showItemOptions(
                    context,
                    activeEntries[index - 1] as Map<String, dynamic>,
                  ),
                );
              },
            ),
    );
  }

  Widget _buildGridItem(Map<String, dynamic> entry) {
    final media = entry['media'] as Map<String, dynamic>? ?? {};
    final title = media['title']?['userPreferred'] ?? 'Unknown';
    final coverImage = media['coverImage'] as Map<String, dynamic>? ?? {};
    final imageUrl = coverImage['large'] as String? ?? '';
    final colorStr = coverImage['color'] as String?;

    Color accentColor = borderColor;
    if (colorStr != null && colorStr.startsWith('#')) {
      final hex = colorStr.replaceAll('#', '');
      if (hex.length == 6) {
        accentColor = Color(int.parse('FF$hex', radix: 16));
      }
    }

    return GestureDetector(
      onTap: () {
        // Optional: Open a detail view, or do nothing.
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
              imageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Container(color: hoverBgColor),
                      errorWidget: (context, url, error) =>
                          Container(color: hoverBgColor),
                    )
                  : Container(color: hoverBgColor),
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
                        height:
                            29.0, // Reserves space for exactly 2 lines (fontSize 12 * height 1.2 = 14.4 per line)
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
