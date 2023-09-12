// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/presentation/home_screen/home_screen.dart';
import 'package:notes/presentation/theme/theme.dart';
import 'package:notes/utilities/file_handing_hive.dart';
import 'package:notes/utilities/hive_type_adapter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteListModelAdapter());
  await Hive.openBox<NoteListModel>('NotesStorage');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        FileHandlingModel();
      },
      child: MaterialApp(
        theme: darkTheme,
        home: HomeScreen(),
      ),
    );
  }
}
