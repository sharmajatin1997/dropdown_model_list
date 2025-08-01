import 'package:dropdown_model_list/drop_down/multiselect_chip.dart';
import 'package:flutter/material.dart';

/// A model that holds a list of selectable dropdown items.
class MultiDropdownSearchListModel<T> {
  /// The list of options available for selection in the dropdown.
  final List<OptionItemsMultiSearch<T>> listOptionItems;

  /// Creates a [MultiDropdownSearchListModel] with a list of [OptionItemsMultiSearch].
  MultiDropdownSearchListModel(this.listOptionItems);
}

/// Represents an individual selectable option in a multi-select dropdown.
/// Contains a display title and an optional underlying model value.
class OptionItemsMultiSearch<T> {
  /// The actual value associated with the dropdown item.
  final T? model;

  /// The display name shown in the dropdown.
  final String displayTitle;

  /// Creates an [OptionItemsMultiSearch] with an optional [model] and a required [displayTitle].
  OptionItemsMultiSearch({this.model, required this.displayTitle});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is OptionItemsMultiSearch<T> &&
              runtimeType == other.runtimeType &&
              displayTitle == other.displayTitle;

  @override
  int get hashCode => displayTitle.hashCode;
}


/// A customizable widget that allows users to select multiple options from a searchable dropdown list.
///
/// Displays a dropdown with checkboxes, optional search bar, and chips to show selected items.
class MultipleSelectionSearchDropList<T> extends StatefulWidget {
  /// The data model containing the dropdown options.
  final MultiDropdownSearchListModel<T> dropListModel;

  /// The list of currently selected items.
  final List<OptionItemsMultiSearch<T>> selectedItems;

  /// Callback triggered when the selected options change.
  final ValueChanged<List<OptionItemsMultiSearch<T>>> onOptionsSelected;

  /// Hint text displayed when no items are selected.
  final String hintText;

  /// Background color of the dropdown overlay.
  final Color? dropboxColor;

  /// Border color of the dropdown overlay.
  final Color? dropBoxBorderColor;

  /// Color of the scrollbar thumb.
  final Color? scrollThumbColor;

  /// Radius of the scrollbar thumb.
  final Radius? scrollRadius;

  /// Thickness of the scrollbar.
  final double? scrollThickness;

  /// Maximum height of the dropdown container.
  final double? heightBottomContainer;

  /// Font size for the hint text.
  final double? fontSizeHint;

  /// Text color for individual dropdown items.
  final Color? textColorItem;

  /// Text color for the hint/placeholder.
  final Color? textColorTitle;

  /// Whether to show a dropdown arrow icon.
  final bool showArrowIcon;

  /// Whether to show a clear button.
  final bool showClearButton;

  /// Callback triggered when the clear button is pressed.
  final VoidCallback? onClear;

  /// Height of the dropdown field.
  final double? height;

  /// Width of the dropdown field.
  final double? width;

  /// Padding inside the dropdown container.
  final EdgeInsetsGeometry? containerPadding;

  /// Margin around the dropdown container.
  final EdgeInsetsGeometry? containerMargin;

  /// Custom decoration for the dropdown container.
  final Decoration? containerDecoration;

  /// Whether to show a border around the container.
  final bool showBorder;

  /// Whether the dropdown is interactive.
  final bool enable;

  /// Whether to show the search bar inside the dropdown.
  final bool enableSearch;

  /// Color of the border when `showBorder` is true.
  final Color? borderColor;

  /// Shadow color of the container when border is not shown.
  final Color? shadowColor;

  /// Width of the border when `showBorder` is true.
  final double borderSize;

  /// Size of the arrow icon.
  final double arrowIconSize;

  /// Color of the arrow icon.
  final Color? arrowColor;

  /// Border radius for the container.
  final BorderRadiusGeometry? borderRadius;

  /// List of box shadows to apply to the container.
  final List<BoxShadow>? boxShadow;

  /// Optional custom widget for the "Done" button in the overlay.
  final Widget? doneButton;

  /// Creates a [MultipleSelectionSearchDropList] widget.
  const MultipleSelectionSearchDropList({
    super.key,
    required this.dropListModel,
    required this.selectedItems,
    required this.onOptionsSelected,
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
    this.fontSizeHint,
    this.arrowIconSize = 20,
    this.arrowColor,
    this.doneButton,
    this.enableSearch = true,
  });

  @override
  State<MultipleSelectionSearchDropList<T>> createState() =>
      _MultipleSelectionSearchDropListState<T>();
}

class _MultipleSelectionSearchDropListState<T>
    extends State<MultipleSelectionSearchDropList<T>> {
  final LayerLink _layerLink = LayerLink();
  late TextEditingController _searchController;
  late FocusNode _searchFocusNode;
  final ScrollController scrollController = ScrollController();

  OverlayEntry? _overlayEntry;
  bool isOverlayOpen = false;

  late List<OptionItemsMultiSearch<T>> _localFilteredItems;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
    _localFilteredItems = widget.dropListModel.listOptionItems;
  }

  void _openOverlay() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    isOverlayOpen = true;
    _searchFocusNode.requestFocus();
  }

  void _closeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    isOverlayOpen = false;
    _searchController.clear();
    _localFilteredItems = widget.dropListModel.listOptionItems;
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    Size size = renderBox.size;

    double itemHeight = 50;
    double searchBoxHeight = 70;
    int itemCount = _localFilteredItems.length;
    double maxAllowedHeight = widget.heightBottomContainer ?? 300;
    double calculatedHeight = (itemCount * itemHeight) + searchBoxHeight + 60;

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
                        Visibility(
                          visible: widget.enableSearch,
                          child: Padding(
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
                        ),
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
                                final isSelected =
                                    widget.selectedItems.contains(item);

                                return CheckboxListTile(
                                  value: isSelected,
                                  onChanged: (bool? selected) {
                                    setState(() {
                                      if (selected == true) {
                                        widget.selectedItems.add(item);
                                      } else {
                                        widget.selectedItems.remove(item);
                                      }
                                      widget.onOptionsSelected(
                                          widget.selectedItems);
                                    });
                                    setOverlayState(() {});
                                  },
                                  title: Text(
                                    item.displayTitle,
                                    style: TextStyle(
                                      color:
                                          widget.textColorItem ?? Colors.black,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                _closeOverlay();
                                setState(() {});
                              },
                              child: widget.doneButton ??
                                  ElevatedButton(
                                    onPressed: () {
                                      _closeOverlay();
                                      setState(() {});
                                    },
                                    child: const Text('Done'),
                                  ),
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
              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          margin: widget.containerMargin ?? const EdgeInsets.only(top: 10),
          decoration: widget.showBorder
              ? widget.containerDecoration ??
                  BoxDecoration(
                    borderRadius:
                        widget.borderRadius ?? BorderRadius.circular(10),
                    border: Border.all(
                        color: widget.borderColor ?? Colors.black,
                        width: widget.borderSize),
                    color: Colors.white.withAlpha(230),
                  )
              : widget.containerDecoration ??
                  BoxDecoration(
                    borderRadius:
                        widget.borderRadius ?? BorderRadius.circular(10),
                    color: Colors.white.withAlpha(243),
                    boxShadow: widget.boxShadow ??
                        [
                          BoxShadow(
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                            color: widget.shadowColor ?? Colors.black12,
                          ),
                        ],
                  ),
          child: widget.selectedItems.isNotEmpty
              ? ChipRow(
                  selectedLabels:
                      widget.selectedItems.map((e) => e.displayTitle).toList(),
                  onDelete: (label) {
                    setState(() {
                      widget.selectedItems
                          .removeWhere((e) => e.displayTitle == label);
                      widget.onOptionsSelected(widget.selectedItems);
                    });
                  },
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.hintText,
                          style: TextStyle(
                            color:
                                widget.textColorTitle ?? Colors.grey.shade600,
                            fontSize: widget.fontSizeHint ?? 14,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: widget.arrowColor ?? Colors.black,
                        size: widget.arrowIconSize,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
