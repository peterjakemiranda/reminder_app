import 'package:flutter/material.dart';
import 'package:reminder_app/models/todo_list/todo_list.dart';

class SelectReminderListScreen extends StatelessWidget {
  final List<TodoList> todoLists;
  final TodoList selectedList;
  final Function(TodoList) selectedListCallback;

  const SelectReminderListScreen(
      {Key? key,
      required this.todoLists,
      required this.selectedList,
      required this.selectedListCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select List'),
      ),
      body: ListView.builder(
        itemCount: todoLists.length,
        itemBuilder: (context, index) {
          final item = todoLists[index];
          return ListTile(
            onTap: () {
              selectedListCallback(item);
              Navigator.pop(context);
            },
            title: Text(item.title),
            trailing:
                item.title == selectedList.title ? Icon(Icons.check) : null,
          );
        },
      ),
    );
  }
}
