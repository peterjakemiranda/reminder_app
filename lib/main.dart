import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/config/custom_theme.dart';
import 'package:reminder_app/models/todo_list/todo_list_collection.dart';
import 'package:reminder_app/screens/add_list/add_list_screen.dart';
import 'package:reminder_app/screens/add_reminder/add_reminder_screen.dart';
import 'package:reminder_app/screens/auth/authenticate_screen.dart';
import 'package:reminder_app/screens/home/homescreen.dart';
import 'package:reminder_app/screens/wrapper.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('There was an error.'),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              StreamProvider<User?>.value(
                value: FirebaseAuth.instance.authStateChanges(),
                initialData: FirebaseAuth.instance.currentUser,
              ),
              ChangeNotifierProvider(create: (context) => CustomTheme()),
            ],
            child: Wrapper(),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
