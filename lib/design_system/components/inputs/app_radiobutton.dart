import 'package:flutter/material.dart';
import '../../core/abstract_sizing.dart';
import '../../core/breakpoints.dart';
import '../../extensions/context_extensions.dart';
import '../../extensions/typography_extensions.dart';
import '../../extensions/color_extensions.dart';

/// Radio button size variants
enum AppRadioButtonSize {
  xs,
  sm,
  md,
  lg,
  xl,
}

/// Radio button variant
enum AppRadioButtonVariant {
  standard,
  filled,
  outlined,
  minimal,
}

/// Radio button option model
class AppRadioOption<T> {
  final T value;
  final String label;
  final String? description;
  final Widget? icon;
  final bool isEnabled;

  const AppRadioOption({
    required this.value,
    required this.label,
    this.description,
    this.icon,
    this.isEnabled = true,
  });
}

/// Single radio button component
class AppRadioButton<T> extends StatefulWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final String? label;
  final String? description;
  final AppRadioButtonSize size;
  final AppRadioButtonVariant variant;
  final bool isEnabled;
  final Color? activeColor;
  final Color? focusColor;
  final Color? hoverColor;
  final WidgetStateProperty<Color?>? fillColor;
  final WidgetStateProperty<Color?>? overlayColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool autofocus;
  final FocusNode? focusNode;
  final String? semanticLabel;
  final Widget? leading;
  final Widget? trailing;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final bool isCompact;

  const AppRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.label,
    this.description,
    this.size = AppRadioButtonSize.md,
    this.variant = AppRadioButtonVariant.standard,
    this.isEnabled = true,
    this.activeColor,
    this.focusColor,
    this.hoverColor,
    this.fillColor,
    this.overlayColor,
    this.padding,
    this.margin,
    this.autofocus = false,
    this.focusNode,
    this.semanticLabel,
    this.leading,
    this.trailing,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.isCompact = false,
  });

  @override
  State<AppRadioButton<T>> createState() => _AppRadioButtonState<T>();
}

class _AppRadioButtonState<T> extends State<AppRadioButton<T>>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late FocusNode _focusNode;
  bool _isHovered = false;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _animationController.dispose();
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    _focusNode.removeListener(_handleFocusChange);
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _handleTap() {
    if (!widget.isEnabled) return;

    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    widget.onChanged?.call(widget.value);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;

    return Container(
      margin: widget.margin,
      child: widget.isCompact
          ? _buildCompactRadio(context, deviceSize)
          : _buildFullRadio(context, deviceSize),
    );
  }

  Widget _buildCompactRadio(BuildContext context, DeviceSize deviceSize) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: _buildRadioOnly(context, deviceSize),
        );
      },
    );
  }

  Widget _buildFullRadio(BuildContext context, DeviceSize deviceSize) {
    return InkWell(
      onTap: _handleTap,
      onHover: (hovered) {
        setState(() {
          _isHovered = hovered;
        });
      },
      focusNode: _focusNode,
      autofocus: widget.autofocus,
      borderRadius: BorderRadius.circular(
        AppRadiusSizing.getValue(AppSize.sm, deviceSize),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: widget.padding ?? _getDefaultPadding(deviceSize),
        decoration: BoxDecoration(
          color: _getBackgroundColor(context),
          borderRadius: BorderRadius.circular(
            AppRadiusSizing.getValue(AppSize.sm, deviceSize),
          ),
          border: _getBorder(context, deviceSize),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: widget.mainAxisAlignment,
          crossAxisAlignment: widget.crossAxisAlignment,
          children: [
            if (widget.leading != null) ...[
              widget.leading!,
              SizedBox(
                  width: AppSpacingSizing.getValue(AppSize.sm, deviceSize)),
            ],
            AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: _buildRadioOnly(context, deviceSize),
                );
              },
            ),
            if (widget.label != null || widget.description != null) ...[
              SizedBox(
                  width: AppSpacingSizing.getValue(AppSize.sm, deviceSize)),
              Expanded(
                child: _buildLabelContent(context, deviceSize),
              ),
            ],
            if (widget.trailing != null) ...[
              SizedBox(
                  width: AppSpacingSizing.getValue(AppSize.sm, deviceSize)),
              widget.trailing!,
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRadioOnly(BuildContext context, DeviceSize deviceSize) {
    return SizedBox(
      width: _getRadioSize(deviceSize),
      height: _getRadioSize(deviceSize),
      child: Radio<T>(
        value: widget.value,
        groupValue: widget.groupValue,
        onChanged: widget.isEnabled ? widget.onChanged : null,
        activeColor: widget.activeColor ?? context.primary,
        focusColor: widget.focusColor ?? context.primary.withValues(alpha: 0.12),
        hoverColor: widget.hoverColor ?? context.primary.withValues(alpha: 0.08),
        fillColor: widget.fillColor ?? _getRadioFillColor(context),
        overlayColor: widget.overlayColor ?? _getRadioOverlayColor(context),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: _getVisualDensity(deviceSize),
        focusNode: widget.isCompact ? _focusNode : null,
        autofocus: widget.isCompact ? widget.autofocus : false,
        toggleable: false,
      ),
    );
  }

  Widget _buildLabelContent(BuildContext context, DeviceSize deviceSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: _getLabelTextStyle(context, deviceSize),
          ),
        ],
        if (widget.description != null) ...[
          if (widget.label != null)
            SizedBox(height: AppSpacingSizing.getValue(AppSize.xs, deviceSize)),
          Text(
            widget.description!,
            style: _getDescriptionTextStyle(context, deviceSize),
          ),
        ],
      ],
    );
  }

  // Helper methods
  double _getRadioSize(DeviceSize deviceSize) {
    return AppIconSizing.getValue(
        _getAppSizeFromRadioSize(widget.size), deviceSize);
  }

  EdgeInsetsGeometry _getDefaultPadding(DeviceSize deviceSize) {
    return EdgeInsets.symmetric(
      horizontal: AppSpacingSizing.getValue(AppSize.sm, deviceSize),
      vertical: AppSpacingSizing.getValue(AppSize.xs, deviceSize),
    );
  }

  Color? _getBackgroundColor(BuildContext context) {
    if (!widget.isEnabled) return null;

    switch (widget.variant) {
      case AppRadioButtonVariant.standard:
        return null;
      case AppRadioButtonVariant.filled:
        if (_isHovered || _isFocused) {
          return context.surfaceVariant;
        }
        return null;
      case AppRadioButtonVariant.outlined:
        return context.surface;
      case AppRadioButtonVariant.minimal:
        if (_isHovered || _isFocused) {
          return context.primary.withValues(alpha: 0.04);
        }
        return null;
    }
  }

  Border? _getBorder(BuildContext context, DeviceSize deviceSize) {
    switch (widget.variant) {
      case AppRadioButtonVariant.outlined:
        return Border.all(
          color: _isFocused ? context.primary : context.outline,
          width: _isFocused ? 2 : 1,
        );
      case AppRadioButtonVariant.standard:
      case AppRadioButtonVariant.filled:
      case AppRadioButtonVariant.minimal:
        return null;
    }
  }

  WidgetStateProperty<Color?> _getRadioFillColor(BuildContext context) {
    return WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.disabled)) {
        return context.onSurface.withValues(alpha: 0.38);
      }
      if (states.contains(WidgetState.selected)) {
        return widget.activeColor ?? context.primary;
      }
      return context.onSurfaceVariant;
    });
  }

  WidgetStateProperty<Color?> _getRadioOverlayColor(BuildContext context) {
    return WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.pressed)) {
        return context.primary.withValues(alpha: 0.12);
      }
      if (states.contains(WidgetState.hovered)) {
        return context.primary.withValues(alpha: 0.08);
      }
      if (states.contains(WidgetState.focused)) {
        return context.primary.withValues(alpha: 0.12);
      }
      return null;
    });
  }

  VisualDensity _getVisualDensity(DeviceSize deviceSize) {
    switch (widget.size) {
      case AppRadioButtonSize.xs:
        return const VisualDensity(horizontal: -4, vertical: -4);
      case AppRadioButtonSize.sm:
        return const VisualDensity(horizontal: -2, vertical: -2);
      case AppRadioButtonSize.md:
        return VisualDensity.standard;
      case AppRadioButtonSize.lg:
        return const VisualDensity(horizontal: 2, vertical: 2);
      case AppRadioButtonSize.xl:
        return const VisualDensity(horizontal: 4, vertical: 4);
    }
  }

  TextStyle _getLabelTextStyle(BuildContext context, DeviceSize deviceSize) {
    return context.bodyMedium.copyWith(
      fontSize: AppTypographySizing.getValue(
          _getAppSizeFromRadioSize(widget.size), deviceSize),
      color: widget.isEnabled
          ? context.onSurface
          : context.onSurface.withValues(alpha: 0.38),
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle _getDescriptionTextStyle(
      BuildContext context, DeviceSize deviceSize) {
    return context.bodySmall.copyWith(
      fontSize: AppTypographySizing.getValue(AppSize.sm, deviceSize),
      color: widget.isEnabled
          ? context.onSurfaceVariant
          : context.onSurfaceVariant.withValues(alpha: 0.38),
    );
  }

  AppSize _getAppSizeFromRadioSize(AppRadioButtonSize size) {
    switch (size) {
      case AppRadioButtonSize.xs:
        return AppSize.xs;
      case AppRadioButtonSize.sm:
        return AppSize.sm;
      case AppRadioButtonSize.md:
        return AppSize.md;
      case AppRadioButtonSize.lg:
        return AppSize.lg;
      case AppRadioButtonSize.xl:
        return AppSize.xl;
    }
  }
}

/// Radio button group component
class AppRadioButtonGroup<T> extends StatefulWidget {
  final List<AppRadioOption<T>> options;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String? label;
  final String? errorText;
  final String? helperText;
  final AppRadioButtonSize size;
  final AppRadioButtonVariant variant;
  final bool isEnabled;
  final bool isRequired;
  final Axis direction;
  final WrapAlignment wrapAlignment;
  final WrapCrossAlignment wrapCrossAlignment;
  final double spacing;
  final double runSpacing;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool allowDeselection;

  const AppRadioButtonGroup({
    super.key,
    required this.options,
    this.value,
    this.onChanged,
    this.label,
    this.errorText,
    this.helperText,
    this.size = AppRadioButtonSize.md,
    this.variant = AppRadioButtonVariant.standard,
    this.isEnabled = true,
    this.isRequired = false,
    this.direction = Axis.vertical,
    this.wrapAlignment = WrapAlignment.start,
    this.wrapCrossAlignment = WrapCrossAlignment.start,
    this.spacing = 8.0,
    this.runSpacing = 4.0,
    this.padding,
    this.margin,
    this.allowDeselection = false,
  });

  @override
  State<AppRadioButtonGroup<T>> createState() => _AppRadioButtonGroupState<T>();
}

class _AppRadioButtonGroupState<T> extends State<AppRadioButtonGroup<T>> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;

    return Container(
      margin: widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null) ...[
            _buildLabel(context, deviceSize),
            SizedBox(height: AppSpacingSizing.getValue(AppSize.xs, deviceSize)),
          ],
          Container(
            padding: widget.padding,
            child: _buildRadioGroup(context, deviceSize),
          ),
          if (widget.errorText != null || widget.helperText != null) ...[
            SizedBox(height: AppSpacingSizing.getValue(AppSize.xs, deviceSize)),
            _buildHelperText(context, deviceSize),
          ],
        ],
      ),
    );
  }

  Widget _buildLabel(BuildContext context, DeviceSize deviceSize) {
    return RichText(
      text: TextSpan(
        text: widget.label!,
        style: _getLabelTextStyle(context, deviceSize),
        children: [
          if (widget.isRequired)
            TextSpan(
              text: ' *',
              style: TextStyle(color: context.error),
            ),
        ],
      ),
    );
  }

  Widget _buildRadioGroup(BuildContext context, DeviceSize deviceSize) {
    final responsiveSpacing = AppSpacingSizing.getValue(AppSize.sm, deviceSize);
    final responsiveRunSpacing =
        AppSpacingSizing.getValue(AppSize.xs, deviceSize);

    if (widget.direction == Axis.vertical) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.options.map((option) {
          final index = widget.options.indexOf(option);
          return Padding(
            padding: EdgeInsets.only(
              bottom: index < widget.options.length - 1 ? responsiveSpacing : 0,
            ),
            child: _buildRadioButton(context, deviceSize, option),
          );
        }).toList(),
      );
    } else {
      return Wrap(
        direction: widget.direction,
        alignment: widget.wrapAlignment,
        crossAxisAlignment: widget.wrapCrossAlignment,
        spacing: responsiveSpacing,
        runSpacing: responsiveRunSpacing,
        children: widget.options.map((option) {
          return _buildRadioButton(context, deviceSize, option);
        }).toList(),
      );
    }
  }

  Widget _buildRadioButton(
      BuildContext context, DeviceSize deviceSize, AppRadioOption<T> option) {
    return AppRadioButton<T>(
      value: option.value,
      groupValue: widget.value,
      onChanged: widget.isEnabled && option.isEnabled
          ? (value) {
              if (widget.allowDeselection && value == widget.value) {
                widget.onChanged?.call(null);
              } else {
                widget.onChanged?.call(value);
              }
            }
          : null,
      label: option.label,
      description: option.description,
      size: widget.size,
      variant: widget.variant,
      isEnabled: widget.isEnabled && option.isEnabled,
      leading: option.icon,
    );
  }

  Widget _buildHelperText(BuildContext context, DeviceSize deviceSize) {
    final text = widget.errorText ?? widget.helperText;
    final isError = widget.errorText != null;

    return Text(
      text!,
      style: _getHelperTextStyle(context, deviceSize).copyWith(
        color: isError ? context.error : context.onSurfaceVariant,
      ),
    );
  }

  TextStyle _getLabelTextStyle(BuildContext context, DeviceSize deviceSize) {
    return context.labelMedium.copyWith(
      fontSize: AppTypographySizing.getValue(AppSize.sm, deviceSize),
      fontWeight: FontWeight.w500,
      color: widget.isEnabled
          ? context.onSurface
          : context.onSurface.withValues(alpha: 0.38),
    );
  }

  TextStyle _getHelperTextStyle(BuildContext context, DeviceSize deviceSize) {
    return context.bodySmall.copyWith(
      fontSize: AppTypographySizing.getValue(AppSize.xs, deviceSize),
    );
  }
}
