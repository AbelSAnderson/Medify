import 'package:medify/database/model_base.dart';
import 'package:medify/database/models/user.dart';

///Model for the user's connections
class UserConnection extends ModelBase {
  ///The user you have a connection with
  User user;

  ///The status of your connection with the user
  Status status;

  UserConnection(this.user, this.status);

  UserConnection.fromJson(Map<String, dynamic> json)
      : this.user = User.fromJson(json),
        this.status = json["is_connected"] == 0 ? Status.requested : Status.connected;
}

class UserConnectionList {
  final List<UserConnection> userConnections;

  UserConnectionList(this.userConnections);

  UserConnectionList.from(List<dynamic> userConnectionJson) : userConnections = userConnectionJson.map((e) => UserConnection.fromJson(e)).toList();
}

///Enum for the connection status of the users
enum Status { requested, connected }
