import 'package:medify/database1/api_handler.dart';
import 'package:medify/database1/models/user_connection.dart';

class ClientQueries {
  ClientQueries();

  Future<List<UserConnection>> retrieveAllFromApi() async {
    var jsonData = await ApiHandler.medifyAPI().getData("clients");
    return UserConnectionList.from(jsonData).userConnections;
  }

  Future<Map<String, dynamic>> acceptRequest(int userId) async {
    var jsonData = await ApiHandler.medifyAPI().getData("acceptRequest/$userId", filterResponse: false);
    return jsonData;
  }

  Future<Map<String, dynamic>> removeClient(int userId) async {
    var jsonData = await ApiHandler.medifyAPI().getDeleteData("removeClient/$userId", filterResponse: false);
    return jsonData;
  }
}
