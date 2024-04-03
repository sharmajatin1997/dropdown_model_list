class DropListModel {
  DropListModel(this.listOptionItems);
  final List<OptionItem> listOptionItems;
}

class OptionItem {
  final String? id;
  final String? data;
  final String title;

  OptionItem({this.id, required this.title, this.data});
}
