import 'package:flutter/material.dart';
import '../../../../theme/theme.dart';
import '../common/custom_range_slider_thumb_shape.dart';

/// A generic selection dropdown panel for range filters.
class RangeFilterPanel extends StatefulWidget {
  /// The title of the range panel.
  final String title;

  /// Label for the minimum value field.
  final String minLabel;

  /// Label for the maximum value field.
  final String maxLabel;

  /// The minimum limit of the range.
  final double minLimit;

  /// The maximum limit of the range.
  final double maxLimit;

  /// Currently selected minimum value.
  final double? selectedMin;

  /// Currently selected maximum value.
  final double? selectedMax;

  /// Total number of divisions on the slider track.
  final int? divisions;

  /// Whether the values are decimal/floating point.
  final bool isDecimal;

  /// Callback when the range changes.
  final void Function(double? min, double? max) onChanged;

  /// Creates a range filter panel.
  const RangeFilterPanel({
    super.key,
    required this.title,
    required this.minLabel,
    required this.maxLabel,
    required this.minLimit,
    required this.maxLimit,
    required this.selectedMin,
    required this.selectedMax,
    this.divisions,
    required this.isDecimal,
    required this.onChanged,
  });

  @override
  State<RangeFilterPanel> createState() => _RangeFilterPanelState();
}

class _RangeFilterPanelState extends State<RangeFilterPanel> {
  late double _currentMin;
  late double _currentMax;

  late final TextEditingController _minController;
  late final TextEditingController _maxController;

  late final FocusNode _minFocus;
  late final FocusNode _maxFocus;

  @override
  void initState() {
    super.initState();
    _currentMin = widget.selectedMin ?? widget.minLimit;
    _currentMax = widget.selectedMax ?? widget.maxLimit;

    _minController = TextEditingController(text: _formatValue(_currentMin));
    _maxController = TextEditingController(text: _formatValue(_currentMax));

    _minFocus = FocusNode();
    _maxFocus = FocusNode();

    _minController.addListener(_onMinTextChanged);
    _maxController.addListener(_onMaxTextChanged);

    _minFocus.addListener(_onFocusChanged);
    _maxFocus.addListener(_onFocusChanged);
  }

  @override
  void didUpdateWidget(RangeFilterPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedMin != oldWidget.selectedMin ||
        widget.selectedMax != oldWidget.selectedMax) {
      setState(() {
        _currentMin = widget.selectedMin ?? widget.minLimit;
        _currentMax = widget.selectedMax ?? widget.maxLimit;

        if (!_minFocus.hasFocus) {
          _minController.text = _formatValue(_currentMin);
        }
        if (!_maxFocus.hasFocus) {
          _maxController.text = _formatValue(_currentMax);
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

  String _formatValue(double value) {
    return widget.isDecimal
        ? value.toStringAsFixed(1)
        : value.round().toString();
  }

  void _onFocusChanged() {
    setState(() {});
    if (!_minFocus.hasFocus) {
      _minController.text = _formatValue(_currentMin);
    }
    if (!_maxFocus.hasFocus) {
      _maxController.text = _formatValue(_currentMax);
    }
  }

  void _onMinTextChanged() {
    if (!_minFocus.hasFocus) return;
    final val = double.tryParse(_minController.text);
    if (val != null && val >= widget.minLimit && val <= _currentMax) {
      setState(() {
        _currentMin = val;
      });
      widget.onChanged(_currentMin, _currentMax);
    }
  }

  void _onMaxTextChanged() {
    if (!_maxFocus.hasFocus) return;
    final val = double.tryParse(_maxController.text);
    if (val != null && val >= _currentMin && val <= widget.maxLimit) {
      setState(() {
        _currentMax = val;
      });
      widget.onChanged(_currentMin, _currentMax);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                widget.title,
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
              values: RangeValues(_currentMin, _currentMax),
              min: widget.minLimit,
              max: widget.maxLimit,
              divisions: widget.divisions,
              onChanged: (values) {
                setState(() {
                  if (widget.isDecimal) {
                    _currentMin = (values.start * 10).round() / 10;
                    _currentMax = (values.end * 10).round() / 10;
                  } else {
                    _currentMin = values.start.roundToDouble();
                    _currentMax = values.end.roundToDouble();
                  }
                  _minController.text = _formatValue(_currentMin);
                  _maxController.text = _formatValue(_currentMax);
                });
                widget.onChanged(_currentMin, _currentMax);
              },
            ),
          ),
          SizedBox(height: getResponsiveSize(context, 16.0)),
          Row(
            children: [
              Expanded(
                child: _buildInput(
                  context,
                  label: widget.minLabel,
                  controller: _minController,
                  focusNode: _minFocus,
                ),
              ),
              SizedBox(width: getResponsiveSize(context, 16.0)),
              Expanded(
                child: _buildInput(
                  context,
                  label: widget.maxLabel,
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

  Widget _buildInput(
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
            keyboardType: widget.isDecimal
                ? const TextInputType.numberWithOptions(decimal: true)
                : TextInputType.number,
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
