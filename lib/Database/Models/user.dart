import 'package:hive/hive.dart';
import 'package:medify/database/model_base.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends ModelBase {
  @HiveField(0)
  int id;

  @HiveField(1)
  String firstName;

  @HiveField(2)
  String lastName;

  @HiveField(3)
  String pharmacyNumber;

  @HiveField(4)
  String doctorNumber;

  User(this.id, this.firstName, this.lastName, this.pharmacyNumber,
      this.doctorNumber);
}
