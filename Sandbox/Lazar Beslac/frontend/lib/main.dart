import 'package:flutter/material.dart';
import 'package:povezivanje/TodoList.dart';
import 'package:povezivanje/TodoListModel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoListModel(),
      child: MaterialApp(
        title: 'Flutter Demo',
        home: TodoList(),
      ),
    );
  }
}

