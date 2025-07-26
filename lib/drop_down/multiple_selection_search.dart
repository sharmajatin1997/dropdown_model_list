import 'package:dropdown_model_list/drop_down/multiselect_chip.dart';
import 'package:flutter/material.dart';

// Model
class MultiDropdownSearchListModel<T> {
  final List<OptionItemsMultiSearch<T>> listOptionItems;
  MultiDropdownSearchListModel(this.listOptionItems);
}

class OptionItemsMultiSearch<T> {
  final T? model;
  final String displayTitle;

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

class MultipleSelectionSearchDropList<T> extends StatefulWidget {
  final MultiDropdownSearchListModel<T> dropListModel;
  final List<OptionItemsMultiSearch<T>> selectedItems;
  final ValueChanged<List<OptionItemsMultiSearch<T>>> onOptionsSelected;
  final String hintText;

  final Color? dropboxColor;
  final Color? dropBoxBorderColor;
  final Color? scrollThumbColor;

  final Radius? scrollRadius;
  final double? scrollThickness;
  final double? heightBottomContainer;
  final double? fontSizeHint;
  final Color? textColorItem;
  final Color? textColorTitle;
  final bool showArrowIcon;
  final bool showClearButton;
  final VoidCallback? onClear;
  final double? height, width;
  final EdgeInsetsGeometry? containerPadding, containerMargin;
  final Decoration? containerDecoration;
  final bool showBorder;
  final bool enable;
  final bool enableSearch;
  final Color? borderColor;
  final Color? shadowColor;
  final double borderSize;
  final double arrowIconSize;
  final Color? arrowColor;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Widget? doneButton;

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
    this.enableSearch=true,
  });

  @override
  State<MultipleSelectionSearchDropList<T>> createState() => _MultipleSelectionSearchDropListState<T>();
}

class _MultipleSelectionSearchDropListState<T> extends State<MultipleSelectionSearchDropList<T>> {
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
                                      _localFilteredItems = widget.dropListModel.listOptionItems;
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
                            radius: widget.scrollRadius ?? const Radius.circular(4),
                            thickness: widget.scrollThickness ?? 3,
                            child: ListView.builder(
                              controller: scrollController,
                              padding: EdgeInsets.zero,
                              itemCount: _localFilteredItems.length,
                              itemBuilder: (context, index) {
                                final item = _localFilteredItems[index];
                                final isSelected = widget.selectedItems.contains(item);

                                return CheckboxListTile(
                                  value: isSelected,
                                  onChanged: (bool? selected) {
                                    setState(() {
                                      if (selected == true) {
                                        widget.selectedItems.add(item);
                                      } else {
                                        widget.selectedItems.remove(item);
                                      }
                                      widget.onOptionsSelected(widget.selectedItems);
                                    });
                                    setOverlayState(() {});
                                  },
                                  title: Text(
                                    item.displayTitle,
                                    style: TextStyle(
                                      color: widget.textColorItem ?? Colors.black,
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
                            child:GestureDetector(
                              onTap: (){
                                _closeOverlay();
                                setState(() {});
                              },
                              child: widget.doneButton??
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
          if(widget.enable){
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
          padding: widget.containerPadding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          margin: widget.containerMargin ?? const EdgeInsets.only(top: 10),
          decoration: widget.showBorder
              ? widget.containerDecoration ??
              BoxDecoration(
                borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
                border: Border.all(
                    color: widget.borderColor ?? Colors.black,
                    width: widget.borderSize),
                color: Colors.white.withAlpha(230),
              )
              : widget.containerDecoration ??
              BoxDecoration(
                borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
                color: Colors.white.withOpacity(0.95),
                boxShadow: widget.boxShadow ?? [
                  BoxShadow(
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                    color: widget.shadowColor ?? Colors.black12,
                  ),
                ],
              ),
          child: Expanded(
            child: widget.selectedItems.isNotEmpty
                ? ChipRow(
              selectedLabels: widget.selectedItems.map((e) => e.displayTitle).toList(),
              onDelete: (label) {
                setState(() {
                  widget.selectedItems.removeWhere((e) => e.displayTitle == label);
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
                        color: widget.textColorTitle ?? Colors.grey.shade600,
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
      ),
    );
  }
}
