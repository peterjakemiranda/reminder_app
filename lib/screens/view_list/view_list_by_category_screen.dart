import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/models/category/category.dart';
import 'package:reminder_app/screens/view_list/widgets/reminder_list.dart';

import '../../common/helpers/helpers.dart';
import '../../models/reminder/reminder.dart';

class ViewListByCategoryScreen extends StatelessWidget {
  final Category category;

  const ViewListByCategoryScreen({Key? key, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allReminders = Provider.of<List<Reminder>>(context);
    final remindersForCategory = allReminders
        .where((reminder) =>
            reminder.categoryId == category.id || category.id == 'all')
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: ListView.builder(
        itemCount: remindersForCategory.length,
        itemBuilder: (context, index) {
          final reminder = remindersForCategory[index];
          return ReminderList(reminder: reminder);
        },
      ),
    );
  }
}
