import 'package:flutter/material.dart';
import '../../core/design_tokens.dart';
import '../../core/breakpoints.dart';
import '../../extensions/context_extensions.dart';
import '../../extensions/typography_extensions.dart';
import '../../extensions/color_extensions.dart';

/// Button size variants
enum AppButtonSize {
  xs,
  sm,
  md,
  lg,
  xl,
}

/// Button style variants
enum AppButtonVariant {
  primary,
  secondary,
  tertiary,
  outline,
  ghost,
  link,
  danger,
  success,
  warning,
  info,
}

/// Responsive button component
class AppButton extends StatefulWidget {
  final String? text;
  final Widget? child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final AppButtonSize size;
  final AppButtonVariant variant;
  final bool isLoading;
  final bool isDisabled;
  final bool isFullWidth;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final double? elevation;
  final String? tooltip;
  final bool autofocus;
  final FocusNode? focusNode;

  const AppButton({
    super.key,
    this.text,
    this.child,
    this.onPressed,
    this.onLongPress,
    this.size = AppButtonSize.md,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.isDisabled = false,
    this.isFullWidth = false,
    this.leadingIcon,
    this.trailingIcon,
    this.borderRadius,
    this.padding,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.elevation,
    this.tooltip,
    this.autofocus = false,
    this.focusNode,
  }) : assert(text != null || child != null,
            'Either text or child must be provided');

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;
  bool _isHovered = false;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppDuration.fast,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: AppCurves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final buttonStyle = _getButtonStyle(context);
    final textStyle = _getTextStyle(context);
    final buttonPadding = _getButtonPadding(context);
    final buttonHeight = _getButtonHeight(context);
    final buttonBorderRadius = _getBorderRadius(context);

    Widget buttonChild = _buildButtonChild(context, textStyle);

    if (widget.isFullWidth) {
      buttonChild = SizedBox(
        width: double.infinity,
        height: buttonHeight,
        child: buttonChild,
      );
    } else {
      buttonChild = SizedBox(
        height: buttonHeight,
        child: buttonChild,
      );
    }

    Widget button = AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        );
      },
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap:
              widget.isDisabled || widget.isLoading ? null : widget.onPressed,
          onLongPress:
              widget.isDisabled || widget.isLoading ? null : widget.onLongPress,
          onTapDown: _handleTapDown,
          onTapUp: _handleTapUp,
          onTapCancel: _handleTapCancel,
          onHover: _handleHover,
          onFocusChange: _handleFocusChange,
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          borderRadius: buttonBorderRadius,
          child: Container(
            padding: buttonPadding,
            decoration: BoxDecoration(
              color: buttonStyle.backgroundColor?.resolve(_getButtonState()),
              border: buttonStyle.side?.resolve(_getButtonState()) != null
                  ? Border.all(
                      color:
                          buttonStyle.side!.resolve(_getButtonState())!.color,
                      width:
                          buttonStyle.side!.resolve(_getButtonState())!.width,
                    )
                  : null,
              borderRadius: buttonBorderRadius,
              boxShadow:
                  buttonStyle.elevation?.resolve(_getButtonState()) != null &&
                          buttonStyle.elevation!.resolve(_getButtonState())! > 0
                      ? context.boxShadow(
                          buttonStyle.elevation!.resolve(_getButtonState())!)
                      : null,
            ),
            child: buttonChild,
          ),
        ),
      ),
    );

    if (widget.tooltip != null) {
      button = Tooltip(
        message: widget.tooltip!,
        child: button,
      );
    }

    return button;
  }

  Widget _buildButtonChild(BuildContext context, TextStyle textStyle) {
    if (widget.isLoading) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: _getIconSize(context),
            height: _getIconSize(context),
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                textStyle.color ?? context.onPrimary,
              ),
            ),
          ),
          if (widget.text != null || widget.child != null) ...[
            SizedBox(width: context.spacingSm),
            Flexible(
              child: widget.child ??
                  Text(
                    widget.text!,
                    style: textStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
            ),
          ],
        ],
      );
    }

    final hasLeading = widget.leadingIcon != null;
    final hasTrailing = widget.trailingIcon != null;
    final hasText = widget.text != null || widget.child != null;

    if (!hasText && !hasLeading && !hasTrailing) {
      return const SizedBox.shrink();
    }

    if (!hasText) {
      return widget.leadingIcon ?? widget.trailingIcon!;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (hasLeading) ...[
          widget.leadingIcon!,
          SizedBox(width: context.spacingSm),
        ],
        Flexible(
          child: widget.child ??
              Text(
                widget.text!,
                style: textStyle,
                overflow: TextOverflow.ellipsis,
              ),
        ),
        if (hasTrailing) ...[
          SizedBox(width: context.spacingSm),
          widget.trailingIcon!,
        ],
      ],
    );
  }

  ButtonStyle _getButtonStyle(BuildContext context) {
    final colors = _getButtonColors(context);
    final shape = _getButtonShape(context);
    final elevation = _getButtonElevation(context);

    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.disabled)) {
          return colors.disabledBackground;
        }
        if (states.contains(WidgetState.pressed)) {
          return colors.pressedBackground;
        }
        if (states.contains(WidgetState.hovered)) {
          return colors.hoveredBackground;
        }
        if (states.contains(WidgetState.focused)) {
          return colors.focusedBackground;
        }
        return colors.background;
      }),
      foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.disabled)) {
          return colors.disabledForeground;
        }
        if (states.contains(WidgetState.pressed)) {
          return colors.pressedForeground;
        }
        if (states.contains(WidgetState.hovered)) {
          return colors.hoveredForeground;
        }
        if (states.contains(WidgetState.focused)) {
          return colors.focusedForeground;
        }
        return colors.foreground;
      }),
      side: WidgetStateProperty.resolveWith<BorderSide?>((states) {
        if (widget.variant == AppButtonVariant.outline ||
            widget.borderColor != null) {
          Color borderColor = widget.borderColor ?? colors.border;
          if (states.contains(WidgetState.disabled)) {
            borderColor = borderColor.withValues(alpha: 0.38);
          }
          return BorderSide(color: borderColor, width: 1);
        }
        return null;
      }),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(shape),
      elevation: WidgetStateProperty.resolveWith<double>((states) {
        if (states.contains(WidgetState.disabled)) {
          return 0;
        }
        if (states.contains(WidgetState.pressed)) {
          return elevation * 0.5;
        }
        if (states.contains(WidgetState.hovered)) {
          return elevation * 1.5;
        }
        return elevation;
      }),
      animationDuration: AppDuration.fast,
    );
  }

  _ButtonColors _getButtonColors(BuildContext context) {
    final colors = context.colors;

    switch (widget.variant) {
      case AppButtonVariant.primary:
        return _ButtonColors(
          background: widget.backgroundColor ?? colors.primary,
          foreground: widget.foregroundColor ?? colors.onPrimary,
          hoveredBackground:
              (widget.backgroundColor ?? colors.primary).withValues(alpha: 0.9),
          hoveredForeground: widget.foregroundColor ?? colors.onPrimary,
          pressedBackground:
              (widget.backgroundColor ?? colors.primary).withValues(alpha: 0.8),
          pressedForeground: widget.foregroundColor ?? colors.onPrimary,
          focusedBackground:
              (widget.backgroundColor ?? colors.primary).withValues(alpha: 0.9),
          focusedForeground: widget.foregroundColor ?? colors.onPrimary,
          disabledBackground: colors.surface.withValues(alpha: 0.12),
          disabledForeground: colors.onSurface.withValues(alpha: 0.38),
          border: colors.primary,
        );

      case AppButtonVariant.secondary:
        return _ButtonColors(
          background: widget.backgroundColor ?? colors.secondary,
          foreground: widget.foregroundColor ?? colors.onSecondary,
          hoveredBackground: (widget.backgroundColor ?? colors.secondary)
              .withValues(alpha: 0.9),
          hoveredForeground: widget.foregroundColor ?? colors.onSecondary,
          pressedBackground: (widget.backgroundColor ?? colors.secondary)
              .withValues(alpha: 0.8),
          pressedForeground: widget.foregroundColor ?? colors.onSecondary,
          focusedBackground: (widget.backgroundColor ?? colors.secondary)
              .withValues(alpha: 0.9),
          focusedForeground: widget.foregroundColor ?? colors.onSecondary,
          disabledBackground: colors.surface.withValues(alpha: 0.12),
          disabledForeground: colors.onSurface.withValues(alpha: 0.38),
          border: colors.secondary,
        );

      case AppButtonVariant.tertiary:
        return _ButtonColors(
          background: widget.backgroundColor ?? colors.tertiary,
          foreground: widget.foregroundColor ?? colors.onTertiary,
          hoveredBackground: (widget.backgroundColor ?? colors.tertiary)
              .withValues(alpha: 0.9),
          hoveredForeground: widget.foregroundColor ?? colors.onTertiary,
          pressedBackground: (widget.backgroundColor ?? colors.tertiary)
              .withValues(alpha: 0.8),
          pressedForeground: widget.foregroundColor ?? colors.onTertiary,
          focusedBackground: (widget.backgroundColor ?? colors.tertiary)
              .withValues(alpha: 0.9),
          focusedForeground: widget.foregroundColor ?? colors.onTertiary,
          disabledBackground: colors.surface.withValues(alpha: 0.12),
          disabledForeground: colors.onSurface.withValues(alpha: 0.38),
          border: colors.tertiary,
        );

      case AppButtonVariant.outline:
        return _ButtonColors(
          background: widget.backgroundColor ?? Colors.transparent,
          foreground: widget.foregroundColor ?? colors.primary,
          hoveredBackground: (widget.foregroundColor ?? colors.primary)
              .withValues(alpha: 0.08),
          hoveredForeground: widget.foregroundColor ?? colors.primary,
          pressedBackground: (widget.foregroundColor ?? colors.primary)
              .withValues(alpha: 0.12),
          pressedForeground: widget.foregroundColor ?? colors.primary,
          focusedBackground: (widget.foregroundColor ?? colors.primary)
              .withValues(alpha: 0.08),
          focusedForeground: widget.foregroundColor ?? colors.primary,
          disabledBackground: Colors.transparent,
          disabledForeground: colors.onSurface.withValues(alpha: 0.38),
          border: widget.borderColor ?? colors.outline,
        );

      case AppButtonVariant.ghost:
        return _ButtonColors(
          background: widget.backgroundColor ?? Colors.transparent,
          foreground: widget.foregroundColor ?? colors.primary,
          hoveredBackground: (widget.foregroundColor ?? colors.primary)
              .withValues(alpha: 0.08),
          hoveredForeground: widget.foregroundColor ?? colors.primary,
          pressedBackground: (widget.foregroundColor ?? colors.primary)
              .withValues(alpha: 0.12),
          pressedForeground: widget.foregroundColor ?? colors.primary,
          focusedBackground: (widget.foregroundColor ?? colors.primary)
              .withValues(alpha: 0.08),
          focusedForeground: widget.foregroundColor ?? colors.primary,
          disabledBackground: Colors.transparent,
          disabledForeground: colors.onSurface.withValues(alpha: 0.38),
          border: Colors.transparent,
        );

      case AppButtonVariant.link:
        return _ButtonColors(
          background: widget.backgroundColor ?? Colors.transparent,
          foreground: widget.foregroundColor ?? context.link,
          hoveredBackground: context.link.withValues(alpha: 0.08),
          hoveredForeground: widget.foregroundColor ?? context.link,
          pressedBackground: context.link.withValues(alpha: 0.12),
          pressedForeground: widget.foregroundColor ?? context.link,
          focusedBackground: context.link.withValues(alpha: 0.08),
          focusedForeground: widget.foregroundColor ?? context.link,
          disabledBackground: Colors.transparent,
          disabledForeground: colors.onSurface.withValues(alpha: 0.38),
          border: Colors.transparent,
        );

      case AppButtonVariant.danger:
        return _ButtonColors(
          background: widget.backgroundColor ?? colors.error,
          foreground: widget.foregroundColor ?? colors.onError,
          hoveredBackground:
              (widget.backgroundColor ?? colors.error).withValues(alpha: 0.9),
          hoveredForeground: widget.foregroundColor ?? colors.onError,
          pressedBackground:
              (widget.backgroundColor ?? colors.error).withValues(alpha: 0.8),
          pressedForeground: widget.foregroundColor ?? colors.onError,
          focusedBackground:
              (widget.backgroundColor ?? colors.error).withValues(alpha: 0.9),
          focusedForeground: widget.foregroundColor ?? colors.onError,
          disabledBackground: colors.surface.withValues(alpha: 0.12),
          disabledForeground: colors.onSurface.withValues(alpha: 0.38),
          border: colors.error,
        );

      case AppButtonVariant.success:
        return _ButtonColors(
          background: widget.backgroundColor ?? context.success,
          foreground: widget.foregroundColor ?? context.onSuccess,
          hoveredBackground: (widget.backgroundColor ?? context.success)
              .withValues(alpha: 0.9),
          hoveredForeground: widget.foregroundColor ?? context.onSuccess,
          pressedBackground: (widget.backgroundColor ?? context.success)
              .withValues(alpha: 0.8),
          pressedForeground: widget.foregroundColor ?? context.onSuccess,
          focusedBackground: (widget.backgroundColor ?? context.success)
              .withValues(alpha: 0.9),
          focusedForeground: widget.foregroundColor ?? context.onSuccess,
          disabledBackground: colors.surface.withValues(alpha: 0.12),
          disabledForeground: colors.onSurface.withValues(alpha: 0.38),
          border: context.success,
        );

      case AppButtonVariant.warning:
        return _ButtonColors(
          background: widget.backgroundColor ?? context.warning,
          foreground: widget.foregroundColor ?? context.onWarning,
          hoveredBackground: (widget.backgroundColor ?? context.warning)
              .withValues(alpha: 0.9),
          hoveredForeground: widget.foregroundColor ?? context.onWarning,
          pressedBackground: (widget.backgroundColor ?? context.warning)
              .withValues(alpha: 0.8),
          pressedForeground: widget.foregroundColor ?? context.onWarning,
          focusedBackground: (widget.backgroundColor ?? context.warning)
              .withValues(alpha: 0.9),
          focusedForeground: widget.foregroundColor ?? context.onWarning,
          disabledBackground: colors.surface.withValues(alpha: 0.12),
          disabledForeground: colors.onSurface.withValues(alpha: 0.38),
          border: context.warning,
        );

      case AppButtonVariant.info:
        return _ButtonColors(
          background: widget.backgroundColor ?? context.info,
          foreground: widget.foregroundColor ?? context.onInfo,
          hoveredBackground:
              (widget.backgroundColor ?? context.info).withValues(alpha: 0.9),
          hoveredForeground: widget.foregroundColor ?? context.onInfo,
          pressedBackground:
              (widget.backgroundColor ?? context.info).withValues(alpha: 0.8),
          pressedForeground: widget.foregroundColor ?? context.onInfo,
          focusedBackground:
              (widget.backgroundColor ?? context.info).withValues(alpha: 0.9),
          focusedForeground: widget.foregroundColor ?? context.onInfo,
          disabledBackground: colors.surface.withValues(alpha: 0.12),
          disabledForeground: colors.onSurface.withValues(alpha: 0.38),
          border: context.info,
        );
    }
  }

  TextStyle _getTextStyle(BuildContext context) {
    TextStyle baseStyle;

    switch (widget.size) {
      case AppButtonSize.xs:
        baseStyle = context.labelSmall;
        break;
      case AppButtonSize.sm:
        baseStyle = context.labelMedium;
        break;
      case AppButtonSize.md:
        baseStyle = context.labelLarge;
        break;
      case AppButtonSize.lg:
        baseStyle = context.titleSmall;
        break;
      case AppButtonSize.xl:
        baseStyle = context.titleMedium;
        break;
    }

    return baseStyle.copyWith(
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    );
  }

  EdgeInsetsGeometry _getButtonPadding(BuildContext context) {
    if (widget.padding != null) {
      return widget.padding!;
    }

    switch (widget.size) {
      case AppButtonSize.xs:
        return EdgeInsets.symmetric(
          horizontal: context.spacingSm,
          vertical: context.spacingXs,
        );
      case AppButtonSize.sm:
        return EdgeInsets.symmetric(
          horizontal: context.spacingMd,
          vertical: context.spacingSm,
        );
      case AppButtonSize.md:
        return EdgeInsets.symmetric(
          horizontal: context.spacingLg,
          vertical: context.spacingMd,
        );
      case AppButtonSize.lg:
        return EdgeInsets.symmetric(
          horizontal: context.spacingXl,
          vertical: context.spacingLg,
        );
      case AppButtonSize.xl:
        return EdgeInsets.symmetric(
          horizontal: context.spacingXl * 1.5,
          vertical: context.spacingXl,
        );
    }
  }

  double _getButtonHeight(BuildContext context) {
    switch (widget.size) {
      case AppButtonSize.xs:
        return context.responsiveValue(ResponsiveValue(
          xs: 24.0,
          sm: 28.0,
          md: 32.0,
          lg: 36.0,
          xl: 40.0,
        ));
      case AppButtonSize.sm:
        return context.responsiveValue(ResponsiveValue(
          xs: 32.0,
          sm: 36.0,
          md: 40.0,
          lg: 44.0,
          xl: 48.0,
        ));
      case AppButtonSize.md:
        return context.responsiveValue(ResponsiveValue(
          xs: 40.0,
          sm: 44.0,
          md: 48.0,
          lg: 52.0,
          xl: 56.0,
        ));
      case AppButtonSize.lg:
        return context.responsiveValue(ResponsiveValue(
          xs: 48.0,
          sm: 52.0,
          md: 56.0,
          lg: 60.0,
          xl: 64.0,
        ));
      case AppButtonSize.xl:
        return context.responsiveValue(ResponsiveValue(
          xs: 56.0,
          sm: 60.0,
          md: 64.0,
          lg: 68.0,
          xl: 72.0,
        ));
    }
  }

  double _getIconSize(BuildContext context) {
    switch (widget.size) {
      case AppButtonSize.xs:
        return context.iconSizeXs;
      case AppButtonSize.sm:
        return context.iconSizeSm;
      case AppButtonSize.md:
        return context.iconSizeMd;
      case AppButtonSize.lg:
        return context.iconSizeLg;
      case AppButtonSize.xl:
        return context.iconSizeLg * 1.2;
    }
  }

  BorderRadius _getBorderRadius(BuildContext context) {
    if (widget.borderRadius != null) {
      return widget.borderRadius!;
    }

    switch (widget.size) {
      case AppButtonSize.xs:
        return BorderRadius.circular(context.radiusXs);
      case AppButtonSize.sm:
        return BorderRadius.circular(context.radiusSm);
      case AppButtonSize.md:
        return BorderRadius.circular(context.radiusMd);
      case AppButtonSize.lg:
        return BorderRadius.circular(context.radiusMd);
      case AppButtonSize.xl:
        return BorderRadius.circular(context.radiusMd * 1.2);
    }
  }

  RoundedRectangleBorder _getButtonShape(BuildContext context) {
    return RoundedRectangleBorder(
      borderRadius: _getBorderRadius(context),
    );
  }

  double _getButtonElevation(BuildContext context) {
    if (widget.elevation != null) {
      return widget.elevation!;
    }

    switch (widget.variant) {
      case AppButtonVariant.primary:
      case AppButtonVariant.secondary:
      case AppButtonVariant.tertiary:
      case AppButtonVariant.danger:
      case AppButtonVariant.success:
      case AppButtonVariant.warning:
      case AppButtonVariant.info:
        return context.elevationSm;
      case AppButtonVariant.outline:
      case AppButtonVariant.ghost:
      case AppButtonVariant.link:
        return 0;
    }
  }

  void _handleTapDown(TapDownDetails details) {
    if (!widget.isDisabled && !widget.isLoading) {
      setState(() {
        _isPressed = true;
      });
      _animationController.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (!widget.isDisabled && !widget.isLoading) {
      setState(() {
        _isPressed = false;
      });
      _animationController.reverse();
    }
  }

  void _handleTapCancel() {
    if (!widget.isDisabled && !widget.isLoading) {
      setState(() {
        _isPressed = false;
      });
      _animationController.reverse();
    }
  }

  void _handleHover(bool isHovered) {
    if (!widget.isDisabled && !widget.isLoading) {
      setState(() {
        _isHovered = isHovered;
      });
    }
  }

  void _handleFocusChange(bool isFocused) {
    if (!widget.isDisabled && !widget.isLoading) {
      setState(() {
        _isFocused = isFocused;
      });
    }
  }

  Set<WidgetState> _getButtonState() {
    final states = <WidgetState>{};
    if (widget.isDisabled) {
      states.add(WidgetState.disabled);
    }
    if (_isPressed) {
      states.add(WidgetState.pressed);
    }
    if (_isHovered) {
      states.add(WidgetState.hovered);
    }
    if (_isFocused) {
      states.add(WidgetState.focused);
    }
    return states;
  }
}

/// Helper class for button colors
class _ButtonColors {
  final Color background;
  final Color foreground;
  final Color hoveredBackground;
  final Color hoveredForeground;
  final Color pressedBackground;
  final Color pressedForeground;
  final Color focusedBackground;
  final Color focusedForeground;
  final Color disabledBackground;
  final Color disabledForeground;
  final Color border;

  const _ButtonColors({
    required this.background,
    required this.foreground,
    required this.hoveredBackground,
    required this.hoveredForeground,
    required this.pressedBackground,
    required this.pressedForeground,
    required this.focusedBackground,
    required this.focusedForeground,
    required this.disabledBackground,
    required this.disabledForeground,
    required this.border,
  });
}
