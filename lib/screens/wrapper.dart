import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/models/reminder/reminder.dart';
import 'package:reminder_app/services/database_service.dart';

import '../config/custom_theme.dart';
import '../models/todo_list/todo_list.dart';
import '../models/todo_list/todo_list_collection.dart';
import 'add_list/add_list_screen.dart';
import 'add_reminder/add_reminder_screen.dart';
import 'auth/authenticate_screen.dart';
import 'home/homescreen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final customTheme = Provider.of<CustomTheme>(context);
    return MultiProvider(
      providers: [
        StreamProvider<List<TodoList>>.value(
          initialData: [],
          value: user != null
              ? DatabaseService(uid: user.uid).todoListStream()
              : null,
        ),
        StreamProvider<List<Reminder>>.value(
          initialData: [],
          value: user != null
              ? DatabaseService(uid: user.uid).reminderStream()
              : null,
        )
      ],
      child: MaterialApp(
        // initialRoute: '/',
        routes: {
          // '/': (context) => AuthenticateScreen(),
          '/home': (context) => HomeScreen(),
          '/add-list': (context) => AddListScreen(),
          '/add-reminder': (context) => AddReminderScreen(),
        },
        home: user != null ? HomeScreen() : AuthenticateScreen(),
        theme: customTheme.lightTheme,
        darkTheme: customTheme.darkTheme,
        themeMode: customTheme.currentTheme(),
      ),
    );
  }
}
