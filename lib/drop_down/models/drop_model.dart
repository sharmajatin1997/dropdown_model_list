class DropdownListModel<T> {
  final List<OptionItems<T>> listOptionItems;
  DropdownListModel(this.listOptionItems);
}

class OptionItems<T> {
  final T? model;
  final String displayTitle;

  OptionItems({ this.model, required this.displayTitle});
}