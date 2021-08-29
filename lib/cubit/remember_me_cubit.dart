import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medify/database1/api_handler.dart';
import 'package:medify/database1/model_queries/user_queries.dart';
import 'package:medify/database1/models/user.dart';
import 'package:medify/repositories/user_repository.dart';

part 'remember_me_state.dart';

class RememberMeCubit extends Cubit<RememberMeState> {
  RememberMeCubit(this.userRepository) : super(RememberMeInitial());

  final UserRepository userRepository;

  Future<void> checkIfLoggedIn() async {
    var secureStorage = FlutterSecureStorage();
    var isLoggedIn = await secureStorage.read(key: "isLoggedIn");

    if (isLoggedIn == "true") {
      var email = await secureStorage.read(key: "email");
      var password = await secureStorage.read(key: "password");

      try {
        var jsonResponse = await new UserQueries().login(email, password);
        if (jsonResponse['success'] != null) {
          // Update the APi token & retrieve the user from the response
          print("Bearer " + jsonResponse['success']['token']);
          ApiHandler.medifyAPI().setToken("Bearer " + jsonResponse['success']['token']);
          var user = User.fromJson(jsonResponse['success']['user']);
          userRepository.updateUser(user);
          userRepository.password = password;
          emit(RememberMeSuccess());
        } else {
          secureStorage.write(key: "isLoggedIn", value: "false");
          emit(RememberMeFailure());
        }
      } catch (e) {
        secureStorage.write(key: "isLoggedIn", value: "false");
        emit(RememberMeFailure());
      }
    } else {
      emit(RememberMeFailure());
    }
  }
}
