import 'package:hive/hive.dart';
import 'package:medify/Database/Models/medication.dart';
import 'package:medify/Database/model_base.dart';

@HiveType(typeId: 2)
class MedicationInfo extends ModelBase {

  @HiveField(0)
  int id;

  @HiveField(1)
  String medicationType;

  @HiveField(2)
  int pillsRemaining;

  @HiveField(3)
  int repeat;

  @HiveField(4)
  Medication medication;

  MedicationInfo(this.id, this.medicationType, this.pillsRemaining, this.repeat, this.medication);
}