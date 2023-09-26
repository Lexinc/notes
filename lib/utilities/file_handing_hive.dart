import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../presentation/home_screen/widgets/home_screen_list.dart';
import 'hive_type_adapter.dart';

class FileHandlingModel {
  String formattedDate =
      DateFormat('dd.MM.yyyy HH:mm').format(DateTime.now().toLocal());
  final box = Hive.box<NoteListModel>('NotesStorage');

  Future<void> write(
      String title, String text, GlobalKey<AnimatedListState> listKey) async {
    final list = [title, text, formattedDate.toString()];
    final trimmedTitle = title.trim();
    final trimmedText = text.trim();

    if (trimmedText.isNotEmpty || trimmedTitle.isNotEmpty) {
      final noteModel = NoteListModel(list);
      await box.add(noteModel);
      int index = box.length - 1;
      listKey.currentState?.insertItem(index);
    }
  }

  Future<void> rewrite(
      {required String title,
      required String text,
      required int boxItemKey,
      required int index,
      required GlobalKey<AnimatedListState> listKey}) async {
    final list = [title, text, formattedDate.toString()];
    final trimmedTitle = title.trim();
    final trimmedText = text.trim();

    if (trimmedText.isNotEmpty || trimmedTitle.isNotEmpty) {
      _delete(boxItemKey);
      NoteListModel noteModel = NoteListModel(list);
      await box.put(boxItemKey, noteModel);
    } else {
      _delete(boxItemKey);
      listKey.currentState!.removeItem(
        index,
        (context, animation) => HomeScreenList(
          boxItemKey: boxItemKey,
          animation: animation,
          index: index,
        ),
      );
    }
  }

  Future<void> _delete(int key) async {
    await box.delete(key);
  }

  void remove(int boxItemKey, int index, Box<NoteListModel> box,
      GlobalKey<AnimatedListState> listKey) {
    _delete(boxItemKey);
    listKey.currentState!.removeItem(
      index,
      (context, animation) => HomeScreenList(
        boxItemKey: boxItemKey,
        animation: animation,
        index: index,
      ),
    );
  }

  Future<List<String>> read(int boxItemKey) async {
    final boxConstraintsKey = box.containsKey(boxItemKey);
    if (boxConstraintsKey) {
      final NoteListModel noteModel = box.get(boxItemKey)!;
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

  int? search(int key, String queryText, Box<NoteListModel> box) {
    bool titleResult = false;
    bool textResult = false;
    if (box.containsKey(key)) {
      final List<String> note = box.get(key)!.data;

      titleResult = note[0].contains(queryText);
      textResult = note[1].contains(queryText);
    }
    if (titleResult || textResult) {
      return key;
    } else {
      return null;
    }
  }
}
