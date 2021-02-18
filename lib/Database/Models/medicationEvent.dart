import 'package:hive/hive.dart';
import 'package:medify/Database/model_base.dart';

import 'medicationInfo.dart';

@HiveType(typeId: 3)
class MedicationEvent extends ModelBase {

  @HiveField(0)
  int id;

  @HiveField(1)
  DateTime datetime;

  @HiveField(2)
  MedicationInfo medicationInfo;

  MedicationEvent(this.id, this.datetime, this.medicationInfo);
}