import 'package:hive/hive.dart';
import 'package:medify/database/model_base.dart';

@HiveType(typeId: 1)
class Medication extends ModelBase {
  @HiveField(0)
  int id;

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
}
