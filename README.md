<h1 align="center">Flutter DropDown Model List</h1>

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
    dropdown_model_list: any
```

2. Import the package and use it in your App.

## Usage Example

```
import 'package:dropdown_model_list/dropdown_model_list.dart';

```

## Short Example

```
            
             ///Search DropDown
            SearchDropList(
              itemSelected: optionItemSelected,
              dropListModel: dropListModel,
              showIcon: false,
              showArrowIcon: true,
              showBorder: true,
              textEditingController: controller,
              paddingTop: 0,
              suffixIcon: Icons.arrow_drop_down,
              containerPadding: const EdgeInsets.all(10),
              icon: const Icon(Icons.person, color: Colors.black),
              onOptionSelected: (optionItem) {
                optionItemSelected = optionItem;
                if (kDebugMode) {
                  print(optionItemSelected.id);
                }
                setState(() {});
              },
            ),
            
            ///Multiple Selection DropDown
            SelectDropMultipleList(
              defaultText: optionItemSelected,
              dropListModel: dropListModel,
              showIcon: false,
              showBorder: true,
              paddingTop: 0,
              submitText: "OK",
              colorSubmitButton: Colors.amber,
              selectedIconWidget: Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.rectangle, color: Colors.amber),
                child: const Icon(
                  Icons.done,
                  size: 15,
                  color: Colors.white,
                ),
              ),
              suffixIcon: Icons.arrow_drop_down,
              containerPadding: const EdgeInsets.all(10),
              icon: const Icon(Icons.person, color: Colors.black),
              onOptionListSelected: (list) {
                for (var data in list) {
                  if (data.id != null) {
                    if (kDebugMode) {
                      print(data.id);
                    }
                  }
                }
                setState(() {});
              },
            ),
            
            ///Radio Selection DropDown
            SelectDropRadio(
              defaultText: optionItemSelected,
              dropListModel: dropListModel,
              showIcon: false,
              showBorder: true,
              paddingTop: 0,
              submitText: "OK",
              colorSubmitButton: Colors.amber,
              selectedRadioColor: Colors.amber,
              suffixIcon: Icons.arrow_drop_down,
              containerPadding: const EdgeInsets.all(10),
              icon: const Icon(Icons.person, color: Colors.black),
              onOptionListSelected: (data) {
                print(data.title);
                setState(() {});
              },
            ),
```

## Example

```
import 'package:dropdown_model_list/dropdown_model_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DropDown Menu',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'DropDown Menu'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DropListModel dropListModel = DropListModel([
    OptionItem(id: "1", title: "Jatin Sharma", data: 'CSE Student'),
    OptionItem(id: "2", title: "Puneet Chand", data: 'CSE Student'),
    OptionItem(id: "3", title: "Vikas Bhardwaj", data: 'CSE Student'),
    OptionItem(id: "4", title: "Rakesh Kumar", data: 'CSE Student'),
    OptionItem(id: "5", title: "Alok Dubey", data: 'CSE Student'),
    OptionItem(id: "6", title: "Kiran Yadav", data: 'CSE Student'),
    OptionItem(id: "7", title: "Pradeep Kumar", data: 'CSE Student'),
    OptionItem(id: "8", title: "Amit Kumar", data: 'CSE Student'),
    OptionItem(id: "9", title: "Shweta Sharma", data: 'CSE Student'),
    OptionItem(id: "10", title: "Ankit Bhist", data: 'CSE Student'),
  ]);
  OptionItem optionItemSelected = OptionItem(title: "Select User");

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: <Widget>[

            ///Search DropDown
            SearchDropList(
              itemSelected: optionItemSelected,
              dropListModel: dropListModel,
              showIcon: false,
              showArrowIcon: true,
              showBorder: true,
              enable: true,
              textEditingController: controller,
              paddingTop: 0,
              suffixIcon: Icons.arrow_drop_down,
              containerPadding: const EdgeInsets.all(10),
              icon: const Icon(Icons.person, color: Colors.black),
              onOptionSelected: (optionItem) {
                optionItemSelected = optionItem;
                if (kDebugMode) {
                  print(optionItemSelected.id);
                }
                setState(() {});
              },
            ),

            ///Multiple Selection DropDown
            SelectDropMultipleList(
              defaultText: optionItemSelected,
              dropListModel: dropListModel,
              showIcon: false,
              showBorder: true,
              enable: true,
              paddingTop: 0,
              submitText: "OK",
              onTapCross: (data) {
                if (data) {
                  print("List Clear");
                }
              },
              colorSubmitButton: Colors.amber,
              selectedIconWidget: Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.rectangle, color: Colors.amber),
                child: const Icon(
                  Icons.done,
                  size: 15,
                  color: Colors.white,
                ),
              ),
              suffixIcon: Icons.arrow_drop_down,
              containerPadding: const EdgeInsets.all(10),
              icon: const Icon(Icons.person, color: Colors.black),
              onOptionListSelected: (list) {
                for (var data in list) {
                  if (data.id != null) {
                    if (kDebugMode) {
                      print(data.id);
                    }
                  }
                }
                setState(() {});
              },
            ),

            ///Radio Selection DropDown
            SelectDropRadio(
              defaultText: optionItemSelected,
              dropListModel: dropListModel,
              showIcon: false,
              showBorder: true,
              paddingTop: 0,
              enable: true,
              submitText: "OK",
              colorSubmitButton: Colors.amber,
              selectedRadioColor: Colors.amber,
              suffixIcon: Icons.arrow_drop_down,
              containerPadding: const EdgeInsets.all(10),
              icon: const Icon(Icons.person, color: Colors.black),
              onOptionListSelected: (data) {
                print(data.title);
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}

```
## Example Select Drop Down
```
import 'package:dropdown_model_list/drop_down/drop_model.dart';
import 'package:dropdown_model_list/dropdown_model_list.dart';
import 'package:example/model/userModel.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DropDown Menu',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'DropDown Menu'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        title: Text(widget.title),
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

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
