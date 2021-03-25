import 'package:medify/database/model_base.dart';
import 'package:medify/database/models/user.dart';

///Model for the user's connections
class UserConnection extends ModelBase {
  ///The user you have a connection with
  User user;

  ///The status of your connection with the user
  Status status;

  UserConnection(this.user, this.status);
}

///Enum for the connection status of the users
enum Status { requested, connected }
