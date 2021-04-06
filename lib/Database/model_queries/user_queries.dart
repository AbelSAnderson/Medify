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

  Future<Map<String, dynamic>> login(String email, String password) async {
    var jsonData = await ApiHandler.medifyAPI().getPostData("login", {'email' : email, 'password': password}, filterResponse: false);
    return jsonData;
  }

  // Future<User> register(String name, String email, String password, String pharmacyPhone) {
  //
  // }
}