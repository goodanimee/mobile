import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../components/error_view.dart';
import '../components/loading_indicator.dart';
import '../components/lucide_icons_helper.dart';
import '../models/media_studio.dart';
import '../services/media_service.dart';
import '../theme/theme.dart';

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
  bool _isLoading = true;
  Studio? _studio;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchStudioDetails();
  }

  Future<void> _fetchStudioDetails() async {
    try {
      final data = await MediaService.getStudio(widget.studioId, 1);
      if (mounted) {
        setState(() {
          _studio = data;
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
      final studio = _studio!;
      final mediaNodes = studio.media?.nodes ?? [];

      if (mediaNodes.isEmpty) {
        body = Center(
          child: Text(
            'No media found for this studio',
            style: TextStyle(color: textMuted, fontSize: fontBody(context)),
          ),
        );
      } else {
        body = ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          itemCount: mediaNodes.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final media = mediaNodes[index];
            final titleText = media.title.userPreferred.isNotEmpty
                ? media.title.userPreferred
                : media.title.romaji.isNotEmpty
                ? media.title.romaji
                : media.title.english.isNotEmpty
                ? media.title.english
                : 'Unknown';

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: hoverBgColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: cardBorderColor),
              ),
              child: Text(
                titleText,
                style: TextStyle(
                  color: textPrimary,
                  fontSize: fontBody(context),
                  fontWeight: FontWeight.w500,
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
                  right: 56,
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
                        : LucideHeartIcon(
                            isFilled: isFav,
                            color: isFav
                                ? Colors.redAccent.shade400
                                : textPrimary,
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
