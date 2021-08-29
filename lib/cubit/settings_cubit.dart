import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsState.initial());

  changeFontScaleFactor(double value) async {
    await Future.delayed(Duration.zero);
    emit(state.copyWith(fontScaleFactor: value));
  }

  logout() async {
    _removeLoginInfo();
  }

  _removeLoginInfo() async {
    var secureStorage = FlutterSecureStorage();
    secureStorage.delete(key: "isLoggedIn");
    secureStorage.delete(key: "email");
    secureStorage.delete(key: "password");
  }
}
