import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reminder_app/models/todo_list/todo_list.dart';

import '../models/reminder/reminder.dart';

class DatabaseService {
  final String uid;
  final FirebaseFirestore _database;
  final DocumentReference _useRef;

  DatabaseService({required this.uid})
      : _database = FirebaseFirestore.instance,
        _useRef = FirebaseFirestore.instance.collection('users').doc(uid);

  Stream<List<TodoList>> todoListStream() {
    return _useRef.collection('todo_lists').snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (todoListSnapshot) => TodoList.fromJson(
                  todoListSnapshot.data(),
                ),
              )
              .toList(),
        );
  }

  Stream<List<Reminder>> reminderStream() {
    return _useRef.collection('reminders').snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (remindersSnapshot) => Reminder.fromJson(
                  remindersSnapshot.data(),
                ),
              )
              .toList(),
        );
  }

  addTodoList({required TodoList todoList}) async {
    final todoListRef = _useRef.collection('todo_lists').doc();
    todoList.id = todoListRef.id;
    try {
      await todoListRef.set(todoList.toJson());
      print('list added');
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  removeTodoList({required String? id}) async {
    final todoListRef = _useRef.collection('todo_lists').doc(id);
    final reminderSnapshots = await _useRef
        .collection('reminders')
        .where('list.id', isEqualTo: id)
        .get();

    WriteBatch batch = FirebaseFirestore.instance.batch();
    reminderSnapshots.docs.forEach((reminder) {
      batch.delete(reminder.reference);
    });
    batch.delete(todoListRef);
    try {
      batch.commit();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  addReminder({required Reminder reminder}) async {
    final reminderRef = _useRef.collection('reminders').doc();
    final listRef = _useRef.collection('todo_lists').doc(reminder.list['id']);
    reminder.id = reminderRef.id;

    WriteBatch batch = _database.batch();

    batch.set(reminderRef, reminder.toJson());
    batch.update(
      listRef,
      {'reminder_count': reminder.list['reminder_count'] + 1},
    );

    try {
      await batch.commit();
      print('reminder added');
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  removeReminder({
    required Reminder reminder,
    required int listReminderCount,
  }) async {
    WriteBatch batch = _database.batch();

    final reminderRef = _useRef.collection('reminders').doc(reminder.id);

    final listRef = _useRef.collection('todo_lists').doc(reminder.list['id']);

    batch.delete(reminderRef);
    batch.update(listRef, {'reminder_count': listReminderCount - 1});

    try {
      batch.commit();
    } catch (e) {
      print(e);
    }
  }
}
