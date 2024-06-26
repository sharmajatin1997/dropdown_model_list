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
            SelectDropList(
              itemSelected:optionItemSelected,
              dropListModel:dropListModel,
              showIcon: true,     // Show Icon in DropDown Title
              showArrowIcon: true,     // Show Arrow Icon in DropDown
              showBorder: true,
              paddingTop: 0,
              icon: const Icon(Icons.person,color: Colors.black),
              onOptionSelected:(optionItem){
                optionItemSelected = optionItem;
                setState(() {});
              },
            )
            
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

## Short Example Using Getx

```

    DropListModel dropListContentModel = DropListModel([
    OptionItem(id: "audio", title: "Audio"),
    OptionItem(id: "video", title: "Video",),
    OptionItem(id: "presentation", title: "Presentation"),
    OptionItem(id: "document", title: "Documents",),
    ]);
  
    var optionItemSelectedContent = OptionItem(title: "Select Content").obs;
    var contentType = ''.obs;
     
    Obx(() =>
     SelectDropList(
          hintColorTitle: Colors.black,
          itemSelected: optionItemSelectedContent.value,
          dropListModel: dropListContentModel,
          showIcon: false, // Show Icon in DropDown Title
          showArrowIcon: true, // Show Arrow Icon in DropDown
          showBorder: true,
          borderColor: Colors.grey,
          suffixIcon: Icons.arrow_drop_down,
          arrowIconSize: 28,
          paddingDropItem: 10,
          paddingBottom: 0,
          paddingLeft: 0,
          containerPadding: const EdgeInsets.only(left: 0,right: 10),
          paddingRight: 0,
          paddingTop: 0,
          onOptionSelected: (optionItem) {
                optionItemSelectedContent.value = optionItem;
            },
          )),
            
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
            ///Simple DropDown
            SelectDropList(
              itemSelected: optionItemSelected,
              dropListModel: dropListModel,
              showIcon: false,
              showArrowIcon: true,
              showBorder: true,
              enable: true,
              paddingTop: 0,
              paddingDropItem: const EdgeInsets.only(
                  left: 20, top: 10, bottom: 10, right: 20),
              suffixIcon: Icons.arrow_drop_down,
              containerPadding: const EdgeInsets.all(10),
              icon: const Icon(Icons.person, color: Colors.black),
              onOptionSelected: (optionItem) {
                optionItemSelected = optionItem;
                setState(() {});
              },
            ),

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
![Simulator Screen Shot - iPhone 14 Plus - 2023-08-21 at 13 05 02](https://github.com/sharmajatin1997/dropdown_model_list/assets/80152469/77679cde-47c5-4793-9c21-42f104803d9b)
![Screenshot_1693204401](https://github.com/sharmajatin1997/dropdown_model_list/assets/80152469/aa72000e-3d5d-4203-841f-4c6374c9b831)
![Simulator Screenshot - iPhone 15 Pro Max - 2023-11-27 at 16 09 26](https://github.com/sharmajatin1997/dropdown_model_list/assets/80152469/7f875339-57f6-4050-a16a-15304465a36c)


## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
