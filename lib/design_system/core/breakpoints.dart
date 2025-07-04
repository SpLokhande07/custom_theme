/// Defines breakpoints for responsive design
class AppBreakpoints {
  static const double mobile = 600;
  static const double tablet = 1024;
  static const double desktop = 1440;
  static const double largeDesktop = 1920;

  /// Custom breakpoints for specific use cases
  static const double smallMobile = 375;
  static const double largeMobile = 480;
  static const double smallTablet = 768;
  static const double largeTablet = 1200;
}

/// Enum for device sizes
enum DeviceSize {
  xs, // Extra small (< 375px)
  sm, // Small (375px - 599px)
  md, // Medium (600px - 1023px)
  lg, // Large (1024px - 1439px)
  xl, // Extra large (>= 1440px)
}

/// Extension to get device size from width
extension DeviceSizeExtension on double {
  DeviceSize get deviceSize {
    if (this < AppBreakpoints.smallMobile) return DeviceSize.xs;
    if (this < AppBreakpoints.mobile) return DeviceSize.sm;
    if (this < AppBreakpoints.tablet) return DeviceSize.md;
    if (this < AppBreakpoints.desktop) return DeviceSize.lg;
    return DeviceSize.xl;
  }
}

/// Responsive value container
class ResponsiveValue<T> {
  final T xs;
  final T sm;
  final T md;
  final T lg;
  final T xl;

  const ResponsiveValue({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
  });

  /// Create responsive value with fallback
  factory ResponsiveValue.all(T value) {
    return ResponsiveValue(
      xs: value,
      sm: value,
      md: value,
      lg: value,
      xl: value,
    );
  }

  /// Create responsive value with mobile and desktop variants
  factory ResponsiveValue.symmetric({
    required T mobile,
    required T desktop,
  }) {
    return ResponsiveValue(
      xs: mobile,
      sm: mobile,
      md: mobile,
      lg: desktop,
      xl: desktop,
    );
  }

  /// Get value based on device size
  T getValue(DeviceSize size) {
    switch (size) {
      case DeviceSize.xs:
        return xs;
      case DeviceSize.sm:
        return sm;
      case DeviceSize.md:
        return md;
      case DeviceSize.lg:
        return lg;
      case DeviceSize.xl:
        return xl;
    }
  }
}
