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

  @HiveField(5)
  String email;

  User(this.id, this.firstName, this.lastName, this.pharmacyNumber,
      this.doctorNumber, this.email);

  // Decode the User from a json file
  User.fromJson(Map<String, dynamic> json)
      : this.id = json["id"],
        this.firstName = json["first_name"].toString(),
        this.lastName = json["last_name"].toString(),
        this.pharmacyNumber = json["pharmacy_number"].toString(),
        this.doctorNumber = json["doctor_number"].toString(),
        this.email = json["email"].toString();
}

/// User List Class used to decode a list of Users
class UserList {
  final List<User> users;

  UserList(this.users);

  UserList.from(List<dynamic> userJson)
      : users = userJson.map((e) => User.fromJson(e)).toList();
}
