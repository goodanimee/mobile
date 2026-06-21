import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import 'custom_range_slider_thumb_shape.dart';

/// The selection dropdown panel for advanced start year range filters.
class YearFilterPanel extends StatefulWidget {
  /// Current selected minimum year.
  final int? selectedMin;

  /// Current selected maximum year.
  final int? selectedMax;

  /// Callback when the year range changes.
  final void Function(int? min, int? max) onChanged;

  /// Creates a year filter panel.
  const YearFilterPanel({
    super.key,
    required this.selectedMin,
    required this.selectedMax,
    required this.onChanged,
  });

  @override
  State<YearFilterPanel> createState() => _YearFilterPanelState();
}

class _YearFilterPanelState extends State<YearFilterPanel> {
  static const int minYear = 1917;
  late final int maxYear;

  late int _currentMin;
  late int _currentMax;

  late final TextEditingController _minController;
  late final TextEditingController _maxController;

  late final FocusNode _minFocus;
  late final FocusNode _maxFocus;

  @override
  void initState() {
    super.initState();
    maxYear = DateTime.now().year + 1;
    _currentMin = widget.selectedMin ?? minYear;
    _currentMax = widget.selectedMax ?? maxYear;

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
  void didUpdateWidget(YearFilterPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedMin != oldWidget.selectedMin ||
        widget.selectedMax != oldWidget.selectedMax) {
      setState(() {
        _currentMin = widget.selectedMin ?? minYear;
        _currentMax = widget.selectedMax ?? maxYear;

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
    if (val != null && val >= minYear && val <= _currentMax) {
      setState(() {
        _currentMin = val;
      });
      widget.onChanged(_currentMin, _currentMax);
    }
  }

  void _onMaxTextChanged() {
    if (!_maxFocus.hasFocus) return;
    final val = int.tryParse(_maxController.text);
    if (val != null && val >= _currentMin && val <= maxYear) {
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
                'Year Range',
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
              min: minYear.toDouble(),
              max: maxYear.toDouble(),
              divisions: maxYear - minYear,
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
                child: _buildYearInput(
                  context,
                  label: 'Min Year',
                  controller: _minController,
                  focusNode: _minFocus,
                ),
              ),
              SizedBox(width: getResponsiveSize(context, 16.0)),
              Expanded(
                child: _buildYearInput(
                  context,
                  label: 'Max Year',
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

  Widget _buildYearInput(
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
