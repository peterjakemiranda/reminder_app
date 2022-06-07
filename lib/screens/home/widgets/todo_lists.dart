import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/common/helpers/helpers.dart';
import 'package:reminder_app/models/todo_list/todo_list.dart';
import 'package:reminder_app/screens/view_list/view_list_screen.dart';
import 'package:reminder_app/services/database_service.dart';

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
                    try {
                      DatabaseService(uid: user!.uid)
                          .removeTodoList(id: todoLists[index].id);
                      showSnackbar(context, 'List deleted.');
                    } catch (e) {
                      print(e);
                      showSnackbar(context, 'Unable to delete todo list');
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
