import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/provider/provider_list_model.dart';
import 'package:notes/utilities/file_handing_hive.dart';
import '../../../utilities/hive_type_adapter.dart';
import '../../note_screen/note_screen.dart';

class HomeScreenList extends StatelessWidget {
  const HomeScreenList({
    super.key,
    required this.boxItemKey,
    required this.animation,
    required this.index,
  });

  final int boxItemKey;

  final Animation<double> animation;
  final int index;

  @override
  Widget build(BuildContext context) => SizeTransition(
        sizeFactor: animation,
        child: buildItem(context),
      );
  Widget buildItem(context) {
    final GlobalKey<AnimatedListState> listKey =
        ProviderListModel.watch(context)!.model.listKey;
    final Box<NoteListModel> box = Hive.box<NoteListModel>('NotesStorage');
    final theme = Theme.of(context);
    return FutureBuilder(
        future: FileHandlingModel().read(boxItemKey),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<String> errorValues = [
              'Data not found',
              'Data not found',
              'Data not found'
            ];
            List<String> values = snapshot.data ?? errorValues;
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.green[800],
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NoteScreen(
                            noteTitleControllerData: values[0],
                            noteTextControllerData: values[1],
                            boxItemKey: boxItemKey,
                            index: index,
                          )));
                },
                title: Text(
                  values[0],
                  style: theme.textTheme.titleSmall,
                ),
                trailing: IconButton(
                    alignment: Alignment.center,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: theme.scaffoldBackgroundColor,
                            title: const Text(
                              'Delete item',
                            ),
                            content: Text(
                              'Are you sure you want to delete this item?',
                              style: theme.textTheme.bodySmall,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  FileHandlingModel()
                                      .remove(boxItemKey, index, box, listKey);
                                },
                                style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.red)),
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.delete,
                      size: 28,
                    )),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      values[1],
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      values[2],
                      style: theme.textTheme.labelSmall,
                    )
                  ],
                ),
              ),
            );
          }
        });
  }
}
