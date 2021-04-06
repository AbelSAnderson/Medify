import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsState.initial());

  changeFontScaleFactor(double value) async {
    await Future.delayed(Duration.zero);
    emit(state.copyWith(fontScaleFactor: value));
  }
}
