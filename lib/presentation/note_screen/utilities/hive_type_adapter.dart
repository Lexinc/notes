import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'hive_type_adapter.g.dart';

@HiveType(typeId: 0)
class NoteListModel extends HiveObject {
  @HiveField(0)
  List<String> data;

  NoteListModel(this.data);
}
