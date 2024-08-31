import 'package:medify/database/api_handler.dart';
import 'package:medify/database/models/user.dart';

class CaregiversQueries {
  CaregiversQueries();

  Future<List<User>> retrieveAllFromApi() async {
    var jsonData = await ApiHandler.medifyAPI().getData("caregivers");
    return UserList.from(jsonData).users;
  }

  Future<Map<String, dynamic>> deleteFromApi(int userId) async {
    return await ApiHandler.medifyAPI().getDeleteData("removeCaregiver/$userId", filterResponse: false);
  }

  Future<Map<String, dynamic>> requestCaregiver(String email) async {
    var jsonData = await ApiHandler.medifyAPI().getPostData("requestCaregiver", {"email": email}, filterResponse: false);
    return jsonData;
  }
}
