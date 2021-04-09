import 'dart:async';

import 'package:http/http.dart';
import 'package:medify/database/models/user.dart';
import 'package:medify/database/api_handler.dart';
import 'package:medify/database/model_queries/user_queries.dart';

class UserRepository {
  final StreamController<User> streamController = StreamController();
  User currentUser;
  String password;
  final UserQueries userQueries = UserQueries();

  Future<void> updateUser(User user) async {
    currentUser = user;
    //This updates the stream and anyone listening to the stream will get the updated user
    streamController.add(currentUser);
  }

  Future<User> updateUserToApi(User user) async {
    var updatedUser = await userQueries.updateToApi(user);
    currentUser = updatedUser;
    //This updates the stream and anyone listening to the stream will get the updated user
    streamController.add(currentUser);
    return updatedUser;
  }
}
