import 'package:flutter/widgets.dart';

/// Font size for mini text.
const double fontMiniBase = 11.0;

/// Font size for small text.
const double fontSmallBase = 12.0;

/// Font size for body text.
const double fontBodyBase = 13.5;

/// Font size for medium text.
const double fontMediumBase = 15.0;

/// Font size for large text.
const double fontLargeBase = 16.0;

/// Font size for title text.
const double fontTitleBase = 18.0;

/// Returns a responsive font size based on screen width.
double getResponsiveFontSize(BuildContext context, double baseFontSize) {
  final width = MediaQuery.of(context).size.width;
  final scaleFactor = (width / 486.0).clamp(0.8, 1.0);
  return baseFontSize * scaleFactor;
}

/// Returns a responsive size based on screen width.
double getResponsiveSize(BuildContext context, double baseSize) {
  final width = MediaQuery.of(context).size.width;
  final scaleFactor = (width / 486.0).clamp(0.8, 1.0);
  return baseSize * scaleFactor;
}

/// Scaled size for mini text.
double fontMini(BuildContext context) =>
    getResponsiveFontSize(context, fontMiniBase);

/// Scaled size for small text.
double fontSmall(BuildContext context) =>
    getResponsiveFontSize(context, fontSmallBase);

/// Scaled size for body text.
double fontBody(BuildContext context) =>
    getResponsiveFontSize(context, fontBodyBase);

/// Scaled size for medium text.
double fontMedium(BuildContext context) =>
    getResponsiveFontSize(context, fontMediumBase);

/// Scaled size for large text.
double fontLarge(BuildContext context) =>
    getResponsiveFontSize(context, fontLargeBase);

/// Scaled size for title text.
double fontTitle(BuildContext context) =>
    getResponsiveFontSize(context, fontTitleBase);
