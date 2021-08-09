import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TiagoHomePage extends StatelessWidget {
  const TiagoHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDos'),
      ),
      body: FutureBuilder(
        future: fetchTodos(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              return Text('active');
            case ConnectionState.done:
              List todoList = snapshot.data;
              return ListView.builder(
                  itemBuilder: (context, index) {
                    return TBTodoRow(todoList[index]);
                  },
                  itemCount: todoList.length);
            case ConnectionState.waiting:
              return Text('waiting');
            case ConnectionState.none:
              return Text('none');
          }
        },
      ),
    );
  }
}

class TBTodoRow extends StatelessWidget {
  final TBTodo todo;
  const TBTodoRow(this.todo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Checkbox(value: todo.completed, onChanged: null),
        title: Text(todo.title),
      ),
    );
  }
}

Future<List<TBTodo>> fetchTodos() async {
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/todos'),
  );
  List todos = jsonDecode(response.body);
  return todos.map((mapTodo) => TBTodo.fromMap(mapTodo)).toList();
}

class TBTodo {
  final bool completed;
  final String title;
  TBTodo({required this.completed, required this.title});

  factory TBTodo.fromMap(Map<String, dynamic> map) =>
      TBTodo(completed: map['completed'], title: map['title']);
}
