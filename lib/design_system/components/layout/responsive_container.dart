import 'package:flutter/material.dart';
import '../../core/breakpoints.dart';
import '../../extensions/context_extensions.dart';

/// Responsive container component with adaptive sizing and spacing
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final ResponsiveValue<double>? width;
  final ResponsiveValue<double>? height;
  final ResponsiveValue<EdgeInsetsGeometry>? padding;
  final ResponsiveValue<EdgeInsetsGeometry>? margin;
  final ResponsiveValue<AlignmentGeometry>? alignment;
  final ResponsiveValue<Decoration>? decoration;
  final ResponsiveValue<BoxConstraints>? constraints;
  final Color? color;
  final bool centerContent;
  final bool fillParent;
  final double? maxWidth;
  final double? minWidth;
  final double? maxHeight;
  final double? minHeight;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.alignment,
    this.decoration,
    this.constraints,
    this.color,
    this.centerContent = false,
    this.fillParent = false,
    this.maxWidth,
    this.minWidth,
    this.maxHeight,
    this.minHeight,
  });

  // Factory constructors for common layouts
  factory ResponsiveContainer.page({
    Key? key,
    required Widget child,
    bool centerContent = false,
    ResponsiveValue<EdgeInsetsGeometry>? padding,
    Color? color,
  }) {
    return ResponsiveContainer(
      key: key,
      child: child,
      centerContent: centerContent,
      padding: padding ?? _defaultPagePadding,
      maxWidth: 1200,
      fillParent: true,
      color: color,
    );
  }

  factory ResponsiveContainer.section({
    Key? key,
    required Widget child,
    ResponsiveValue<EdgeInsetsGeometry>? padding,
    ResponsiveValue<EdgeInsetsGeometry>? margin,
    Color? color,
    ResponsiveValue<Decoration>? decoration,
  }) {
    return ResponsiveContainer(
      key: key,
      child: child,
      padding: padding ?? _defaultSectionPadding,
      margin: margin ?? _defaultSectionMargin,
      fillParent: true,
      color: color,
      decoration: decoration,
    );
  }

  factory ResponsiveContainer.card({
    Key? key,
    required Widget child,
    ResponsiveValue<EdgeInsetsGeometry>? padding,
    ResponsiveValue<EdgeInsetsGeometry>? margin,
    Color? color,
  }) {
    return ResponsiveContainer(
      key: key,
      child: child,
      padding: padding ?? _defaultCardPadding,
      margin: margin ?? _defaultCardMargin,
      decoration: _cardDecoration,
      color: color,
    );
  }

  factory ResponsiveContainer.grid({
    Key? key,
    required Widget child,
    ResponsiveValue<EdgeInsetsGeometry>? padding,
    ResponsiveValue<EdgeInsetsGeometry>? margin,
  }) {
    return ResponsiveContainer(
      key: key,
      child: child,
      padding: padding ?? _defaultGridPadding,
      margin: margin ?? _defaultGridMargin,
      fillParent: true,
    );
  }

  // Default responsive values
  static ResponsiveValue<EdgeInsetsGeometry> get _defaultPagePadding =>
      ResponsiveValue(
        xs: const EdgeInsets.all(16.0),
        sm: const EdgeInsets.all(20.0),
        md: const EdgeInsets.all(24.0),
        lg: const EdgeInsets.all(32.0),
        xl: const EdgeInsets.all(40.0),
      );

  static ResponsiveValue<EdgeInsetsGeometry> get _defaultSectionPadding =>
      ResponsiveValue(
        xs: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        sm: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 20.0),
        md: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 24.0),
        lg: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 32.0),
        xl: const EdgeInsets.symmetric(vertical: 56.0, horizontal: 40.0),
      );

  static ResponsiveValue<EdgeInsetsGeometry> get _defaultSectionMargin =>
      ResponsiveValue(
        xs: const EdgeInsets.symmetric(vertical: 16.0),
        sm: const EdgeInsets.symmetric(vertical: 20.0),
        md: const EdgeInsets.symmetric(vertical: 24.0),
        lg: const EdgeInsets.symmetric(vertical: 32.0),
        xl: const EdgeInsets.symmetric(vertical: 40.0),
      );

  static ResponsiveValue<EdgeInsetsGeometry> get _defaultCardPadding =>
      ResponsiveValue(
        xs: const EdgeInsets.all(12.0),
        sm: const EdgeInsets.all(16.0),
        md: const EdgeInsets.all(20.0),
        lg: const EdgeInsets.all(24.0),
        xl: const EdgeInsets.all(28.0),
      );

  static ResponsiveValue<EdgeInsetsGeometry> get _defaultCardMargin =>
      ResponsiveValue(
        xs: const EdgeInsets.all(8.0),
        sm: const EdgeInsets.all(12.0),
        md: const EdgeInsets.all(16.0),
        lg: const EdgeInsets.all(20.0),
        xl: const EdgeInsets.all(24.0),
      );

  static ResponsiveValue<EdgeInsetsGeometry> get _defaultGridPadding =>
      ResponsiveValue(
        xs: const EdgeInsets.all(8.0),
        sm: const EdgeInsets.all(12.0),
        md: const EdgeInsets.all(16.0),
        lg: const EdgeInsets.all(20.0),
        xl: const EdgeInsets.all(24.0),
      );

  static ResponsiveValue<EdgeInsetsGeometry> get _defaultGridMargin =>
      ResponsiveValue(
        xs: const EdgeInsets.all(4.0),
        sm: const EdgeInsets.all(6.0),
        md: const EdgeInsets.all(8.0),
        lg: const EdgeInsets.all(10.0),
        xl: const EdgeInsets.all(12.0),
      );

  static ResponsiveValue<Decoration> get _cardDecoration =>
      ResponsiveValue<Decoration>(
        xs: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              offset: const Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
        sm: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              offset: const Offset(0, 2),
              blurRadius: 6,
            ),
          ],
        ),
        md: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              offset: const Offset(0, 4),
              blurRadius: 8,
            ),
          ],
        ),
        lg: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              offset: const Offset(0, 6),
              blurRadius: 12,
            ),
          ],
        ),
        xl: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              offset: const Offset(0, 8),
              blurRadius: 16,
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;

    // Get responsive values
    final containerWidth = width?.getValue(deviceSize);
    final containerHeight = height?.getValue(deviceSize);
    final containerPadding = padding?.getValue(deviceSize);
    final containerMargin = margin?.getValue(deviceSize);
    final containerAlignment = alignment?.getValue(deviceSize);
    final containerDecoration = decoration?.getValue(deviceSize);
    final containerConstraints = constraints?.getValue(deviceSize);

    // Build constraints
    BoxConstraints? finalConstraints = containerConstraints;
    if (maxWidth != null ||
        minWidth != null ||
        maxHeight != null ||
        minHeight != null) {
      finalConstraints = BoxConstraints(
        maxWidth: maxWidth ?? double.infinity,
        minWidth: minWidth ?? 0,
        maxHeight: maxHeight ?? double.infinity,
        minHeight: minHeight ?? 0,
      );
    }

    Widget container = Container(
      width: fillParent ? double.infinity : containerWidth,
      height: containerHeight,
      padding: containerPadding,
      margin: containerMargin,
      alignment: centerContent ? Alignment.center : containerAlignment,
      decoration: (containerDecoration != null && color != null)
          ? (containerDecoration is BoxDecoration 
              ? (containerDecoration).copyWith(color: color)
              : BoxDecoration(color: color))
          : containerDecoration ?? (color != null ? BoxDecoration(color: color) : null),
      constraints: finalConstraints,
      child: child,
    );

    return container;
  }
}

/// Responsive row component
class ResponsiveRow extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final ResponsiveValue<double>? spacing;
  final bool wrapOnSmallScreens;

  const ResponsiveRow({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.spacing,
    this.wrapOnSmallScreens = true,
  });

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;
    final shouldWrap = wrapOnSmallScreens &&
        (deviceSize == DeviceSize.xs || deviceSize == DeviceSize.sm);

    if (shouldWrap) {
      return ResponsiveColumn(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: spacing,
        children: children,
      );
    }

    final rowSpacing = spacing?.getValue(deviceSize) ?? 0.0;

    if (rowSpacing > 0) {
      final spacedChildren = <Widget>[];
      for (int i = 0; i < children.length; i++) {
        spacedChildren.add(children[i]);
        if (i < children.length - 1) {
          spacedChildren.add(SizedBox(width: rowSpacing));
        }
      }

      return Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: mainAxisSize,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
        textBaseline: textBaseline,
        children: spacedChildren,
      );
    }

    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: children,
    );
  }
}

/// Responsive column component
class ResponsiveColumn extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final ResponsiveValue<double>? spacing;

  const ResponsiveColumn({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;
    final columnSpacing = spacing?.getValue(deviceSize) ?? 0.0;

    if (columnSpacing > 0) {
      final spacedChildren = <Widget>[];
      for (int i = 0; i < children.length; i++) {
        spacedChildren.add(children[i]);
        if (i < children.length - 1) {
          spacedChildren.add(SizedBox(height: columnSpacing));
        }
      }

      return Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: mainAxisSize,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
        textBaseline: textBaseline,
        children: spacedChildren,
      );
    }

    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: children,
    );
  }
}
