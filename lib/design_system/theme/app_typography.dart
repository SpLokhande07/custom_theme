import 'package:flutter/material.dart';
import '../core/breakpoints.dart';

/// Typography system following Material Design 3 principles
class AppTypography {
  // Font families
  static const String primaryFont = 'Inter';
  static const String secondaryFont = 'Roboto';
  static const String monoFont = 'Roboto Mono';

  // Base font sizes
  static const double fontSizeXs = 10.0;
  static const double fontSizeSm = 12.0;
  static const double fontSizeMd = 14.0;
  static const double fontSizeLg = 16.0;
  static const double fontSizeXl = 18.0;
  static const double fontSize2xl = 20.0;
  static const double fontSize3xl = 24.0;
  static const double fontSize4xl = 28.0;
  static const double fontSize5xl = 32.0;
  static const double fontSize6xl = 36.0;
  static const double fontSize7xl = 48.0;
  static const double fontSize8xl = 64.0;
  static const double fontSize9xl = 72.0;

  // Font weights
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;

  // Line heights
  static const double lineHeightTight = 1.2;
  static const double lineHeightNormal = 1.5;
  static const double lineHeightRelaxed = 1.6;
  static const double lineHeightLoose = 2.0;

  // Letter spacing
  static const double letterSpacingTight = -0.05;
  static const double letterSpacingNormal = 0.0;
  static const double letterSpacingWide = 0.05;
  static const double letterSpacingWider = 0.1;

  // Responsive font sizes
  static ResponsiveValue<double> get displayLarge => ResponsiveValue(
        xs: 32.0,
        sm: 40.0,
        md: 48.0,
        lg: 56.0,
        xl: 64.0,
      );

  static ResponsiveValue<double> get displayMedium => ResponsiveValue(
        xs: 28.0,
        sm: 32.0,
        md: 36.0,
        lg: 40.0,
        xl: 48.0,
      );

  static ResponsiveValue<double> get displaySmall => ResponsiveValue(
        xs: 24.0,
        sm: 28.0,
        md: 32.0,
        lg: 36.0,
        xl: 40.0,
      );

  static ResponsiveValue<double> get headlineLarge => ResponsiveValue(
        xs: 20.0,
        sm: 24.0,
        md: 28.0,
        lg: 32.0,
        xl: 36.0,
      );

  static ResponsiveValue<double> get headlineMedium => ResponsiveValue(
        xs: 18.0,
        sm: 20.0,
        md: 24.0,
        lg: 28.0,
        xl: 32.0,
      );

  static ResponsiveValue<double> get headlineSmall => ResponsiveValue(
        xs: 16.0,
        sm: 18.0,
        md: 20.0,
        lg: 24.0,
        xl: 28.0,
      );

  static ResponsiveValue<double> get titleLarge => ResponsiveValue(
        xs: 16.0,
        sm: 18.0,
        md: 20.0,
        lg: 22.0,
        xl: 24.0,
      );

  static ResponsiveValue<double> get titleMedium => ResponsiveValue(
        xs: 14.0,
        sm: 16.0,
        md: 18.0,
        lg: 20.0,
        xl: 22.0,
      );

  static ResponsiveValue<double> get titleSmall => ResponsiveValue(
        xs: 12.0,
        sm: 14.0,
        md: 16.0,
        lg: 18.0,
        xl: 20.0,
      );

  static ResponsiveValue<double> get bodyLarge => ResponsiveValue(
        xs: 14.0,
        sm: 16.0,
        md: 16.0,
        lg: 18.0,
        xl: 20.0,
      );

  static ResponsiveValue<double> get bodyMedium => ResponsiveValue(
        xs: 12.0,
        sm: 14.0,
        md: 14.0,
        lg: 16.0,
        xl: 18.0,
      );

  static ResponsiveValue<double> get bodySmall => ResponsiveValue(
        xs: 10.0,
        sm: 12.0,
        md: 12.0,
        lg: 14.0,
        xl: 16.0,
      );

  static ResponsiveValue<double> get labelLarge => ResponsiveValue(
        xs: 12.0,
        sm: 14.0,
        md: 14.0,
        lg: 16.0,
        xl: 18.0,
      );

  static ResponsiveValue<double> get labelMedium => ResponsiveValue(
        xs: 10.0,
        sm: 12.0,
        md: 12.0,
        lg: 14.0,
        xl: 16.0,
      );

  static ResponsiveValue<double> get labelSmall => ResponsiveValue(
        xs: 8.0,
        sm: 10.0,
        md: 10.0,
        lg: 12.0,
        xl: 14.0,
      );

  /// Text style builders
  static TextStyle _buildTextStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required double lineHeight,
    required double letterSpacing,
    required Color color,
    String? fontFamily,
    TextDecoration? decoration,
    List<Shadow>? shadows,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: lineHeight,
      letterSpacing: letterSpacing,
      color: color,
      fontFamily: fontFamily ?? primaryFont,
      decoration: decoration,
      shadows: shadows,
    );
  }

  /// Display text styles
  static TextStyle displayLargeStyle(Color color, {DeviceSize? deviceSize}) {
    final size = deviceSize ?? DeviceSize.md;
    return _buildTextStyle(
      fontSize: displayLarge.getValue(size),
      fontWeight: bold,
      lineHeight: lineHeightTight,
      letterSpacing: letterSpacingTight,
      color: color,
    );
  }

  static TextStyle displayMediumStyle(Color color, {DeviceSize? deviceSize}) {
    final size = deviceSize ?? DeviceSize.md;
    return _buildTextStyle(
      fontSize: displayMedium.getValue(size),
      fontWeight: bold,
      lineHeight: lineHeightTight,
      letterSpacing: letterSpacingTight,
      color: color,
    );
  }

  static TextStyle displaySmallStyle(Color color, {DeviceSize? deviceSize}) {
    final size = deviceSize ?? DeviceSize.md;
    return _buildTextStyle(
      fontSize: displaySmall.getValue(size),
      fontWeight: semiBold,
      lineHeight: lineHeightTight,
      letterSpacing: letterSpacingNormal,
      color: color,
    );
  }

  /// Headline text styles
  static TextStyle headlineLargeStyle(Color color, {DeviceSize? deviceSize}) {
    final size = deviceSize ?? DeviceSize.md;
    return _buildTextStyle(
      fontSize: headlineLarge.getValue(size),
      fontWeight: semiBold,
      lineHeight: lineHeightTight,
      letterSpacing: letterSpacingNormal,
      color: color,
    );
  }

  static TextStyle headlineMediumStyle(Color color, {DeviceSize? deviceSize}) {
    final size = deviceSize ?? DeviceSize.md;
    return _buildTextStyle(
      fontSize: headlineMedium.getValue(size),
      fontWeight: semiBold,
      lineHeight: lineHeightTight,
      letterSpacing: letterSpacingNormal,
      color: color,
    );
  }

  static TextStyle headlineSmallStyle(Color color, {DeviceSize? deviceSize}) {
    final size = deviceSize ?? DeviceSize.md;
    return _buildTextStyle(
      fontSize: headlineSmall.getValue(size),
      fontWeight: medium,
      lineHeight: lineHeightNormal,
      letterSpacing: letterSpacingNormal,
      color: color,
    );
  }

  /// Title text styles
  static TextStyle titleLargeStyle(Color color, {DeviceSize? deviceSize}) {
    final size = deviceSize ?? DeviceSize.md;
    return _buildTextStyle(
      fontSize: titleLarge.getValue(size),
      fontWeight: medium,
      lineHeight: lineHeightNormal,
      letterSpacing: letterSpacingNormal,
      color: color,
    );
  }

  static TextStyle titleMediumStyle(Color color, {DeviceSize? deviceSize}) {
    final size = deviceSize ?? DeviceSize.md;
    return _buildTextStyle(
      fontSize: titleMedium.getValue(size),
      fontWeight: medium,
      lineHeight: lineHeightNormal,
      letterSpacing: letterSpacingNormal,
      color: color,
    );
  }

  static TextStyle titleSmallStyle(Color color, {DeviceSize? deviceSize}) {
    final size = deviceSize ?? DeviceSize.md;
    return _buildTextStyle(
      fontSize: titleSmall.getValue(size),
      fontWeight: medium,
      lineHeight: lineHeightNormal,
      letterSpacing: letterSpacingNormal,
      color: color,
    );
  }

  /// Body text styles
  static TextStyle bodyLargeStyle(Color color, {DeviceSize? deviceSize}) {
    final size = deviceSize ?? DeviceSize.md;
    return _buildTextStyle(
      fontSize: bodyLarge.getValue(size),
      fontWeight: regular,
      lineHeight: lineHeightNormal,
      letterSpacing: letterSpacingNormal,
      color: color,
    );
  }

  static TextStyle bodyMediumStyle(Color color, {DeviceSize? deviceSize}) {
    final size = deviceSize ?? DeviceSize.md;
    return _buildTextStyle(
      fontSize: bodyMedium.getValue(size),
      fontWeight: regular,
      lineHeight: lineHeightNormal,
      letterSpacing: letterSpacingNormal,
      color: color,
    );
  }

  static TextStyle bodySmallStyle(Color color, {DeviceSize? deviceSize}) {
    final size = deviceSize ?? DeviceSize.md;
    return _buildTextStyle(
      fontSize: bodySmall.getValue(size),
      fontWeight: regular,
      lineHeight: lineHeightNormal,
      letterSpacing: letterSpacingNormal,
      color: color,
    );
  }

  /// Label text styles
  static TextStyle labelLargeStyle(Color color, {DeviceSize? deviceSize}) {
    final size = deviceSize ?? DeviceSize.md;
    return _buildTextStyle(
      fontSize: labelLarge.getValue(size),
      fontWeight: medium,
      lineHeight: lineHeightNormal,
      letterSpacing: letterSpacingWide,
      color: color,
    );
  }

  static TextStyle labelMediumStyle(Color color, {DeviceSize? deviceSize}) {
    final size = deviceSize ?? DeviceSize.md;
    return _buildTextStyle(
      fontSize: labelMedium.getValue(size),
      fontWeight: medium,
      lineHeight: lineHeightNormal,
      letterSpacing: letterSpacingWide,
      color: color,
    );
  }

  static TextStyle labelSmallStyle(Color color, {DeviceSize? deviceSize}) {
    final size = deviceSize ?? DeviceSize.md;
    return _buildTextStyle(
      fontSize: labelSmall.getValue(size),
      fontWeight: medium,
      lineHeight: lineHeightNormal,
      letterSpacing: letterSpacingWider,
      color: color,
    );
  }

  /// Specialized text styles
  static TextStyle codeStyle(Color color, {DeviceSize? deviceSize}) {
    final size = deviceSize ?? DeviceSize.md;
    return _buildTextStyle(
      fontSize: bodyMedium.getValue(size),
      fontWeight: regular,
      lineHeight: lineHeightRelaxed,
      letterSpacing: letterSpacingNormal,
      color: color,
      fontFamily: monoFont,
    );
  }

  static TextStyle linkStyle(Color color, {DeviceSize? deviceSize}) {
    final size = deviceSize ?? DeviceSize.md;
    return _buildTextStyle(
      fontSize: bodyMedium.getValue(size),
      fontWeight: regular,
      lineHeight: lineHeightNormal,
      letterSpacing: letterSpacingNormal,
      color: color,
      decoration: TextDecoration.underline,
    );
  }

  static TextStyle errorStyle(Color color, {DeviceSize? deviceSize}) {
    final size = deviceSize ?? DeviceSize.md;
    return _buildTextStyle(
      fontSize: bodySmall.getValue(size),
      fontWeight: regular,
      lineHeight: lineHeightNormal,
      letterSpacing: letterSpacingNormal,
      color: color,
    );
  }

  static TextStyle captionStyle(Color color, {DeviceSize? deviceSize}) {
    final size = deviceSize ?? DeviceSize.md;
    return _buildTextStyle(
      fontSize: labelSmall.getValue(size),
      fontWeight: regular,
      lineHeight: lineHeightNormal,
      letterSpacing: letterSpacingNormal,
      color: color,
    );
  }

  static TextStyle overlineStyle(Color color, {DeviceSize? deviceSize}) {
    final size = deviceSize ?? DeviceSize.md;
    return _buildTextStyle(
      fontSize: labelSmall.getValue(size),
      fontWeight: medium,
      lineHeight: lineHeightNormal,
      letterSpacing: letterSpacingWider,
      color: color,
    );
  }

  /// Generate Material 3 TextTheme
  static TextTheme getTextTheme(ColorScheme colorScheme,
      {DeviceSize? deviceSize}) {
    final size = deviceSize ?? DeviceSize.md;

    return TextTheme(
      displayLarge: displayLargeStyle(colorScheme.onSurface, deviceSize: size),
      displayMedium:
          displayMediumStyle(colorScheme.onSurface, deviceSize: size),
      displaySmall: displaySmallStyle(colorScheme.onSurface, deviceSize: size),
      headlineLarge:
          headlineLargeStyle(colorScheme.onSurface, deviceSize: size),
      headlineMedium:
          headlineMediumStyle(colorScheme.onSurface, deviceSize: size),
      headlineSmall:
          headlineSmallStyle(colorScheme.onSurface, deviceSize: size),
      titleLarge: titleLargeStyle(colorScheme.onSurface, deviceSize: size),
      titleMedium: titleMediumStyle(colorScheme.onSurface, deviceSize: size),
      titleSmall: titleSmallStyle(colorScheme.onSurface, deviceSize: size),
      bodyLarge: bodyLargeStyle(colorScheme.onSurface, deviceSize: size),
      bodyMedium: bodyMediumStyle(colorScheme.onSurface, deviceSize: size),
      bodySmall: bodySmallStyle(colorScheme.onSurface, deviceSize: size),
      labelLarge: labelLargeStyle(colorScheme.onSurface, deviceSize: size),
      labelMedium: labelMediumStyle(colorScheme.onSurface, deviceSize: size),
      labelSmall: labelSmallStyle(colorScheme.onSurface, deviceSize: size),
    );
  }
}
