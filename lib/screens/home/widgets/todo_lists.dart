import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/models/todo_list/todo_list.dart';
import 'package:reminder_app/screens/view_list/view_list_screen.dart';

import '../../../common/widgets/category_icon.dart';
import '../../../common/widgets/dismissable_background.dart';
import '../../../models/common/custom_color_collection.dart';
import '../../../models/common/custom_icon_collection.dart';
import '../../../models/todo_list/todo_list_collection.dart';

class TodoLists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todoLists = Provider.of<List<TodoList>>(context);
    final user = Provider.of<User?>(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Lists',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: todoLists.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  onDismissed: (direction) async {
                    final todoListRef = FirebaseFirestore.instance
                        .collection('users')
                        .doc(user?.uid)
                        .collection('todo_lists')
                        .doc(todoLists[index].id);

                    final reminderSnapshots = await FirebaseFirestore.instance
                        .collection('users')
                        .doc(user?.uid)
                        .collection('reminders')
                        .where('list.id', isEqualTo: todoLists[index].id)
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
                    }
                  },
                  direction: DismissDirection.endToStart,
                  key: UniqueKey(),
                  background: DismissableBackground(),
                  child: Card(
                    shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    elevation: 0,
                    margin: EdgeInsets.zero,
                    child: ListTile(
                      onTap: todoLists[index].reminderCount > 0
                          ? () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewListScreen(
                                            todoList: todoLists[index],
                                          )));
                            }
                          : null,
                      leading: CategoryIcon(
                        bgColor: (CustomColorCollection()
                            .findColorById(todoLists[index].icon['color'])
                            .color),
                        iconData: (CustomIconCollection()
                            .findIconById(todoLists[index].icon['id'])
                            .icon),
                      ),
                      title: Text(todoLists[index].title),
                      trailing: Text(
                        todoLists[index].reminderCount.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
