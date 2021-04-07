import 'package:hive/hive.dart';
import 'package:medify/database/model_base.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends ModelBase {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String pharmacyNumber;

  @HiveField(3)
  String email;

  User(this.id, this.name, this.pharmacyNumber, this.email);

  // Decode the User from a json file
  User.fromJson(Map<String, dynamic> json)
      : this.id = json["id"],
        this.name = json["name"].toString(),
        this.pharmacyNumber = json["pharmacy_number"].toString(),
        this.email = json["email"].toString();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'pharmacy_number': pharmacyNumber,
        'is_caregiver': "0",
        'email': email,
      };
}

/// User List Class used to decode a list of Users
class UserList {
  final List<User> users;

  UserList(this.users);

  UserList.from(List<dynamic> userJson) : users = userJson.map((e) => User.fromJson(e)).toList();
}
