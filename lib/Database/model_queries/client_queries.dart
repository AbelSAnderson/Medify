import 'package:medify/database/api_handler.dart';
import 'package:medify/database/models/user_connection.dart';

class ClientQueries {
  ClientQueries();

  Future<List<UserConnection>> retrieveAllFromApi() async {
    var jsonData = await ApiHandler.medifyAPI().getData("clients");
    print(jsonData);
    return UserConnectionList.from(jsonData).userConnections;
  }
}
