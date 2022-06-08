import 'package:flutter/material.dart';

class CustomTheme extends ChangeNotifier {
  bool _isDarkTheme = true;

  ThemeMode currentTheme() {
    if (_isDarkTheme) {
      return ThemeMode.dark;
    }
    return ThemeMode.light;
  }

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(backgroundColor: Colors.black),
    // iconTheme: IconThemeData(color: Colors.white),
    accentColor: Colors.white,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Colors.blueAccent,
        textStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    dividerColor: Colors.grey[600],
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(shape: StadiumBorder()),
    ),
    cardColor: Color(0xFF1A191D),
  );

  ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Color(0xFFeeeeee),
      primaryColor: Color(0xFFeeeeee),
      appBarTheme: AppBarTheme(
        foregroundColor: Colors.black,
        backgroundColor: Color(0xFFeeeeee),
        elevation: 0,
      ),
      iconTheme: IconThemeData(color: Colors.black),
      accentColor: Colors.black,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // dividerColor: Colors.grey[600],
      cardColor: Colors.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(shape: StadiumBorder()),
      ));
}
