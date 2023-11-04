import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AppTheme {
  static const background = Color(0xFF161718);
  static const surface = Color(0xFF212121);
  // green.shade300
  static const primary = Color(0xFF81C784);

  static const textHeader = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static const textSubheader = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
}

class AppAnimations {
  static final leftRightShimmer = [
    ShimmerEffect(duration: 1.seconds, color: AppTheme.primary),
    ShimmerEffect(
      duration: 1.seconds,
      delay: 1.5.seconds,
      angle: ShimmerEffect.defaultAngle + math.pi,
      color: AppTheme.primary,
    ),
  ];
}
