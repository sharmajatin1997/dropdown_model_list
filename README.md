<h1 align="center">Flutter DropDown Model List</h1>
<img src="https://github.com/user-attachments/assets/113b8659-3302-47cc-b2f5-050790fb881a" alt="DropDown_Model_list" width="100%" />

## Features
Flexible DropDown Model List works with a simple model list and Easy to use & customized.
In DropDown Model List Feature:-
* Single Selection
* Single Selection With Search
* Multiple Selection
* Radio Button Selection

<br>
# Installation

1. Add the latest version of package to your pubspec.yaml (and dart pub get):

```
dart
  dependencies:
    flutter:
      sdk: flutter
    dropdown_model_list: latest
```

2. Import the package and use it in your App.

## Usage Example

```
import 'package:dropdown_model_list/dropdown_model_list.dart';

```

## Example of Single Selection DropDown

```
import 'package:dropdown_model_list/drop_down/select_drop_list.dart';
import 'package:example/model/userModel.dart';
import 'package:flutter/material.dart';

class SingleSelection extends StatefulWidget {
  const SingleSelection({super.key});

  @override
  State<SingleSelection> createState() => _SingleSelectionPageState();
}

class _SingleSelectionPageState extends State<SingleSelection> {
  final users = [
    UserModel(id: '1', title: 'Alice'),
    UserModel(id: '2', title: 'Bob'),
    UserModel(id: '3', title: 'Charlie'),
  ];

  OptionItems<UserModel>? selectedUser;
  late DropdownListModel<UserModel> userDropdown;

  // Define one reusable placeholder
  final OptionItems<UserModel> placeholderOption = OptionItems(model: null, displayTitle: "Choose user");

  @override
  void initState() {
    super.initState();
    // Start with placeholder shown
    selectedUser = placeholderOption;

    // Only actual users in dropdown
    userDropdown = DropdownListModel<UserModel>(
      users.map((u) => OptionItems<UserModel>(
        model: u,
        displayTitle: u.title!,
      )).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Single Selection DropDown'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// Dropdown
            SelectDropList<UserModel>(
              itemSelected: selectedUser,
              dropListModel: userDropdown,
              onOptionSelected: (optionItem) {
                setState(() {
                  selectedUser = optionItem;
                });
              },
              hintText: "Choose user",
              showArrowIcon: true,
              height: 50,
              arrowColor: Colors.black,
              textColorTitle: Colors.black,
              textColorItem: Colors.black,
              dropboxColor: Colors.white,
              dropBoxBorderColor: Colors.grey,
              scrollThumbColor: Colors.blue,
            ),

            const SizedBox(height: 20),

            /// Clear button
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedUser = placeholderOption; // 👈 not in list, but shown
                });
              },
              child: const Text("Clear Selected User"),
            )
          ],
        ),
      ),
    );
  }
}
            
```
## Image of Single Selection DropDown
<img width="1024" height="1024" alt="single_selection" src="https://github.com/user-attachments/assets/2a313e7d-a789-4f71-8dce-8eba08d45625" />

## Example of Search DropDown

```
import 'package:dropdown_model_list/drop_down/search_drop_list.dart';
import 'package:example/model/userModel.dart';
import 'package:flutter/material.dart';

class SearchSingleSelection extends StatefulWidget {
  const SearchSingleSelection({super.key});

  @override
  State<SearchSingleSelection> createState() => _SearchSingleSelectionPageState();
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
          .map((u) =>
          OptionItemsSearch<UserModel>(model: u, displayTitle: u.title ?? ''))
          .toList(),
    );
  }

  void _onClearSelection() {
    setState(() {
      selectedUser = placeholderOption;
    });
  }

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
```
## Image of Search DropDown
<img width="1024" height="1024" alt="search_dropdown" src="https://github.com/user-attachments/assets/01141fb4-581c-41a3-9396-b7e8e3f56661" />

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
