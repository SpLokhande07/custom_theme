import 'package:flutter/material.dart';
import 'breakpoints.dart';

/// Design tokens for spacing
class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;

  /// Responsive spacing
  static ResponsiveValue<double> get responsiveXs => ResponsiveValue(
        xs: 2.0,
        sm: 4.0,
        md: 4.0,
        lg: 6.0,
        xl: 8.0,
      );

  static ResponsiveValue<double> get responsiveSm => ResponsiveValue(
        xs: 4.0,
        sm: 6.0,
        md: 8.0,
        lg: 10.0,
        xl: 12.0,
      );

  static ResponsiveValue<double> get responsiveMd => ResponsiveValue(
        xs: 8.0,
        sm: 12.0,
        md: 16.0,
        lg: 20.0,
        xl: 24.0,
      );

  static ResponsiveValue<double> get responsiveLg => ResponsiveValue(
        xs: 12.0,
        sm: 16.0,
        md: 24.0,
        lg: 32.0,
        xl: 40.0,
      );

  static ResponsiveValue<double> get responsiveXl => ResponsiveValue(
        xs: 16.0,
        sm: 24.0,
        md: 32.0,
        lg: 40.0,
        xl: 48.0,
      );
}

/// Design tokens for border radius
class AppRadius {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double round = 999.0;

  /// Responsive border radius
  static ResponsiveValue<double> get responsiveXs => ResponsiveValue(
        xs: 2.0,
        sm: 3.0,
        md: 4.0,
        lg: 5.0,
        xl: 6.0,
      );

  static ResponsiveValue<double> get responsiveSm => ResponsiveValue(
        xs: 4.0,
        sm: 6.0,
        md: 8.0,
        lg: 10.0,
        xl: 12.0,
      );

  static ResponsiveValue<double> get responsiveMd => ResponsiveValue(
        xs: 6.0,
        sm: 8.0,
        md: 12.0,
        lg: 14.0,
        xl: 16.0,
      );
}

/// Design tokens for elevation
class AppElevation {
  static const double none = 0.0;
  static const double xs = 2.0;
  static const double sm = 4.0;
  static const double md = 8.0;
  static const double lg = 16.0;
  static const double xl = 24.0;

  /// Responsive elevation
  static ResponsiveValue<double> get responsiveXs => ResponsiveValue(
        xs: 1.0,
        sm: 2.0,
        md: 2.0,
        lg: 3.0,
        xl: 4.0,
      );

  static ResponsiveValue<double> get responsiveSm => ResponsiveValue(
        xs: 2.0,
        sm: 3.0,
        md: 4.0,
        lg: 5.0,
        xl: 6.0,
      );

  static ResponsiveValue<double> get responsiveMd => ResponsiveValue(
        xs: 4.0,
        sm: 6.0,
        md: 8.0,
        lg: 10.0,
        xl: 12.0,
      );
}

/// Design tokens for sizing
class AppSizing {
  static const double iconXs = 12.0;
  static const double iconSm = 16.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;
  static const double iconXl = 48.0;

  /// Responsive icon sizes
  static ResponsiveValue<double> get responsiveIconXs => ResponsiveValue(
        xs: 10.0,
        sm: 12.0,
        md: 12.0,
        lg: 14.0,
        xl: 16.0,
      );

  static ResponsiveValue<double> get responsiveIconSm => ResponsiveValue(
        xs: 12.0,
        sm: 14.0,
        md: 16.0,
        lg: 18.0,
        xl: 20.0,
      );

  static ResponsiveValue<double> get responsiveIconMd => ResponsiveValue(
        xs: 16.0,
        sm: 20.0,
        md: 24.0,
        lg: 28.0,
        xl: 32.0,
      );

  static ResponsiveValue<double> get responsiveIconLg => ResponsiveValue(
        xs: 20.0,
        sm: 24.0,
        md: 32.0,
        lg: 36.0,
        xl: 40.0,
      );
}

/// Design tokens for duration
class AppDuration {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration medium = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration extraSlow = Duration(milliseconds: 1000);
}

/// Design tokens for curves
class AppCurves {
  static const Curve easeIn = Curves.easeIn;
  static const Curve easeOut = Curves.easeOut;
  static const Curve easeInOut = Curves.easeInOut;
  static const Curve bounce = Curves.bounceOut;
  static const Curve elastic = Curves.elasticOut;
}
