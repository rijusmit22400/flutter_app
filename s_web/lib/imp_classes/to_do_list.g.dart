// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'to_do_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class todolistAdapter extends TypeAdapter<to_do_list> {
  @override
  final int typeId = 1;

  @override
  to_do_list read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return to_do_list(
      title: fields[0] as String,
      item: (fields[1] as List).cast<dynamic>(),
      status: (fields[2] as List).cast<dynamic>(),
    ).._type = fields[3] as String;
  }

  @override
  void write(BinaryWriter writer, to_do_list obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.item)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj._type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is todolistAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
