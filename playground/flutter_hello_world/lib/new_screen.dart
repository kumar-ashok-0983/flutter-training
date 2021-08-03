import 'package:flutter/material.dart';

class NewScreen extends StatelessWidget {
  NewScreen({Key? key}) : super(key: key);
  final List todos = [
    Todo(false, 'my first todo'),
    Todo(false, 'second todo'),
    Todo(false, 'third todo'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App from scratch'),
      ),
      body: ListView(
        children: [
          TodoRow(todos[0]),
          TodoRow(todos[1]),
          TodoRow(todos[2]),
        ],
      ),
      // color: Colors.pink,
    );
  }
}

class TodoRow extends StatelessWidget {
  final Todo myTodo;

  TodoRow(this.myTodo);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: myTodo.completed, onChanged: null),
        Text(myTodo.title),
      ],
    );
  }
}

//
class Todo {
  final bool completed;
  final String title;

  Todo(this.completed, this.title);
}
