import 'package:flutter/material.dart';
import 'package:reminder_app/common/widgets/category_icon.dart';

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

  @override
  void initState() {
    super.initState();
    _titleTextController.addListener(() {
      setState(() {
        _title = _titleTextController.text;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _titleTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Reminder'),
        actions: [
          TextButton(
            onPressed: _title.isEmpty
                ? null
                : () {
                    print('Add to database');
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
                  onTap: () {},
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
                      Text('New List'),
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
                  onTap: () {},
                  tileColor: Theme.of(context).cardColor,
                  leading: Text(
                    'Category',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CategoryIcon(
                          bgColor: Colors.blueAccent,
                          iconData: Icons.calendar_today),
                      SizedBox(width: 10),
                      Text('Schedule'),
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
