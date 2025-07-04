import 'package:flutter/material.dart';
import '../core/breakpoints.dart';
import '../core/responsive_helper.dart';
import '../core/design_tokens.dart';

/// Extension on BuildContext to provide easy access to design system
extension DesignSystemExtension on BuildContext {
  /// Get responsive helper instance
  ResponsiveHelper get responsive => ResponsiveHelper.instance;

  /// Get current device size
  DeviceSize get deviceSize => responsive.deviceSize;

  /// Get screen dimensions
  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;

  /// Device type checks
  bool get isMobile => responsive.isMobile;
  bool get isTablet => responsive.isTablet;
  bool get isDesktop => responsive.isDesktop;

  /// Get responsive values
  T responsiveValue<T>(ResponsiveValue<T> value) {
    return responsive.getResponsiveValue(value);
  }

  /// Scale values based on screen size
  double scaleWidth(double value) => responsive.scaleWidth(value);
  double scaleHeight(double value) => responsive.scaleHeight(value);

  /// Get responsive font size
  double responsiveFontSize(double baseFontSize) {
    return responsive.getResponsiveFontSize(baseFontSize);
  }

  /// Get responsive padding
  EdgeInsets responsivePadding({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
  }) {
    return responsive.getResponsivePadding(
      xs: xs ?? 8.0,
      sm: sm ?? 12.0,
      md: md ?? 16.0,
      lg: lg ?? 20.0,
      xl: xl ?? 24.0,
    );
  }

  /// Get responsive margin
  EdgeInsets responsiveMargin({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
  }) {
    return responsive.getResponsiveMargin(
      xs: xs ?? 4.0,
      sm: sm ?? 8.0,
      md: md ?? 12.0,
      lg: lg ?? 16.0,
      xl: xl ?? 20.0,
    );
  }
}

/// Extension for spacing
extension SpacingExtension on BuildContext {
  /// Get responsive spacing values
  double get spacingXs => responsiveValue(AppSpacing.responsiveXs);
  double get spacingSm => responsiveValue(AppSpacing.responsiveSm);
  double get spacingMd => responsiveValue(AppSpacing.responsiveMd);
  double get spacingLg => responsiveValue(AppSpacing.responsiveLg);
  double get spacingXl => responsiveValue(AppSpacing.responsiveXl);

  /// Get padding with responsive spacing
  EdgeInsets paddingAll(double value) =>
      EdgeInsets.all(responsiveFontSize(value));
  EdgeInsets paddingSymmetric({double? horizontal, double? vertical}) =>
      EdgeInsets.symmetric(
        horizontal: horizontal != null ? responsiveFontSize(horizontal) : 0,
        vertical: vertical != null ? responsiveFontSize(vertical) : 0,
      );
  EdgeInsets paddingOnly({
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) =>
      EdgeInsets.only(
        left: left != null ? responsiveFontSize(left) : 0,
        top: top != null ? responsiveFontSize(top) : 0,
        right: right != null ? responsiveFontSize(right) : 0,
        bottom: bottom != null ? responsiveFontSize(bottom) : 0,
      );

  /// Get margin with responsive spacing
  EdgeInsets marginAll(double value) =>
      EdgeInsets.all(responsiveFontSize(value));
  EdgeInsets marginSymmetric({double? horizontal, double? vertical}) =>
      EdgeInsets.symmetric(
        horizontal: horizontal != null ? responsiveFontSize(horizontal) : 0,
        vertical: vertical != null ? responsiveFontSize(vertical) : 0,
      );
  EdgeInsets marginOnly({
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) =>
      EdgeInsets.only(
        left: left != null ? responsiveFontSize(left) : 0,
        top: top != null ? responsiveFontSize(top) : 0,
        right: right != null ? responsiveFontSize(right) : 0,
        bottom: bottom != null ? responsiveFontSize(bottom) : 0,
      );
}

/// Extension for border radius
extension RadiusExtension on BuildContext {
  /// Get responsive border radius values
  double get radiusXs => responsiveValue(AppRadius.responsiveXs);
  double get radiusSm => responsiveValue(AppRadius.responsiveSm);
  double get radiusMd => responsiveValue(AppRadius.responsiveMd);

  /// Get border radius with responsive values
  BorderRadius borderRadiusAll(double value) =>
      BorderRadius.circular(responsiveFontSize(value));
  BorderRadius borderRadiusOnly({
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
  }) =>
      BorderRadius.only(
        topLeft: Radius.circular(
          topLeft != null ? responsiveFontSize(topLeft) : 0,
        ),
        topRight: Radius.circular(
          topRight != null ? responsiveFontSize(topRight) : 0,
        ),
        bottomLeft: Radius.circular(
          bottomLeft != null ? responsiveFontSize(bottomLeft) : 0,
        ),
        bottomRight: Radius.circular(
          bottomRight != null ? responsiveFontSize(bottomRight) : 0,
        ),
      );
}

/// Extension for elevation
extension ElevationExtension on BuildContext {
  /// Get responsive elevation values
  double get elevationXs => responsiveValue(AppElevation.responsiveXs);
  double get elevationSm => responsiveValue(AppElevation.responsiveSm);
  double get elevationMd => responsiveValue(AppElevation.responsiveMd);

  /// Get box shadow with responsive elevation
  List<BoxShadow> boxShadow(double elevation) {
    return [
      BoxShadow(
        color: Colors.black.withAlpha(
            26), // 0.1 opacity is approximately 26 in alpha (0.1 * 255 ≈ 26)
        offset: Offset(0, elevation / 2),
        blurRadius: elevation,
        spreadRadius: 0,
      ),
    ];
  }
}

/// Extension for icon sizing
extension IconSizeExtension on BuildContext {
  /// Get responsive icon sizes
  double get iconSizeXs => responsiveValue(AppSizing.responsiveIconXs);
  double get iconSizeSm => responsiveValue(AppSizing.responsiveIconSm);
  double get iconSizeMd => responsiveValue(AppSizing.responsiveIconMd);
  double get iconSizeLg => responsiveValue(AppSizing.responsiveIconLg);
}

/// Extension for theme access
extension ThemeExtension on BuildContext {
  /// Get current theme
  ThemeData get theme => Theme.of(this);

  /// Get color scheme
  ColorScheme get colorScheme => theme.colorScheme;

  /// Get text theme
  TextTheme get textTheme => theme.textTheme;

  /// Check if dark mode is enabled
  bool get isDarkMode => theme.brightness == Brightness.dark;
}

/// Extension for media query shortcuts
extension MediaQueryExtension on BuildContext {
  /// Get media query data
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Get orientation
  Orientation get orientation => mediaQuery.orientation;

  /// Check if portrait
  bool get isPortrait => orientation == Orientation.portrait;

  /// Check if landscape
  bool get isLandscape => orientation == Orientation.landscape;

  /// Get device pixel ratio
  double get pixelRatio => mediaQuery.devicePixelRatio;

  /// Get text scale factor
  TextScaler get textScaler => mediaQuery.textScaler;

  /// Get platform brightness
  Brightness get platformBrightness => mediaQuery.platformBrightness;

  /// Get view insets
  EdgeInsets get viewInsets => mediaQuery.viewInsets;

  /// Get padding
  EdgeInsets get padding => mediaQuery.padding;

  /// Get safe area
  EdgeInsets get safeArea => mediaQuery.padding;

  /// Get keyboard height
  double get keyboardHeight => viewInsets.bottom;

  /// Check if keyboard is visible
  bool get isKeyboardVisible => keyboardHeight > 0;
}
