import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/models/todo_list/todo_list_collection.dart';
import 'package:reminder_app/screens/add_list/add_list_screen.dart';
import 'package:reminder_app/screens/add_reminder/add_reminder_screen.dart';
import 'package:reminder_app/screens/home/homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodoListCollection>(
      create: (BuildContext context) => TodoListCollection(),
      child: MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (context) => HomeScreen(),
            '/add-list': (context) => AddListScreen(),
            '/add-reminder': (context) => AddReminderScreen(),
          },
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.black,
            appBarTheme: AppBarTheme(color: Colors.black),
            brightness: Brightness.dark,
            iconTheme: IconThemeData(color: Colors.white),
            accentColor: Colors.white,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.blueAccent,
                textStyle: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            dividerColor: Colors.grey[600],
          )),
    );
  }
}
