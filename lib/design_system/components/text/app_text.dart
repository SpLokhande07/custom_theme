import 'package:flutter/material.dart';
import '../../extensions/typography_extensions.dart';

/// Text variant enum
enum AppTextVariant {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineLarge,
  headlineMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
  labelLarge,
  labelMedium,
  labelSmall,
  caption,
  overline,
  code,
  link,
  error,
}

/// Text size enum
enum AppTextSize {
  xs,
  sm,
  md,
  lg,
  xl,
}

/// Responsive text component
class AppText extends StatefulWidget {
  final String text;
  final AppTextVariant? variant;
  final AppTextSize? size;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? lineHeight;
  final double? letterSpacing;
  final String? fontFamily;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final TextDecorationStyle? decorationStyle;
  final double? decorationThickness;
  final List<Shadow>? shadows;
  final bool isSelectable;
  final bool isRich;
  final VoidCallback? onTap;
  final String? semanticsLabel;
  final bool? isAnimated;
  final Duration? animationDuration;
  final Curve? animationCurve;

  const AppText(
    this.text, {
    super.key,
    this.variant,
    this.size,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.lineHeight,
    this.letterSpacing,
    this.fontFamily,
    this.textAlign,
    this.textDirection,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.decoration,
    this.decorationColor,
    this.decorationStyle,
    this.decorationThickness,
    this.shadows,
    this.isSelectable = false,
    this.isRich = false,
    this.onTap,
    this.semanticsLabel,
    this.isAnimated,
    this.animationDuration,
    this.animationCurve,
  });

  // Factory constructors for common text variants
  factory AppText.displayLarge(
    String text, {
    Key? key,
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool isSelectable = false,
    VoidCallback? onTap,
  }) {
    return AppText(
      text,
      key: key,
      variant: AppTextVariant.displayLarge,
      color: color,
      fontWeight: fontWeight,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      isSelectable: isSelectable,
      onTap: onTap,
    );
  }

  factory AppText.displayMedium(
    String text, {
    Key? key,
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool isSelectable = false,
    VoidCallback? onTap,
  }) {
    return AppText(
      text,
      key: key,
      variant: AppTextVariant.displayMedium,
      color: color,
      fontWeight: fontWeight,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      isSelectable: isSelectable,
      onTap: onTap,
    );
  }

  factory AppText.displaySmall(
    String text, {
    Key? key,
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool isSelectable = false,
    VoidCallback? onTap,
  }) {
    return AppText(
      text,
      key: key,
      variant: AppTextVariant.displaySmall,
      color: color,
      fontWeight: fontWeight,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      isSelectable: isSelectable,
      onTap: onTap,
    );
  }

  factory AppText.headlineLarge(
    String text, {
    Key? key,
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool isSelectable = false,
    VoidCallback? onTap,
  }) {
    return AppText(
      text,
      key: key,
      variant: AppTextVariant.headlineLarge,
      color: color,
      fontWeight: fontWeight,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      isSelectable: isSelectable,
      onTap: onTap,
    );
  }

  factory AppText.headlineMedium(
    String text, {
    Key? key,
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool isSelectable = false,
    VoidCallback? onTap,
  }) {
    return AppText(
      text,
      key: key,
      variant: AppTextVariant.headlineMedium,
      color: color,
      fontWeight: fontWeight,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      isSelectable: isSelectable,
      onTap: onTap,
    );
  }

  factory AppText.headlineSmall(
    String text, {
    Key? key,
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool isSelectable = false,
    VoidCallback? onTap,
  }) {
    return AppText(
      text,
      key: key,
      variant: AppTextVariant.headlineSmall,
      color: color,
      fontWeight: fontWeight,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      isSelectable: isSelectable,
      onTap: onTap,
    );
  }

  factory AppText.titleLarge(
    String text, {
    Key? key,
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool isSelectable = false,
    VoidCallback? onTap,
  }) {
    return AppText(
      text,
      key: key,
      variant: AppTextVariant.titleLarge,
      color: color,
      fontWeight: fontWeight,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      isSelectable: isSelectable,
      onTap: onTap,
    );
  }

  factory AppText.titleMedium(
    String text, {
    Key? key,
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool isSelectable = false,
    VoidCallback? onTap,
  }) {
    return AppText(
      text,
      key: key,
      variant: AppTextVariant.titleMedium,
      color: color,
      fontWeight: fontWeight,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      isSelectable: isSelectable,
      onTap: onTap,
    );
  }

  factory AppText.titleSmall(
    String text, {
    Key? key,
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool isSelectable = false,
    VoidCallback? onTap,
  }) {
    return AppText(
      text,
      key: key,
      variant: AppTextVariant.titleSmall,
      color: color,
      fontWeight: fontWeight,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      isSelectable: isSelectable,
      onTap: onTap,
    );
  }

  factory AppText.bodyLarge(
    String text, {
    Key? key,
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool isSelectable = false,
    VoidCallback? onTap,
  }) {
    return AppText(
      text,
      key: key,
      variant: AppTextVariant.bodyLarge,
      color: color,
      fontWeight: fontWeight,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      isSelectable: isSelectable,
      onTap: onTap,
    );
  }

  factory AppText.bodyMedium(
    String text, {
    Key? key,
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool isSelectable = false,
    VoidCallback? onTap,
  }) {
    return AppText(
      text,
      key: key,
      variant: AppTextVariant.bodyMedium,
      color: color,
      fontWeight: fontWeight,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      isSelectable: isSelectable,
      onTap: onTap,
    );
  }

  factory AppText.bodySmall(
    String text, {
    Key? key,
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool isSelectable = false,
    VoidCallback? onTap,
  }) {
    return AppText(
      text,
      key: key,
      variant: AppTextVariant.bodySmall,
      color: color,
      fontWeight: fontWeight,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      isSelectable: isSelectable,
      onTap: onTap,
    );
  }

  factory AppText.labelLarge(
    String text, {
    Key? key,
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool isSelectable = false,
    VoidCallback? onTap,
  }) {
    return AppText(
      text,
      key: key,
      variant: AppTextVariant.labelLarge,
      color: color,
      fontWeight: fontWeight,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      isSelectable: isSelectable,
      onTap: onTap,
    );
  }

  factory AppText.labelMedium(
    String text, {
    Key? key,
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool isSelectable = false,
    VoidCallback? onTap,
  }) {
    return AppText(
      text,
      key: key,
      variant: AppTextVariant.labelMedium,
      color: color,
      fontWeight: fontWeight,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      isSelectable: isSelectable,
      onTap: onTap,
    );
  }

  factory AppText.labelSmall(
    String text, {
    Key? key,
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool isSelectable = false,
    VoidCallback? onTap,
  }) {
    return AppText(
      text,
      key: key,
      variant: AppTextVariant.labelSmall,
      color: color,
      fontWeight: fontWeight,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      isSelectable: isSelectable,
      onTap: onTap,
    );
  }

  factory AppText.caption(
    String text, {
    Key? key,
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool isSelectable = false,
    VoidCallback? onTap,
  }) {
    return AppText(
      text,
      key: key,
      variant: AppTextVariant.caption,
      color: color,
      fontWeight: fontWeight,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      isSelectable: isSelectable,
      onTap: onTap,
    );
  }

  factory AppText.overline(
    String text, {
    Key? key,
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool isSelectable = false,
    VoidCallback? onTap,
  }) {
    return AppText(
      text,
      key: key,
      variant: AppTextVariant.overline,
      color: color,
      fontWeight: fontWeight,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      isSelectable: isSelectable,
      onTap: onTap,
    );
  }

  factory AppText.code(
    String text, {
    Key? key,
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool isSelectable = true,
    VoidCallback? onTap,
  }) {
    return AppText(
      text,
      key: key,
      variant: AppTextVariant.code,
      color: color,
      fontWeight: fontWeight,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      isSelectable: isSelectable,
      onTap: onTap,
    );
  }

  factory AppText.link(
    String text, {
    Key? key,
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool isSelectable = false,
    VoidCallback? onTap,
  }) {
    return AppText(
      text,
      key: key,
      variant: AppTextVariant.link,
      color: color,
      fontWeight: fontWeight,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      isSelectable: isSelectable,
      onTap: onTap,
    );
  }

  factory AppText.error(
    String text, {
    Key? key,
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool isSelectable = false,
    VoidCallback? onTap,
  }) {
    return AppText(
      text,
      key: key,
      variant: AppTextVariant.error,
      color: color,
      fontWeight: fontWeight,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      isSelectable: isSelectable,
      onTap: onTap,
    );
  }

  @override
  State<AppText> createState() => _AppTextState();
}

class _AppTextState extends State<AppText> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    if (widget.isAnimated ?? false) {
      _animationController = AnimationController(
        duration: widget.animationDuration ?? const Duration(milliseconds: 300),
        vsync: this,
      );

      _fadeAnimation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve ?? Curves.easeInOut,
      ));

      _slideAnimation = Tween<Offset>(
        begin: const Offset(0, 0.1),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve ?? Curves.easeInOut,
      ));

      _animationController.forward();
    }
  }

  @override
  void dispose() {
    if (widget.isAnimated ?? false) {
      _animationController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = _getTextStyle(context);

    Widget textWidget = _buildTextWidget(context, textStyle);

    if (widget.onTap != null) {
      textWidget = GestureDetector(
        onTap: widget.onTap,
        child: textWidget,
      );
    }

    if (widget.isAnimated ?? false) {
      textWidget = AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: child,
            ),
          );
        },
        child: textWidget,
      );
    }

    return textWidget;
  }

  Widget _buildTextWidget(BuildContext context, TextStyle textStyle) {
    if (widget.isSelectable) {
      return SelectableText(
        widget.text,
        style: textStyle,
        textAlign: widget.textAlign,
        textDirection: widget.textDirection,
        maxLines: widget.maxLines,
        semanticsLabel: widget.semanticsLabel,
      );
    } else {
      return Text(
        widget.text,
        style: textStyle,
        textAlign: widget.textAlign,
        textDirection: widget.textDirection,
        maxLines: widget.maxLines,
        overflow: widget.overflow,
        softWrap: widget.softWrap,
        semanticsLabel: widget.semanticsLabel,
      );
    }
  }

  TextStyle _getTextStyle(BuildContext context) {
    TextStyle baseStyle = _getBaseStyle(context);

    // Apply size modifications
    if (widget.size != null) {
      baseStyle = _applySizeModifications(context, baseStyle);
    }

    // Apply custom modifications
    return baseStyle.copyWith(
      color: widget.color,
      fontWeight: widget.fontWeight,
      fontSize: widget.fontSize,
      height: widget.lineHeight,
      letterSpacing: widget.letterSpacing,
      fontFamily: widget.fontFamily,
      decoration: widget.decoration,
      decorationColor: widget.decorationColor,
      decorationStyle: widget.decorationStyle,
      decorationThickness: widget.decorationThickness,
      shadows: widget.shadows,
    );
  }

  TextStyle _getBaseStyle(BuildContext context) {
    switch (widget.variant) {
      case AppTextVariant.displayLarge:
        return context.displayLarge;
      case AppTextVariant.displayMedium:
        return context.displayMedium;
      case AppTextVariant.displaySmall:
        return context.displaySmall;
      case AppTextVariant.headlineLarge:
        return context.headlineLarge;
      case AppTextVariant.headlineMedium:
        return context.headlineMedium;
      case AppTextVariant.headlineSmall:
        return context.headlineSmall;
      case AppTextVariant.titleLarge:
        return context.titleLarge;
      case AppTextVariant.titleMedium:
        return context.titleMedium;
      case AppTextVariant.titleSmall:
        return context.titleSmall;
      case AppTextVariant.bodyLarge:
        return context.bodyLarge;
      case AppTextVariant.bodyMedium:
        return context.bodyMedium;
      case AppTextVariant.bodySmall:
        return context.bodySmall;
      case AppTextVariant.labelLarge:
        return context.labelLarge;
      case AppTextVariant.labelMedium:
        return context.labelMedium;
      case AppTextVariant.labelSmall:
        return context.labelSmall;
      case AppTextVariant.caption:
        return context.captionStyle;
      case AppTextVariant.overline:
        return context.overlineStyle;
      case AppTextVariant.code:
        return context.codeStyle;
      case AppTextVariant.link:
        return context.linkStyle;
      case AppTextVariant.error:
        return context.errorStyle;
      case null:
        return context.bodyMedium;
    }
  }

  TextStyle _applySizeModifications(BuildContext context, TextStyle baseStyle) {
    double sizeFactor = 1.0;

    switch (widget.size!) {
      case AppTextSize.xs:
        sizeFactor = 0.8;
        break;
      case AppTextSize.sm:
        sizeFactor = 0.9;
        break;
      case AppTextSize.md:
        sizeFactor = 1.0;
        break;
      case AppTextSize.lg:
        sizeFactor = 1.1;
        break;
      case AppTextSize.xl:
        sizeFactor = 1.2;
        break;
    }

    return baseStyle.copyWith(
      fontSize: (baseStyle.fontSize ?? 14.0) * sizeFactor,
    );
  }
}
