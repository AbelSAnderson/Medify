import 'package:medify/database/api_handler.dart';
import 'package:medify/database/models/user_connection.dart';

class ClientQueries {
  ClientQueries();

  Future<List<UserConnection>> retrieveAllFromApi() async {
    var jsonData = await ApiHandler.medifyAPI().getData("clients");
    print(jsonData);
    return UserConnectionList.from(jsonData).userConnections;
  }

  Future<Map<String, dynamic>> acceptRequest(int userId) async {
    var jsonData = await ApiHandler.medifyAPI().getData("acceptRequest/$userId", filterResponse: false);
    return jsonData;
  }

  Future<Map<String, dynamic>> denyRequest(int userId) async {
    var jsonData = await ApiHandler.medifyAPI().getData("denyRequest/$userId", filterResponse: false);
    return jsonData;
  }
}
