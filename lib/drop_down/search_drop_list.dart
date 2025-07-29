import 'package:flutter/material.dart';

/// A customizable searchable dropdown list widget.
///
/// [SearchDropList] provides a UI component that allows users to search and select
/// an item from a dropdown list. Supports custom styling, overlay, borders, shadow,
/// and clear/reset functionality.
class SearchDropList<T> extends StatefulWidget {
  /// The model representing the dropdown list of options.
  final DropdownSearchListModel<T> dropListModel;

  /// The currently selected item in the dropdown.
  final OptionItemsSearch<T>? itemSelected;

  /// Callback when an option is selected.
  final ValueChanged<OptionItemsSearch<T>> onOptionSelected;

  /// Placeholder or hint text when no item is selected.
  final String hintText;

  /// Background color of the dropdown list.
  final Color? dropboxColor;

  /// Border color of the dropdown list.
  final Color? dropBoxBorderColor;

  /// Color of the scrollbar thumb.
  final Color? scrollThumbColor;

  /// Radius of the scrollbar thumb.
  final Radius? scrollRadius;

  /// Thickness of the scrollbar.
  final double? scrollThickness;

  /// Max height allowed for dropdown overlay.
  final double? heightBottomContainer;

  /// Text color for dropdown items.
  final Color? textColorItem;

  /// Text color for the selected item title.
  final Color? textColorTitle;

  /// Whether to show the dropdown arrow icon.
  final bool showArrowIcon;

  /// Whether to show a clear/reset button when an item is selected.
  final bool showClearButton;

  /// Callback triggered when the clear button is pressed.
  final VoidCallback? onClear;

  /// Height of the dropdown widget.
  final double? height;

  /// Width of the dropdown widget.
  final double? width;

  /// Padding inside the container.
  final EdgeInsetsGeometry? containerPadding;

  /// Margin around the container.
  final EdgeInsetsGeometry? containerMargin;

  /// Decoration of the container.
  final Decoration? containerDecoration;

  /// Whether to show a border around the container.
  final bool showBorder;

  /// Whether the dropdown is interactive.
  final bool enable;

  /// Color of the dropdown border.
  final Color? borderColor;

  /// Shadow color of the container.
  final Color? shadowColor;

  /// Width of the border.
  final double borderSize;

  /// Border radius of the container.
  final BorderRadiusGeometry? borderRadius;

  /// Box shadow effects.
  final List<BoxShadow>? boxShadow;
  /// Creates a [SearchDropList] widget.
  const SearchDropList({
    super.key,
    required this.dropListModel,
    required this.itemSelected,
    required this.onOptionSelected,
    required this.hintText,
    this.dropboxColor,
    this.dropBoxBorderColor,
    this.scrollThumbColor,
    this.scrollRadius,
    this.scrollThickness,
    this.heightBottomContainer,
    this.textColorItem,
    this.textColorTitle,
    this.showArrowIcon = false,
    this.showClearButton = false,
    this.onClear,
    this.height,
    this.width,
    this.containerPadding,
    this.containerMargin,
    this.containerDecoration,
    required this.showBorder,
    required this.enable,
    this.borderColor,
    this.shadowColor,
    required this.borderSize,
    this.borderRadius,
    this.boxShadow,
  });

  @override
  State<SearchDropList<T>> createState() => _SearchDropListState<T>();
}

/// State class for [SearchDropList].
class _SearchDropListState<T> extends State<SearchDropList<T>> {
  final LayerLink _layerLink = LayerLink();
  late TextEditingController _searchController;
  late FocusNode _searchFocusNode;
  final ScrollController scrollController = ScrollController();

  OverlayEntry? _overlayEntry;
  bool isOverlayOpen = false;

  late List<OptionItemsSearch<T>> _localFilteredItems;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
    _localFilteredItems = widget.dropListModel.listOptionItems;
  }

  /// Opens the dropdown overlay.
  void _openOverlay() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    isOverlayOpen = true;
    _searchFocusNode.requestFocus();
  }

  /// Closes the dropdown overlay.
  void _closeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    isOverlayOpen = false;
    _searchController.clear();
    _localFilteredItems = widget.dropListModel.listOptionItems;
  }

  /// Creates the dropdown overlay entry.
  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    Size size = renderBox.size;

    double itemHeight = 50;
    double searchBoxHeight = 70;
    int itemCount = _localFilteredItems.length;
    double maxAllowedHeight = widget.heightBottomContainer ?? 300;
    double calculatedHeight = (itemCount * itemHeight) + searchBoxHeight;

    return OverlayEntry(
      builder: (context) {
        return Positioned(
          left: offset.dx,
          top: offset.dy + size.height,
          width: size.width,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: widget.height != null
                ? Offset(0, widget.height! + 15)
                : const Offset(0, 65),
            child: Material(
              elevation: 4,
              child: StatefulBuilder(
                builder: (context, setOverlayState) {
                  return Container(
                    height: calculatedHeight > maxAllowedHeight
                        ? maxAllowedHeight
                        : calculatedHeight,
                    decoration: BoxDecoration(
                      color: widget.dropboxColor ?? Colors.white,
                      border: Border.all(
                        color: widget.dropBoxBorderColor ?? Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Search bar
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _searchController,
                            focusNode: _searchFocusNode,
                            onChanged: (query) {
                              setState(() {
                                _localFilteredItems = widget
                                    .dropListModel.listOptionItems
                                    .where((item) => item.displayTitle
                                    .toLowerCase()
                                    .contains(query.toLowerCase()))
                                    .toList();
                              });
                              setOverlayState(() {});
                            },
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: _searchController.text.isNotEmpty
                                  ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {
                                    _localFilteredItems = widget
                                        .dropListModel.listOptionItems;
                                  });
                                  setOverlayState(() {});
                                },
                              )
                                  : null,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                            ),
                          ),
                        ),
                        // Dropdown list
                        Expanded(
                          child: RawScrollbar(
                            controller: scrollController,
                            thumbVisibility: true,
                            thumbColor: widget.scrollThumbColor ?? Colors.blue,
                            radius:
                            widget.scrollRadius ?? const Radius.circular(4),
                            thickness: widget.scrollThickness ?? 3,
                            child: ListView.builder(
                              controller: scrollController,
                              padding: EdgeInsets.zero,
                              itemCount: _localFilteredItems.length,
                              itemBuilder: (context, index) {
                                final item = _localFilteredItems[index];
                                return ListTile(
                                  title: Text(
                                    item.displayTitle,
                                    style: TextStyle(
                                      color:
                                      widget.textColorItem ?? Colors.black,
                                    ),
                                  ),
                                  onTap: () {
                                    widget.onOptionSelected(item);
                                    _closeOverlay();
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: () {
          if (widget.enable) {
            if (!isOverlayOpen) {
              _openOverlay();
            } else {
              _closeOverlay();
            }
          }
        },
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
                          color: widget.shadowColor ?? Colors.black26),
                    ],
              ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.itemSelected?.displayTitle ?? widget.hintText,
                style: TextStyle(
                  color: widget.textColorTitle ?? Colors.grey[700],
                ),
              ),
              if (widget.showClearButton &&
                  widget.itemSelected?.displayTitle != widget.hintText)
                GestureDetector(
                  onTap: () {
                    widget.onClear?.call();
                    _searchController.clear();
                    _localFilteredItems = widget.dropListModel.listOptionItems;
                    setState(() {});
                  },
                  child: const Icon(Icons.clear, size: 20),
                )
              else if (widget.showArrowIcon)
                const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }
}

/// Model representing a list of dropdown items.
class DropdownSearchListModel<T> {
  /// The list of option items available in the dropdown.
  final List<OptionItemsSearch<T>> listOptionItems;
  /// Creates a [DropdownSearchListModel] with a list of [OptionItemsSearch].
  DropdownSearchListModel(this.listOptionItems);
}

/// Model representing a selectable item in the dropdown.
class OptionItemsSearch<T> {
  /// The underlying value for the dropdown option.
  final T? model;

  /// The text label displayed in the dropdown.
  final String displayTitle;
  /// Creates an [OptionItemsSearch] with an optional [model] and a required [displayTitle].
  OptionItemsSearch({this.model, required this.displayTitle});
}
