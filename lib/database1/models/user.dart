import 'package:hive/hive.dart';
import 'package:medify/database1/model_base.dart';

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

  bool isCaregiver = false;

  User(this.id, this.name, this.pharmacyNumber, this.email);

  // Decode the User from a json file
  User.fromJson(Map<String, dynamic> json)
      : this.id = json["id"],
        this.name = json["name"].toString(),
        this.pharmacyNumber = json["pharmacy_number"].toString(),
        this.isCaregiver = json["is_caregiver"] == 0 ? false : true,
        this.email = json["email"].toString();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'pharmacy_number': pharmacyNumber,
        'is_caregiver': isCaregiver == false ? 0 : 1,
        'email': email,
      };
}

/// User List Class used to decode a list of Users
class UserList {
  final List<User> users;

  UserList(this.users);

  UserList.from(List<dynamic> userJson) : users = userJson.map((e) => User.fromJson(e)).toList();
}
