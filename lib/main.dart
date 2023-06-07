import 'package:flutter/material.dart';
import 'package:todo_app/core/constant.dart';
import 'package:todo_app/views/todos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: MyColors.bg_gray,
      ),
      home: const Todos(),
    );
  }
}


