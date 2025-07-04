import 'package:flutter/material.dart';
import '../theme/app_typography.dart';
import 'context_extensions.dart';

/// Typography extension for BuildContext
extension TypographyExtension on BuildContext {
  /// Get responsive typography based on current device size

  // Display styles
  TextStyle get displayLarge => AppTypography.displayLargeStyle(
        colorScheme.onSurface,
        deviceSize: deviceSize,
      );

  TextStyle get displayMedium => AppTypography.displayMediumStyle(
        colorScheme.onSurface,
        deviceSize: deviceSize,
      );

  TextStyle get displaySmall => AppTypography.displaySmallStyle(
        colorScheme.onSurface,
        deviceSize: deviceSize,
      );

  // Headline styles
  TextStyle get headlineLarge => AppTypography.headlineLargeStyle(
        colorScheme.onSurface,
        deviceSize: deviceSize,
      );

  TextStyle get headlineMedium => AppTypography.headlineMediumStyle(
        colorScheme.onSurface,
        deviceSize: deviceSize,
      );

  TextStyle get headlineSmall => AppTypography.headlineSmallStyle(
        colorScheme.onSurface,
        deviceSize: deviceSize,
      );

  // Title styles
  TextStyle get titleLarge => AppTypography.titleLargeStyle(
        colorScheme.onSurface,
        deviceSize: deviceSize,
      );

  TextStyle get titleMedium => AppTypography.titleMediumStyle(
        colorScheme.onSurface,
        deviceSize: deviceSize,
      );

  TextStyle get titleSmall => AppTypography.titleSmallStyle(
        colorScheme.onSurface,
        deviceSize: deviceSize,
      );

  // Body styles
  TextStyle get bodyLarge => AppTypography.bodyLargeStyle(
        colorScheme.onSurface,
        deviceSize: deviceSize,
      );

  TextStyle get bodyMedium => AppTypography.bodyMediumStyle(
        colorScheme.onSurface,
        deviceSize: deviceSize,
      );

  TextStyle get bodySmall => AppTypography.bodySmallStyle(
        colorScheme.onSurface,
        deviceSize: deviceSize,
      );

  // Label styles
  TextStyle get labelLarge => AppTypography.labelLargeStyle(
        colorScheme.onSurface,
        deviceSize: deviceSize,
      );

  TextStyle get labelMedium => AppTypography.labelMediumStyle(
        colorScheme.onSurface,
        deviceSize: deviceSize,
      );

  TextStyle get labelSmall => AppTypography.labelSmallStyle(
        colorScheme.onSurface,
        deviceSize: deviceSize,
      );

  // Specialized styles
  TextStyle get codeStyle => AppTypography.codeStyle(
        colorScheme.onSurface,
        deviceSize: deviceSize,
      );

  TextStyle get linkStyle => AppTypography.linkStyle(
        colorScheme.primary,
        deviceSize: deviceSize,
      );

  TextStyle get errorStyle => AppTypography.errorStyle(
        colorScheme.error,
        deviceSize: deviceSize,
      );

  TextStyle get captionStyle => AppTypography.captionStyle(
        colorScheme.onSurfaceVariant,
        deviceSize: deviceSize,
      );

  TextStyle get overlineStyle => AppTypography.overlineStyle(
        colorScheme.onSurfaceVariant,
        deviceSize: deviceSize,
      );

  // Custom colored variants
  TextStyle displayLargeOn(Color color) => AppTypography.displayLargeStyle(
        color,
        deviceSize: deviceSize,
      );

  TextStyle displayMediumOn(Color color) => AppTypography.displayMediumStyle(
        color,
        deviceSize: deviceSize,
      );

  TextStyle displaySmallOn(Color color) => AppTypography.displaySmallStyle(
        color,
        deviceSize: deviceSize,
      );

  TextStyle headlineLargeOn(Color color) => AppTypography.headlineLargeStyle(
        color,
        deviceSize: deviceSize,
      );

  TextStyle headlineMediumOn(Color color) => AppTypography.headlineMediumStyle(
        color,
        deviceSize: deviceSize,
      );

  TextStyle headlineSmallOn(Color color) => AppTypography.headlineSmallStyle(
        color,
        deviceSize: deviceSize,
      );

  TextStyle titleLargeOn(Color color) => AppTypography.titleLargeStyle(
        color,
        deviceSize: deviceSize,
      );

  TextStyle titleMediumOn(Color color) => AppTypography.titleMediumStyle(
        color,
        deviceSize: deviceSize,
      );

  TextStyle titleSmallOn(Color color) => AppTypography.titleSmallStyle(
        color,
        deviceSize: deviceSize,
      );

  TextStyle bodyLargeOn(Color color) => AppTypography.bodyLargeStyle(
        color,
        deviceSize: deviceSize,
      );

  TextStyle bodyMediumOn(Color color) => AppTypography.bodyMediumStyle(
        color,
        deviceSize: deviceSize,
      );

  TextStyle bodySmallOn(Color color) => AppTypography.bodySmallStyle(
        color,
        deviceSize: deviceSize,
      );

  TextStyle labelLargeOn(Color color) => AppTypography.labelLargeStyle(
        color,
        deviceSize: deviceSize,
      );

  TextStyle labelMediumOn(Color color) => AppTypography.labelMediumStyle(
        color,
        deviceSize: deviceSize,
      );

  TextStyle labelSmallOn(Color color) => AppTypography.labelSmallStyle(
        color,
        deviceSize: deviceSize,
      );

  TextStyle codeOn(Color color) => AppTypography.codeStyle(
        color,
        deviceSize: deviceSize,
      );

  TextStyle linkOn(Color color) => AppTypography.linkStyle(
        color,
        deviceSize: deviceSize,
      );

  TextStyle errorOn(Color color) => AppTypography.errorStyle(
        color,
        deviceSize: deviceSize,
      );

  TextStyle captionOn(Color color) => AppTypography.captionStyle(
        color,
        deviceSize: deviceSize,
      );

  TextStyle overlineOn(Color color) => AppTypography.overlineStyle(
        color,
        deviceSize: deviceSize,
      );
}

/// Extension for TextStyle with responsive modifications
extension TextStyleExtension on TextStyle {
  /// Copy with responsive font size
  TextStyle responsiveSize(BuildContext context, double baseFontSize) {
    return copyWith(
      fontSize: context.responsiveFontSize(baseFontSize),
    );
  }

  /// Copy with weight
  TextStyle weight(FontWeight fontWeight) {
    return copyWith(fontWeight: fontWeight);
  }

  /// Copy with color
  TextStyle colored(Color color) {
    return copyWith(color: color);
  }

  /// Copy with size
  TextStyle sized(double fontSize) {
    return copyWith(fontSize: fontSize);
  }

  /// Copy with height
  TextStyle height(double lineHeight) {
    return copyWith(height: lineHeight);
  }

  /// Copy with letter spacing
  TextStyle letterSpacing(double spacing) {
    return copyWith(letterSpacing: spacing);
  }

  /// Copy with decoration
  TextStyle decoration(TextDecoration decoration) {
    return copyWith(decoration: decoration);
  }

  /// Copy with shadow
  TextStyle shadow(List<Shadow> shadows) {
    return copyWith(shadows: shadows);
  }

  /// Copy with font family
  TextStyle fontFamily(String family) {
    return copyWith(fontFamily: family);
  }

  /// Helper for common modifications
  TextStyle get thin => weight(AppTypography.thin);
  TextStyle get extraLight => weight(AppTypography.extraLight);
  TextStyle get light => weight(AppTypography.light);
  TextStyle get regular => weight(AppTypography.regular);
  TextStyle get medium => weight(AppTypography.medium);
  TextStyle get semiBold => weight(AppTypography.semiBold);
  TextStyle get bold => weight(AppTypography.bold);
  TextStyle get extraBold => weight(AppTypography.extraBold);
  TextStyle get black => weight(AppTypography.black);

  /// Line height helpers
  TextStyle get tight => height(AppTypography.lineHeightTight);
  TextStyle get normal => height(AppTypography.lineHeightNormal);
  TextStyle get relaxed => height(AppTypography.lineHeightRelaxed);
  TextStyle get loose => height(AppTypography.lineHeightLoose);

  /// Letter spacing helpers
  TextStyle get spacingTight => letterSpacing(AppTypography.letterSpacingTight);
  TextStyle get spacingNormal =>
      letterSpacing(AppTypography.letterSpacingNormal);
  TextStyle get spacingWide => letterSpacing(AppTypography.letterSpacingWide);
  TextStyle get spacingWider => letterSpacing(AppTypography.letterSpacingWider);

  /// Decoration helpers
  TextStyle get underline => decoration(TextDecoration.underline);
  TextStyle get overline => decoration(TextDecoration.overline);
  TextStyle get lineThrough => decoration(TextDecoration.lineThrough);
  TextStyle get noDecoration => decoration(TextDecoration.none);

  /// Font family helpers
  TextStyle get primaryFont => fontFamily(AppTypography.primaryFont);
  TextStyle get secondaryFont => fontFamily(AppTypography.secondaryFont);
  TextStyle get monoFont => fontFamily(AppTypography.monoFont);

  /// Common text effects
  TextStyle get withShadow => copyWith(
        shadows: [
          Shadow(
            offset: const Offset(1, 1),
            blurRadius: 2,
            color: Colors.black.withAlpha(
                64), // 0.25 opacity is approximately 64 in alpha (0.25 * 255 ≈ 64)
          ),
        ],
      );

  TextStyle get glow => copyWith(
        shadows: [
          Shadow(
            offset: const Offset(0, 0),
            blurRadius: 8,
            color: Colors.white.withAlpha(
                204), // 0.8 opacity is approximately 204 in alpha (0.8 * 255 ≈ 204)
          ),
        ],
      );

  TextStyle get softShadow => copyWith(
        shadows: [
          Shadow(
            offset: const Offset(0, 2),
            blurRadius: 4,
            color: Colors.black.withAlpha(
                26), // 0.1 opacity is approximately 26 in alpha (0.1 * 255 ≈ 26)
          ),
        ],
      );

  /// Interactive states
  TextStyle get disabled => copyWith(
        color: color?.withAlpha(
            97), // 0.38 opacity is approximately 97 in alpha (0.38 * 255 ≈ 97)
      );

  TextStyle get pressed => copyWith(
        color: color?.withAlpha(
            31), // 0.12 opacity is approximately 31 in alpha (0.12 * 255 ≈ 31)
      );

  TextStyle get hover => copyWith(
        color: color?.withAlpha(
            20), // 0.08 opacity is approximately 20 in alpha (0.08 * 255 ≈ 20)
      );

  TextStyle get focus => copyWith(
        color: color?.withAlpha(
            31), // 0.12 opacity is approximately 31 in alpha (0.12 * 255 ≈ 31)
      );
}
