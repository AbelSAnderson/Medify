import 'package:hive/hive.dart';
import 'package:medify/database/model_base.dart';

import 'medication_info.dart';

@HiveType(typeId: 3)
class MedicationEvent extends ModelBase {
  @HiveField(0)
  int id;

  @HiveField(1)
  DateTime datetime;

  @HiveField(2)
  MedicationInfo medicationInfo;

  @HiveField(3)
  bool medTaken;

  @HiveField(4)
  int amountTaken;

  MedicationEvent(this.id, this.datetime, this.medicationInfo, this.medTaken, this.amountTaken);
}
