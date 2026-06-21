import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import 'custom_range_slider_thumb_shape.dart';

/// The selection dropdown panel for advanced duration or volume range filters.
class DurationFilterPanel extends StatefulWidget {
  /// Current selected minimum value.
  final int? selectedMin;

  /// Current selected maximum value.
  final int? selectedMax;

  /// Active media type (ANIME or MANGA).
  final String mediaType;

  /// Callback when the range changes.
  final void Function(int? min, int? max) onChanged;

  /// Creates a duration filter panel.
  const DurationFilterPanel({
    super.key,
    required this.selectedMin,
    required this.selectedMax,
    required this.mediaType,
    required this.onChanged,
  });

  @override
  State<DurationFilterPanel> createState() => _DurationFilterPanelState();
}

class _DurationFilterPanelState extends State<DurationFilterPanel> {
  static const int minLimit = 0;
  static const int maxLimit = 200;

  late int _currentMin;
  late int _currentMax;

  late final TextEditingController _minController;
  late final TextEditingController _maxController;

  late final FocusNode _minFocus;
  late final FocusNode _maxFocus;

  @override
  void initState() {
    super.initState();
    _currentMin = widget.selectedMin ?? minLimit;
    _currentMax = widget.selectedMax ?? maxLimit;

    _minController = TextEditingController(text: _currentMin.toString());
    _maxController = TextEditingController(text: _currentMax.toString());

    _minFocus = FocusNode();
    _maxFocus = FocusNode();

    _minController.addListener(_onMinTextChanged);
    _maxController.addListener(_onMaxTextChanged);

    _minFocus.addListener(_onFocusChanged);
    _maxFocus.addListener(_onFocusChanged);
  }

  @override
  void didUpdateWidget(DurationFilterPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedMin != oldWidget.selectedMin ||
        widget.selectedMax != oldWidget.selectedMax) {
      setState(() {
        _currentMin = widget.selectedMin ?? minLimit;
        _currentMax = widget.selectedMax ?? maxLimit;

        if (!_minFocus.hasFocus) {
          _minController.text = _currentMin.toString();
        }
        if (!_maxFocus.hasFocus) {
          _maxController.text = _currentMax.toString();
        }
      });
    }
  }

  @override
  void dispose() {
    _minController.removeListener(_onMinTextChanged);
    _maxController.removeListener(_onMaxTextChanged);
    _minFocus.removeListener(_onFocusChanged);
    _maxFocus.removeListener(_onFocusChanged);
    _minController.dispose();
    _maxController.dispose();
    _minFocus.dispose();
    _maxFocus.dispose();
    super.dispose();
  }

  void _onFocusChanged() {
    setState(() {});
    if (!_minFocus.hasFocus) {
      _minController.text = _currentMin.toString();
    }
    if (!_maxFocus.hasFocus) {
      _maxController.text = _currentMax.toString();
    }
  }

  void _onMinTextChanged() {
    if (!_minFocus.hasFocus) return;
    final val = int.tryParse(_minController.text);
    if (val != null && val >= minLimit && val <= _currentMax) {
      setState(() {
        _currentMin = val;
      });
      widget.onChanged(_currentMin, _currentMax);
    }
  }

  void _onMaxTextChanged() {
    if (!_maxFocus.hasFocus) return;
    final val = int.tryParse(_maxController.text);
    if (val != null && val >= _currentMin && val <= maxLimit) {
      setState(() {
        _currentMax = val;
      });
      widget.onChanged(_currentMin, _currentMax);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isAnime = widget.mediaType == 'ANIME';
    final String title = isAnime ? 'Duration Range' : 'Volume Range';
    final String minLabel = isAnime ? 'Min Duration (mins)' : 'Min Volumes';
    final String maxLabel = isAnime ? 'Max Duration (mins)' : 'Max Volumes';

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF161616),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: cardBorderColor),
      ),
      padding: EdgeInsets.all(getResponsiveSize(context, 16.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: textMuted,
                  fontSize: fontSmall(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  widget.onChanged(null, null);
                },
                child: Text(
                  'Reset',
                  style: TextStyle(
                    color: paletteRed,
                    fontSize: fontSmall(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: getResponsiveSize(context, 16.0)),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: borderColor,
              inactiveTrackColor: cardBorderColor,
              trackHeight: 2.0,
              thumbColor: borderColor,
              overlayColor: Colors.transparent,
              overlayShape: SliderComponentShape.noOverlay,
              rangeThumbShape: const CustomRangeSliderThumbShape(),
              rangeTrackShape: const RoundedRectRangeSliderTrackShape(),
            ),
            child: RangeSlider(
              values: RangeValues(
                _currentMin.toDouble(),
                _currentMax.toDouble(),
              ),
              min: minLimit.toDouble(),
              max: maxLimit.toDouble(),
              divisions: maxLimit - minLimit,
              onChanged: (values) {
                setState(() {
                  _currentMin = values.start.round();
                  _currentMax = values.end.round();
                  _minController.text = _currentMin.toString();
                  _maxController.text = _currentMax.toString();
                });
                widget.onChanged(_currentMin, _currentMax);
              },
            ),
          ),
          SizedBox(height: getResponsiveSize(context, 16.0)),
          Row(
            children: [
              Expanded(
                child: _buildDurationInput(
                  context,
                  label: minLabel,
                  controller: _minController,
                  focusNode: _minFocus,
                ),
              ),
              SizedBox(width: getResponsiveSize(context, 16.0)),
              Expanded(
                child: _buildDurationInput(
                  context,
                  label: maxLabel,
                  controller: _maxController,
                  focusNode: _maxFocus,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDurationInput(
    BuildContext context, {
    required String label,
    required TextEditingController controller,
    required FocusNode focusNode,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: textMuted,
            fontSize: fontMini(context),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6.0),
        Container(
          height: getResponsiveSize(context, 40.0),
          decoration: BoxDecoration(
            color: surfaceBackground,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(
              color: focusNode.hasFocus ? borderColor : cardBorderColor,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          alignment: Alignment.center,
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: TextInputType.number,
            style: TextStyle(color: textPrimary, fontSize: fontBody(context)),
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }
}
