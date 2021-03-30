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

  Medication(this.id, this.brandName, this.usage, this.precaution, this.dosage, this.ingredient);

  // Decode the Medication from a json file
  Medication.fromJson(Map<String, dynamic> json)
      : this.id = json["id"],
        this.brandName = json["openfda"]["brand_name"][0].toString(),
        this.usage = json["indications_and_usage"][0].toString(), // Could also use dosage_and_administration
        this.precaution = json["warnings"][0].toString(), // Could also use other_safety_information
        this.dosage = json["dosage_and_administration"][0].toString(),
        this.ingredient = json["active_ingredient"][0].toString(); // Could also use inactive_ingredient
}

/// Medication List Class used to decode a list of Medications
class MedicationList {
  final List<Medication> medications;

  MedicationList(this.medications);

  MedicationList.from(List<dynamic> medicationJson) : medications = medicationJson.map((e) => Medication.fromJson(e)).toList();
}
