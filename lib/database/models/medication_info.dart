import 'package:hive/hive.dart';
import 'package:medify/database/models/medication.dart';
import 'package:medify/database/model_base.dart';

@HiveType(typeId: 2)
class MedicationInfo extends ModelBase {
  @HiveField(0)
  int id;

  @HiveField(1)
  int medicationType;

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
