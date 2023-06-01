import 'package:dropdown_model_list/drop_down/model.dart';
import 'package:flutter/material.dart';

class SelectDropList extends StatefulWidget {
  final OptionItem itemSelected;
  final DropListModel dropListModel;
  final Function(OptionItem optionItem) onOptionSelected;
  final bool showIcon;
  final bool showArrowIcon;
  final double paddingLeft;
  final double paddingRight;
  final double paddingTop;
  final double paddingBottom;
  final Widget? icon;
  final double arrowIconSize;
  final Color? arrowColor;
  final Color? textColorTitle;
  final double textSizeTitle;
  final Color? textColorItem;
  final double textSizeItem;
  final bool showBorder;
  final Color? borderColor;
  final double borderSize;
  const SelectDropList({super.key, required this.itemSelected,required this.dropListModel,required this.showIcon,required this.showArrowIcon,required this.onOptionSelected,this.paddingLeft = 20,this.paddingRight=20,this.paddingTop=20,this.paddingBottom=20,this.icon,this.arrowIconSize=20,this.textColorTitle,this.textSizeTitle=16,this.arrowColor,this.textColorItem,this.textSizeItem=14,this.showBorder=true,this.borderColor,this.borderSize=1});

  @override
  SelectDropListState createState() => SelectDropListState();
}

class SelectDropListState extends State<SelectDropList>
    with SingleTickerProviderStateMixin {
    late OptionItem optionItemSelected;
    late AnimationController expandController;
    late Animation<double> animation;
    bool isShow = false;

  @override
  void initState() {
    super.initState();
    optionItemSelected = OptionItem(id: widget.itemSelected.id, title: widget.itemSelected.title);
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
      padding: EdgeInsets.only(left: widget.paddingLeft,right: widget.paddingRight,top: widget.paddingTop,bottom: widget.paddingBottom),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
            decoration:
            widget.showBorder?
            BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border:Border.all(color: widget.borderColor??Colors.black,width: widget.borderSize) ,
              color: Colors.white,
            ):
            BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow:  const [
                BoxShadow(
                    blurRadius: 2, color: Colors.black26, offset: Offset(0, 0))
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Visibility(
                    visible: widget.showIcon,
                    child: widget.icon!=null?widget.icon!:const Icon(
                      Icons.menu,
                      color: Colors.black,
                    )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    isShow = !isShow;
                    _runExpandCheck();
                    setState(() {});
                  },
                  child: Text(
                    optionItemSelected.title,
                    style: TextStyle(color: widget.textColorTitle??Colors.black, fontSize: widget.textSizeTitle),
                  ),
                )),
                Visibility(
                  visible: widget.showArrowIcon,
                  child: Align(
                    alignment: const Alignment(1, 0),
                    child: Icon(
                      isShow ? Icons.arrow_drop_down : Icons.arrow_right,
                      color: widget.arrowColor??Colors.black,
                      size: widget.arrowIconSize,
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
                  margin: const EdgeInsets.only(bottom: 20, left: 2, right: 2),
                  padding: const EdgeInsets.only(bottom: 20),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2,
                          color: Colors.black26,
                          offset: Offset(0, 0))
                    ],
                  ),
                  child: _buildDropListOptions(
                      widget.dropListModel.listOptionItems, context,widget.textColorItem,widget.textSizeItem))),
        ],
      ),
    );
  }

  Column _buildDropListOptions(List<OptionItem> items, BuildContext context, Color? textColorItem, double textSizeItem) {
    return Column(
      children: items.map((item) => _buildSubMenu(item, context,textColorItem,textSizeItem)).toList(),
    );
  }

  Widget _buildSubMenu(OptionItem item, BuildContext context,Color? textColorItem, double textSizeItem) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
      child: GestureDetector(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(top: 15),
                child: Text(item.title,
                    style: TextStyle(
                        color:textColorItem??Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: textSizeItem),
                    maxLines: 3,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
          ],
        ),
        onTap: () {
          optionItemSelected = item;
          // print(optionItemSelected.id);
          isShow = false;
          expandController.reverse();
          widget.onOptionSelected(item);
        },
      ),
    );
  }
}
