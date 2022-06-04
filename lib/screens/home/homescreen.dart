import 'package:flutter/cupertino.dart';
import 'package:reminder_app/common/widgets/category_icon.dart';
import 'package:reminder_app/models/category/category.dart';
import 'package:flutter/material.dart';
import 'package:reminder_app/models/category/category_collection.dart';
import 'package:reminder_app/models/todo_list/todo_list.dart';
import 'package:reminder_app/models/todo_list/todo_list_collection.dart';
import 'package:reminder_app/screens/home/widgets/list_view_items.dart';

import 'widgets/footer.dart';
import 'widgets/grid_view_items.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var layoutType = 'grid';
  CategoryCollection categories = CategoryCollection();
  List<TodoList> todoLists = [];

  addNewList(TodoList list) {
    setState(() {
      todoLists.add(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                if (layoutType == 'grid') {
                  setState(() {
                    layoutType = 'list';
                  });
                } else {
                  setState(() {
                    layoutType = 'grid';
                  });
                }
              },
              child: Text(
                layoutType == 'grid' ? 'Edit' : 'Done',
              ))
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.black,
            child: AnimatedCrossFade(
              duration: const Duration(milliseconds: 300),
              firstChild:
                  GridViewItems(categories: categories.selectedCategories),
              secondChild: ListViewItems(categoryCollection: categories),
              crossFadeState: layoutType == 'grid'
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
            ),
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: todoLists.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Text(todoLists[index].title),
                  );
                },
              ),
            ),
          ),
          Footer(addNewListCallback: (todoList) => addNewList(todoList)),
        ],
      ),
    );
  }
}
