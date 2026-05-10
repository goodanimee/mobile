import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

const bgColor = Color(0xFF111111);
const textColor = Colors.white;
const borderColor = Color(0xFF3B82F6);
const cardBorderColor = Color(0xFF2C2C2C);
const hoverBgColor = Color(0xFF1A1A1A);
const pressBgColor = Color(0xFF252525);
const shadowColor = Colors.black;
const sectionTitleColor = Color(0xFFAAAAAA);

const cardShadow = BoxShadow(
  color: Color(0x80000000),
  blurRadius: 4.0,
  offset: Offset(0, 0),
);

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

final buttonTextStyle = TextStyler()
    .color(textColor)
    .fontSize(15)
    .fontWeight(FontWeight.w600)
    .letterSpacing(0.3);
