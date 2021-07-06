import 'dart:async';

import 'package:medify/database/models/user.dart';
import 'package:medify/database/model_queries/user_queries.dart';

class UserRepository {
  final StreamController<User> streamController = StreamController<User>.broadcast();
  User currentUser;
  String password;
  final UserQueries userQueries = UserQueries();

  UserRepository() {
    streamController.stream.asBroadcastStream(onCancel: (stream) => stream.cancel());
  }

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

  Future<void> changePassword(String newPassword) async {
    await userQueries.changePassword(currentUser, newPassword);
    password = newPassword;
  }
}
