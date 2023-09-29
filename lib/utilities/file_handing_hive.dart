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
      listKey.currentState
          ?.insertItem(index, duration: const Duration(milliseconds: 500));
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
      await box.delete(boxItemKey);
      NoteListModel noteModel = NoteListModel(list);
      await box.put(boxItemKey, noteModel);
    } else {
      await box.delete(boxItemKey);
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

  Future<void> remove(
    int? boxItemKey,
    int index,
    Box<NoteListModel> box,
    GlobalKey<AnimatedListState>? listKey,
  ) async {
    if (boxItemKey != null && listKey != null) {
      NoteListModel? removedData = box.getAt(index);
      await box.deleteAt(index);
      if (listKey.currentState != null) {
        listKey.currentState!.removeItem(
            index,
            (context, animation) => HomeScreenList(
                  removedData: removedData?.data,
                  animation: animation,
                  index: index,
                ),
            duration: const Duration(milliseconds: 500));
      }
    }
  }

  List<String> read(int? boxItemKey, List<String>? removedData) {
    List<String> listNotFound = [
      'Data not found',
      'Data not found',
      'Data not found'
    ];
    List<String> listIsNull = ['Data is null', 'Data is null', 'Data is null'];
    if (boxItemKey != null) {
      final boxConstraintsKey = box.containsKey(boxItemKey);
      if (boxConstraintsKey) {
        final NoteListModel noteModel = box.get(boxItemKey)!;
        return noteModel.data;
      } else {
        return listNotFound;
      }
    } else if (removedData != null) {
      return removedData;
    } else {
      return listIsNull;
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
