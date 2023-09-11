// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/presentation/home_screen/home_screen.dart';
import 'package:notes/presentation/note_screen/utilities/hive_type_adapter.dart';
import 'package:notes/presentation/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteListModelAdapter());
  await Hive.openBox<NoteListModel>('NotesStore4');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darkTheme,
      home: HomeScreen(),
    );
  }
}
