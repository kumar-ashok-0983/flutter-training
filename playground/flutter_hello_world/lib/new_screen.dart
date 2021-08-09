import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewScreen extends StatelessWidget {
  NewScreen({Key? key}) : super(key: key);

  late final Future<Todo> futureTodo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App from scratch'),
      ),
      body: FutureBuilder(
        future: fetchTodos(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return ListView(
                children: [
                  TodoRow(snapshot.data!),
                ],
              );
            case ConnectionState.none:
              return Text('None');
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.active:
              return Text('Active');
          }
        },
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
        Checkbox(
          value: myTodo.completed,
          onChanged: (bool? value) {},
        ),
        Text(myTodo.title),
      ],
    );
  }
}

class Todo {
  final bool completed;
  final String title;

  Todo({required this.completed, required this.title});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(completed: json['completed'], title: json['title']);
  }
}

Future<Todo> fetchTodos() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));

  if (response.statusCode == 200) {
    return Todo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Todos');
  }
}
