import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/presentation/home_screen/widgets/home_screen_list.dart';
import 'package:notes/presentation/note_screen/note_screen.dart';
import 'package:notes/utilities/file_handing_hive.dart';
import '../../utilities/hive_type_adapter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchText = '';
  TextEditingController searchTextController = TextEditingController();
  @override
  void initState() {
    super.initState();
    searchText;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Iterable<Widget> closeIconButton = [
      IconButton(
          onPressed: () {
            setState(() {
              searchTextController.text = '';
              searchText = '';
            });
          },
          icon: const Icon(Icons.close))
    ];
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            preferredSize: const Size(50, 50),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
              child: SearchBar(
                hintText: 'Search...',
                controller: searchTextController,
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
                trailing: closeIconButton,
                constraints: const BoxConstraints(maxHeight: 50),
                leading: const Icon(
                  Icons.search,
                ),
              ),
            )),
        elevation: 0,
        title: Text(
          'Notes',
          style: theme.textTheme.headlineLarge,
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<NoteListModel>('NotesStorage').listenable(),
        builder: (context, Box<NoteListModel> box, _) {
          if (box.isEmpty) {
            return Center(
                child: Text(
              'No data!',
              style: theme.textTheme.titleLarge,
            ));
          }
          return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, index) {
                  int boxKey = box.keyAt(index);
                  if (searchText.isEmpty) {
                    return HomeScreenList(
                      box: box,
                      boxKey: boxKey,
                    );
                  } else {
                    int? filteredKey =
                        FileHandlingModel().search(boxKey, searchText, box);
                    if (filteredKey != null) {
                      return HomeScreenList(
                        box: box,
                        boxKey: boxKey,
                      );
                    } else {
                      return Offstage(
                        offstage: true, // Установите true, чтобы скрыть виджет
                        child: HomeScreenList(
                          box: box,
                          boxKey: boxKey,
                        ),
                      );
                    }
                  }
                },
              ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => NoteScreen()));
        },
        child: const Icon(
          Icons.add,
          size: 35,
        ),
      ),
    );
  }
}
