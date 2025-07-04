import 'package:flutter/material.dart';
import '../core/breakpoints.dart';
import '../core/abstract_sizing.dart';

/// Responsive utilities for common responsive design patterns
class ResponsiveUtils {
  /// Get responsive value based on screen width
  static T getResponsiveValue<T>(
    BuildContext context, {
    required T mobile,
    required T tablet,
    required T desktop,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= AppBreakpoints.desktop) {
      return desktop;
    } else if (screenWidth >= AppBreakpoints.tablet) {
      return tablet;
    } else {
      return mobile;
    }
  }

  /// Get responsive spacing value
  static double getResponsiveSpacing(
    BuildContext context,
    AppSize size,
  ) {
    final deviceSize = MediaQuery.of(context).size.width.deviceSize;
    return AppSpacingSizing.getValue(size, deviceSize);
  }

  /// Get responsive typography size
  static double getResponsiveTypography(
    BuildContext context,
    AppSize size,
  ) {
    final deviceSize = MediaQuery.of(context).size.width.deviceSize;
    return AppTypographySizing.getValue(size, deviceSize);
  }

  /// Get responsive radius
  static double getResponsiveRadius(
    BuildContext context,
    AppSize size,
  ) {
    final deviceSize = MediaQuery.of(context).size.width.deviceSize;
    return AppRadiusSizing.getValue(size, deviceSize);
  }

  /// Get responsive icon size
  static double getResponsiveIconSize(
    BuildContext context,
    AppSize size,
  ) {
    final deviceSize = MediaQuery.of(context).size.width.deviceSize;
    return AppIconSizing.getValue(size, deviceSize);
  }

  /// Get responsive elevation
  static double getResponsiveElevation(
    BuildContext context,
    AppSize size,
  ) {
    final deviceSize = MediaQuery.of(context).size.width.deviceSize;
    return AppElevationSizing.getValue(size, deviceSize);
  }

  /// Get responsive grid columns
  static int getResponsiveColumns(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= AppBreakpoints.largeDesktop) {
      return 6;
    } else if (screenWidth >= AppBreakpoints.desktop) {
      return 5;
    } else if (screenWidth >= AppBreakpoints.tablet) {
      return 4;
    } else if (screenWidth >= AppBreakpoints.mobile) {
      return 3;
    } else {
      return 2;
    }
  }

  /// Get responsive container constraints
  static BoxConstraints getResponsiveConstraints(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= AppBreakpoints.largeDesktop) {
      return const BoxConstraints(maxWidth: 1400);
    } else if (screenWidth >= AppBreakpoints.desktop) {
      return const BoxConstraints(maxWidth: 1200);
    } else if (screenWidth >= AppBreakpoints.tablet) {
      return const BoxConstraints(maxWidth: 800);
    } else {
      return const BoxConstraints(maxWidth: double.infinity);
    }
  }

  /// Check if screen is mobile
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < AppBreakpoints.mobile;
  }

  /// Check if screen is tablet
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= AppBreakpoints.mobile && width < AppBreakpoints.desktop;
  }

  /// Check if screen is desktop
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppBreakpoints.desktop;
  }

  /// Get responsive padding
  static EdgeInsets getResponsivePadding(
    BuildContext context,
    AppSize size,
  ) {
    final value = getResponsiveSpacing(context, size);
    return EdgeInsets.all(value);
  }

  /// Get responsive margin
  static EdgeInsets getResponsiveMargin(
    BuildContext context,
    AppSize size,
  ) {
    final value = getResponsiveSpacing(context, size);
    return EdgeInsets.all(value);
  }

  /// Get responsive border radius
  static BorderRadius getResponsiveBorderRadius(
    BuildContext context,
    AppSize size,
  ) {
    final value = getResponsiveRadius(context, size);
    return BorderRadius.circular(value);
  }

  /// Get responsive box shadows
  static List<BoxShadow> getResponsiveBoxShadows(
    BuildContext context,
    AppSize size,
  ) {
    final elevation = getResponsiveElevation(context, size);
    return [
      BoxShadow(
        color: Colors.black.withAlpha(1),
        offset: Offset(0, elevation / 2),
        blurRadius: elevation,
        spreadRadius: 0,
      ),
    ];
  }

  /// Get responsive text scale factor
  static double getResponsiveTextScaleFactor(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= AppBreakpoints.largeDesktop) {
      return 1.2;
    } else if (screenWidth >= AppBreakpoints.desktop) {
      return 1.1;
    } else if (screenWidth >= AppBreakpoints.tablet) {
      return 1.0;
    } else if (screenWidth >= AppBreakpoints.mobile) {
      return 0.9;
    } else {
      return 0.8;
    }
  }

  /// Get responsive aspect ratio
  static double getResponsiveAspectRatio(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final screenWidth = MediaQuery.of(context).size.width;

    if (orientation == Orientation.landscape) {
      return screenWidth >= AppBreakpoints.tablet ? 16 / 9 : 4 / 3;
    } else {
      return screenWidth >= AppBreakpoints.tablet ? 4 / 3 : 3 / 4;
    }
  }

  /// Get responsive flex values
  static List<int> getResponsiveFlex(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= AppBreakpoints.desktop) {
      return [1, 2, 1]; // sidebar, main, sidebar
    } else if (screenWidth >= AppBreakpoints.tablet) {
      return [1, 3]; // sidebar, main
    } else {
      return [1]; // main only
    }
  }

  /// Get responsive sidebar width
  static double getResponsiveSidebarWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= AppBreakpoints.largeDesktop) {
      return 280;
    } else if (screenWidth >= AppBreakpoints.desktop) {
      return 240;
    } else if (screenWidth >= AppBreakpoints.tablet) {
      return 200;
    } else {
      return 0; // Hidden on mobile
    }
  }

  /// Get responsive app bar height
  static double getResponsiveAppBarHeight(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= AppBreakpoints.desktop) {
      return 64;
    } else if (screenWidth >= AppBreakpoints.tablet) {
      return 56;
    } else {
      return 48;
    }
  }

  /// Get responsive bottom navigation height
  static double getResponsiveBottomNavHeight(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= AppBreakpoints.tablet) {
      return 0; // Hidden on tablet and desktop
    } else {
      return 56;
    }
  }

  /// Get responsive dialog constraints
  static BoxConstraints getResponsiveDialogConstraints(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    if (screenWidth >= AppBreakpoints.desktop) {
      return BoxConstraints(
        maxWidth: 600,
        maxHeight: screenHeight * 0.8,
        minWidth: 400,
        minHeight: 200,
      );
    } else if (screenWidth >= AppBreakpoints.tablet) {
      return BoxConstraints(
        maxWidth: screenWidth * 0.8,
        maxHeight: screenHeight * 0.8,
        minWidth: 320,
        minHeight: 200,
      );
    } else {
      return BoxConstraints(
        maxWidth: screenWidth * 0.95,
        maxHeight: screenHeight * 0.9,
        minWidth: 280,
        minHeight: 150,
      );
    }
  }

  /// Get responsive modal bottom sheet height
  static double getResponsiveModalHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= AppBreakpoints.desktop) {
      return screenHeight * 0.7;
    } else if (screenWidth >= AppBreakpoints.tablet) {
      return screenHeight * 0.8;
    } else {
      return screenHeight * 0.9;
    }
  }

  /// Get responsive snack bar margin
  static EdgeInsets getResponsiveSnackBarMargin(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= AppBreakpoints.desktop) {
      return const EdgeInsets.all(16);
    } else if (screenWidth >= AppBreakpoints.tablet) {
      return const EdgeInsets.all(12);
    } else {
      return const EdgeInsets.all(8);
    }
  }

  /// Get responsive toast position
  static AlignmentGeometry getResponsiveToastAlignment(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= AppBreakpoints.desktop) {
      return Alignment.topRight;
    } else {
      return Alignment.topCenter;
    }
  }

  /// Get responsive loading indicator size
  static double getResponsiveLoadingSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= AppBreakpoints.desktop) {
      return 48;
    } else if (screenWidth >= AppBreakpoints.tablet) {
      return 40;
    } else {
      return 32;
    }
  }

  /// Get responsive card elevation
  static double getResponsiveCardElevation(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= AppBreakpoints.desktop) {
      return 8;
    } else if (screenWidth >= AppBreakpoints.tablet) {
      return 4;
    } else {
      return 2;
    }
  }

  /// Get responsive form field height
  static double getResponsiveFormFieldHeight(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= AppBreakpoints.desktop) {
      return 56;
    } else if (screenWidth >= AppBreakpoints.tablet) {
      return 48;
    } else {
      return 44;
    }
  }

  /// Get responsive button height
  static double getResponsiveButtonHeight(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= AppBreakpoints.desktop) {
      return 48;
    } else if (screenWidth >= AppBreakpoints.tablet) {
      return 44;
    } else {
      return 40;
    }
  }

  /// Get responsive icon button size
  static double getResponsiveIconButtonSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= AppBreakpoints.desktop) {
      return 48;
    } else if (screenWidth >= AppBreakpoints.tablet) {
      return 44;
    } else {
      return 40;
    }
  }

  /// Get responsive minimum touch target size
  static double getResponsiveMinTouchTarget(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= AppBreakpoints.desktop) {
      return 48;
    } else {
      return 44; // iOS and Material Design minimum
    }
  }

  /// Get responsive animation duration
  static Duration getResponsiveAnimationDuration(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= AppBreakpoints.desktop) {
      return const Duration(milliseconds: 300);
    } else if (screenWidth >= AppBreakpoints.tablet) {
      return const Duration(milliseconds: 250);
    } else {
      return const Duration(milliseconds: 200);
    }
  }

  /// Get responsive page transition duration
  static Duration getResponsivePageTransitionDuration(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= AppBreakpoints.desktop) {
      return const Duration(milliseconds: 400);
    } else if (screenWidth >= AppBreakpoints.tablet) {
      return const Duration(milliseconds: 350);
    } else {
      return const Duration(milliseconds: 300);
    }
  }
}
