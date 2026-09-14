import 'package:flutter/animation.dart';

/// Fast animation duration for micro-interactions
const kAnimFast = Duration(milliseconds: 150);

/// Standard animation duration for content transitions
const kAnimStandard = Duration(milliseconds: 300);

/// Easing curve for entering transitions
const kCurveEnter = Curves.easeOutCubic;

/// Easing curve for exiting transitions
const kCurveExit = Curves.easeInCubic;

/// Easing curve for symmetric expansions and state transitions
const kCurveSymmetric = Curves.easeInOut;
