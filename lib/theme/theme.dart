import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

/// Main background color
const bgColor = Color(0xFF111111);
/// Default text color
const textColor = Colors.white;
/// Primary border and accent color
const borderColor = Color(0xFF3B82F6);
/// Default card border color
const cardBorderColor = Color(0xFF2C2C2C);
/// Background color for hover states
const hoverBgColor = Color(0xFF1A1A1A);
/// Background color for pressed states
const pressBgColor = Color(0xFF252525);
/// Default shadow color
const shadowColor = Colors.black;
/// Color for section titles and secondary text
const sectionTitleColor = Color(0xFFAAAAAA);

/// Standard card shadow style
const cardShadow = BoxShadow(
  color: Color(0x80000000),
  blurRadius: 4.0,
  offset: Offset(0, 0),
);

/// Style for button containers using Mix
final buttonBoxStyle = BoxStyler()
    .color(bgColor.withValues(alpha: 0.8))
    .padding(EdgeInsetsMix.symmetric(horizontal: 24, vertical: 12))
    .borderRadius(BorderRadiusMix.circular(10))
    .border(BorderMix.all(BorderSideMix(color: borderColor, width: 1.0)))
    .shadow(
      BoxShadowMix(
        color: shadowColor.withValues(alpha: 0.5),
        blurRadius: 4.0,
        offset: const Offset(0, 0),
      ),
    )
    .onHovered(BoxStyler().color(hoverBgColor))
    .onPressed(BoxStyler().color(pressBgColor));

/// Style for button text using Mix
final buttonTextStyle = TextStyler()
    .color(textColor)
    .fontSize(15)
    .fontWeight(FontWeight.w600)
    .letterSpacing(0.3);
