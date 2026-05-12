import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

// --- Core Brand Palette (Ideal colors from Rankings Tab) ---
const paletteRed = Color(0xFF963E3C);
const paletteRedDark = Color(0xFF702E2D);
const paletteYellow = Color(0xFF9C8C3A);
const paletteYellowDark = Color(0xFF756A2B);
const paletteGreen = Color(0xFF417545);
const paletteGreenDark = Color(0xFF315434);
const paletteBlue = Color(0xFF32668C);
const paletteBlueDark = Color(0xFF234A66);
const palettePurple = Color(0xFF6B3473);
const palettePurpleDark = Color(0xFF4C2552);
const paletteGray = Color(0xFF6B7280);
const paletteGrayDark = Color(0xFF4B5563);

// --- Semantic Role Mappings ---

/// Main background color
const bgColor = Color(0xFF111111);

/// Primary accent color (derived from Blue)
const borderColor = paletteBlue;

/// Default card border color
const cardBorderColor = Color(0xFF2C2C2C);

/// Interactive state colors
const hoverBgColor = Color(0xFF1A1A1A);
const pressBgColor = Color(0xFF252525);
const shadowColor = Colors.black;

/// Text colors
const textPrimary = Colors.white;
const textSecondary = Colors.white70;
const textMuted = Colors.white54;
const textHint = Colors.white30;
const textTitle = Colors.white60;

// Legacy alias for compatibility
const textColor = textPrimary;
const sectionTitleColor = textSecondary;

/// Background and overlay colors
const overlayBackground = Color(0x80000000);
const surfaceBackground = Colors.black38;
const surfaceBackgroundDark = Colors.black54;
const surfaceBackgroundDeep = Colors.black87;
const neutralLight = Color(0xFFEEEEEE);

/// Visualization Colors (Rankings/Trends/Scores)
const scoreRed = paletteRed;
const scoreRedDark = paletteRedDark;
const scoreYellow = paletteYellow;
const scoreYellowDark = paletteYellowDark;
const scoreGreen = paletteGreen;
const scoreGreenDark = paletteGreenDark;
const scoreBlue = paletteBlue;
const scoreBlueDark = paletteBlueDark;
const scorePurple = palettePurple;
const scorePurpleDark = palettePurpleDark;

/// Icon/Component Colors
const scoreStar = Colors.amber;
const heartIcon = Colors.pinkAccent;
const adultBadge = Colors.redAccent;

/// Status Colors
const statusWatching = paletteGreen;
const statusWatchingDark = paletteGreenDark;
const statusCompleted = paletteBlue;
const statusCompletedDark = paletteBlueDark;
const statusPaused = paletteYellow;
const statusPausedDark = paletteYellowDark;
const statusDropped = paletteRed;
const statusDroppedDark = paletteRedDark;
const statusPlanning = palettePurple;
const statusPlanningDark = palettePurpleDark;
const statusOther = Color(0xFF4F4F4F);
const statusOtherDark = Color(0xFF383838);

// --- Reusable Gradient Styles ---

/// Standard yellow gradient for stars/ratings
const goldGradient = [paletteYellow, paletteYellowDark];

/// Standard red/pink gradient for hearts/popularity
const loveGradient = [paletteRed, paletteRedDark];

/// Standard shadow style
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
