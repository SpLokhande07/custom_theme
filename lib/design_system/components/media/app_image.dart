import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/abstract_sizing.dart';
import '../../core/breakpoints.dart';
import '../../extensions/context_extensions.dart';
import '../../extensions/color_extensions.dart';

/// Image size variants
enum AppImageSize {
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

/// Image fit variants
enum AppImageFit {
  cover,
  contain,
  fill,
  fitWidth,
  fitHeight,
  scaleDown,
  none,
}

/// Image shape variants
enum AppImageShape {
  rectangle,
  circle,
  rounded,
  stadium,
}

/// Image variant for different use cases
enum AppImageVariant {
  standard,
  avatar,
  thumbnail,
  hero,
  background,
  icon,
}

/// Responsive image container component
class AppImageContainer extends StatefulWidget {
  final String? imageUrl;
  final String? assetPath;
  final Widget? child;
  final AppImageSize size;
  final AppImageVariant variant;
  final AppImageShape shape;
  final AppImageFit fit;
  final double? width;
  final double? height;
  final double? aspectRatio;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final List<BoxShadow>? shadows;
  final Gradient? gradient;
  final Widget? placeholder;
  final Widget? errorWidget;
  final bool isLoading;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final String? heroTag;
  final bool enableHero;
  final bool isResponsive;
  final Map<String, String>? headers;
  final double? borderRadius;
  final BlendMode? colorBlendMode;
  final Color? colorFilter;

  const AppImageContainer({
    super.key,
    this.imageUrl,
    this.assetPath,
    this.child,
    this.size = AppImageSize.md,
    this.variant = AppImageVariant.standard,
    this.shape = AppImageShape.rectangle,
    this.fit = AppImageFit.cover,
    this.width,
    this.height,
    this.aspectRatio,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.padding,
    this.margin,
    this.shadows,
    this.gradient,
    this.placeholder,
    this.errorWidget,
    this.isLoading = false,
    this.onTap,
    this.onLongPress,
    this.heroTag,
    this.enableHero = false,
    this.isResponsive = true,
    this.headers,
    this.borderRadius,
    this.colorBlendMode,
    this.colorFilter,
  }) : assert(
          imageUrl != null || assetPath != null || child != null,
          'Either imageUrl, assetPath, or child must be provided',
        );

  // Factory constructors for common use cases
  factory AppImageContainer.avatar({
    Key? key,
    String? imageUrl,
    String? assetPath,
    Widget? child,
    AppImageSize size = AppImageSize.md,
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    EdgeInsetsGeometry? margin,
    VoidCallback? onTap,
    Widget? placeholder,
    Widget? errorWidget,
  }) {
    return AppImageContainer(
      key: key,
      imageUrl: imageUrl,
      assetPath: assetPath,
      child: child,
      size: size,
      variant: AppImageVariant.avatar,
      shape: AppImageShape.circle,
      fit: AppImageFit.cover,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      margin: margin,
      onTap: onTap,
      placeholder: placeholder,
      errorWidget: errorWidget,
    );
  }

  factory AppImageContainer.thumbnail({
    Key? key,
    String? imageUrl,
    String? assetPath,
    AppImageSize size = AppImageSize.sm,
    AppImageShape shape = AppImageShape.rounded,
    Color? backgroundColor,
    EdgeInsetsGeometry? margin,
    VoidCallback? onTap,
    Widget? placeholder,
    Widget? errorWidget,
  }) {
    return AppImageContainer(
      key: key,
      imageUrl: imageUrl,
      assetPath: assetPath,
      size: size,
      variant: AppImageVariant.thumbnail,
      shape: shape,
      fit: AppImageFit.cover,
      backgroundColor: backgroundColor,
      margin: margin,
      onTap: onTap,
      placeholder: placeholder,
      errorWidget: errorWidget,
    );
  }

  factory AppImageContainer.hero({
    Key? key,
    String? imageUrl,
    String? assetPath,
    AppImageSize size = AppImageSize.xl3,
    double? aspectRatio,
    Color? backgroundColor,
    Gradient? gradient,
    EdgeInsetsGeometry? margin,
    VoidCallback? onTap,
    String? heroTag,
    Widget? placeholder,
    Widget? errorWidget,
  }) {
    return AppImageContainer(
      key: key,
      imageUrl: imageUrl,
      assetPath: assetPath,
      size: size,
      variant: AppImageVariant.hero,
      shape: AppImageShape.rounded,
      fit: AppImageFit.cover,
      aspectRatio: aspectRatio ?? 16 / 9,
      backgroundColor: backgroundColor,
      gradient: gradient,
      margin: margin,
      onTap: onTap,
      heroTag: heroTag,
      enableHero: heroTag != null,
      placeholder: placeholder,
      errorWidget: errorWidget,
    );
  }

  factory AppImageContainer.background({
    Key? key,
    String? imageUrl,
    String? assetPath,
    Widget? child,
    double? width,
    double? height,
    Color? backgroundColor,
    Gradient? gradient,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BlendMode? colorBlendMode,
    Color? colorFilter,
  }) {
    return AppImageContainer(
      key: key,
      imageUrl: imageUrl,
      assetPath: assetPath,
      child: child,
      variant: AppImageVariant.background,
      fit: AppImageFit.cover,
      width: width,
      height: height,
      backgroundColor: backgroundColor,
      gradient: gradient,
      padding: padding,
      margin: margin,
      colorBlendMode: colorBlendMode,
      colorFilter: colorFilter,
    );
  }

  @override
  State<AppImageContainer> createState() => _AppImageContainerState();
}

class _AppImageContainerState extends State<AppImageContainer> {
  bool _hasError = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;
    final dimensions = _getImageDimensions(deviceSize);
    final decoration = _getImageDecoration(context, deviceSize);
    final borderRadius = _getBorderRadius(context, deviceSize);

    Widget imageWidget = _buildImageContent(context, deviceSize, dimensions);

    if (widget.enableHero && widget.heroTag != null) {
      imageWidget = Hero(
        tag: widget.heroTag!,
        child: imageWidget,
      );
    }

    if (widget.onTap != null || widget.onLongPress != null) {
      imageWidget = GestureDetector(
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        child: imageWidget,
      );
    }

    return Container(
      width: dimensions.width,
      height: dimensions.height,
      margin: widget.margin,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Container(
          decoration: decoration,
          padding: widget.padding,
          child: imageWidget,
        ),
      ),
    );
  }

  Widget _buildImageContent(
      BuildContext context, DeviceSize deviceSize, Size dimensions) {
    if (widget.isLoading || _isLoading) {
      return _buildPlaceholder(context, deviceSize) ??
          _buildDefaultLoader(context, deviceSize);
    }

    if (_hasError) {
      return _buildErrorWidget(context, deviceSize) ??
          _buildDefaultError(context, deviceSize);
    }

    if (widget.child != null) {
      return widget.child!;
    }

    if (widget.assetPath != null) {
      return _buildAssetImage(context, deviceSize, dimensions);
    }

    if (widget.imageUrl != null) {
      return _buildNetworkImage(context, deviceSize, dimensions);
    }

    return _buildPlaceholder(context, deviceSize) ??
        _buildDefaultPlaceholder(context, deviceSize);
  }

  Widget _buildNetworkImage(
      BuildContext context, DeviceSize deviceSize, Size dimensions) {
    return Image.network(
      widget.imageUrl!,
      width: dimensions.width,
      height: dimensions.height,
      fit: _getBoxFit(),
      headers: widget.headers,
      color: widget.colorFilter,
      colorBlendMode: widget.colorBlendMode,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          setState(() {
            _isLoading = false;
            _hasError = false;
          });
          return child;
        }

        if (!_isLoading) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              setState(() {
                _isLoading = true;
              });
            }
          });
        }

        return _buildPlaceholder(context, deviceSize) ??
            _buildDefaultLoader(context, deviceSize);
      },
      errorBuilder: (context, error, stackTrace) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            setState(() {
              _hasError = true;
              _isLoading = false;
            });
          }
        });

        return _buildErrorWidget(context, deviceSize) ??
            _buildDefaultError(context, deviceSize);
      },
    );
  }

  Widget _buildAssetImage(
      BuildContext context, DeviceSize deviceSize, Size dimensions) {
    final isVector = widget.assetPath!.toLowerCase().endsWith('.svg');

    if (isVector) {
      return SvgPicture.asset(
        widget.assetPath!,
        width: dimensions.width,
        height: dimensions.height,
        fit: _getBoxFit(),
        colorFilter: widget.colorFilter != null
            ? ColorFilter.mode(
                widget.colorFilter!, widget.colorBlendMode ?? BlendMode.srcIn)
            : null,
        placeholderBuilder: (context) =>
            _buildPlaceholder(context, deviceSize) ??
            _buildDefaultLoader(context, deviceSize),
      );
    } else {
      return Image.asset(
        widget.assetPath!,
        width: dimensions.width,
        height: dimensions.height,
        fit: _getBoxFit(),
        color: widget.colorFilter,
        colorBlendMode: widget.colorBlendMode,
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorWidget(context, deviceSize) ??
              _buildDefaultError(context, deviceSize);
        },
      );
    }
  }

  Widget? _buildPlaceholder(BuildContext context, DeviceSize deviceSize) {
    return widget.placeholder;
  }

  Widget? _buildErrorWidget(BuildContext context, DeviceSize deviceSize) {
    return widget.errorWidget;
  }

  Widget _buildDefaultLoader(BuildContext context, DeviceSize deviceSize) {
    return Container(
      color: widget.backgroundColor ?? context.surfaceVariant,
      child: Center(
        child: SizedBox(
          width: AppIconSizing.getValue(AppSize.lg, deviceSize),
          height: AppIconSizing.getValue(AppSize.lg, deviceSize),
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(context.primary),
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultPlaceholder(BuildContext context, DeviceSize deviceSize) {
    return Container(
      color: widget.backgroundColor ?? context.surfaceVariant,
      child: Center(
        child: Icon(
          _getPlaceholderIcon(),
          size: AppIconSizing.getValue(AppSize.lg, deviceSize),
          color: context.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _buildDefaultError(BuildContext context, DeviceSize deviceSize) {
    return Container(
      color: widget.backgroundColor ?? context.errorContainer,
      child: Center(
        child: Icon(
          Icons.broken_image,
          size: AppIconSizing.getValue(AppSize.lg, deviceSize),
          color: context.onErrorContainer,
        ),
      ),
    );
  }

  Size _getImageDimensions(DeviceSize deviceSize) {
    double? width = widget.width;
    double? height = widget.height;

    if (widget.isResponsive) {
      final baseSize = AppIconSizing.getValue(
          _getAppSizeFromImageSize(widget.size), deviceSize);

      if (width == null && height == null) {
        width = baseSize;
        height = widget.aspectRatio != null
            ? baseSize / widget.aspectRatio!
            : baseSize;
      } else if (width == null) {
        width =
            widget.aspectRatio != null ? height! * widget.aspectRatio! : height;
      } else {
        height ??=
            widget.aspectRatio != null ? width / widget.aspectRatio! : width;
      }
    }

    return Size(width ?? double.infinity, height ?? double.infinity);
  }

  BoxDecoration _getImageDecoration(
      BuildContext context, DeviceSize deviceSize) {
    return BoxDecoration(
      color: widget.backgroundColor,
      gradient: widget.gradient,
      border: widget.borderColor != null
          ? Border.all(
              color: widget.borderColor!,
              width: widget.borderWidth ?? 1,
            )
          : null,
      borderRadius: _getBorderRadius(context, deviceSize),
      boxShadow: widget.shadows,
    );
  }

  BorderRadius _getBorderRadius(BuildContext context, DeviceSize deviceSize) {
    if (widget.borderRadius != null) {
      return BorderRadius.circular(widget.borderRadius!);
    }

    switch (widget.shape) {
      case AppImageShape.rectangle:
        return BorderRadius.zero;
      case AppImageShape.circle:
        return BorderRadius.circular(1000);
      case AppImageShape.rounded:
        return BorderRadius.circular(
          AppRadiusSizing.getValue(AppSize.md, deviceSize),
        );
      case AppImageShape.stadium:
        return BorderRadius.circular(1000);
    }
  }

  BoxFit _getBoxFit() {
    switch (widget.fit) {
      case AppImageFit.cover:
        return BoxFit.cover;
      case AppImageFit.contain:
        return BoxFit.contain;
      case AppImageFit.fill:
        return BoxFit.fill;
      case AppImageFit.fitWidth:
        return BoxFit.fitWidth;
      case AppImageFit.fitHeight:
        return BoxFit.fitHeight;
      case AppImageFit.scaleDown:
        return BoxFit.scaleDown;
      case AppImageFit.none:
        return BoxFit.none;
    }
  }

  IconData _getPlaceholderIcon() {
    switch (widget.variant) {
      case AppImageVariant.avatar:
        return Icons.person;
      case AppImageVariant.thumbnail:
        return Icons.image;
      case AppImageVariant.hero:
        return Icons.landscape;
      case AppImageVariant.background:
        return Icons.wallpaper;
      case AppImageVariant.icon:
        return Icons.category;
      case AppImageVariant.standard:
        return Icons.image;
    }
  }

  AppSize _getAppSizeFromImageSize(AppImageSize size) {
    switch (size) {
      case AppImageSize.xs:
        return AppSize.xs;
      case AppImageSize.sm:
        return AppSize.sm;
      case AppImageSize.md:
        return AppSize.md;
      case AppImageSize.lg:
        return AppSize.lg;
      case AppImageSize.xl:
        return AppSize.xl;
      case AppImageSize.xl2:
        return AppSize.xl2;
      case AppImageSize.xl3:
        return AppSize.xl3;
      case AppImageSize.xl4:
        return AppSize.xl4;
      case AppImageSize.xl5:
        return AppSize.xl5;
    }
  }
}

/// SVG Icon component
class AppSvgIcon extends StatelessWidget {
  final String assetPath;
  final AppImageSize size;
  final Color? color;
  final double? width;
  final double? height;
  final BoxFit fit;
  final String? semanticLabel;
  final bool isResponsive;

  const AppSvgIcon({
    super.key,
    required this.assetPath,
    this.size = AppImageSize.md,
    this.color,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.semanticLabel,
    this.isResponsive = true,
  });

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;
    final iconSize = isResponsive
        ? AppIconSizing.getValue(_getAppSizeFromImageSize(size), deviceSize)
        : _getStaticSize();

    return SvgPicture.asset(
      assetPath,
      width: width ?? iconSize,
      height: height ?? iconSize,
      fit: fit,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      semanticsLabel: semanticLabel,
    );
  }

  double _getStaticSize() {
    switch (size) {
      case AppImageSize.xs:
        return 12.0;
      case AppImageSize.sm:
        return 16.0;
      case AppImageSize.md:
        return 24.0;
      case AppImageSize.lg:
        return 32.0;
      case AppImageSize.xl:
        return 40.0;
      case AppImageSize.xl2:
        return 48.0;
      case AppImageSize.xl3:
        return 56.0;
      case AppImageSize.xl4:
        return 64.0;
      case AppImageSize.xl5:
        return 72.0;
    }
  }

  AppSize _getAppSizeFromImageSize(AppImageSize size) {
    switch (size) {
      case AppImageSize.xs:
        return AppSize.xs;
      case AppImageSize.sm:
        return AppSize.sm;
      case AppImageSize.md:
        return AppSize.md;
      case AppImageSize.lg:
        return AppSize.lg;
      case AppImageSize.xl:
        return AppSize.xl;
      case AppImageSize.xl2:
        return AppSize.xl2;
      case AppImageSize.xl3:
        return AppSize.xl3;
      case AppImageSize.xl4:
        return AppSize.xl4;
      case AppImageSize.xl5:
        return AppSize.xl5;
    }
  }
}
