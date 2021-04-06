import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medify/database/api_handler.dart';
import 'package:medify/database/model_queries/user_queries.dart';
import 'package:medify/database/models/user.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  loginUser(String email, String password) async {
    var jsonResponse = {};
    try {
      emit(LoginValidating());
      jsonResponse = await new UserQueries().login(email, password);
    } catch (exception) {
      emit(LoginFailed(exception.toString()));
      return;
    }

    if (jsonResponse['success'] != null) {
      // Update the APi token & retrieve the user from the response
      ApiHandler.medifyAPI().setToken("Bearer " + jsonResponse['success']['token']);
      var user = User.fromJson(jsonResponse['success']['user']);
      emit(LoginSucceeded());
    } else if (jsonResponse['error'] != null) {
      emit(LoginFailed(jsonResponse['error']));
    } else {
      emit(LoginFailed("Connection with server failed."));
    }
  }

  // registerUser(String name, String email, String password, String pharmacyPhoneNumber) async {
  //
  // }
}
