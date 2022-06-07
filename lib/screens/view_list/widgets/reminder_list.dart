import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/common/widgets/dismissable_background.dart';
import 'package:reminder_app/models/todo_list/todo_list.dart';
import 'package:reminder_app/services/database_service.dart';

import '../../../common/helpers/helpers.dart';
import '../../../models/reminder/reminder.dart';

class ReminderList extends StatelessWidget {
  const ReminderList({
    Key? key,
    required this.reminder,
  }) : super(key: key);

  final Reminder reminder;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final allReminders = Provider.of<List<Reminder>>(context);
    final remindersForList = allReminders
        .where((element) => element.list['id'] == reminder.list['id'])
        .toList();

    return Dismissible(
      background: DismissableBackground(),
      key: UniqueKey(),
      onDismissed: (direction) async {
        try {
          DatabaseService(uid: user!.uid).removeReminder(
              reminder: reminder, listReminderCount: remindersForList.length);
          showSnackbar(context, 'Reminder deleted.');
        } catch (e) {
          print(e);
          showSnackbar(context, 'Unable to delete reminder');
        }
      },
      child: Card(
        child: ListTile(
          title: Text(reminder.title),
          subtitle: reminder.notes != null ? Text(reminder.notes!) : null,
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(formatDate(reminder.dueDate)),
              Text(
                formatTime(context, reminder.dueTime['hour'],
                    reminder.dueTime['minute']),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
