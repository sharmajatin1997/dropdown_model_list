<h1 align="center">Flutter DropDown Model List</h1>

## Features
Flexible DropDown Model List works with a simple model list and Easy to use & customized.

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
    OptionItem(id: "1", title: "Jatin Sharma"),
    OptionItem(id: "2", title: "Puneet Chand"),
    OptionItem(id: "3", title: "Vikas Bhardwaj"),
    OptionItem(id: "4", title: "Rakesh Kumar"),
    OptionItem(id: "5", title: "Vikram Verma"),
    OptionItem(id: "6", title: "Kiran Yadav"),
    OptionItem(id: "7", title: "Pradeep Kumar"),
    OptionItem(id: "8", title: "Amit Kumar"),
    OptionItem(id: "9", title: "Sweta Sharma"),
    OptionItem(id: "10", title: "Ankit Bhist"),
  ]);
  OptionItem optionItemSelected = OptionItem(title: "Select User");

  TextEditingController controller=TextEditingController();

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
              // Show Icon in DropDown Title
              showArrowIcon: true,
              // Show Arrow Icon in DropDown
              showBorder: true,
              paddingTop: 0,
              suffixIcon: Icons.arrow_drop_down,
              containerPadding: const EdgeInsets.all(10),
              icon: const Icon(Icons.person, color: Colors.black),
              onOptionSelected: (optionItem) {
                optionItemSelected = optionItem;
                print(optionItemSelected.id);
                setState(() {});
              },
            ),
            
            ///Search DropDown 
            
            SearchDropList(
              itemSelected: optionItemSelected,
              dropListModel: dropListModel,
              showIcon: false,
              // Show Icon in DropDown Title
              showArrowIcon: true,
              // Show Arrow Icon in DropDown
              showBorder: true,
              textEditingController: controller,
              paddingTop: 0,
              suffixIcon: Icons.arrow_drop_down,
              containerPadding: const EdgeInsets.all(10),
              icon: const Icon(Icons.person, color: Colors.black),
              onOptionSelected: (optionItem) {
                optionItemSelected = optionItem;
                print(optionItemSelected.id);
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
![Screen 1](https://github.com/sharmajatin1997/dropdown_model_list/assets/80152469/c8f9449a-c440-4c36-bcf9-62c67cfc01af)

![Simulator Screen Shot - iPhone 14 - 2023-06-08 at 13 23 06](https://github.com/sharmajatin1997/dropdown_model_list/assets/80152469/f65c1dae-3492-4929-afbb-566f0bcb8366)

![Simulator Screen Shot - iPhone 14 Plus - 2023-08-21 at 13 05 02](https://github.com/sharmajatin1997/dropdown_model_list/assets/80152469/77679cde-47c5-4793-9c21-42f104803d9b)


## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
