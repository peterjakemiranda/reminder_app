import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/common/widgets/dismissable_background.dart';
import 'package:reminder_app/models/todo_list/todo_list.dart';

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
        WriteBatch batch = FirebaseFirestore.instance.batch();

        final reminderRef = FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .collection('reminders')
            .doc(reminder.id);

        final listRef = FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .collection('todo_lists')
            .doc(reminder.list['id']);

        batch.delete(reminderRef);
        batch.update(listRef, {'reminder_count': remindersForList.length - 1});

        try {
          batch.commit();
        } catch (e) {
          print(e);
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
