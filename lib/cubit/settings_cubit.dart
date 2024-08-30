import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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

class SettingsState extends Equatable {
  final double fontScaleFactor;

  const SettingsState({
    required this.fontScaleFactor,
  });

  SettingsState.initial()
      : this(
          fontScaleFactor: 1.5,
        );

  SettingsState copyWith({
    double? fontScaleFactor,
  }) {
    return SettingsState(
      fontScaleFactor: fontScaleFactor ?? this.fontScaleFactor,
    );
  }

  @override
  List<Object> get props => [
        fontScaleFactor,
      ];
}
