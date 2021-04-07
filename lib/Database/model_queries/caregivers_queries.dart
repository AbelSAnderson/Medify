import 'dart:convert';

import 'package:http/http.dart';
import 'package:medify/database/api_handler.dart';
import 'package:medify/database/models/user.dart';

class CaregiversQueries {
  CaregiversQueries();

  Future<List<User>> retrieveAllFromApi() async {
    var jsonData = await ApiHandler.medifyAPI().getData("caregivers");
    print(jsonData);
    return UserList.from(jsonData).users;
  }

  Future<Response> deleteFromApi() async {
    return await ApiHandler.medifyAPI().getDeleteData("");
  }
}
