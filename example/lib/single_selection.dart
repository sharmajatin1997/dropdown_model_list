import 'package:dropdown_model_list/drop_down/models/drop_model.dart';
import 'package:dropdown_model_list/dropdown_model_list.dart';
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