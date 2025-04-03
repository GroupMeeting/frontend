// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dongari_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DongariModelAdapter extends TypeAdapter<DongariModel> {
  @override
  final int typeId = 1;

  @override
  DongariModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DongariModel(
      name: fields[0] as String,
      feeDate: fields[1] as String,
      region: fields[2] as String,
      contacts: (fields[3] as List).cast<SelectedContact>(),
      imagePath: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DongariModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.feeDate)
      ..writeByte(2)
      ..write(obj.region)
      ..writeByte(3)
      ..write(obj.contacts)
      ..writeByte(4)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DongariModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
