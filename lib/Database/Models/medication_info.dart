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
  DateTime takeAt;

  @HiveField(4)
  int repeat;

  @HiveField(5)
  Medication medication;

  MedicationInfo(this.id, this.medicationType, this.pillsRemaining, this.takeAt, this.repeat, this.medication);
}
