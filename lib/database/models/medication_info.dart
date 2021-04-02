import 'package:hive/hive.dart';
import 'package:medify/database/model_base.dart';
import 'package:medify/database/models/medication.dart';

part 'medication_info.g.dart';

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

  MedicationInfo(this.id, this.medicationType, this.pillsRemaining, this.takeAt,
      this.repeat, this.medication);

  // Decode the Medication Info from a json file
  MedicationInfo.fromJson(Map<String, dynamic> json)
      : this.id = json["id"],
        this.medicationType = json["med_type"],
        this.pillsRemaining = json["pills_remaining"],
        this.takeAt = DateTime.parse(json["take_at"]),
        this.repeat = json["repeat_interval"],
        this.medication = Medication.fromJson(json["medication"]);
}

/// MedicationInfo List Class used to decode a list of Medication Info
class MedicationInfoList {
  final List<MedicationInfo> medicationInfo;

  MedicationInfoList(this.medicationInfo);

  MedicationInfoList.from(List<dynamic> medicationInfoJson)
      : medicationInfo = medicationInfoJson.map((e) => MedicationInfo.fromJson(e)).toList();
}
