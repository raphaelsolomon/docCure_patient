// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 1;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      uid: fields[0] as String?,
      name: fields[1] as String?,
      email: fields[2] as String?,
      verified: fields[3] as bool?,
      phone: fields[4] as String?,
      country: fields[5] as String?,
      profilePhoto: fields[6] as String?,
      token: fields[7] as String?,
      gender: fields[8] as String?,
      marital_status: fields[9] as String?,
      age: fields[13] as String?,
      dob: fields[10] as String?,
      status: fields[15] as String?,
      cat: fields[14] as String?,
      height: fields[12] as String?,
      weight: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.verified)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.country)
      ..writeByte(6)
      ..write(obj.profilePhoto)
      ..writeByte(7)
      ..write(obj.token)
      ..writeByte(8)
      ..write(obj.gender)
      ..writeByte(9)
      ..write(obj.marital_status)
      ..writeByte(10)
      ..write(obj.dob)
      ..writeByte(11)
      ..write(obj.weight)
      ..writeByte(12)
      ..write(obj.height)
      ..writeByte(13)
      ..write(obj.age)
      ..writeByte(14)
      ..write(obj.cat)
      ..writeByte(15)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
