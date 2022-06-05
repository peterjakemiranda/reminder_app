import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:reminder_app/models/common/custom_color.dart';
import 'package:reminder_app/models/todo_list/todo_list.dart';

class TodoListCollection with ChangeNotifier {
  final List<TodoList> _todoList = [];
  UnmodifiableListView<TodoList> get todoLists =>
      UnmodifiableListView(_todoList);

  TodoList findTodoListById(id) {
    return _todoList.firstWhere((list) => list.id == id);
  }

  addTodoList(TodoList todoList) {
    _todoList.add(todoList);
    notifyListeners();
  }

  removeTodoList(TodoList todoList) {
    _todoList.removeWhere((element) => element.id == todoList.id);
    notifyListeners();
  }
}
