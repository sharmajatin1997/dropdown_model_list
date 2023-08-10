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
              itemSelected: optionItemSelected,
              dropListModel: dropListModel,
              showIcon: false,
              // Show Icon in DropDown Title
              showArrowIcon: true,
              // Show Arrow Icon in DropDown
              showBorder: true,
              paddingTop: 0,
              heightBottomContainer: 120,
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
