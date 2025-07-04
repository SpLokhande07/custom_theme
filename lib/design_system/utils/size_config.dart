import 'package:flutter/material.dart';
import '../core/breakpoints.dart';

/// Size configuration utility for responsive design
class SizeConfig {
  static late double _screenWidth;
  static late double _screenHeight;
  static late double _blockSizeHorizontal;
  static late double _blockSizeVertical;
  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double _safeBlockHorizontal;
  static late double _safeBlockVertical;
  static late DeviceSize _deviceSize;
  static late Orientation _orientation;
  static late TextScaler _textScaler;
  static late double _pixelRatio;

  /// Initialize size configuration
  static void init(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _blockSizeHorizontal = _screenWidth / 100;
    _blockSizeVertical = _screenHeight / 100;
    _orientation = mediaQuery.orientation;
    _textScaler = mediaQuery.textScaler;
    _pixelRatio = mediaQuery.devicePixelRatio;

    _safeAreaHorizontal = mediaQuery.padding.left + mediaQuery.padding.right;
    _safeAreaVertical = mediaQuery.padding.top + mediaQuery.padding.bottom;
    _safeBlockHorizontal = (_screenWidth - _safeAreaHorizontal) / 100;
    _safeBlockVertical = (_screenHeight - _safeAreaVertical) / 100;

    _deviceSize = _screenWidth.deviceSize;
  }

  /// Get screen width
  static double get screenWidth => _screenWidth;

  /// Get screen height
  static double get screenHeight => _screenHeight;

  /// Get block size horizontal (1% of screen width)
  static double get blockSizeHorizontal => _blockSizeHorizontal;

  /// Get block size vertical (1% of screen height)
  static double get blockSizeVertical => _blockSizeVertical;

  /// Get safe area horizontal
  static double get safeAreaHorizontal => _safeAreaHorizontal;

  /// Get safe area vertical
  static double get safeAreaVertical => _safeAreaVertical;

  /// Get safe block horizontal (1% of safe area width)
  static double get safeBlockHorizontal => _safeBlockHorizontal;

  /// Get safe block vertical (1% of safe area height)
  static double get safeBlockVertical => _safeBlockVertical;

  /// Get device size
  static DeviceSize get deviceSize => _deviceSize;

  /// Get orientation
  static Orientation get orientation => _orientation;

  /// Get text scale factor
  static double get textScaleFactor => 1.0; // Default value for backward compatibility
  
  /// Get text scaler
  static TextScaler get textScaler => _textScaler;

  /// Get pixel ratio
  static double get pixelRatio => _pixelRatio;

  /// Check if device is mobile
  static bool get isMobile =>
      _deviceSize == DeviceSize.xs || _deviceSize == DeviceSize.sm;

  /// Check if device is tablet
  static bool get isTablet => _deviceSize == DeviceSize.md;

  /// Check if device is desktop
  static bool get isDesktop =>
      _deviceSize == DeviceSize.lg || _deviceSize == DeviceSize.xl;

  /// Check if device is in portrait mode
  static bool get isPortrait => _orientation == Orientation.portrait;

  /// Check if device is in landscape mode
  static bool get isLandscape => _orientation == Orientation.landscape;

  /// Get responsive width based on percentage
  static double getResponsiveWidth(double percentage) {
    return _safeBlockHorizontal * percentage;
  }

  /// Get responsive height based on percentage
  static double getResponsiveHeight(double percentage) {
    return _safeBlockVertical * percentage;
  }

  /// Get responsive font size
  static double getResponsiveFontSize(double fontSize) {
    double scaleFactor = 1.0;

    // Adjust based on device size
    switch (_deviceSize) {
      case DeviceSize.xs:
        scaleFactor = 0.85;
        break;
      case DeviceSize.sm:
        scaleFactor = 0.9;
        break;
      case DeviceSize.md:
        scaleFactor = 1.0;
        break;
      case DeviceSize.lg:
        scaleFactor = 1.1;
        break;
      case DeviceSize.xl:
        scaleFactor = 1.15;
        break;
    }

    // Consider text scale factor
    return fontSize * scaleFactor * _textScaler.scale(1.0);
  }

  /// Get responsive padding
  static EdgeInsets getResponsivePadding({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    if (all != null) {
      return EdgeInsets.all(getResponsiveWidth(all));
    }

    return EdgeInsets.only(
      top: getResponsiveHeight(top ?? vertical ?? 0),
      bottom: getResponsiveHeight(bottom ?? vertical ?? 0),
      left: getResponsiveWidth(left ?? horizontal ?? 0),
      right: getResponsiveWidth(right ?? horizontal ?? 0),
    );
  }

  /// Get responsive margin
  static EdgeInsets getResponsiveMargin({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    if (all != null) {
      return EdgeInsets.all(getResponsiveWidth(all));
    }

    return EdgeInsets.only(
      top: getResponsiveHeight(top ?? vertical ?? 0),
      bottom: getResponsiveHeight(bottom ?? vertical ?? 0),
      left: getResponsiveWidth(left ?? horizontal ?? 0),
      right: getResponsiveWidth(right ?? horizontal ?? 0),
    );
  }

  /// Get responsive border radius
  static BorderRadius getResponsiveBorderRadius(double radius) {
    return BorderRadius.circular(getResponsiveWidth(radius));
  }

  /// Get responsive size for icons/images
  static double getResponsiveIconSize(double size) {
    return getResponsiveWidth(size);
  }

  /// Get responsive elevation
  static double getResponsiveElevation(double elevation) {
    double scaleFactor = 1.0;

    switch (_deviceSize) {
      case DeviceSize.xs:
        scaleFactor = 0.8;
        break;
      case DeviceSize.sm:
        scaleFactor = 0.9;
        break;
      case DeviceSize.md:
        scaleFactor = 1.0;
        break;
      case DeviceSize.lg:
        scaleFactor = 1.1;
        break;
      case DeviceSize.xl:
        scaleFactor = 1.2;
        break;
    }

    return elevation * scaleFactor;
  }

  /// Get responsive spacing
  static double getResponsiveSpacing(double spacing) {
    return getResponsiveWidth(spacing);
  }

  /// Calculate responsive dimensions for containers
  static Size getResponsiveContainerSize({
    double? width,
    double? height,
    double? aspectRatio,
  }) {
    double containerWidth =
        width != null ? getResponsiveWidth(width) : _screenWidth;
    double containerHeight = height != null
        ? getResponsiveHeight(height)
        : aspectRatio != null
            ? containerWidth / aspectRatio
            : _screenHeight;

    return Size(containerWidth, containerHeight);
  }

  /// Get minimum touch target size for accessibility
  static double get minTouchTargetSize {
    switch (_deviceSize) {
      case DeviceSize.xs:
        return 44.0;
      case DeviceSize.sm:
        return 44.0;
      case DeviceSize.md:
        return 48.0;
      case DeviceSize.lg:
        return 48.0;
      case DeviceSize.xl:
        return 52.0;
    }
  }

  /// Get responsive grid columns
  static int getResponsiveGridColumns() {
    switch (_deviceSize) {
      case DeviceSize.xs:
        return 1;
      case DeviceSize.sm:
        return 2;
      case DeviceSize.md:
        return 3;
      case DeviceSize.lg:
        return 4;
      case DeviceSize.xl:
        return 5;
    }
  }

  /// Get responsive max width for content
  static double getResponsiveMaxWidth() {
    switch (_deviceSize) {
      case DeviceSize.xs:
        return _screenWidth;
      case DeviceSize.sm:
        return _screenWidth;
      case DeviceSize.md:
        return 768.0;
      case DeviceSize.lg:
        return 1024.0;
      case DeviceSize.xl:
        return 1200.0;
    }
  }
}
