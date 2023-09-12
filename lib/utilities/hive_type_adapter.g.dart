// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_type_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteListModelAdapter extends TypeAdapter<NoteListModel> {
  @override
  final int typeId = 0;

  @override
  NoteListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteListModel(
      (fields[0] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, NoteListModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
