import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import 'hive_type_adapter.dart';

class FileHandlingModel extends ChangeNotifier {
  String formattedDate =
      DateFormat('dd.MM.yyyy HH:mm').format(DateTime.now().toLocal());
  final box = Hive.box<NoteListModel>('NotesStorage');

  Future<void> write(String title, String text) async {
    final list = [title, text, formattedDate.toString()];
    final noteModel = NoteListModel(list);
    await box.add(noteModel);
  }

  Future<void> rewrite(String title, String text, int boxKey) async {
    final list = [title, text, formattedDate.toString()];
    if (title.isNotEmpty || text.isNotEmpty) {
      await box.delete(boxKey);
      NoteListModel noteModel = NoteListModel(list);
      await box.put(boxKey, noteModel);
    }
  }

  Future<void> delete(int index) async {
    await box.delete(index);
  }

  Future<List<String>> read(int index) async {
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
}
