// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/presentation/home_screen/widgets/home_screen_list.dart';
import 'package:notes/utilities/hive_type_adapter.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ValueListenableBuilder(
      valueListenable: Hive.box<NoteListModel>('NotesStorage').listenable(),
      builder: (context, Box<NoteListModel> box, _) {
        if (box.values.isEmpty) {
          return Center(
              child: Text(
            'No data!',
            style: theme.textTheme.titleLarge,
          ));
        }
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ListView.separated(
              itemCount: box.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                int boxKey = box.keyAt(index);
                return HomeScreenList(
                  box: box,
                  boxKey: boxKey,
                );
              },
            ));
      },
    );
  }
}
