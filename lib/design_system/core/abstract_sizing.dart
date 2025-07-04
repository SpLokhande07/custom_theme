import 'breakpoints.dart';

/// Abstract sizing system for consistent responsive design
enum AppSize {
  xs,
  sm,
  md,
  lg,
  xl,
  xl2,
  xl3,
  xl4,
  xl5,
}

/// Abstract base class for responsive sizing
abstract class ResponsiveSizing {
  /// Get responsive value based on device size and app size
  static double getValue(AppSize appSize, DeviceSize deviceSize) {
    final sizeMap = _getSizeMap(appSize);
    return sizeMap[deviceSize] ?? sizeMap[DeviceSize.md]!;
  }

  /// Get size map for specific app size
  static Map<DeviceSize, double> _getSizeMap(AppSize appSize) {
    switch (appSize) {
      case AppSize.xs:
        return {
          DeviceSize.xs: 4.0,
          DeviceSize.sm: 6.0,
          DeviceSize.md: 8.0,
          DeviceSize.lg: 10.0,
          DeviceSize.xl: 12.0,
        };
      case AppSize.sm:
        return {
          DeviceSize.xs: 8.0,
          DeviceSize.sm: 10.0,
          DeviceSize.md: 12.0,
          DeviceSize.lg: 14.0,
          DeviceSize.xl: 16.0,
        };
      case AppSize.md:
        return {
          DeviceSize.xs: 12.0,
          DeviceSize.sm: 14.0,
          DeviceSize.md: 16.0,
          DeviceSize.lg: 18.0,
          DeviceSize.xl: 20.0,
        };
      case AppSize.lg:
        return {
          DeviceSize.xs: 16.0,
          DeviceSize.sm: 18.0,
          DeviceSize.md: 20.0,
          DeviceSize.lg: 22.0,
          DeviceSize.xl: 24.0,
        };
      case AppSize.xl:
        return {
          DeviceSize.xs: 20.0,
          DeviceSize.sm: 22.0,
          DeviceSize.md: 24.0,
          DeviceSize.lg: 26.0,
          DeviceSize.xl: 28.0,
        };
      case AppSize.xl2:
        return {
          DeviceSize.xs: 24.0,
          DeviceSize.sm: 26.0,
          DeviceSize.md: 28.0,
          DeviceSize.lg: 30.0,
          DeviceSize.xl: 32.0,
        };
      case AppSize.xl3:
        return {
          DeviceSize.xs: 28.0,
          DeviceSize.sm: 30.0,
          DeviceSize.md: 32.0,
          DeviceSize.lg: 34.0,
          DeviceSize.xl: 36.0,
        };
      case AppSize.xl4:
        return {
          DeviceSize.xs: 32.0,
          DeviceSize.sm: 34.0,
          DeviceSize.md: 36.0,
          DeviceSize.lg: 38.0,
          DeviceSize.xl: 40.0,
        };
      case AppSize.xl5:
        return {
          DeviceSize.xs: 36.0,
          DeviceSize.sm: 38.0,
          DeviceSize.md: 40.0,
          DeviceSize.lg: 42.0,
          DeviceSize.xl: 44.0,
        };
    }
  }
}

/// Spacing sizing system
class AppSpacingSizing extends ResponsiveSizing {
  static double getValue(AppSize appSize, DeviceSize deviceSize) {
    final sizeMap = _getSpacingSizeMap(appSize);
    return sizeMap[deviceSize] ?? sizeMap[DeviceSize.md]!;
  }

  static Map<DeviceSize, double> _getSpacingSizeMap(AppSize appSize) {
    switch (appSize) {
      case AppSize.xs:
        return {
          DeviceSize.xs: 2.0,
          DeviceSize.sm: 4.0,
          DeviceSize.md: 4.0,
          DeviceSize.lg: 6.0,
          DeviceSize.xl: 8.0,
        };
      case AppSize.sm:
        return {
          DeviceSize.xs: 4.0,
          DeviceSize.sm: 6.0,
          DeviceSize.md: 8.0,
          DeviceSize.lg: 10.0,
          DeviceSize.xl: 12.0,
        };
      case AppSize.md:
        return {
          DeviceSize.xs: 8.0,
          DeviceSize.sm: 12.0,
          DeviceSize.md: 16.0,
          DeviceSize.lg: 20.0,
          DeviceSize.xl: 24.0,
        };
      case AppSize.lg:
        return {
          DeviceSize.xs: 12.0,
          DeviceSize.sm: 16.0,
          DeviceSize.md: 24.0,
          DeviceSize.lg: 32.0,
          DeviceSize.xl: 40.0,
        };
      case AppSize.xl:
        return {
          DeviceSize.xs: 16.0,
          DeviceSize.sm: 24.0,
          DeviceSize.md: 32.0,
          DeviceSize.lg: 40.0,
          DeviceSize.xl: 48.0,
        };
      case AppSize.xl2:
        return {
          DeviceSize.xs: 24.0,
          DeviceSize.sm: 32.0,
          DeviceSize.md: 48.0,
          DeviceSize.lg: 56.0,
          DeviceSize.xl: 64.0,
        };
      case AppSize.xl3:
        return {
          DeviceSize.xs: 32.0,
          DeviceSize.sm: 40.0,
          DeviceSize.md: 56.0,
          DeviceSize.lg: 72.0,
          DeviceSize.xl: 80.0,
        };
      case AppSize.xl4:
        return {
          DeviceSize.xs: 40.0,
          DeviceSize.sm: 48.0,
          DeviceSize.md: 64.0,
          DeviceSize.lg: 80.0,
          DeviceSize.xl: 96.0,
        };
      case AppSize.xl5:
        return {
          DeviceSize.xs: 48.0,
          DeviceSize.sm: 56.0,
          DeviceSize.md: 72.0,
          DeviceSize.lg: 96.0,
          DeviceSize.xl: 112.0,
        };
    }
  }
}

/// Typography sizing system
class AppTypographySizing extends ResponsiveSizing {
  static double getValue(AppSize appSize, DeviceSize deviceSize) {
    final sizeMap = _getTypographySizeMap(appSize);
    return sizeMap[deviceSize] ?? sizeMap[DeviceSize.md]!;
  }

  static Map<DeviceSize, double> _getTypographySizeMap(AppSize appSize) {
    switch (appSize) {
      case AppSize.xs:
        return {
          DeviceSize.xs: 8.0,
          DeviceSize.sm: 10.0,
          DeviceSize.md: 10.0,
          DeviceSize.lg: 12.0,
          DeviceSize.xl: 14.0,
        };
      case AppSize.sm:
        return {
          DeviceSize.xs: 10.0,
          DeviceSize.sm: 12.0,
          DeviceSize.md: 12.0,
          DeviceSize.lg: 14.0,
          DeviceSize.xl: 16.0,
        };
      case AppSize.md:
        return {
          DeviceSize.xs: 12.0,
          DeviceSize.sm: 14.0,
          DeviceSize.md: 14.0,
          DeviceSize.lg: 16.0,
          DeviceSize.xl: 18.0,
        };
      case AppSize.lg:
        return {
          DeviceSize.xs: 14.0,
          DeviceSize.sm: 16.0,
          DeviceSize.md: 16.0,
          DeviceSize.lg: 18.0,
          DeviceSize.xl: 20.0,
        };
      case AppSize.xl:
        return {
          DeviceSize.xs: 16.0,
          DeviceSize.sm: 18.0,
          DeviceSize.md: 18.0,
          DeviceSize.lg: 20.0,
          DeviceSize.xl: 22.0,
        };
      case AppSize.xl2:
        return {
          DeviceSize.xs: 18.0,
          DeviceSize.sm: 20.0,
          DeviceSize.md: 20.0,
          DeviceSize.lg: 22.0,
          DeviceSize.xl: 24.0,
        };
      case AppSize.xl3:
        return {
          DeviceSize.xs: 20.0,
          DeviceSize.sm: 22.0,
          DeviceSize.md: 24.0,
          DeviceSize.lg: 28.0,
          DeviceSize.xl: 32.0,
        };
      case AppSize.xl4:
        return {
          DeviceSize.xs: 24.0,
          DeviceSize.sm: 28.0,
          DeviceSize.md: 32.0,
          DeviceSize.lg: 36.0,
          DeviceSize.xl: 40.0,
        };
      case AppSize.xl5:
        return {
          DeviceSize.xs: 28.0,
          DeviceSize.sm: 32.0,
          DeviceSize.md: 40.0,
          DeviceSize.lg: 48.0,
          DeviceSize.xl: 56.0,
        };
    }
  }
}

/// Border radius sizing system
class AppRadiusSizing extends ResponsiveSizing {
  static double getValue(AppSize appSize, DeviceSize deviceSize) {
    final sizeMap = _getRadiusSizeMap(appSize);
    return sizeMap[deviceSize] ?? sizeMap[DeviceSize.md]!;
  }

  static Map<DeviceSize, double> _getRadiusSizeMap(AppSize appSize) {
    switch (appSize) {
      case AppSize.xs:
        return {
          DeviceSize.xs: 2.0,
          DeviceSize.sm: 3.0,
          DeviceSize.md: 4.0,
          DeviceSize.lg: 5.0,
          DeviceSize.xl: 6.0,
        };
      case AppSize.sm:
        return {
          DeviceSize.xs: 4.0,
          DeviceSize.sm: 6.0,
          DeviceSize.md: 8.0,
          DeviceSize.lg: 10.0,
          DeviceSize.xl: 12.0,
        };
      case AppSize.md:
        return {
          DeviceSize.xs: 6.0,
          DeviceSize.sm: 8.0,
          DeviceSize.md: 12.0,
          DeviceSize.lg: 14.0,
          DeviceSize.xl: 16.0,
        };
      case AppSize.lg:
        return {
          DeviceSize.xs: 8.0,
          DeviceSize.sm: 12.0,
          DeviceSize.md: 16.0,
          DeviceSize.lg: 20.0,
          DeviceSize.xl: 24.0,
        };
      case AppSize.xl:
        return {
          DeviceSize.xs: 12.0,
          DeviceSize.sm: 16.0,
          DeviceSize.md: 20.0,
          DeviceSize.lg: 24.0,
          DeviceSize.xl: 28.0,
        };
      case AppSize.xl2:
        return {
          DeviceSize.xs: 16.0,
          DeviceSize.sm: 20.0,
          DeviceSize.md: 24.0,
          DeviceSize.lg: 28.0,
          DeviceSize.xl: 32.0,
        };
      case AppSize.xl3:
        return {
          DeviceSize.xs: 20.0,
          DeviceSize.sm: 24.0,
          DeviceSize.md: 28.0,
          DeviceSize.lg: 32.0,
          DeviceSize.xl: 36.0,
        };
      case AppSize.xl4:
        return {
          DeviceSize.xs: 24.0,
          DeviceSize.sm: 28.0,
          DeviceSize.md: 32.0,
          DeviceSize.lg: 36.0,
          DeviceSize.xl: 40.0,
        };
      case AppSize.xl5:
        return {
          DeviceSize.xs: 28.0,
          DeviceSize.sm: 32.0,
          DeviceSize.md: 36.0,
          DeviceSize.lg: 40.0,
          DeviceSize.xl: 44.0,
        };
    }
  }
}

/// Icon sizing system
class AppIconSizing extends ResponsiveSizing {
  static double getValue(AppSize appSize, DeviceSize deviceSize) {
    final sizeMap = _getIconSizeMap(appSize);
    return sizeMap[deviceSize] ?? sizeMap[DeviceSize.md]!;
  }

  static Map<DeviceSize, double> _getIconSizeMap(AppSize appSize) {
    switch (appSize) {
      case AppSize.xs:
        return {
          DeviceSize.xs: 10.0,
          DeviceSize.sm: 12.0,
          DeviceSize.md: 12.0,
          DeviceSize.lg: 14.0,
          DeviceSize.xl: 16.0,
        };
      case AppSize.sm:
        return {
          DeviceSize.xs: 12.0,
          DeviceSize.sm: 14.0,
          DeviceSize.md: 16.0,
          DeviceSize.lg: 18.0,
          DeviceSize.xl: 20.0,
        };
      case AppSize.md:
        return {
          DeviceSize.xs: 16.0,
          DeviceSize.sm: 20.0,
          DeviceSize.md: 24.0,
          DeviceSize.lg: 28.0,
          DeviceSize.xl: 32.0,
        };
      case AppSize.lg:
        return {
          DeviceSize.xs: 20.0,
          DeviceSize.sm: 24.0,
          DeviceSize.md: 32.0,
          DeviceSize.lg: 36.0,
          DeviceSize.xl: 40.0,
        };
      case AppSize.xl:
        return {
          DeviceSize.xs: 24.0,
          DeviceSize.sm: 28.0,
          DeviceSize.md: 36.0,
          DeviceSize.lg: 40.0,
          DeviceSize.xl: 48.0,
        };
      case AppSize.xl2:
        return {
          DeviceSize.xs: 28.0,
          DeviceSize.sm: 32.0,
          DeviceSize.md: 40.0,
          DeviceSize.lg: 48.0,
          DeviceSize.xl: 56.0,
        };
      case AppSize.xl3:
        return {
          DeviceSize.xs: 32.0,
          DeviceSize.sm: 36.0,
          DeviceSize.md: 48.0,
          DeviceSize.lg: 56.0,
          DeviceSize.xl: 64.0,
        };
      case AppSize.xl4:
        return {
          DeviceSize.xs: 36.0,
          DeviceSize.sm: 40.0,
          DeviceSize.md: 56.0,
          DeviceSize.lg: 64.0,
          DeviceSize.xl: 72.0,
        };
      case AppSize.xl5:
        return {
          DeviceSize.xs: 40.0,
          DeviceSize.sm: 48.0,
          DeviceSize.md: 64.0,
          DeviceSize.lg: 72.0,
          DeviceSize.xl: 80.0,
        };
    }
  }
}

/// Elevation sizing system
class AppElevationSizing extends ResponsiveSizing {
  static double getValue(AppSize appSize, DeviceSize deviceSize) {
    final sizeMap = _getElevationSizeMap(appSize);
    return sizeMap[deviceSize] ?? sizeMap[DeviceSize.md]!;
  }

  static Map<DeviceSize, double> _getElevationSizeMap(AppSize appSize) {
    switch (appSize) {
      case AppSize.xs:
        return {
          DeviceSize.xs: 1.0,
          DeviceSize.sm: 2.0,
          DeviceSize.md: 2.0,
          DeviceSize.lg: 3.0,
          DeviceSize.xl: 4.0,
        };
      case AppSize.sm:
        return {
          DeviceSize.xs: 2.0,
          DeviceSize.sm: 3.0,
          DeviceSize.md: 4.0,
          DeviceSize.lg: 5.0,
          DeviceSize.xl: 6.0,
        };
      case AppSize.md:
        return {
          DeviceSize.xs: 4.0,
          DeviceSize.sm: 6.0,
          DeviceSize.md: 8.0,
          DeviceSize.lg: 10.0,
          DeviceSize.xl: 12.0,
        };
      case AppSize.lg:
        return {
          DeviceSize.xs: 8.0,
          DeviceSize.sm: 10.0,
          DeviceSize.md: 12.0,
          DeviceSize.lg: 16.0,
          DeviceSize.xl: 20.0,
        };
      case AppSize.xl:
        return {
          DeviceSize.xs: 12.0,
          DeviceSize.sm: 16.0,
          DeviceSize.md: 20.0,
          DeviceSize.lg: 24.0,
          DeviceSize.xl: 28.0,
        };
      case AppSize.xl2:
        return {
          DeviceSize.xs: 16.0,
          DeviceSize.sm: 20.0,
          DeviceSize.md: 24.0,
          DeviceSize.lg: 28.0,
          DeviceSize.xl: 32.0,
        };
      case AppSize.xl3:
        return {
          DeviceSize.xs: 20.0,
          DeviceSize.sm: 24.0,
          DeviceSize.md: 28.0,
          DeviceSize.lg: 32.0,
          DeviceSize.xl: 36.0,
        };
      case AppSize.xl4:
        return {
          DeviceSize.xs: 24.0,
          DeviceSize.sm: 28.0,
          DeviceSize.md: 32.0,
          DeviceSize.lg: 36.0,
          DeviceSize.xl: 40.0,
        };
      case AppSize.xl5:
        return {
          DeviceSize.xs: 28.0,
          DeviceSize.sm: 32.0,
          DeviceSize.md: 36.0,
          DeviceSize.lg: 40.0,
          DeviceSize.xl: 44.0,
        };
    }
  }
}
