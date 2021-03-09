import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/students.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('First Flutter App'),
          // backgroundColor: Colors.purple,
        ),
        body: Center(
          child: Students(),
        ),
        bottomNavigationBar: Text('Kristina Bojovic'),
      ),

      //Text('Hello World!'),
    );
  }
}
