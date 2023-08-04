// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocationAdapterAdapter extends TypeAdapter<LocationAdapter> {
  @override
  final int typeId = 1;

  @override
  LocationAdapter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocationAdapter(
      lat: fields[0] as double?,
      lng: fields[1] as double?,
      placemark: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LocationAdapter obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.lat)
      ..writeByte(1)
      ..write(obj.lng)
      ..writeByte(2)
      ..write(obj.placemark);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationAdapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
