import 'package:hive/hive.dart';

import 'hive_type_adapter.dart';

// Функция для выполнения поиска в Hive-боксе
List<NoteListModel> searchNotes(String query) {
  final box = Hive.box<NoteListModel>('NotesStorage');

  // Создаем пустой список для хранения результатов поиска
  final List<NoteListModel> searchResults = [];

  for (var key in box.keys) {
    final note = box.get(key);

    // Проверяем, соответствует ли заметка поисковому запросу
    if (note!.data.any((text) => text.contains(query))) {
      searchResults.add(note);
    }
  }

  return searchResults;
}
