import 'package:flutter/material.dart';
import 'screens/entry_lists_screen.dart';

class App extends StatelessWidget {
  final String title;

  const App({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: EntryListsScreen(),
    );
  }
}
