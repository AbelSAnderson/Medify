import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medify/database1/model_queries/user_queries.dart';
import 'package:medify/database1/api_handler.dart';
import 'package:medify/database1/model_queries/user_queries.dart';
import 'package:medify/database1/models/user.dart';
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
        userRepository.password = password;
        try {
          _saveLoginInfo(email, password);
        } catch (e) {
          print(e.toString());
        }
        emit(LoginSucceeded());
      } else if (jsonResponse['error'] != null) {
        emit(LoginFailed(jsonResponse['error']));
      } else {
        emit(LoginFailed("Connection with server failed."));
      }
    } catch (exception) {
      emit(LoginFailed("Incorrect Email or Password"));
      return;
    }
  }

  registerUser(String name, String email, String password, String pharmacyPhoneNumber, int isCaregiver) async {
    emit(LoginValidating());

    try {
      pharmacyPhoneNumber = pharmacyPhoneNumber != "" ? pharmacyPhoneNumber : null;
      var jsonResponse = await new UserQueries().register(name, email, password, pharmacyPhoneNumber, isCaregiver);

      if (jsonResponse['status']) {
        await ApiHandler.medifyAPI().setToken("Bearer " + jsonResponse['data']['token']);
        var user = User.fromJson(jsonResponse['data']['user']);
        userRepository.updateUser(user);
        try {
          _saveLoginInfo(email, password);
        } catch (e) {
          print(e.toString());
        }
        // UserQueries().verifyRequest(email);

        emit(LoginSucceeded());
      } else {
        var errorMessage = "${jsonResponse['message']}: ${jsonResponse['errors']['email'][0]}";

        emit(LoginFailed(errorMessage));
      }
    } catch (exception) {
      emit(LoginFailed("Email is already taken"));
      print(exception.toString());
      return;
    }
  }

  Future<void> _saveLoginInfo(String email, String password) async {
    var secureStorage = FlutterSecureStorage();
    var isLoggedIn = await secureStorage.read(key: "isLoggedIn");

    if (isLoggedIn != "true") {
      secureStorage.write(key: "isLoggedIn", value: "true");
      secureStorage.write(key: "email", value: email);
      secureStorage.write(key: "password", value: password);
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
