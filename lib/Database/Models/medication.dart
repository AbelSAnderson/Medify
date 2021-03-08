import 'package:hive/hive.dart';
import 'package:medify/database/model_base.dart';

part 'medication.g.dart';

@HiveType(typeId: 1)
class Medication extends ModelBase {
  @HiveField(0)
  String id;

  @HiveField(1)
  String brandName;

  @HiveField(2)
  String usage;

  @HiveField(3)
  String precaution;

  @HiveField(4)
  String dosage;

  @HiveField(5)
  String ingredient;

  Medication(this.id, this.brandName, this.usage, this.precaution, this.dosage,
      this.ingredient);

  // Decode the Medication from a json file - should be changed later to handle lack of information
  Medication.fromJson(Map<String, dynamic> json)
      : this.id = json["id"],
        this.brandName = json["brand_name"] != null
            ? json["brand_name"]
            : '', // Potential fix on missing information - needs to be tested
        this.usage = json[
            "indications_and_usage"], // Could also use dosage_and_administration
        this.precaution =
            json["warnings"], // Could also use other_safety_information
        this.dosage = json["dosage_and_administration"],
        this.ingredient =
            json["active_ingredient"]; // Could also use inactive_ingredient
}

/// Medication List Class used to decode a list of Medications
class MedicationList {
  final List<Medication> medications;

  MedicationList(this.medications);

  MedicationList.from(List<dynamic> medicationJson)
      : medications =
            medicationJson.map((e) => Medication.fromJson(e)).toList();
}
