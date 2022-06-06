import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/common/helpers/helpers.dart';
import 'package:reminder_app/models/category/category.dart';
import 'package:reminder_app/models/todo_list/todo_list.dart';
import 'package:reminder_app/screens/view_list/widgets/reminder_list.dart';

import '../../models/reminder/reminder.dart';

class ViewListScreen extends StatelessWidget {
  final TodoList todoList;

  const ViewListScreen({Key? key, required this.todoList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allReminders = Provider.of<List<Reminder>>(context);
    final remindersForList = allReminders
        .where((reminder) => reminder.list['id'] == todoList.id)
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(todoList.title),
      ),
      body: ListView.builder(
        itemCount: remindersForList.length,
        itemBuilder: (context, index) {
          final reminder = remindersForList[index];
          return ReminderList(reminder: reminder);
        },
      ),
    );
  }
}
