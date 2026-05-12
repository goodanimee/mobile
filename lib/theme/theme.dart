import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

/// Primary brand red
const paletteRed = Color(0xFF963E3C);

/// Dark variant of brand red
const paletteRedDark = Color(0xFF702E2D);

/// Primary brand yellow
const paletteYellow = Color(0xFF9C8C3A);

/// Dark variant of brand yellow
const paletteYellowDark = Color(0xFF756A2B);

/// Primary brand green
const paletteGreen = Color(0xFF417545);

/// Dark variant of brand green
const paletteGreenDark = Color(0xFF315434);

/// Primary brand blue
const paletteBlue = Color(0xFF32668C);

/// Dark variant of brand blue
const paletteBlueDark = Color(0xFF234A66);

/// Primary brand purple
const palettePurple = Color(0xFF6B3473);

/// Dark variant of brand purple
const palettePurpleDark = Color(0xFF4C2552);

/// Primary brand gray
const paletteGray = Color(0xFF6B7280);

/// Dark variant of brand gray
const paletteGrayDark = Color(0xFF4B5563);

/// Main background color
const bgColor = Color(0xFF111111);

/// Primary accent color
const borderColor = paletteBlue;

/// Default card border color
const cardBorderColor = Color(0xFF2C2C2C);

/// Background color for hover states
const hoverBgColor = Color(0xFF1A1A1A);

/// Background color for pressed states
const pressBgColor = Color(0xFF252525);

/// Default shadow color
const shadowColor = Colors.black;

/// Default text color
const textPrimary = Colors.white;

/// Secondary text color
const textSecondary = Colors.white70;

/// Muted text color
const textMuted = Colors.white54;

/// Hint text color
const textHint = Colors.white30;

/// Title text color
const textTitle = Colors.white60;

/// Alias for textPrimary
const textColor = textPrimary;

/// Alias for textSecondary
const sectionTitleColor = textSecondary;

/// Background color for overlays
const overlayBackground = Color(0x80000000);

/// General surface background
const surfaceBackground = Colors.black38;

/// Darker surface background
const surfaceBackgroundDark = Colors.black54;

/// Deepest surface background
const surfaceBackgroundDeep = Colors.black87;

/// Neutral light color
const neutralLight = Color(0xFFEEEEEE);

/// Visualization red
const scoreRed = paletteRed;

/// Dark visualization red
const scoreRedDark = paletteRedDark;

/// Visualization yellow
const scoreYellow = paletteYellow;

/// Dark visualization yellow
const scoreYellowDark = paletteYellowDark;

/// Visualization green
const scoreGreen = paletteGreen;

/// Dark visualization green
const scoreGreenDark = paletteGreenDark;

/// Visualization blue
const scoreBlue = paletteBlue;

/// Dark visualization blue
const scoreBlueDark = paletteBlueDark;

/// Visualization purple
const scorePurple = palettePurple;

/// Dark visualization purple
const scorePurpleDark = palettePurpleDark;

/// Color for score stars
const scoreStar = Colors.amber;

/// Color for heart icons
const heartIcon = Colors.pinkAccent;

/// Color for adult badges
const adultBadge = Colors.redAccent;

/// Color for watching status
const statusWatching = paletteGreen;

/// Dark variant for watching status
const statusWatchingDark = paletteGreenDark;

/// Color for completed status
const statusCompleted = paletteBlue;

/// Dark variant for completed status
const statusCompletedDark = paletteBlueDark;

/// Color for paused status
const statusPaused = paletteYellow;

/// Dark variant for paused status
const statusPausedDark = paletteYellowDark;

/// Color for dropped status
const statusDropped = paletteRed;

/// Dark variant for dropped status
const statusDroppedDark = paletteRedDark;

/// Color for planning status
const statusPlanning = palettePurple;

/// Dark variant for planning status
const statusPlanningDark = palettePurpleDark;

/// Color for other statuses
const statusOther = Color(0xFF4F4F4F);

/// Dark variant for other statuses
const statusOtherDark = Color(0xFF383838);

/// Standard yellow gradient for stars
const goldGradient = [paletteYellow, paletteYellowDark];

/// Standard red gradient for hearts
const loveGradient = [paletteRed, paletteRedDark];

/// Standard shadow style for cards
const cardShadow = BoxShadow(
  color: Color(0x80000000),
  blurRadius: 4.0,
  offset: Offset(0, 0),
);

/// Style for button containers
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

/// Style for button text
final buttonTextStyle = TextStyler()
    .color(textColor)
    .fontSize(15)
    .fontWeight(FontWeight.w600)
    .letterSpacing(0.3);
