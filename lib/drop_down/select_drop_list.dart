import 'package:flutter/material.dart';

class SelectDropList<T> extends StatefulWidget {
  final OptionItems<T>? itemSelected;
  final DropdownListModel<T> dropListModel;
  final Function(OptionItems<T>) onOptionSelected;
  final String hintText;
  final bool showIcon;
  final bool showArrowIcon;
  final Widget? icon;
  final double arrowIconSize;
  final Color? arrowColor;
  final Color? textColorTitle;
  final Color? hintColorTitle;
  final double textSizeTitle;
  final Color? textColorItem;
  final double textSizeItem;
  final bool showBorder;
  final bool enable;
  final Color? borderColor;
  final Color? shadowColor;
  final double borderSize;
  final double? height, width;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? containerPadding;
  final EdgeInsetsGeometry? containerMargin;
  final Decoration? containerDecoration;
  final double? heightBottomContainer;
  final IconData? suffixIcon;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? paddingDropItem;
  final Color? dropBoxBorderColor;
  final Color? dropboxColor;
  final BorderRadiusGeometry? dropBoxBorderRadius;
  final Color? scrollThumbColor;
  final double? scrollThickness;
  final Radius? scrollRadius;
  final VoidCallback? onClear;
  final bool showClearButton;

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
    this.scrollRadius, this.padding,
  });

  @override
  SelectDropListState<T> createState() => SelectDropListState<T>();
}

class SelectDropListState<T> extends State<SelectDropList<T>> {
  OptionItems<T>? optionItemSelected;
  bool isShow = false;
  final scrollController = ScrollController();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    optionItemSelected = widget.itemSelected;
  }

  void _toggleOverlay() {
    if (!isShow) {
      if (widget.dropListModel.listOptionItems.isEmpty) return;
      _showOverlay();
      setState(() => isShow = true);
    } else {
      _removeOverlay();
    }
  }

  void _showOverlay() {
    if (_overlayEntry != null) return;
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => isShow = false);
  }

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
          offset:widget.height!=null? Offset(0, widget.height!+10):Offset(0, 60),
          child: Material(
            elevation: 4,
            borderRadius: widget.dropBoxBorderRadius ?? BorderRadius.circular(10),
            child: Container(
              height: widget.heightBottomContainer,
              decoration: BoxDecoration(
                color: widget.dropboxColor ?? Colors.white,
                border: Border.all(color: widget.dropBoxBorderColor ?? Colors.grey),
                borderRadius: widget.dropBoxBorderRadius ?? BorderRadius.circular(10),
              ),
              child: RawScrollbar(
                controller: scrollController,
                thumbVisibility: true,
                thumbColor: widget.scrollThumbColor ?? Colors.black,
                radius: widget.scrollRadius ?? Radius.circular(4),
                thickness: widget.scrollThickness ?? 3,
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: widget.dropListModel.listOptionItems.map((item) => _buildSubMenu(item)).toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

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
          padding: widget.containerPadding ?? const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          margin: widget.containerMargin ?? const EdgeInsets.only(top: 10),
          decoration: widget.showBorder
              ? widget.containerDecoration ??
              BoxDecoration(
                borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
                border: Border.all(color: widget.borderColor ?? Colors.black, width: widget.borderSize),
                color: Colors.white,
              )
              : widget.containerDecoration ??
              BoxDecoration(
                borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: widget.boxShadow ?? [
                  BoxShadow(blurRadius: 2, color: widget.shadowColor ?? Colors.black26),
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
                      optionItemSelected = OptionItems<T>(model: null, displayTitle: widget.hintText);
                    });
                    widget.onClear?.call();
                  },
                  child: Icon(Icons.clear, color: Colors.grey),
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
    // If parent changed the selected item, update local state
    if (widget.itemSelected != oldWidget.itemSelected) {
      setState(() {
        optionItemSelected = widget.itemSelected;
      });
    }
  }
}

//Model

class DropdownListModel<T> {
  final List<OptionItems<T>> listOptionItems;
  DropdownListModel(this.listOptionItems);
}

class OptionItems<T> {
  final T? model;
  final String displayTitle;

  OptionItems({ this.model, required this.displayTitle});
}

