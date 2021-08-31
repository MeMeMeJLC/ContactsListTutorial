import 'package:flutter/material.dart';
import 'src/contacts_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ContactsScreen(title: 'Contacts List'),
    );
  }
}
