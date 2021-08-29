// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medication_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MedicationInfoAdapter extends TypeAdapter<MedicationInfo> {
  @override
  final int typeId = 2;

  @override
  MedicationInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MedicationInfo(
      fields[0] as int,
      fields[1] as int,
      fields[2] as int,
      fields[3] as DateTime,
      fields[4] as int,
      fields[5] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, MedicationInfo obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.medicationType)
      ..writeByte(2)
      ..write(obj.pillsRemaining)
      ..writeByte(3)
      ..write(obj.takeAt)
      ..writeByte(4)
      ..write(obj.repeat)
      ..writeByte(5)
      ..write(obj.medication);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedicationInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
