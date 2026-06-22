import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../theme/theme.dart';

/// Represents a media tag with an ID and a name.
class MediaTag {
  /// The unique identifier.
  final int id;

  /// The name of the tag.
  final String name;

  /// Creates a media tag.
  const MediaTag({required this.id, required this.name});
}

/// A custom vertical bar thumb shape for a modern, sleek slider.
class CustomSliderThumbShape extends SliderComponentShape {
  /// Width of the vertical bar thumb.
  final double thumbWidth;

  /// Height of the vertical bar thumb.
  final double thumbHeight;

  /// Corner radius of the vertical bar thumb.
  final double borderRadius;

  /// Creates a custom slider thumb shape.
  const CustomSliderThumbShape({
    this.thumbWidth = 6.0,
    this.thumbHeight = 16.0,
    this.borderRadius = 3.0,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(thumbWidth, thumbHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final RRect rect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: thumbWidth, height: thumbHeight),
      Radius.circular(borderRadius),
    );

    final Paint fillPaint = Paint()
      ..color = const Color(0xFF161616)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(rect, fillPaint);

    final Paint strokePaint = Paint()
      ..color = sliderTheme.thumbColor ?? borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawRRect(rect, strokePaint);
  }
}

/// A bottom sheet for selecting and filtering tags with three-state selection and a min percentage slider.
class TagFilterSheet extends StatefulWidget {
  /// The initial selected tags by ID.
  final Map<int, bool?> initialTags;

  /// The initial minimum tag percentage.
  final int initialMinPercentage;

  /// Optional scroll controller for the sheet.
  final ScrollController? scrollController;

  /// Creates a tag filter sheet.
  const TagFilterSheet({
    super.key,
    required this.initialTags,
    required this.initialMinPercentage,
    this.scrollController,
  });

  @override
  State<TagFilterSheet> createState() => _TagFilterSheetState();
}

class _TagFilterSheetState extends State<TagFilterSheet> {
  late final Map<int, bool?> _localTags;
  late int _localMinPercentage;
  String _searchQuery = '';
  late final TextEditingController _searchController;

  final List<MediaTag> _allTags = const [
    MediaTag(id: 1, name: 'CGI'),
    MediaTag(id: 2, name: 'Magic'),
    MediaTag(id: 3, name: 'Mecha'),
    MediaTag(id: 4, name: 'School'),
    MediaTag(id: 5, name: 'Seinen'),
    MediaTag(id: 6, name: 'Shounen'),
    MediaTag(id: 7, name: 'Super Power'),
    MediaTag(id: 8, name: 'Time Travel'),
    MediaTag(id: 9, name: 'Post-Apocalyptic'),
    MediaTag(id: 10, name: 'Space'),
  ];

  @override
  void initState() {
    super.initState();
    _localTags = Map<int, bool?>.from(widget.initialTags);
    _localMinPercentage = widget.initialMinPercentage;
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
    final List<MediaTag> filteredTags = _allTags
        .where((t) => t.name.toLowerCase().contains(_searchQuery.toLowerCase()))
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
                    'Filter by Tags',
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
                          hintText: 'Search tags...',
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
            const SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingVal),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Minimum Tag Percentage',
                        style: TextStyle(
                          color: textMuted,
                          fontSize: fontSmall(context),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$_localMinPercentage%',
                        style: TextStyle(
                          color: borderColor,
                          fontSize: fontSmall(context),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: borderColor,
                      inactiveTrackColor: cardBorderColor,
                      trackHeight: 2.0,
                      thumbColor: borderColor,
                      overlayColor: Colors.transparent,
                      overlayShape: SliderComponentShape.noOverlay,
                      thumbShape: const CustomSliderThumbShape(),
                    ),
                    child: Slider(
                      value: _localMinPercentage.toDouble(),
                      max: 100.0,
                      divisions: 100,
                      onChanged: (value) {
                        setState(() {
                          _localMinPercentage = value.round();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Flexible(
              child: ListView.separated(
                controller: widget.scrollController,
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: paddingVal),
                itemCount: filteredTags.length,
                separatorBuilder: (context, index) => const Divider(
                  color: cardBorderColor,
                  height: 1.0,
                  thickness: 1.0,
                ),
                itemBuilder: (context, index) {
                  final tag = filteredTags[index];
                  return _buildTagOption(context, tag);
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
                        for (final t in _allTags) {
                          _localTags[t.id] = null;
                        }
                        _localMinPercentage = 18;
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
                      Navigator.of(context).pop({
                        'tags': _localTags,
                        'minPercentage': _localMinPercentage,
                      });
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

  Widget _buildTagOption(BuildContext context, MediaTag tag) {
    final state = _localTags[tag.id];
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
            _localTags[tag.id] = nextState;
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
                  tag.name,
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
