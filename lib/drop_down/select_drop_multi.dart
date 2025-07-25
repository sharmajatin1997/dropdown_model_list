import 'package:dropdown_model_list/drop_down/models/model.dart';
import 'package:flutter/material.dart';

class SelectDropMultipleList extends StatefulWidget {
  final OptionItem defaultText;
  final DropListModel dropListModel;
  final Function(List<OptionItem> optionItem) onOptionListSelected;
  final Function(bool cancel)? onTapCross;
  final bool showIcon;
  final bool showCrossIcon;
  final double paddingLeft;
  final double paddingRight;
  final double paddingTop;
  final double paddingBottom;
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
  final Widget? selectedIconWidget;
  final String? submitText;
  final Color? colorSubmitButton;
  final Color? dropboxColor;
  final EdgeInsetsGeometry? paddingBottomList;

  const SelectDropMultipleList(
      {super.key,
      required this.defaultText,
      required this.dropListModel,
      required this.showIcon,
      required this.onOptionListSelected,
      this.onTapCross,
      this.paddingLeft = 20,
      this.paddingRight = 20,
      this.paddingTop = 20,
      this.paddingBottom = 20,
      this.icon,
      this.arrowIconSize = 20,
      this.textColorTitle,
      this.textSizeTitle = 16,
      this.arrowColor,
      this.textColorItem,
      this.textSizeItem = 14,
      this.showBorder = true,
      this.showCrossIcon = true,
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
      this.selectedIconWidget,
      this.submitText,
      this.colorSubmitButton,
      this.paddingBottomList,
      this.dropboxColor,
      this.borderSize = 1});

  @override
  SelectDropMultipleListState createState() => SelectDropMultipleListState();
}

class SelectDropMultipleListState extends State<SelectDropMultipleList>
    with SingleTickerProviderStateMixin {
  late OptionItem optionItemSelected;
  List<OptionItem> selectedItems = [];
  List<String> select = [];
  late AnimationController expandController;
  late Animation<double> animation;
  bool isShow = false;
  bool isShowCross = false;
  final scrollController = ScrollController(initialScrollOffset: 0);

  @override
  void initState() {
    super.initState();
    optionItemSelected =
        OptionItem(id: widget.defaultText.id, title: widget.defaultText.title);
    expandController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.linear,
    );
    _runExpandCheck();
  }

  void _runExpandCheck() {
    if (isShow) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: widget.paddingLeft,
          right: widget.paddingRight,
          top: widget.paddingTop,
          bottom: widget.paddingBottom),
      child: Column(
        children: <Widget>[
          Container(
            height: widget.height ?? 50,
            width: widget.width ?? MediaQuery.of(context).size.width,
            padding: widget.containerPadding ??
                const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            margin: widget.containerMargin ?? const EdgeInsets.only(top: 10),
            decoration: widget.showBorder
                ? widget.containerDecoration ??
                    BoxDecoration(
                      borderRadius:
                          widget.borderRadius ?? BorderRadius.circular(10.0),
                      border: Border.all(
                          color: widget.borderColor ?? Colors.black,
                          width: widget.borderSize),
                      color: Colors.white,
                    )
                : widget.containerDecoration ??
                    BoxDecoration(
                      borderRadius:
                          widget.borderRadius ?? BorderRadius.circular(10.0),
                      color: Colors.white,
                      boxShadow: widget.boxShadow ??
                          [
                            BoxShadow(
                                blurRadius: 2,
                                color: widget.shadowColor ?? Colors.black26,
                                offset: const Offset(0, 0))
                          ],
                    ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Visibility(
                    visible: widget.showIcon,
                    child: widget.icon != null
                        ? widget.icon!
                        : const Icon(
                            Icons.menu,
                            color: Colors.black,
                          )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    if (widget.enable) {
                      isShow = !isShow;
                      _runExpandCheck();
                    }
                    setState(() {});
                  },
                  child: Text(
                    optionItemSelected.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: optionItemSelected.id == '0' ||
                                optionItemSelected.id == null
                            ? widget.hintColorTitle ?? Colors.grey
                            : widget.textColorTitle ?? Colors.black,
                        fontSize: widget.textSizeTitle),
                  ),
                )),
                Visibility(
                  visible: widget.showCrossIcon,
                  child: Visibility(
                    visible: isShowCross,
                    child: Align(
                      alignment: const Alignment(1, 0),
                      child: GestureDetector(
                        onTap: () {
                          // isShow = !isShow;
                          // _runExpandCheck();
                          // setState(() {});
                          isShowCross = false;

                          final tagName = optionItemSelected.id;
                          final split = tagName?.split(',');
                          for (int i = 0; i < split!.length; i++) {
                            if (!select.contains(split[i])) {
                              select.add(split[i]);
                            }
                          }

                          for (var item
                              in widget.dropListModel.listOptionItems) {
                            if (select.contains(item.id)) {
                              selectedItems.remove(item);
                              select.remove(item.id!);
                            }
                          }
                          optionItemSelected = widget.defaultText;
                          widget.onTapCross!(true);
                          setState(() {});
                        },
                        child: const Icon(
                          Icons.close,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          SizeTransition(
              axisAlignment: 1.0,
              sizeFactor: animation,
              child: Container(
                  height: widget.heightBottomContainer ?? 230,
                  margin: const EdgeInsets.only(bottom: 20, left: 2, right: 2),
                  padding: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    color: widget.dropboxColor ?? Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 2,
                          color: Colors.black26,
                          offset: Offset(0, 0))
                    ],
                  ),
                  child: Scrollbar(
                    thickness: 4,
                    thumbVisibility: true,
                    interactive: true,
                    controller: scrollController,
                    radius: const Radius.circular(0),
                    scrollbarOrientation: ScrollbarOrientation.right,
                    child: Stack(
                      children: [
                        SizedBox(
                          height: widget.heightBottomContainer != null
                              ? widget.heightBottomContainer! - 60
                              : 160,
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: _buildDropListOptions(
                                widget.dropListModel.listOptionItems,
                                context,
                                widget.textColorItem,
                                widget.textSizeItem),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 10,
                          child: GestureDetector(
                            onTap: () {
                              isShow = false;
                              expandController.reverse();
                              widget.onOptionListSelected(selectedItems);
                            },
                            child: Container(
                              width: 80,
                              height: 35,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: widget.colorSubmitButton ??
                                    Colors.blue.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x3D001978),
                                    offset: Offset(0, 0),
                                    blurRadius: 5,
                                  )
                                ],
                              ),
                              margin: const EdgeInsets.only(left: 10, top: 10),
                              child: Text(
                                widget.submitText ?? 'Submit',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ))),
        ],
      ),
    );
  }

  Column _buildDropListOptions(List<OptionItem> items, BuildContext context,
      Color? textColorItem, double textSizeItem) {
    return Column(
      children: items
          .map((item) =>
              _buildSubMenu(item, context, textColorItem, textSizeItem))
          .toList(),
    );
  }

  Widget _buildSubMenu(OptionItem item, BuildContext context,
      Color? textColorItem, double textSizeItem) {
    return Padding(
      padding: widget.paddingBottomList ??
          const EdgeInsets.only(left: 20, top: 5, bottom: 5, right: 10),
      child: GestureDetector(
        onTap: () {
          if (!select.contains(item.id)) {
            selectedItems.add(item);
            select.add(item.id!);
          } else {
            selectedItems.remove(item);
            select.remove(item.id!);
          }

          List<String> title = [];
          for (var item in selectedItems) {
            if (item.id != null) {
              title.add(item.title);
            }
          }
          if (title.isNotEmpty) {
            isShowCross = true;
            optionItemSelected = OptionItem(id: "1", title: title.join(','));
          } else {
            isShowCross = false;
            optionItemSelected = widget.defaultText;
          }

          setState(() {});
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0, top: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Text(item.title,
                    style: TextStyle(
                        color: textColorItem ?? Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: textSizeItem),
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis),
              ),
              const SizedBox(
                width: 5,
              ),
              Visibility(
                  visible: select.contains(item.id),
                  child: widget.selectedIconWidget ??
                      Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.blue),
                        child: const Icon(
                          Icons.done,
                          size: 15,
                          color: Colors.white,
                        ),
                      )),
            ],
          ),
        ),
      ),
    );
  }
}
