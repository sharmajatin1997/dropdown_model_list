import 'package:dropdown_model_list/drop_down/search_drop_list.dart';
import 'package:example/model/userModel.dart';
import 'package:flutter/material.dart';

class SearchSingleSelection extends StatefulWidget {
  const SearchSingleSelection({super.key});

  @override
  State<SearchSingleSelection> createState() =>
      _SearchSingleSelectionPageState();
}

class _SearchSingleSelectionPageState extends State<SearchSingleSelection> {
  final users = [
    UserModel(id: '1', title: 'Alice'),
    UserModel(id: '2', title: 'Bob'),
    UserModel(id: '3', title: 'Charlie'),
  ];

  OptionItemsSearch<UserModel>? selectedUser;
  late DropdownSearchListModel<UserModel> userDropdown;

  // Placeholder used to reset the dropdown
  final OptionItemsSearch<UserModel> placeholderOption =
      OptionItemsSearch(model: null, displayTitle: "Choose user");

  @override
  void initState() {
    super.initState();
    selectedUser = placeholderOption;

    userDropdown = DropdownSearchListModel<UserModel>(
      users
          .map((u) => OptionItemsSearch<UserModel>(
              model: u, displayTitle: u.title ?? ''))
          .toList(),
    );
  }

  void _onClearSelection() {
    setState(() {
      selectedUser = placeholderOption;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search DropDown'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// Custom Search Dropdown
            SearchDropList<UserModel>(
              itemSelected: selectedUser,
              dropListModel: userDropdown,
              onOptionSelected: (optionItem) {
                setState(() {
                  selectedUser = optionItem;
                });
              },
              hintText: "Choose user",
              showArrowIcon: true,
              textColorTitle: Colors.black,
              textColorItem: Colors.black,
              dropboxColor: Colors.white,
              dropBoxBorderColor: Colors.grey,
              scrollThumbColor: Colors.blue,
              showClearButton: true,
              onClear: _onClearSelection,
              showBorder: false,
              enable: true,
              borderSize: 1,
            ),

            const SizedBox(height: 20),

            /// Clear Button (optional if showClearButton is used)
            ElevatedButton(
              onPressed: _onClearSelection,
              child: const Text("Clear Selected User"),
            )
          ],
        ),
      ),
    );
  }
}
