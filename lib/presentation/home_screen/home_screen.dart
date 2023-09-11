// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:notes/presentation/home_screen/widgets/home_screen_body.dart';
import 'package:notes/presentation/note_screen/note_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            child: Padding(
              padding: EdgeInsets.only(bottom: 10, left: 5, right: 5),
              child: SearchBar(
                hintText: 'Search...',
                constraints: BoxConstraints(maxHeight: 50),
                leading: Icon(
                  Icons.search,
                ),
              ),
            ),
            preferredSize: Size(50, 50)),
        elevation: 0,
        title: Text(
          'Notes',
          style: theme.textTheme.headlineLarge,
        ),
      ),
      body: HomeScreenBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => NoteScreen()));
        },
        child: Icon(
          Icons.add,
          size: 35,
        ),
      ),
    );
  }
}
