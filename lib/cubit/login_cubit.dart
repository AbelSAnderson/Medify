import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medify/database/api_handler.dart';
import 'package:medify/database/model_queries/user_queries.dart';
import 'package:medify/database/models/user.dart';
import 'package:medify/repositories/user_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final UserRepository userRepository;
  LoginCubit(this.userRepository) : super(LoginInitial());

  loginUser(String email, String password) async {
    emit(LoginValidating());

    try {
      var jsonResponse = await new UserQueries().login(email, password);
      if (jsonResponse['success'] != null) {
        // Update the APi token & retrieve the user from the response
        ApiHandler.medifyAPI().setToken("Bearer " + jsonResponse['success']['token']);
        var user = User.fromJson(jsonResponse['success']['user']);
        userRepository.updateUser(user);
        // TODO: Save user appropriately in Hive db

        emit(LoginSucceeded());
      } else if (jsonResponse['error'] != null) {
        emit(LoginFailed(jsonResponse['error']));
      } else {
        emit(LoginFailed("Connection with server failed."));
      }
    } catch (exception) {
      emit(LoginFailed(exception.toString()));
      return;
    }
  }

  registerUser(String name, String email, String password, String pharmacyPhoneNumber, int isCaregiver) async {
    emit(LoginValidating());

    try {
      var jsonResponse = await new UserQueries().register(name, email, password, pharmacyPhoneNumber, isCaregiver);

      if (jsonResponse['status']) {
        ApiHandler.medifyAPI().setToken("Bearer " + jsonResponse['data']['token']);
        var user = User.fromJson(jsonResponse['data']['user']);
        userRepository.updateUser(user);
        // TODO: Save user appropriately in Hive db

        emit(LoginSucceeded());
      } else {
        // TODO: Handle all error messages
        var errorMessage = "${jsonResponse['message']}: ${jsonResponse['errors']['email'][0]}";

        emit(LoginFailed(errorMessage));
      }
    } catch (exception) {
      emit(LoginFailed(exception.toString()));
      return;
    }
  }

  resetState() {
    emit(LoginInitial());
  }
}
