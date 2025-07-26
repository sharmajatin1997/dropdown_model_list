import 'package:dropdown_model_list/drop_down/multiple_selection_search.dart';
import 'package:example/model/userModel.dart';
import 'package:flutter/material.dart';

class SearchMultipleSelection extends StatefulWidget {
  const SearchMultipleSelection({super.key});

  @override
  State<SearchMultipleSelection> createState() =>
      _SearchMultipleSelectionPageState();
}

class _SearchMultipleSelectionPageState extends State<SearchMultipleSelection> {
  final users = [
    UserModel(id: '1', title: 'Alice'),
    UserModel(id: '2', title: 'Bob'),
    UserModel(id: '3', title: 'Charlie'),
  ];

  late MultiDropdownSearchListModel<UserModel> userDropdown;

  // State for selected users
  List<OptionItemsMultiSearch<UserModel>> selectedUsers = [];

  @override
  void initState() {
    super.initState();

    userDropdown = MultiDropdownSearchListModel<UserModel>(
      users
          .map((u) => OptionItemsMultiSearch<UserModel>(
        model: u,
        displayTitle: u.title ?? '',
      ))
          .toList(),
    );
  }

  void _onClearSelection() {
    setState(() {
      selectedUsers.clear();
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Custom Search Dropdown
            MultipleSelectionSearchDropList<UserModel>(
              dropListModel: userDropdown,
              hintText: "Choose user",
              showArrowIcon: true,
              height: 60,
              textColorTitle: Colors.black,
              textColorItem: Colors.black,
              dropboxColor: Colors.white,
              dropBoxBorderColor: Colors.grey,
              scrollThumbColor: Colors.blue,
              showClearButton: true,
              onClear: _onClearSelection,
              showBorder: false,
              enable: true,
              doneButton: Container(
                height: 30,
                width: 100,
                color: Colors.red,
              ),
              borderSize: 1,
              // 👇 Track selected items
              selectedItems: selectedUsers,
              // 👇 Handle new selections
              onOptionsSelected: (List<OptionItemsMultiSearch<UserModel>> value) {
                setState(() {
                  selectedUsers = value;
                });
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _onClearSelection,
              child: const Text("Clear Selected User"),
            ),

            const SizedBox(height: 20),

            /// Display selected values
            const Text(
              "Selected Users:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...selectedUsers.map((user) => Text(user.displayTitle)),
          ],
        ),
      ),
    );
  }
}

