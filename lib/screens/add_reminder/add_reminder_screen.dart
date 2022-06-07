import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/common/widgets/category_icon.dart';
import 'package:reminder_app/models/category/category_collection.dart';
import 'package:reminder_app/models/category/category.dart';
import 'package:reminder_app/models/reminder/reminder.dart';
import 'package:reminder_app/screens/add_reminder/select_reminder_category_screen.dart';
import 'package:reminder_app/screens/add_reminder/select_reminder_list_screen.dart';
import 'package:reminder_app/services/database_service.dart';

import '../../common/helpers/helpers.dart';
import '../../models/todo_list/todo_list.dart';

class AddReminderScreen extends StatefulWidget {
  const AddReminderScreen({Key? key}) : super(key: key);

  @override
  State<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _notesTextController = TextEditingController();

  String _title = '';
  String _notes = '';
  TodoList? _selectedList;
  Category _selectedCategory = CategoryCollection().categories[0];
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _titleTextController.addListener(() {
      setState(() {
        _title = _titleTextController.text;
      });
    });
  }

  _updateSelectedList(TodoList todoList) {
    setState(() {
      _selectedList = todoList;
    });
  }

  _updateSelectedCategory(Category category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _titleTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _todoLists = Provider.of<List<TodoList>>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Reminder'),
        actions: [
          TextButton(
            onPressed:
                _title.isEmpty || _selectedDate == null || _selectedTime == null
                    ? null
                    : () async {
                        final user = Provider.of<User?>(context, listen: false);
                        _selectedList = _selectedList != null
                            ? _selectedList
                            : _todoLists.first;
                        final newReminder = Reminder(
                          id: null,
                          title: _titleTextController.text,
                          notes: _notesTextController.text,
                          categoryId: _selectedCategory.id,
                          list: _selectedList!.toJson(),
                          dueDate: _selectedDate!.millisecondsSinceEpoch,
                          dueTime: {
                            'hour': _selectedTime!.hour,
                            'minute': _selectedTime!.minute
                          },
                        );
                        try {
                          DatabaseService(uid: user!.uid)
                              .addReminder(reminder: newReminder);
                          Navigator.pop(context);
                          print('reminder added');
                          showSnackbar(context, 'Reminder added.');
                        } catch (e) {
                          print(e);
                          showSnackbar(context, 'Unable to add reminder.');
                        }
                      },
            child: Text('Add'),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).cardColor),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Title',
                      border: InputBorder.none,
                    ),
                    controller: _titleTextController,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  Divider(height: 1),
                  SizedBox(
                    height: 100,
                    child: TextField(
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Notes',
                        border: InputBorder.none,
                      ),
                      controller: _notesTextController,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectReminderListScreen(
                          todoLists: _todoLists,
                          selectedList: _selectedList != null
                              ? _selectedList!
                              : _todoLists.first,
                          selectedListCallback: _updateSelectedList,
                        ),
                      ),
                    );
                  },
                  tileColor: Theme.of(context).cardColor,
                  leading: Text(
                    'List',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CategoryIcon(
                          bgColor: Colors.blueAccent,
                          iconData: Icons.calendar_today),
                      SizedBox(width: 10),
                      Text(_selectedList != null
                          ? _selectedList!.title
                          : _todoLists.first.title),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectReminderCategoryScreen(
                                selectedCategory: _selectedCategory,
                                selectedCategoryCallback:
                                    _updateSelectedCategory,
                              ),
                          fullscreenDialog: true),
                    );
                  },
                  tileColor: Theme.of(context).cardColor,
                  leading: Text(
                    'Category',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CategoryIcon(
                          bgColor: _selectedCategory.icon.bgColor,
                          iconData: _selectedCategory.icon.iconData),
                      SizedBox(width: 10),
                      Text(_selectedCategory.name),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                child: ListTile(
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(
                          Duration(days: 365),
                        ));
                    if (pickedDate != null) {
                      setState(() {
                        _selectedDate = pickedDate;
                      });
                    } else {
                      print('no date was picked');
                    }
                  },
                  tileColor: Theme.of(context).cardColor,
                  leading: Text(
                    'Date',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CategoryIcon(
                          bgColor: Colors.deepPurple,
                          iconData: CupertinoIcons.calendar_badge_plus),
                      SizedBox(width: 10),
                      Text(_selectedDate != null
                          ? DateFormat.yMMMd().format(_selectedDate!).toString()
                          : 'Select Date'),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                child: ListTile(
                  onTap: () async {
                    final pickedTime = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
                    if (pickedTime != null) {
                      setState(() {
                        _selectedTime = pickedTime;
                      });
                    } else {
                      print('no time was picked');
                    }
                  },
                  tileColor: Theme.of(context).cardColor,
                  leading: Text(
                    'Time',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CategoryIcon(
                          bgColor: Colors.purple,
                          iconData: CupertinoIcons.time),
                      SizedBox(width: 10),
                      Text(_selectedTime != null
                          ? _selectedTime!.format(context).toString()
                          : 'Select Time'),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
