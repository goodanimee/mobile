import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../theme/theme.dart';

/// A bottom sheet for selecting and filtering genres with three-state selection.
class GenreFilterSheet extends StatefulWidget {
  /// The initial selected genres.
  final Map<String, bool?> initialGenres;

  /// The list of all available genres.
  final List<String> allGenres;

  /// Optional scroll controller for the sheet.
  final ScrollController? scrollController;

  /// Creates a genre filter sheet.
  const GenreFilterSheet({
    super.key,
    required this.initialGenres,
    required this.allGenres,
    this.scrollController,
  });

  @override
  State<GenreFilterSheet> createState() => _GenreFilterSheetState();
}

class _GenreFilterSheetState extends State<GenreFilterSheet> {
  late final Map<String, bool?> _localGenres;
  String _searchQuery = '';
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _localGenres = Map<String, bool?>.from(widget.initialGenres);
    _searchController = TextEditingController();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double paddingVal = getResponsiveSize(context, 16.0);
    final List<String> filteredGenres = widget.allGenres
        .where((g) => g.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF161616),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24.0)),
          border: Border.all(color: cardBorderColor),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12.0),
            Container(
              width: 40.0,
              height: 4.0,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingVal),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filter by Genres',
                    style: TextStyle(
                      color: textPrimary,
                      fontSize: fontMedium(context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingVal),
              child: Container(
                height: getResponsiveSize(context, 40.0),
                decoration: BoxDecoration(
                  color: surfaceBackground,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: cardBorderColor),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Icon(
                      LucideIcons.search,
                      color: textMuted,
                      size: getResponsiveSize(context, 18.0),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        style: TextStyle(
                          color: textPrimary,
                          fontSize: fontBody(context),
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Search genres...',
                          hintStyle: TextStyle(color: textMuted),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    if (_searchQuery.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          _searchController.clear();
                        },
                        child: Icon(
                          LucideIcons.x,
                          color: textMuted,
                          size: getResponsiveSize(context, 18.0),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Flexible(
              child: ListView.separated(
                controller: widget.scrollController,
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: paddingVal),
                itemCount: filteredGenres.length,
                separatorBuilder: (context, index) => const Divider(
                  color: cardBorderColor,
                  height: 1.0,
                  thickness: 1.0,
                ),
                itemBuilder: (context, index) {
                  final genre = filteredGenres[index];
                  return _buildGenreOption(context, genre);
                },
              ),
            ),
            const Divider(color: cardBorderColor, height: 1.0, thickness: 1.0),
            Padding(
              padding: EdgeInsets.all(paddingVal),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        for (final g in widget.allGenres) {
                          _localGenres[g] = null;
                        }
                      });
                    },
                    child: Text(
                      'Clear All',
                      style: TextStyle(
                        color: paletteRed,
                        fontWeight: FontWeight.w600,
                        fontSize: fontBody(context),
                      ),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: textMuted,
                        fontWeight: FontWeight.w600,
                        fontSize: fontBody(context),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(_localGenres);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: borderColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      child: Text(
                        'Apply',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: fontBody(context),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenreOption(BuildContext context, String genre) {
    final state = _localGenres[genre];
    final double paddingVal = getResponsiveSize(context, 12.0);

    final Color bg;
    final Color border;
    final Color textColor;
    final FontWeight fontWeight;
    final IconData? rightIcon;
    final Color rightIconColor;

    if (state == null) {
      bg = Colors.transparent;
      border = Colors.transparent;
      textColor = textMuted;
      fontWeight = FontWeight.normal;
      rightIcon = null;
      rightIconColor = Colors.transparent;
    } else if (state == true) {
      bg = paletteGreen.withValues(alpha: 0.1);
      border = paletteGreen.withValues(alpha: 0.3);
      textColor = textPrimary;
      fontWeight = FontWeight.bold;
      rightIcon = LucideIcons.circleCheck;
      rightIconColor = paletteGreen;
    } else {
      bg = paletteRed.withValues(alpha: 0.1);
      border = paletteRed.withValues(alpha: 0.3);
      textColor = textPrimary;
      fontWeight = FontWeight.bold;
      rightIcon = LucideIcons.circleX;
      rightIconColor = paletteRed;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: () {
          setState(() {
            final bool? nextState;
            if (state == null) {
              nextState = true;
            } else if (state == true) {
              nextState = false;
            } else {
              nextState = null;
            }
            _localGenres[genre] = nextState;
          });
        },
        borderRadius: BorderRadius.circular(6.0),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: paddingVal,
            vertical: getResponsiveSize(context, 10.0),
          ),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: border),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  genre,
                  style: TextStyle(
                    color: textColor,
                    fontSize: fontBody(context),
                    fontWeight: fontWeight,
                  ),
                ),
              ),
              if (rightIcon != null)
                Icon(
                  rightIcon,
                  color: rightIconColor,
                  size: getResponsiveSize(context, 18.0),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
