import 'package:flutter/material.dart';

class ThemeManger {
  static ThemeData lightTheme = ThemeData(
    primaryColor: const Color.fromARGB(255, 121, 10, 212),
    primaryColorLight: const Color.fromARGB(255, 121, 10, 212),
    scaffoldBackgroundColor: Colors.white,
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white,
    ),
    backgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 121, 10, 212),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
  );
}
