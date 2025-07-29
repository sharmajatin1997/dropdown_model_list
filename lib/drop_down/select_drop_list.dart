import 'package:flutter/material.dart';

/// A customizable dropdown selection widget.
///
/// [SelectDropList] provides a highly configurable dropdown menu with overlay behavior.
/// It allows for custom styling, scroll behavior, clear/reset option, and optional icons.
class SelectDropList<T> extends StatefulWidget {
  /// The currently selected item.
  final OptionItems<T>? itemSelected;

  /// The list of selectable items.
  final DropdownListModel<T> dropListModel;

  /// Callback when an option is selected.
  final Function(OptionItems<T>) onOptionSelected;

  /// Placeholder text when no option is selected.
  final String hintText;

  /// Whether to display an icon on the left.
  final bool showIcon;

  /// Whether to show the arrow icon for dropdown state.
  final bool showArrowIcon;

  /// Optional leading icon widget.
  final Widget? icon;

  /// Size of the arrow icon.
  final double arrowIconSize;

  /// Color of the arrow icon.
  final Color? arrowColor;

  /// Color of the selected text.
  final Color? textColorTitle;

  /// Color of the placeholder/hint text.
  final Color? hintColorTitle;

  /// Font size for selected or hint text.
  final double textSizeTitle;

  /// Color of dropdown list items.
  final Color? textColorItem;

  /// Font size of dropdown list items.
  final double textSizeItem;

  /// Whether to show border around dropdown container.
  final bool showBorder;

  /// Whether the dropdown is interactable.
  final bool enable;

  /// Border color of the dropdown.
  final Color? borderColor;

  /// Shadow color for container.
  final Color? shadowColor;

  /// Width of the container border.
  final double borderSize;

  /// Height of the main dropdown button.
  final double? height;

  /// Width of the dropdown button.
  final double? width;

  /// Border radius of the dropdown container.
  final BorderRadiusGeometry? borderRadius;

  /// Box shadows to apply to the dropdown container.
  final List<BoxShadow>? boxShadow;

  /// Padding inside the dropdown container.
  final EdgeInsetsGeometry? containerPadding;

  /// Margin around the dropdown container.
  final EdgeInsetsGeometry? containerMargin;

  /// Custom decoration for the container.
  final Decoration? containerDecoration;

  /// Height of the dropdown overlay container.
  final double? heightBottomContainer;

  /// Suffix icon for additional functionality (optional).
  final IconData? suffixIcon;

  /// Padding around dropdown main row.
  final EdgeInsetsGeometry? padding;

  /// Padding around dropdown list items.
  final EdgeInsetsGeometry? paddingDropItem;

  /// Border color of dropdown overlay box.
  final Color? dropBoxBorderColor;

  /// Background color of dropdown overlay.
  final Color? dropboxColor;

  /// Border radius of the dropdown overlay.
  final BorderRadiusGeometry? dropBoxBorderRadius;

  /// Color of the scrollbar thumb.
  final Color? scrollThumbColor;

  /// Thickness of the scrollbar.
  final double? scrollThickness;

  /// Radius of the scrollbar.
  final Radius? scrollRadius;

  /// Called when the clear button is tapped.
  final VoidCallback? onClear;

  /// Whether to show a clear (reset) button.
  final bool showClearButton;
  /// Creates a [SelectDropList] widget.
  const SelectDropList({
    super.key,
    required this.itemSelected,
    required this.dropListModel,
    required this.onOptionSelected,
    required this.hintText,
    this.onClear,
    this.showClearButton = false,
    this.showIcon = false,
    this.showArrowIcon = true,
    this.icon,
    this.arrowIconSize = 20,
    this.textColorTitle,
    this.textSizeTitle = 16,
    this.paddingDropItem,
    this.arrowColor,
    this.textColorItem,
    this.textSizeItem = 14,
    this.showBorder = true,
    this.enable = true,
    this.width,
    this.borderRadius,
    this.height,
    this.heightBottomContainer,
    this.boxShadow,
    this.borderColor,
    this.hintColorTitle,
    this.containerDecoration,
    this.containerPadding,
    this.shadowColor,
    this.suffixIcon,
    this.containerMargin,
    this.borderSize = 1,
    this.dropBoxBorderRadius,
    this.dropBoxBorderColor,
    this.dropboxColor,
    this.scrollThumbColor,
    this.scrollThickness,
    this.scrollRadius,
    this.padding,
  });

  @override
  SelectDropListState<T> createState() => SelectDropListState<T>();
}

/// State class for [SelectDropList].
class SelectDropListState<T> extends State<SelectDropList<T>> {
  /// Currently selected item.
  OptionItems<T>? optionItemSelected;

  /// Whether the dropdown overlay is shown.
  bool isShow = false;

  /// Controller for the scroll view inside the dropdown.
  final scrollController = ScrollController();

  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    optionItemSelected = widget.itemSelected;
  }

  /// Toggles the dropdown overlay visibility.
  void _toggleOverlay() {
    if (!isShow) {
      if (widget.dropListModel.listOptionItems.isEmpty) return;
      _showOverlay();
      setState(() => isShow = true);
    } else {
      _removeOverlay();
    }
  }

  /// Shows the dropdown overlay.
  void _showOverlay() {
    if (_overlayEntry != null) return;
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  /// Removes the dropdown overlay.
  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => isShow = false);
  }

  /// Creates the dropdown overlay widget.
  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    Size size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height,
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: widget.height != null
              ? Offset(0, widget.height! + 10)
              : const Offset(0, 60),
          child: Material(
            elevation: 4,
            borderRadius:
            widget.dropBoxBorderRadius ?? BorderRadius.circular(10),
            child: Container(
              height: widget.heightBottomContainer,
              decoration: BoxDecoration(
                color: widget.dropboxColor ?? Colors.white,
                border:
                Border.all(color: widget.dropBoxBorderColor ?? Colors.grey),
                borderRadius:
                widget.dropBoxBorderRadius ?? BorderRadius.circular(10),
              ),
              child: RawScrollbar(
                controller: scrollController,
                thumbVisibility: true,
                thumbColor: widget.scrollThumbColor ?? Colors.black,
                radius: widget.scrollRadius ?? const Radius.circular(4),
                thickness: widget.scrollThickness ?? 3,
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: widget.dropListModel.listOptionItems
                        .map((item) => _buildSubMenu(item))
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds an individual item in the dropdown list.
  Widget _buildSubMenu(OptionItems<T> item) {
    return Padding(
      padding: widget.paddingDropItem ?? const EdgeInsets.all(15),
      child: GestureDetector(
        onTap: () {
          optionItemSelected = item;
          _removeOverlay();
          widget.onOptionSelected(item);
          setState(() {});
        },
        child: Row(
          children: [
            Expanded(
              child: Text(
                item.displayTitle,
                style: TextStyle(
                  color: widget.textColorItem ?? Colors.black,
                  fontSize: widget.textSizeItem,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _removeOverlay();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: widget.enable ? _toggleOverlay : null,
        child: Container(
          height: widget.height ?? 50,
          width: widget.width ?? MediaQuery.of(context).size.width,
          padding: widget.containerPadding ??
              const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          margin: widget.containerMargin ?? const EdgeInsets.only(top: 10),
          decoration: widget.showBorder
              ? widget.containerDecoration ??
              BoxDecoration(
                borderRadius:
                widget.borderRadius ?? BorderRadius.circular(10),
                border: Border.all(
                    color: widget.borderColor ?? Colors.black,
                    width: widget.borderSize),
                color: Colors.white,
              )
              : widget.containerDecoration ??
              BoxDecoration(
                borderRadius:
                widget.borderRadius ?? BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: widget.boxShadow ??
                    [
                      BoxShadow(
                        blurRadius: 2,
                        color: widget.shadowColor ?? Colors.black26,
                      ),
                    ],
              ),
          child: Row(
            children: [
              if (widget.showIcon)
                widget.icon ?? const Icon(Icons.menu, color: Colors.black),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  optionItemSelected?.displayTitle ?? widget.hintText,
                  style: TextStyle(
                    color: optionItemSelected == null
                        ? widget.hintColorTitle ?? Colors.grey
                        : widget.textColorTitle ?? Colors.black,
                    fontSize: widget.textSizeTitle,
                  ),
                ),
              ),
              if (widget.showClearButton && optionItemSelected?.model != null)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      optionItemSelected = OptionItems<T>(
                          model: null, displayTitle: widget.hintText);
                    });
                    widget.onClear?.call();
                  },
                  child: const Icon(Icons.clear, color: Colors.grey),
                ),
              if (widget.showArrowIcon)
                Icon(
                  isShow ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: widget.arrowColor ?? Colors.black,
                  size: widget.arrowIconSize,
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant SelectDropList<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.itemSelected != oldWidget.itemSelected) {
      setState(() {
        optionItemSelected = widget.itemSelected;
      });
    }
  }
}

/// A list model containing a collection of dropdown items.
class DropdownListModel<T> {
  /// The list of available items.
  final List<OptionItems<T>> listOptionItems;
  /// Creates a [DropdownListModel] with a list of [OptionItems].
  DropdownListModel(this.listOptionItems);
}

/// Model representing a selectable dropdown item.
class OptionItems<T> {
  /// The actual value (object) of the item.
  final T? model;

  /// The text shown in the dropdown for this item.
  final String displayTitle;

  OptionItems({this.model, required this.displayTitle});
}
