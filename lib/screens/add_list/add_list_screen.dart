import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/models/common/custom_color.dart';
import 'package:reminder_app/models/common/custom_icon.dart';
import 'package:reminder_app/models/common/custom_icon_collection.dart';
import 'package:reminder_app/models/todo_list/todo_list.dart';

import '../../models/common/custom_color_collection.dart';
import '../../models/todo_list/todo_list_collection.dart';

class AddListScreen extends StatefulWidget {
  const AddListScreen({Key? key}) : super(key: key);

  @override
  State<AddListScreen> createState() => _AddListScreenState();
}

class _AddListScreenState extends State<AddListScreen> {
  CustomColor _selectedColor = CustomColorCollection().colors.first;
  CustomIcon _selectedIcon = CustomIconCollection().icons.first;

  TextEditingController _textController = TextEditingController();

  String _listName = '';

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      setState(() {
        _listName = _textController.text;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add List'),
        actions: [
          TextButton(
              onPressed: _listName.isEmpty
                  ? null
                  : () {
                      Provider.of<TodoListCollection>(context, listen: false)
                          .addTodoList(TodoList(
                              id: DateTime.now().toString(),
                              title: _textController.text,
                              icon: {
                            "id": _selectedIcon.id,
                            "color": _selectedColor.id,
                          }));
                      Navigator.pop(context);
                    },
              child: Text(
                'Add',
                style: TextStyle(
                    // color:
                    // listName.isNotEmpty ? Colors.blueAccent : Colors.grey
                    ),
              )),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: Icon(Icons.list_rounded, size: 75),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _textController,
                style: Theme.of(context).textTheme.headline5,
                autofocus: true,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: Container(
                    child: IconButton(
                      onPressed: () {
                        _textController.clear();
                      },
                      icon: Icon(Icons.clear),
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (final customColor in CustomColorCollection().colors)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        this._selectedColor = customColor;
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          border: _selectedColor.id == customColor.id
                              ? Border.all(color: Colors.grey[200]!, width: 5)
                              : null,
                          color: customColor.color,
                          shape: BoxShape.circle),
                    ),
                  )
              ],
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (final customIcon in CustomIconCollection().icons)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        this._selectedIcon = customIcon;
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        customIcon.icon,
                      ),
                      decoration: BoxDecoration(
                          border: _selectedIcon.id == customIcon.id
                              ? Border.all(color: Colors.grey[600]!, width: 5)
                              : null,
                          shape: BoxShape.circle,
                          color: Theme.of(context).cardColor),
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
