import 'package:flutter/material.dart';
import '../../core/abstract_sizing.dart';
import '../../core/breakpoints.dart';
import '../../extensions/context_extensions.dart';
import '../../extensions/typography_extensions.dart';
import '../../extensions/color_extensions.dart';

/// Dropdown size variants
enum AppDropdownSize {
  xs,
  sm,
  md,
  lg,
  xl,
}

/// Dropdown variant
enum AppDropdownVariant {
  outlined,
  filled,
  underlined,
  minimal,
}

/// Dropdown item model
class AppDropdownItem<T> {
  final T value;
  final String label;
  final Widget? icon;
  final Widget? trailing;
  final bool isEnabled;
  final String? description;

  const AppDropdownItem({
    required this.value,
    required this.label,
    this.icon,
    this.trailing,
    this.isEnabled = true,
    this.description,
  });
}

/// Responsive dropdown component
class AppDropdown<T> extends StatefulWidget {
  final List<AppDropdownItem<T>> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String? hint;
  final String? label;
  final String? errorText;
  final String? helperText;
  final AppDropdownSize size;
  final AppDropdownVariant variant;
  final bool isRequired;
  final bool isEnabled;
  final bool isExpanded;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? maxHeight;
  final bool showSearch;
  final String? searchHint;
  final bool allowClear;
  final VoidCallback? onClear;
  final bool isLoading;
  final Widget? loadingWidget;
  final bool showDescription;

  const AppDropdown({
    super.key,
    required this.items,
    this.value,
    this.onChanged,
    this.hint,
    this.label,
    this.errorText,
    this.helperText,
    this.size = AppDropdownSize.md,
    this.variant = AppDropdownVariant.outlined,
    this.isRequired = false,
    this.isEnabled = true,
    this.isExpanded = false,
    this.prefixIcon,
    this.suffixIcon,
    this.fillColor,
    this.borderColor,
    this.padding,
    this.margin,
    this.maxHeight,
    this.showSearch = false,
    this.searchHint,
    this.allowClear = false,
    this.onClear,
    this.isLoading = false,
    this.loadingWidget,
    this.showDescription = false,
  });

  @override
  State<AppDropdown<T>> createState() => _AppDropdownState<T>();
}

class _AppDropdownState<T> extends State<AppDropdown<T>> {
  final LayerLink _layerLink = LayerLink();
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();

  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  List<AppDropdownItem<T>> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
    _focusNode.addListener(_handleFocusChange);
    _searchController.addListener(_handleSearchChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _searchController.removeListener(_handleSearchChange);
    _focusNode.dispose();
    _searchController.dispose();
    _closeDropdown();
    super.dispose();
  }

  @override
  void didUpdateWidget(AppDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      _filteredItems = widget.items;
      _searchController.clear();
    }
  }

  void _handleFocusChange() {
    if (!_focusNode.hasFocus && _isOpen) {
      _closeDropdown();
    }
  }

  void _handleSearchChange() {
    if (!widget.showSearch) return;

    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems = widget.items.where((item) {
        return item.label.toLowerCase().contains(query) ||
            (item.description?.toLowerCase().contains(query) ?? false);
      }).toList();
    });
  }

  void _toggleDropdown() {
    if (_isOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    if (!widget.isEnabled || widget.isLoading) return;

    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isOpen = true;
    });
    _focusNode.requestFocus();
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isOpen = false;
    });
    _searchController.clear();
    _filteredItems = widget.items;
  }

  void _selectItem(T value) {
    widget.onChanged?.call(value);
    _closeDropdown();
  }

  void _clearSelection() {
    widget.onChanged?.call(null);
    widget.onClear?.call();
  }

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
          CompositedTransformTarget(
            link: _layerLink,
            child: _buildDropdownField(context, deviceSize),
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

  Widget _buildDropdownField(BuildContext context, DeviceSize deviceSize) {
    return Focus(
      focusNode: _focusNode,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          padding: widget.padding ?? _getDefaultPadding(deviceSize),
          decoration: _getFieldDecoration(context, deviceSize),
          child: Row(
            children: [
              if (widget.prefixIcon != null) ...[
                widget.prefixIcon!,
                SizedBox(
                    width: AppSpacingSizing.getValue(AppSize.sm, deviceSize)),
              ],
              Expanded(
                child: widget.isLoading
                    ? _buildLoadingContent(context, deviceSize)
                    : _buildFieldContent(context, deviceSize),
              ),
              if (widget.allowClear && widget.value != null) ...[
                SizedBox(
                    width: AppSpacingSizing.getValue(AppSize.sm, deviceSize)),
                GestureDetector(
                  onTap: _clearSelection,
                  child: Icon(
                    Icons.clear,
                    size: AppIconSizing.getValue(
                        _getAppSizeFromDropdownSize(widget.size), deviceSize),
                    color: context.onSurfaceVariant,
                  ),
                ),
              ],
              SizedBox(
                  width: AppSpacingSizing.getValue(AppSize.sm, deviceSize)),
              AnimatedRotation(
                turns: _isOpen ? 0.5 : 0,
                duration: const Duration(milliseconds: 200),
                child: widget.suffixIcon ??
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: AppIconSizing.getValue(
                          _getAppSizeFromDropdownSize(widget.size), deviceSize),
                      color: context.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFieldContent(BuildContext context, DeviceSize deviceSize) {
    if (widget.value == null) {
      return Text(
        widget.hint ?? 'Select option',
        style: _getHintTextStyle(context, deviceSize),
      );
    }

    final selectedItem =
        widget.items.firstWhere((item) => item.value == widget.value);
    return Row(
      children: [
        if (selectedItem.icon != null) ...[
          SizedBox(
            width: AppIconSizing.getValue(
                _getAppSizeFromDropdownSize(widget.size), deviceSize),
            height: AppIconSizing.getValue(
                _getAppSizeFromDropdownSize(widget.size), deviceSize),
            child: selectedItem.icon,
          ),
          SizedBox(width: AppSpacingSizing.getValue(AppSize.sm, deviceSize)),
        ],
        Expanded(
          child: Text(
            selectedItem.label,
            style: _getValueTextStyle(context, deviceSize),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingContent(BuildContext context, DeviceSize deviceSize) {
    return widget.loadingWidget ??
        Row(
          children: [
            SizedBox(
              width: AppIconSizing.getValue(AppSize.sm, deviceSize),
              height: AppIconSizing.getValue(AppSize.sm, deviceSize),
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(context.primary),
              ),
            ),
            SizedBox(width: AppSpacingSizing.getValue(AppSize.sm, deviceSize)),
            Text(
              'Loading...',
              style: _getHintTextStyle(context, deviceSize),
            ),
          ],
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

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: _getDropdownWidth(),
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, _getDropdownOffset()),
          child: Material(
            elevation:
                AppElevationSizing.getValue(AppSize.md, context.deviceSize),
            borderRadius: BorderRadius.circular(
              AppRadiusSizing.getValue(AppSize.md, context.deviceSize),
            ),
            child: _buildDropdownMenu(context, context.deviceSize),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownMenu(BuildContext context, DeviceSize deviceSize) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: widget.maxHeight ?? _getMaxDropdownHeight(deviceSize),
      ),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(
          AppRadiusSizing.getValue(AppSize.md, deviceSize),
        ),
        border: Border.all(color: context.outline),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.showSearch) ...[
            _buildSearchField(context, deviceSize),
            Divider(height: 1, color: context.outline),
          ],
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                final item = _filteredItems[index];
                return _buildDropdownItem(context, deviceSize, item);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField(BuildContext context, DeviceSize deviceSize) {
    return Container(
      padding:
          EdgeInsets.all(AppSpacingSizing.getValue(AppSize.sm, deviceSize)),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: widget.searchHint ?? 'Search...',
          prefixIcon: Icon(Icons.search,
              size: AppIconSizing.getValue(AppSize.sm, deviceSize)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              AppRadiusSizing.getValue(AppSize.sm, deviceSize),
            ),
          ),
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppSpacingSizing.getValue(AppSize.sm, deviceSize),
            vertical: AppSpacingSizing.getValue(AppSize.xs, deviceSize),
          ),
        ),
        style: _getSearchTextStyle(context, deviceSize),
      ),
    );
  }

  Widget _buildDropdownItem(
      BuildContext context, DeviceSize deviceSize, AppDropdownItem<T> item) {
    final isSelected = item.value == widget.value;

    return InkWell(
      onTap: item.isEnabled ? () => _selectItem(item.value) : null,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacingSizing.getValue(AppSize.md, deviceSize),
          vertical: AppSpacingSizing.getValue(AppSize.sm, deviceSize),
        ),
        decoration: BoxDecoration(
          color: isSelected ? context.primaryContainer : Colors.transparent,
        ),
        child: Row(
          children: [
            if (item.icon != null) ...[
              SizedBox(
                width: AppIconSizing.getValue(
                    _getAppSizeFromDropdownSize(widget.size), deviceSize),
                height: AppIconSizing.getValue(
                    _getAppSizeFromDropdownSize(widget.size), deviceSize),
                child: item.icon,
              ),
              SizedBox(
                  width: AppSpacingSizing.getValue(AppSize.sm, deviceSize)),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.label,
                    style:
                        _getItemTextStyle(context, deviceSize, item.isEnabled)
                            .copyWith(
                      color: isSelected ? context.onPrimaryContainer : null,
                    ),
                  ),
                  if (widget.showDescription && item.description != null) ...[
                    SizedBox(
                        height:
                            AppSpacingSizing.getValue(AppSize.xs, deviceSize)),
                    Text(
                      item.description!,
                      style: _getItemDescriptionTextStyle(context, deviceSize)
                          .copyWith(
                        color: isSelected
                            ? context.onPrimaryContainer.withValues(alpha: 0.7)
                            : null,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (item.trailing != null) ...[
              SizedBox(
                  width: AppSpacingSizing.getValue(AppSize.sm, deviceSize)),
              item.trailing!,
            ],
            if (isSelected) ...[
              SizedBox(
                  width: AppSpacingSizing.getValue(AppSize.sm, deviceSize)),
              Icon(
                Icons.check,
                size: AppIconSizing.getValue(AppSize.sm, deviceSize),
                color: context.onPrimaryContainer,
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Helper methods for styling
  BoxDecoration _getFieldDecoration(
      BuildContext context, DeviceSize deviceSize) {
    final borderRadius = BorderRadius.circular(
      AppRadiusSizing.getValue(AppSize.md, deviceSize),
    );

    switch (widget.variant) {
      case AppDropdownVariant.outlined:
        return BoxDecoration(
          color: widget.fillColor ?? Colors.transparent,
          border: Border.all(
            color: _getBorderColor(context),
            width: _isOpen ? 2 : 1,
          ),
          borderRadius: borderRadius,
        );
      case AppDropdownVariant.filled:
        return BoxDecoration(
          color: widget.fillColor ?? context.surfaceVariant,
          border: Border.all(
            color: _isOpen ? context.primary : Colors.transparent,
            width: _isOpen ? 2 : 0,
          ),
          borderRadius: borderRadius,
        );
      case AppDropdownVariant.underlined:
        return BoxDecoration(
          color: widget.fillColor ?? Colors.transparent,
          border: Border(
            bottom: BorderSide(
              color: _getBorderColor(context),
              width: _isOpen ? 2 : 1,
            ),
          ),
        );
      case AppDropdownVariant.minimal:
        return BoxDecoration(
          color: widget.fillColor ?? Colors.transparent,
          border: Border.all(
            color: _isOpen ? context.primary : Colors.transparent,
            width: _isOpen ? 1 : 0,
          ),
          borderRadius: borderRadius,
        );
    }
  }

  Color _getBorderColor(BuildContext context) {
    if (widget.errorText != null) return context.error;
    if (_isOpen) return context.primary;
    return widget.borderColor ?? context.outline;
  }

  EdgeInsetsGeometry _getDefaultPadding(DeviceSize deviceSize) {
    return EdgeInsets.symmetric(
      horizontal: AppSpacingSizing.getValue(AppSize.md, deviceSize),
      vertical: AppSpacingSizing.getValue(AppSize.md, deviceSize),
    );
  }

  double _getDropdownWidth() {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    return renderBox?.size.width ?? 200;
  }

  double _getDropdownOffset() {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    return renderBox?.size.height ?? 48;
  }

  double _getMaxDropdownHeight(DeviceSize deviceSize) {
    return AppSpacingSizing.getValue(AppSize.xl5, deviceSize) * 6;
  }

  // Text style methods
  TextStyle _getLabelTextStyle(BuildContext context, DeviceSize deviceSize) {
    return context.labelMedium.copyWith(
      fontSize: AppTypographySizing.getValue(AppSize.sm, deviceSize),
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle _getValueTextStyle(BuildContext context, DeviceSize deviceSize) {
    return context.bodyMedium.copyWith(
      fontSize: AppTypographySizing.getValue(
          _getAppSizeFromDropdownSize(widget.size), deviceSize),
    );
  }

  TextStyle _getHintTextStyle(BuildContext context, DeviceSize deviceSize) {
    return context.bodyMedium.copyWith(
      fontSize: AppTypographySizing.getValue(
          _getAppSizeFromDropdownSize(widget.size), deviceSize),
      color: context.onSurfaceVariant,
    );
  }

  TextStyle _getHelperTextStyle(BuildContext context, DeviceSize deviceSize) {
    return context.bodySmall.copyWith(
      fontSize: AppTypographySizing.getValue(AppSize.xs, deviceSize),
    );
  }

  TextStyle _getSearchTextStyle(BuildContext context, DeviceSize deviceSize) {
    return context.bodyMedium.copyWith(
      fontSize: AppTypographySizing.getValue(AppSize.sm, deviceSize),
    );
  }

  TextStyle _getItemTextStyle(
      BuildContext context, DeviceSize deviceSize, bool isEnabled) {
    return context.bodyMedium.copyWith(
      fontSize: AppTypographySizing.getValue(
          _getAppSizeFromDropdownSize(widget.size), deviceSize),
      color:
          isEnabled ? context.onSurface : context.onSurface.withValues(alpha: 0.38),
    );
  }

  TextStyle _getItemDescriptionTextStyle(
      BuildContext context, DeviceSize deviceSize) {
    return context.bodySmall.copyWith(
      fontSize: AppTypographySizing.getValue(AppSize.xs, deviceSize),
      color: context.onSurfaceVariant,
    );
  }

  AppSize _getAppSizeFromDropdownSize(AppDropdownSize size) {
    switch (size) {
      case AppDropdownSize.xs:
        return AppSize.xs;
      case AppDropdownSize.sm:
        return AppSize.sm;
      case AppDropdownSize.md:
        return AppSize.md;
      case AppDropdownSize.lg:
        return AppSize.lg;
      case AppDropdownSize.xl:
        return AppSize.xl;
    }
  }
}
