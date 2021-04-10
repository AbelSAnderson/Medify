import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medify/repositories/user_repository.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit(this.userRepository) : super(ChangePasswordInitial());

  final UserRepository userRepository;

  changePassword(String oldPassword, String newPassword) async {
    emit(ChangePasswordLoading());
    try {
      var currentPassword = userRepository.password;
      if (oldPassword == currentPassword) {
        await userRepository.changePassword(newPassword);
        emit(ChangePasswordSucceeded());
      } else {
        emit(ChangePasswordFailed("The password you entered is incorrect."));
      }
    } catch (e) {
      emit(ChangePasswordFailed("Connection timeout."));
    }
  }

  resetState() {
    emit(ChangePasswordInitial());
  }
}
