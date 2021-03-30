import 'package:medify/database/api_handler.dart';
import 'package:medify/database/models/user.dart';
import 'package:medify/database/database_query_base.dart';

/// Class to Handle User Queries
class UserQueries extends DatabaseQueryBase<User> {
  UserQueries() : super("users");

  @override
  Future<List<User>> retrieveAllFromApi() async {
    var jsonData = await ApiHandler.medifyAPI().getData("users");
    return UserList.from(jsonData).users;
  }

  @override
  Future<User> retrieveOneFromApi(int id) async {
    var jsonData = await ApiHandler.medifyAPI().getData("users/$id");
    return User.fromJson(jsonData);
  }
}