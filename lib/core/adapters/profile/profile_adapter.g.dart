// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileAdapterAdapter extends TypeAdapter<ProfileAdapter> {
  @override
  final int typeId = 0;

  @override
  ProfileAdapter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProfileAdapter(
      id: fields[0] as String?,
      dateOfBirth: fields[1] as String?,
      email: fields[2] as String?,
      fullName: fields[3] as String?,
      idVerified: fields[4] as bool?,
      password: fields[5] as String?,
      phoneNumber: fields[6] as String?,
      photoOfId: fields[7] as String?,
      profileImage: fields[8] as dynamic,
      thirdParty: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProfileAdapter obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.dateOfBirth)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.fullName)
      ..writeByte(4)
      ..write(obj.idVerified)
      ..writeByte(5)
      ..write(obj.password)
      ..writeByte(6)
      ..write(obj.phoneNumber)
      ..writeByte(7)
      ..write(obj.photoOfId)
      ..writeByte(8)
      ..write(obj.profileImage)
      ..writeByte(9)
      ..write(obj.thirdParty);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileAdapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
