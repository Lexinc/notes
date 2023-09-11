import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import 'hive_type_adapter.dart';

class FileHandlingModel {
  String formattedDate =
      DateFormat('dd.MM.yyyy HH:mm').format(DateTime.now().toLocal());
  Future<void> write(String title, String text) async {
    final list = [title, text, formattedDate.toString()];
    final box = Hive.box<NoteListModel>('NotesStore4');
    final noteModel = NoteListModel(list);
    await box.add(noteModel);
  }

  Future<List<String>> read(int index) async {
    final box = Hive.box<NoteListModel>('NotesStore4');
    final boxConstraintsKey = box.containsKey(index);
    if (boxConstraintsKey) {
      final NoteListModel noteModel = box.get(index)!;
      return noteModel.data;
    } else {
      List<String> list = [
        'Data not found',
        'Data not found',
        'Data not found'
      ];
      return list;
    }
  }

  Future<int> length() async {
    final box = Hive.box<NoteListModel>('NotesStore4');
    final length = box.length;
    return length;
  }
}
