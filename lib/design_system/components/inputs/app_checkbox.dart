import 'package:flutter/material.dart';
import '../../core/abstract_sizing.dart';
import '../../core/breakpoints.dart';
import '../../extensions/context_extensions.dart';
import '../../extensions/typography_extensions.dart';
import '../../extensions/color_extensions.dart';

/// Checkbox size variants
enum AppCheckboxSize {
  xs,
  sm,
  md,
  lg,
  xl,
}

/// Checkbox variant
enum AppCheckboxVariant {
  standard,
  filled,
  outlined,
  minimal,
}

/// Responsive checkbox component
class AppCheckbox extends StatefulWidget {
  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final String? label;
  final String? description;
  final AppCheckboxSize size;
  final AppCheckboxVariant variant;
  final bool isEnabled;
  final bool isRequired;
  final Color? activeColor;
  final Color? checkColor;
  final Color? focusColor;
  final Color? hoverColor;
  final WidgetStateProperty<Color?>? fillColor;
  final WidgetStateProperty<Color?>? overlayColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool tristate;
  final bool autofocus;
  final FocusNode? focusNode;
  final String? semanticLabel;
  final Widget? leading;
  final Widget? trailing;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final bool isCompact;

  const AppCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.description,
    this.size = AppCheckboxSize.md,
    this.variant = AppCheckboxVariant.standard,
    this.isEnabled = true,
    this.isRequired = false,
    this.activeColor,
    this.checkColor,
    this.focusColor,
    this.hoverColor,
    this.fillColor,
    this.overlayColor,
    this.padding,
    this.margin,
    this.tristate = false,
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
  State<AppCheckbox> createState() => _AppCheckboxState();
}

class _AppCheckboxState extends State<AppCheckbox>
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

    if (widget.tristate) {
      switch (widget.value) {
        case false:
          widget.onChanged?.call(true);
          break;
        case true:
          widget.onChanged?.call(null);
          break;
        case null:
          widget.onChanged?.call(false);
          break;
      }
    } else {
      widget.onChanged?.call(!(widget.value ?? false));
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;

    return Container(
      margin: widget.margin,
      child: widget.isCompact
          ? _buildCompactCheckbox(context, deviceSize)
          : _buildFullCheckbox(context, deviceSize),
    );
  }

  Widget _buildCompactCheckbox(BuildContext context, DeviceSize deviceSize) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: _buildCheckboxOnly(context, deviceSize),
        );
      },
    );
  }

  Widget _buildFullCheckbox(BuildContext context, DeviceSize deviceSize) {
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
                  child: _buildCheckboxOnly(context, deviceSize),
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

  Widget _buildCheckboxOnly(BuildContext context, DeviceSize deviceSize) {
    return SizedBox(
      width: _getCheckboxSize(deviceSize),
      height: _getCheckboxSize(deviceSize),
      child: Checkbox(
        value: widget.value,
        onChanged: widget.isEnabled ? widget.onChanged : null,
        tristate: widget.tristate,
        activeColor: widget.activeColor ?? context.primary,
        checkColor: widget.checkColor ?? context.onPrimary,
        focusColor: widget.focusColor ?? context.primary.withValues(alpha: 0.12),
        hoverColor: widget.hoverColor ?? context.primary.withValues(alpha: 0.08),
        fillColor: widget.fillColor ?? _getCheckboxFillColor(context),
        overlayColor: widget.overlayColor ?? _getCheckboxOverlayColor(context),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: _getVisualDensity(deviceSize),
        focusNode: widget.isCompact ? _focusNode : null,
        autofocus: widget.isCompact ? widget.autofocus : false,
        shape: _getCheckboxShape(context, deviceSize),
        side: _getCheckboxSide(context, deviceSize),
        semanticLabel: widget.semanticLabel,
      ),
    );
  }

  Widget _buildLabelContent(BuildContext context, DeviceSize deviceSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          RichText(
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
  double _getCheckboxSize(DeviceSize deviceSize) {
    return AppIconSizing.getValue(
        _getAppSizeFromCheckboxSize(widget.size), deviceSize);
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
      case AppCheckboxVariant.standard:
        return null;
      case AppCheckboxVariant.filled:
        if (_isHovered || _isFocused) {
          return context.surfaceVariant;
        }
        return null;
      case AppCheckboxVariant.outlined:
        return context.surface;
      case AppCheckboxVariant.minimal:
        if (_isHovered || _isFocused) {
          return context.primary.withValues(alpha: 0.04);
        }
        return null;
    }
  }

  Border? _getBorder(BuildContext context, DeviceSize deviceSize) {
    switch (widget.variant) {
      case AppCheckboxVariant.outlined:
        return Border.all(
          color: _isFocused ? context.primary : context.outline,
          width: _isFocused ? 2 : 1,
        );
      case AppCheckboxVariant.standard:
      case AppCheckboxVariant.filled:
      case AppCheckboxVariant.minimal:
        return null;
    }
  }

  WidgetStateProperty<Color?> _getCheckboxFillColor(BuildContext context) {
    return WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.disabled)) {
        return context.onSurface.withValues(alpha: 0.38);
      }
      if (states.contains(WidgetState.selected)) {
        return widget.activeColor ?? context.primary;
      }
      return null;
    });
  }

  WidgetStateProperty<Color?> _getCheckboxOverlayColor(BuildContext context) {
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

  OutlinedBorder _getCheckboxShape(
      BuildContext context, DeviceSize deviceSize) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        AppRadiusSizing.getValue(AppSize.xs, deviceSize),
      ),
    );
  }

  BorderSide? _getCheckboxSide(BuildContext context, DeviceSize deviceSize) {
    switch (widget.variant) {
      case AppCheckboxVariant.outlined:
        return BorderSide(
          color: context.outline,
          width: 2,
        );
      case AppCheckboxVariant.standard:
      case AppCheckboxVariant.filled:
      case AppCheckboxVariant.minimal:
        return null;
    }
  }

  VisualDensity _getVisualDensity(DeviceSize deviceSize) {
    switch (widget.size) {
      case AppCheckboxSize.xs:
        return const VisualDensity(horizontal: -4, vertical: -4);
      case AppCheckboxSize.sm:
        return const VisualDensity(horizontal: -2, vertical: -2);
      case AppCheckboxSize.md:
        return VisualDensity.standard;
      case AppCheckboxSize.lg:
        return const VisualDensity(horizontal: 2, vertical: 2);
      case AppCheckboxSize.xl:
        return const VisualDensity(horizontal: 4, vertical: 4);
    }
  }

  TextStyle _getLabelTextStyle(BuildContext context, DeviceSize deviceSize) {
    return context.bodyMedium.copyWith(
      fontSize: AppTypographySizing.getValue(
          _getAppSizeFromCheckboxSize(widget.size), deviceSize),
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

  AppSize _getAppSizeFromCheckboxSize(AppCheckboxSize size) {
    switch (size) {
      case AppCheckboxSize.xs:
        return AppSize.xs;
      case AppCheckboxSize.sm:
        return AppSize.sm;
      case AppCheckboxSize.md:
        return AppSize.md;
      case AppCheckboxSize.lg:
        return AppSize.lg;
      case AppCheckboxSize.xl:
        return AppSize.xl;
    }
  }
}
