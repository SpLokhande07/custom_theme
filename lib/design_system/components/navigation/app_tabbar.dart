import 'package:flutter/material.dart';
import '../../core/abstract_sizing.dart';
import '../../core/breakpoints.dart';
import '../../extensions/context_extensions.dart';
import '../../extensions/typography_extensions.dart';
import '../../extensions/color_extensions.dart';

/// Tab bar size variants
enum AppTabBarSize {
  xs,
  sm,
  md,
  lg,
  xl,
}

/// Tab bar variant
enum AppTabBarVariant {
  primary,
  secondary,
  minimal,
  pills,
  underline,
}

/// Tab bar item model
class AppTabItem {
  final String text;
  final Widget? icon;
  final Widget? badge;
  final bool isEnabled;
  final VoidCallback? onTap;

  const AppTabItem({
    required this.text,
    this.icon,
    this.badge,
    this.isEnabled = true,
    this.onTap,
  });
}

/// Responsive tab bar component
class AppTabBar extends StatefulWidget {
  final List<AppTabItem> tabs;
  final int? selectedIndex;
  final ValueChanged<int>? onTabSelected;
  final AppTabBarSize size;
  final AppTabBarVariant variant;
  final bool isScrollable;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? indicatorColor;
  final double? indicatorWeight;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool showBadges;
  final bool showIcons;
  final bool adaptToMobile;
  final TabController? controller;

  const AppTabBar({
    super.key,
    required this.tabs,
    this.selectedIndex,
    this.onTabSelected,
    this.size = AppTabBarSize.md,
    this.variant = AppTabBarVariant.primary,
    this.isScrollable = false,
    this.backgroundColor,
    this.selectedColor,
    this.unselectedColor,
    this.indicatorColor,
    this.indicatorWeight,
    this.padding,
    this.margin,
    this.showBadges = true,
    this.showIcons = true,
    this.adaptToMobile = true,
    this.controller,
  });

  @override
  State<AppTabBar> createState() => _AppTabBarState();
}

class _AppTabBarState extends State<AppTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex ?? 0;
    _tabController = widget.controller ??
        TabController(
          length: widget.tabs.length,
          vsync: this,
          initialIndex: _selectedIndex,
        );
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _tabController.dispose();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(AppTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != null &&
        widget.selectedIndex != _selectedIndex) {
      _selectedIndex = widget.selectedIndex!;
      _tabController.animateTo(_selectedIndex);
    }
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) return;

    final newIndex = _tabController.index;
    if (newIndex != _selectedIndex) {
      setState(() {
        _selectedIndex = newIndex;
      });
      widget.onTabSelected?.call(newIndex);
      widget.tabs[newIndex].onTap?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;
    final shouldAdaptToMobile = widget.adaptToMobile && context.isMobile;

    if (shouldAdaptToMobile && widget.variant == AppTabBarVariant.pills) {
      return _buildMobileTabBar(context, deviceSize);
    }

    return _buildDesktopTabBar(context, deviceSize);
  }

  Widget _buildDesktopTabBar(BuildContext context, DeviceSize deviceSize) {
    switch (widget.variant) {
      case AppTabBarVariant.primary:
        return _buildMaterialTabBar(context, deviceSize);
      case AppTabBarVariant.secondary:
        return _buildSecondaryTabBar(context, deviceSize);
      case AppTabBarVariant.minimal:
        return _buildMinimalTabBar(context, deviceSize);
      case AppTabBarVariant.pills:
        return _buildPillsTabBar(context, deviceSize);
      case AppTabBarVariant.underline:
        return _buildUnderlineTabBar(context, deviceSize);
    }
  }

  Widget _buildMaterialTabBar(BuildContext context, DeviceSize deviceSize) {
    return Container(
      padding: widget.padding ?? _getDefaultPadding(deviceSize),
      margin: widget.margin,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? context.surface,
        border: Border(
          bottom: BorderSide(
            color: context.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        isScrollable: widget.isScrollable,
        indicatorColor: widget.indicatorColor ?? context.primary,
        indicatorWeight: widget.indicatorWeight ?? 2.0,
        labelColor: widget.selectedColor ?? context.primary,
        unselectedLabelColor:
            widget.unselectedColor ?? context.onSurfaceVariant,
        labelStyle: _getTabTextStyle(context, deviceSize, true),
        unselectedLabelStyle: _getTabTextStyle(context, deviceSize, false),
        tabs: widget.tabs
            .map((tab) => _buildTab(context, deviceSize, tab))
            .toList(),
      ),
    );
  }

  Widget _buildSecondaryTabBar(BuildContext context, DeviceSize deviceSize) {
    return Container(
      padding: widget.padding ?? _getDefaultPadding(deviceSize),
      margin: widget.margin,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? context.surfaceVariant,
        borderRadius: BorderRadius.circular(
          AppRadiusSizing.getValue(AppSize.md, deviceSize),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        isScrollable: widget.isScrollable,
        indicator: BoxDecoration(
          color: context.primary,
          borderRadius: BorderRadius.circular(
            AppRadiusSizing.getValue(AppSize.sm, deviceSize),
          ),
        ),
        labelColor: context.onPrimary,
        unselectedLabelColor: context.onSurfaceVariant,
        labelStyle: _getTabTextStyle(context, deviceSize, true),
        unselectedLabelStyle: _getTabTextStyle(context, deviceSize, false),
        tabs: widget.tabs
            .map((tab) => _buildTab(context, deviceSize, tab))
            .toList(),
      ),
    );
  }

  Widget _buildMinimalTabBar(BuildContext context, DeviceSize deviceSize) {
    return Container(
      padding: widget.padding ?? _getDefaultPadding(deviceSize),
      margin: widget.margin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: widget.tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final tab = entry.value;
          final isSelected = index == _selectedIndex;

          return GestureDetector(
            onTap: () => _tabController.animateTo(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(
                horizontal:
                    AppSpacingSizing.getValue(AppSize.md, context.deviceSize),
                vertical:
                    AppSpacingSizing.getValue(AppSize.sm, context.deviceSize),
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? context.primary.withValues(alpha: 0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(
                  AppRadiusSizing.getValue(AppSize.sm, deviceSize),
                ),
              ),
              child: _buildTabContent(context, deviceSize, tab, isSelected),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPillsTabBar(BuildContext context, DeviceSize deviceSize) {
    return Container(
      padding: widget.padding ?? _getDefaultPadding(deviceSize),
      margin: widget.margin,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: widget.tabs.asMap().entries.map((entry) {
            final index = entry.key;
            final tab = entry.value;
            final isSelected = index == _selectedIndex;

            return Padding(
              padding: EdgeInsets.only(
                right: AppSpacingSizing.getValue(AppSize.sm, deviceSize),
              ),
              child: GestureDetector(
                onTap: () => _tabController.animateTo(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacingSizing.getValue(
                        AppSize.lg, context.deviceSize),
                    vertical: AppSpacingSizing.getValue(
                        AppSize.md, context.deviceSize),
                  ),
                  decoration: BoxDecoration(
                    color:
                        isSelected ? context.primary : context.surfaceVariant,
                    borderRadius: BorderRadius.circular(
                      AppRadiusSizing.getValue(AppSize.xl, deviceSize),
                    ),
                    border: Border.all(
                      color: isSelected ? context.primary : context.outline,
                      width: 1,
                    ),
                  ),
                  child: _buildTabContent(context, deviceSize, tab, isSelected),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildUnderlineTabBar(BuildContext context, DeviceSize deviceSize) {
    return Container(
      padding: widget.padding ?? _getDefaultPadding(deviceSize),
      margin: widget.margin,
      child: TabBar(
        controller: _tabController,
        isScrollable: widget.isScrollable,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: widget.indicatorColor ?? context.primary,
            width: widget.indicatorWeight ?? 3.0,
          ),
          insets: EdgeInsets.symmetric(
            horizontal: AppSpacingSizing.getValue(AppSize.md, deviceSize),
          ),
        ),
        labelColor: widget.selectedColor ?? context.primary,
        unselectedLabelColor:
            widget.unselectedColor ?? context.onSurfaceVariant,
        labelStyle: _getTabTextStyle(context, deviceSize, true),
        unselectedLabelStyle: _getTabTextStyle(context, deviceSize, false),
        tabs: widget.tabs
            .map((tab) => _buildTab(context, deviceSize, tab))
            .toList(),
      ),
    );
  }

  Widget _buildMobileTabBar(BuildContext context, DeviceSize deviceSize) {
    return Container(
      padding: widget.padding ?? _getDefaultPadding(deviceSize),
      margin: widget.margin,
      child: Column(
        children: widget.tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final tab = entry.value;
          final isSelected = index == _selectedIndex;

          return GestureDetector(
            onTap: () => _tabController.animateTo(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: double.infinity,
              margin: EdgeInsets.only(
                bottom: AppSpacingSizing.getValue(AppSize.sm, deviceSize),
              ),
              padding: EdgeInsets.symmetric(
                horizontal:
                    AppSpacingSizing.getValue(AppSize.lg, context.deviceSize),
                vertical:
                    AppSpacingSizing.getValue(AppSize.md, context.deviceSize),
              ),
              decoration: BoxDecoration(
                color: isSelected ? context.primary : context.surfaceVariant,
                borderRadius: BorderRadius.circular(
                  AppRadiusSizing.getValue(AppSize.md, deviceSize),
                ),
                border: Border.all(
                  color: isSelected ? context.primary : context.outline,
                  width: 1,
                ),
              ),
              child: _buildTabContent(context, deviceSize, tab, isSelected),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTab(
      BuildContext context, DeviceSize deviceSize, AppTabItem tab) {
    return Tab(
      child: _buildTabContent(context, deviceSize, tab, false),
    );
  }

  Widget _buildTabContent(BuildContext context, DeviceSize deviceSize,
      AppTabItem tab, bool isSelected) {
    final showIcon = widget.showIcons && tab.icon != null;
    final showBadge = widget.showBadges && tab.badge != null;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showIcon) ...[
          SizedBox(
            width: AppIconSizing.getValue(
                _getAppSizeFromTabSize(widget.size), deviceSize),
            height: AppIconSizing.getValue(
                _getAppSizeFromTabSize(widget.size), deviceSize),
            child: tab.icon,
          ),
          SizedBox(width: AppSpacingSizing.getValue(AppSize.sm, deviceSize)),
        ],
        Text(
          tab.text,
          style: _getTabTextStyle(context, deviceSize, isSelected),
        ),
        if (showBadge) ...[
          SizedBox(width: AppSpacingSizing.getValue(AppSize.sm, deviceSize)),
          tab.badge!,
        ],
      ],
    );
  }

  TextStyle _getTabTextStyle(
      BuildContext context, DeviceSize deviceSize, bool isSelected) {
    final baseStyle = context.labelLarge;
    final fontSize = AppTypographySizing.getValue(
      _getAppSizeFromTabSize(widget.size),
      deviceSize,
    );

    return baseStyle.copyWith(
      fontSize: fontSize,
      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
      color: isSelected
          ? (widget.selectedColor ?? context.primary)
          : (widget.unselectedColor ?? context.onSurfaceVariant),
    );
  }

  EdgeInsetsGeometry _getDefaultPadding(DeviceSize deviceSize) {
    return EdgeInsets.symmetric(
      horizontal: AppSpacingSizing.getValue(AppSize.md, deviceSize),
      vertical: AppSpacingSizing.getValue(AppSize.sm, deviceSize),
    );
  }

  AppSize _getAppSizeFromTabSize(AppTabBarSize size) {
    switch (size) {
      case AppTabBarSize.xs:
        return AppSize.xs;
      case AppTabBarSize.sm:
        return AppSize.sm;
      case AppTabBarSize.md:
        return AppSize.md;
      case AppTabBarSize.lg:
        return AppSize.lg;
      case AppTabBarSize.xl:
        return AppSize.xl;
    }
  }
}
