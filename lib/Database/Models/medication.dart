import 'package:hive/hive.dart';
import 'package:medify/Database/model_base.dart';

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

  Medication(this.id, this.brandName, this.usage, this.precaution);
}