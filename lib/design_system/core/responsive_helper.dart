import 'package:flutter/material.dart';
import 'breakpoints.dart';

/// Helper class for responsive design calculations
class ResponsiveHelper {
  static ResponsiveHelper? _instance;
  static ResponsiveHelper get instance => _instance ??= ResponsiveHelper._();
  ResponsiveHelper._();

  late double _screenWidth;
  late double _screenHeight;
  late DeviceSize _deviceSize;

  /// Initialize with screen dimensions
  void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _screenWidth = size.width;
    _screenHeight = size.height;
    _deviceSize = _screenWidth.deviceSize;
  }

  /// Get current screen width
  double get screenWidth => _screenWidth;

  /// Get current screen height
  double get screenHeight => _screenHeight;

  /// Get current device size
  DeviceSize get deviceSize => _deviceSize;

  /// Check if current device is mobile
  bool get isMobile =>
      _deviceSize == DeviceSize.xs || _deviceSize == DeviceSize.sm;

  /// Check if current device is tablet
  bool get isTablet => _deviceSize == DeviceSize.md;

  /// Check if current device is desktop
  bool get isDesktop =>
      _deviceSize == DeviceSize.lg || _deviceSize == DeviceSize.xl;

  /// Get responsive value based on current screen size
  T getResponsiveValue<T>(ResponsiveValue<T> value) {
    return value.getValue(_deviceSize);
  }

  /// Scale value based on screen width
  double scaleWidth(double value) {
    return value * (_screenWidth / AppBreakpoints.desktop);
  }

  /// Scale value based on screen height
  double scaleHeight(double value) {
    return value * (_screenHeight / 1080); // Assuming 1080p as base
  }

  /// Get responsive font size
  double getResponsiveFontSize(double baseFontSize) {
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

    return baseFontSize * scaleFactor;
  }

  /// Get responsive padding
  EdgeInsets getResponsivePadding({
    double xs = 8.0,
    double sm = 12.0,
    double md = 16.0,
    double lg = 20.0,
    double xl = 24.0,
  }) {
    final padding = ResponsiveValue(
      xs: xs,
      sm: sm,
      md: md,
      lg: lg,
      xl: xl,
    ).getValue(_deviceSize);

    return EdgeInsets.all(padding);
  }

  /// Get responsive margin
  EdgeInsets getResponsiveMargin({
    double xs = 4.0,
    double sm = 8.0,
    double md = 12.0,
    double lg = 16.0,
    double xl = 20.0,
  }) {
    final margin = ResponsiveValue(
      xs: xs,
      sm: sm,
      md: md,
      lg: lg,
      xl: xl,
    ).getValue(_deviceSize);

    return EdgeInsets.all(margin);
  }
}
