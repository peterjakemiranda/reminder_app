import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/config/custom_theme.dart';
import 'package:reminder_app/models/category/category_collection.dart';
import 'package:reminder_app/models/todo_list/todo_list.dart';
import 'package:reminder_app/screens/home/widgets/list_view_items.dart';
import 'package:reminder_app/screens/home/widgets/todo_lists.dart';

import 'widgets/footer.dart';
import 'widgets/grid_view_items.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var layoutType = 'grid';
  CategoryCollection categoryCollection = CategoryCollection();

  addNewList(TodoList list) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                final customTheme =
                    Provider.of<CustomTheme>(context, listen: false);
                customTheme.toggleTheme();
              },
              icon: Icon(Icons.wb_sunny)),
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(Icons.logout)),
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
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  AnimatedCrossFade(
                    duration: const Duration(milliseconds: 300),
                    firstChild: GridViewItems(
                        categories: categoryCollection.selectedCategories),
                    secondChild:
                        ListViewItems(categoryCollection: categoryCollection),
                    crossFadeState: layoutType == 'grid'
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                  ),
                  TodoLists(),
                ],
              ),
            ),
            Footer(),
          ],
        ),
      ),
    );
  }
}
