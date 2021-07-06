import 'package:medify/Database/api_handler.dart';
import 'package:medify/database/models/user.dart';
import 'package:medify/database/database_query_base.dart';

/// Class to Handle User Queries
class UserQueries extends DatabaseQueryBase<User> {
  UserQueries() : super("users");

  @override
  Future<List<User>> retrieveAllFromApi(int userId) async {
    var jsonData = await ApiHandler.medifyAPI().getData("users");
    return UserList.from(jsonData).users;
  }

  @override
  Future<User> retrieveOneFromApi(int id) async {
    var jsonData = await ApiHandler.medifyAPI().getData("users/$id");
    return User.fromJson(jsonData);
  }

  Future<User> updateToApi(User user) async {
    var jsonData = await ApiHandler.medifyAPI().getPutData("users/${user.id}", user.toJson());
    return User.fromJson(jsonData);
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    var jsonData = await ApiHandler.medifyAPI().getPostData("login", {'email': email, 'password': password}, filterResponse: false);
    return jsonData;
  }

  Future<Map<String, dynamic>> register(String name, String email, String password, String pharmacyPhone, int isCaregiver) async {
    var body = {'name': name, 'email': email, 'password': password, 'pharmacy_number': pharmacyPhone, 'is_caregiver': isCaregiver};
    var jsonData = await ApiHandler.medifyAPI().getPostData("users", body, filterResponse: false);
    return jsonData;
  }

  Future<void> changePassword(User user, String password) async {
    await ApiHandler.medifyAPI().getPutData("users/${user.id}", {"email": user.email, "password": password});
  }

  Future<Map<String, dynamic>> resetPassword(String email) async {
    return await ApiHandler.medifyAPI().getPostData("resetPassword", {'email': email}, filterResponse: false);
  }

  Future<void> verifyRequest(String email) async {
    return await ApiHandler.medifyAPI().getPostData("user/verify", {'email': email}, filterResponse: false);
  }
}
