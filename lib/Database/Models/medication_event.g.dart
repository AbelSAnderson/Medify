// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medication_event.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MedicationEventAdapter extends TypeAdapter<MedicationEvent> {
  @override
  final int typeId = 3;

  @override
  MedicationEvent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MedicationEvent(
      fields[0] as int,
      fields[1] as DateTime,
      fields[2] as MedicationInfo,
      fields[3] as bool,
      fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MedicationEvent obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.datetime)
      ..writeByte(2)
      ..write(obj.medicationInfo)
      ..writeByte(3)
      ..write(obj.medTaken)
      ..writeByte(4)
      ..write(obj.amountTaken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedicationEventAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
