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
    OptionItem(id: "5", title: "Nitish Kumar")
  ]);
  OptionItem optionItemSelected = OptionItem(title: "Select User");

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
          ],
        ),
      ),
    );
  }
}

```
![Screen 1](https://github.com/sharmajatin1997/dropdown_model_list/assets/80152469/c8f9449a-c440-4c36-bcf9-62c67cfc01af)

![Screen 2](https://github.com/sharmajatin1997/dropdown_model_list/assets/80152469/53f61606-3687-4f86-9e4b-e896861e21f8)


## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
