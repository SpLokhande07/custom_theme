import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'context_extensions.dart';

/// Color extension for BuildContext
extension ColorExtension on BuildContext {
  /// Get color scheme
  ColorScheme get colors => colorScheme;

  // Primary colors
  Color get primary => colors.primary;
  Color get primaryLight => AppColors.primaryLight;
  Color get primaryDark => AppColors.primaryDark;
  Color get primaryContainer => colors.primaryContainer;
  Color get onPrimary => colors.onPrimary;
  Color get onPrimaryContainer => colors.onPrimaryContainer;

  // Secondary colors
  Color get secondary => colors.secondary;
  Color get secondaryLight => AppColors.secondaryLight;
  Color get secondaryDark => AppColors.secondaryDark;
  Color get secondaryContainer => colors.secondaryContainer;
  Color get onSecondary => colors.onSecondary;
  Color get onSecondaryContainer => colors.onSecondaryContainer;

  // Tertiary colors
  Color get tertiary => colors.tertiary;
  Color get tertiaryLight => AppColors.tertiaryLight;
  Color get tertiaryDark => AppColors.tertiaryDark;
  Color get tertiaryContainer => colors.tertiaryContainer;
  Color get onTertiary => colors.onTertiary;
  Color get onTertiaryContainer => colors.onTertiaryContainer;

  // Error colors
  Color get error => colors.error;
  Color get errorLight => AppColors.errorLight;
  Color get errorDark => AppColors.errorDark;
  Color get errorContainer => colors.errorContainer;
  Color get onError => colors.onError;
  Color get onErrorContainer => colors.onErrorContainer;

  // Success colors
  Color get success => AppColors.success;
  Color get successLight => AppColors.successLight;
  Color get successDark => AppColors.successDark;
  Color get successContainer => AppColors.successContainer;
  Color get onSuccess => AppColors.onSuccess;
  Color get onSuccessContainer => AppColors.onSuccessContainer;

  // Warning colors
  Color get warning => AppColors.warning;
  Color get warningLight => AppColors.warningLight;
  Color get warningDark => AppColors.warningDark;
  Color get warningContainer => AppColors.warningContainer;
  Color get onWarning => AppColors.onWarning;
  Color get onWarningContainer => AppColors.onWarningContainer;

  // Info colors
  Color get info => AppColors.info;
  Color get infoLight => AppColors.infoLight;
  Color get infoDark => AppColors.infoDark;
  Color get infoContainer => AppColors.infoContainer;
  Color get onInfo => AppColors.onInfo;
  Color get onInfoContainer => AppColors.onInfoContainer;

  // Surface colors
  Color get surface => colors.surface;
  // Using surfaceContainerHighest instead of deprecated surfaceVariant
  Color get surfaceVariant => colors
      .surfaceContainerHighest; // Keeping getter name for backward compatibility
  Color get surfaceContainer => AppColors.surfaceContainer;
  Color get surfaceContainerHigh => AppColors.surfaceContainerHigh;
  Color get surfaceContainerHighest => colors.surfaceContainerHighest;
  Color get onSurface => colors.onSurface;
  Color get onSurfaceVariant => colors.onSurfaceVariant;

  // Background colors
  Color get background =>
      isDarkMode ? AppColors.darkBackground : AppColors.background;
  Color get onBackground =>
      isDarkMode ? AppColors.darkOnBackground : AppColors.onBackground;

  // Outline colors
  Color get outline => colors.outline;
  Color get outlineVariant => colors.outlineVariant;

  // Shadow colors
  Color get shadow => colors.shadow;
  Color get scrim => colors.scrim;

  // Inverse colors
  Color get inverseSurface => colors.inverseSurface;
  Color get onInverseSurface => colors.onInverseSurface;
  Color get inversePrimary => colors.inversePrimary;

  // Disabled colors
  Color get disabled => AppColors.disabled;
  Color get onDisabled => AppColors.onDisabled;

  // Neutral colors
  Color get neutral => AppColors.neutral;
  Color get neutralVariant => AppColors.neutralVariant;

  // Interactive colors
  Color get link => AppColors.link;
  Color get linkVisited => AppColors.linkVisited;
  Color get focus => AppColors.focus;
  Color get hover => AppColors.hover;
  Color get pressed => AppColors.pressed;
  Color get selected => AppColors.selected;
  Color get dragged => AppColors.dragged;

  // Gradient colors
  LinearGradient get primaryGradient => AppColors.primaryGradient;
  LinearGradient get secondaryGradient => AppColors.secondaryGradient;
  LinearGradient get surfaceGradient => AppColors.surfaceGradient;

  // Custom gradient builders
  LinearGradient customGradient({
    required List<Color> colors,
    Alignment begin = Alignment.topLeft,
    Alignment end = Alignment.bottomRight,
    List<double>? stops,
  }) {
    return LinearGradient(
      colors: colors,
      begin: begin,
      end: end,
      stops: stops,
    );
  }

  RadialGradient radialGradient({
    required List<Color> colors,
    Alignment center = Alignment.center,
    double radius = 0.5,
    List<double>? stops,
  }) {
    return RadialGradient(
      colors: colors,
      center: center,
      radius: radius,
      stops: stops,
    );
  }

  SweepGradient sweepGradient({
    required List<Color> colors,
    Alignment center = Alignment.center,
    double startAngle = 0.0,
    double endAngle = 6.28,
    List<double>? stops,
  }) {
    return SweepGradient(
      colors: colors,
      center: center,
      startAngle: startAngle,
      endAngle: endAngle,
      stops: stops,
    );
  }

  // Semantic color methods
  Color semanticColor({
    required Color Function() onLight,
    required Color Function() onDark,
  }) {
    return isDarkMode ? onDark() : onLight();
  }

  // State-based colors
  Color stateColor({
    required Color base,
    bool isHovered = false,
    bool isPressed = false,
    bool isFocused = false,
    bool isSelected = false,
    bool isDisabled = false,
  }) {
    if (isDisabled) {
      return base.withAlpha(
          97); // 0.38 opacity is approximately 97 in alpha (0.38 * 255 ≈ 97)
    }
    if (isPressed) {
      return base.withAlpha(
          31); // 0.12 opacity is approximately 31 in alpha (0.12 * 255 ≈ 31)
    }
    if (isSelected) {
      return base.withAlpha(
          20); // 0.08 opacity is approximately 20 in alpha (0.08 * 255 ≈ 20)
    }
    if (isFocused) {
      return base.withAlpha(
          31); // 0.12 opacity is approximately 31 in alpha (0.12 * 255 ≈ 31)
    }
    if (isHovered) {
      return base.withAlpha(
          20); // 0.08 opacity is approximately 20 in alpha (0.08 * 255 ≈ 20)
    }
    return base;
  }

  // Elevation-based colors
  Color elevationColor(int level) {
    if (isDarkMode) {
      // Dark theme elevation colors
      switch (level) {
        case 0:
          return surface;
        case 1:
          return Color.lerp(surface, Colors.white, 0.05)!;
        case 2:
          return Color.lerp(surface, Colors.white, 0.07)!;
        case 3:
          return Color.lerp(surface, Colors.white, 0.08)!;
        case 4:
          return Color.lerp(surface, Colors.white, 0.09)!;
        case 5:
          return Color.lerp(surface, Colors.white, 0.11)!;
        default:
          return Color.lerp(surface, Colors.white, 0.15)!;
      }
    } else {
      // Light theme elevation colors
      return surface;
    }
  }

  // Contextual colors for different components
  Color get cardColor => elevationColor(1);
  Color get dialogColor => elevationColor(3);
  Color get bottomSheetColor => elevationColor(2);
  Color get appBarColor => elevationColor(0);
  Color get drawerColor => elevationColor(2);
  Color get snackBarColor => elevationColor(6);

  // Text colors based on background
  Color textColorOnBackground(Color backgroundColor) {
    final brightness = ThemeData.estimateBrightnessForColor(backgroundColor);
    return brightness == Brightness.dark ? Colors.white : Colors.black;
  }

  // Border colors
  Color get borderColor => outline;
  Color get borderColorVariant => outlineVariant;
  Color get borderColorFocus => primary;
  Color get borderColorError => error;
  Color get borderColorSuccess => success;
  Color get borderColorWarning => warning;

  // Input field colors
  Color get inputFillColor => surfaceVariant;
  Color get inputBorderColor => outline;
  Color get inputFocusedBorderColor => primary;
  Color get inputErrorBorderColor => error;
  Color get inputSuccessBorderColor => success;

  // Status colors
  Color statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'success':
        return success;
      case 'error':
      case 'danger':
        return error;
      case 'warning':
        return warning;
      case 'info':
        return info;
      default:
        return neutral;
    }
  }

  // Priority colors
  Color priorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
      case 'urgent':
        return error;
      case 'medium':
        return warning;
      case 'low':
        return success;
      default:
        return neutral;
    }
  }

  // Generate color palette
  List<Color> generatePalette(Color baseColor, {int shades = 10}) {
    final palette = <Color>[];
    for (int i = 0; i < shades; i++) {
      final factor = i / (shades - 1);
      if (factor < 0.5) {
        // Lighter shades
        palette.add(Color.lerp(Colors.white, baseColor, factor * 2)!);
      } else {
        // Darker shades
        palette.add(Color.lerp(baseColor, Colors.black, (factor - 0.5) * 2)!);
      }
    }
    return palette;
  }
}
