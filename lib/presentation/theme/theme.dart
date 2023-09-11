// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  inputDecorationTheme: InputDecorationTheme(),
  hintColor: Colors.grey[400],
  appBarTheme: AppBarTheme(color: Colors.transparent),
  textTheme: TextTheme(
    headlineLarge: TextStyle(fontSize: 30, color: Colors.white),
    titleLarge: TextStyle(fontSize: 30, color: Colors.white),
    bodySmall: TextStyle(fontSize: 20, color: Colors.white),
    titleSmall: TextStyle(
      fontSize: 24,
      color: Colors.white,
    ),
    labelSmall: TextStyle(
        fontStyle: FontStyle.italic,
        color: const Color.fromARGB(138, 255, 255, 255)),
  ),
  scaffoldBackgroundColor: Colors.grey[900],
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: Colors.green[900]),
  searchBarTheme: SearchBarThemeData(
      elevation: MaterialStatePropertyAll(0),
      backgroundColor: MaterialStateProperty.all(Colors.grey[700]),
      hintStyle: MaterialStateProperty.all(TextStyle(color: Colors.grey[400]))),
  iconTheme: IconThemeData(
    color: Colors.grey[400],
  ),
);
