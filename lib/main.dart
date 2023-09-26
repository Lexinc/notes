import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/presentation/home_screen/home_screen.dart';
import 'package:notes/presentation/theme/theme.dart';
import 'package:notes/provider/provider_list_model.dart';
import 'package:notes/utilities/hive_type_adapter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteListModelAdapter());
  await Hive.openBox<NoteListModel>('NotesStorage');
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final model = ListModel();
  @override
  Widget build(BuildContext context) => ProviderListModel(
      model: model,
      child: MaterialApp(
        theme: darkTheme,
        home: const HomeScreen(),
      ));
}
