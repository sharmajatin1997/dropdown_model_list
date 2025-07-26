import 'package:dropdown_model_list/dropdown_model_list.dart';
import 'package:example/search_single_selection.dart';
import 'package:example/single_selection.dart';
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
      home:const SearchSingleSelection(),
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

            ///Multiple Selection DropDown
            SelectDropMultipleList(
              defaultText: optionItemSelected,
              dropListModel: dropListModel,
              showIcon: false,
              showBorder: true,
              enable: true,
              showCrossIcon: false,
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
