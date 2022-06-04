import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:reminder_app/models/common/custom_color.dart';
import 'package:reminder_app/models/todo_list/todo_list.dart';

class TodoListCollection {
  final List<TodoList> _todoList = [
    TodoList(id: 'blue_accent', title: 'Default List', icon: {}),
  ];
  UnmodifiableListView<TodoList> get todoList =>
      UnmodifiableListView(_todoList);

  TodoList findTodoListById(id) {
    return _todoList.firstWhere((list) => list.id == id);
  }
}
