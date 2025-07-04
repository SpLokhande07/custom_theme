import 'package:flutter/material.dart';

/// App color palette following Material Design 3 principles
class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF2196F3);
  static const Color primaryLight = Color(0xFF64B5F6);
  static const Color primaryDark = Color(0xFF1976D2);
  static const Color primaryContainer = Color(0xFFE3F2FD);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onPrimaryContainer = Color(0xFF0D47A1);

  // Secondary colors
  static const Color secondary = Color(0xFF4CAF50);
  static const Color secondaryLight = Color(0xFF81C784);
  static const Color secondaryDark = Color(0xFF388E3C);
  static const Color secondaryContainer = Color(0xFFE8F5E8);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onSecondaryContainer = Color(0xFF1B5E20);

  // Tertiary colors
  static const Color tertiary = Color(0xFFFF9800);
  static const Color tertiaryLight = Color(0xFFFFB74D);
  static const Color tertiaryDark = Color(0xFFF57C00);
  static const Color tertiaryContainer = Color(0xFFFFF3E0);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color onTertiaryContainer = Color(0xFFE65100);

  // Error colors
  static const Color error = Color(0xFFE53935);
  static const Color errorLight = Color(0xFFEF5350);
  static const Color errorDark = Color(0xFFC62828);
  static const Color errorContainer = Color(0xFFFFEBEE);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color onErrorContainer = Color(0xFFB71C1C);

  // Success colors
  static const Color success = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFF81C784);
  static const Color successDark = Color(0xFF2E7D32);
  static const Color successContainer = Color(0xFFE8F5E8);
  static const Color onSuccess = Color(0xFFFFFFFF);
  static const Color onSuccessContainer = Color(0xFF1B5E20);

  // Warning colors
  static const Color warning = Color(0xFFFF9800);
  static const Color warningLight = Color(0xFFFFB74D);
  static const Color warningDark = Color(0xFFEF6C00);
  static const Color warningContainer = Color(0xFFFFF3E0);
  static const Color onWarning = Color(0xFFFFFFFF);
  static const Color onWarningContainer = Color(0xFFE65100);

  // Info colors
  static const Color info = Color(0xFF2196F3);
  static const Color infoLight = Color(0xFF64B5F6);
  static const Color infoDark = Color(0xFF1565C0);
  static const Color infoContainer = Color(0xFFE3F2FD);
  static const Color onInfo = Color(0xFFFFFFFF);
  static const Color onInfoContainer = Color(0xFF0D47A1);

  // Surface colors
  static const Color surface = Color(0xFFFAFAFA);
  static const Color surfaceVariant = Color(0xFFF5F5F5);
  static const Color surfaceContainer = Color(0xFFFFFFFF);
  static const Color surfaceContainerHigh = Color(0xFFF0F0F0);
  static const Color surfaceContainerHighest = Color(0xFFE8E8E8);
  static const Color onSurface = Color(0xFF1C1C1C);
  static const Color onSurfaceVariant = Color(0xFF424242);

  // Background colors
  static const Color background = Color(0xFFFFFFFF);
  static const Color onBackground = Color(0xFF1C1C1C);

  // Outline colors
  static const Color outline = Color(0xFFBDBDBD);
  static const Color outlineVariant = Color(0xFFE0E0E0);

  // Shadow colors
  static const Color shadow = Color(0xFF000000);
  static const Color scrim = Color(0xFF000000);

  // Inverse colors
  static const Color inverseSurface = Color(0xFF313131);
  static const Color onInverseSurface = Color(0xFFF5F5F5);
  static const Color inversePrimary = Color(0xFF90CAF9);

  // Disabled colors
  static const Color disabled = Color(0xFF9E9E9E);
  static const Color onDisabled = Color(0xFF616161);

  // Neutral colors
  static const Color neutral = Color(0xFF757575);
  static const Color neutralVariant = Color(0xFF9E9E9E);

  // Custom semantic colors
  static const Color link = Color(0xFF1976D2);
  static const Color linkVisited = Color(0xFF7B1FA2);
  static const Color focus = Color(0xFF2196F3);
  static const Color hover = Color(0xFFE3F2FD);
  static const Color pressed = Color(0xFFBBDEFB);
  static const Color selected = Color(0xFFE8F5E8);
  static const Color dragged = Color(0xFFE1F5FE);

  // Gradient colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, secondaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient surfaceGradient = LinearGradient(
    colors: [surface, surfaceVariant],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Dark theme colors
  static const Color darkPrimary = Color(0xFF90CAF9);
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkOnSurface = Color(0xFFE0E0E0);
  static const Color darkOnBackground = Color(0xFFE0E0E0);
}

/// Color extension for additional utility methods
extension ColorExtensions on Color {
  /// Get a lighter version of the color
  Color get lighter {
    return Color.lerp(this, Colors.white, 0.2)!;
  }

  /// Get a darker version of the color
  Color get darker {
    return Color.lerp(this, Colors.black, 0.2)!;
  }

  /// Get color with opacity
  Color withOpacity(double opacity) {
    return Color.fromRGBO(r.toInt(), g.toInt(), b.toInt(), opacity);
  }

  /// Get contrasting color (black or white)
  Color get contrastingColor {
    final brightness = ThemeData.estimateBrightnessForColor(this);
    return brightness == Brightness.dark ? Colors.white : Colors.black;
  }

  /// Convert to hex string
  String toHex() {
    final int aInt = (a * 255).round();
    final int rInt = r.toInt();
    final int gInt = g.toInt();
    final int bInt = b.toInt();
    return '#${(aInt << 24 | rInt << 16 | gInt << 8 | bInt).toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }
}

/// Color scheme builder
class AppColorScheme {
  static ColorScheme get light => const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        primaryContainer: AppColors.primaryContainer,
        onPrimaryContainer: AppColors.onPrimaryContainer,
        secondary: AppColors.secondary,
        onSecondary: AppColors.onSecondary,
        secondaryContainer: AppColors.secondaryContainer,
        onSecondaryContainer: AppColors.onSecondaryContainer,
        tertiary: AppColors.tertiary,
        onTertiary: AppColors.onTertiary,
        tertiaryContainer: AppColors.tertiaryContainer,
        onTertiaryContainer: AppColors.onTertiaryContainer,
        error: AppColors.error,
        onError: AppColors.onError,
        errorContainer: AppColors.errorContainer,
        onErrorContainer: AppColors.onErrorContainer,
        outline: AppColors.outline,
        outlineVariant: AppColors.outlineVariant,
        surface: AppColors.surface,
        onSurface: AppColors.onSurface,
        surfaceContainerHighest: AppColors.surfaceVariant, // Using surfaceVariant as surfaceContainerHighest
        onSurfaceVariant: AppColors.onSurfaceVariant,
        inverseSurface: AppColors.inverseSurface,
        onInverseSurface: AppColors.onInverseSurface,
        inversePrimary: AppColors.inversePrimary,
        shadow: AppColors.shadow,
        scrim: AppColors.scrim,
      );

  static ColorScheme get dark => const ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.darkPrimary,
        onPrimary: AppColors.darkOnBackground,
        primaryContainer: AppColors.primaryDark,
        onPrimaryContainer: AppColors.primaryLight,
        secondary: AppColors.secondary,
        onSecondary: AppColors.darkOnBackground,
        secondaryContainer: AppColors.secondaryDark,
        onSecondaryContainer: AppColors.secondaryLight,
        tertiary: AppColors.tertiary,
        onTertiary: AppColors.darkOnBackground,
        tertiaryContainer: AppColors.tertiaryDark,
        onTertiaryContainer: AppColors.tertiaryLight,
        error: AppColors.error,
        onError: AppColors.darkOnBackground,
        errorContainer: AppColors.errorDark,
        onErrorContainer: AppColors.errorLight,
        outline: AppColors.outline,
        outlineVariant: AppColors.outlineVariant,
        surface: AppColors.darkSurface,
        onSurface: AppColors.darkOnSurface,
        surfaceContainerHighest: AppColors.darkSurface, // Using darkSurface as surfaceContainerHighest
        onSurfaceVariant: AppColors.darkOnSurface,
        inverseSurface: AppColors.surface,
        onInverseSurface: AppColors.onSurface,
        inversePrimary: AppColors.inversePrimary,
        shadow: AppColors.shadow,
        scrim: AppColors.scrim,
      );
}
