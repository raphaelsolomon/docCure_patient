// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageModelAdapter extends TypeAdapter<MessageModel> {
  @override
  final int typeId = 2;

  @override
  MessageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MessageModel(
      message: fields[0] as String?,
      time: fields[1] as String?,
      type: fields[2] as String?,
      from: fields[3] as String?,
      to: fields[4] as String?,
      status: fields[5] as bool?,
      isRead: fields[6] as bool?,
      msgId: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MessageModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.message)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.from)
      ..writeByte(4)
      ..write(obj.to)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.isRead)
      ..writeByte(7)
      ..write(obj.msgId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
