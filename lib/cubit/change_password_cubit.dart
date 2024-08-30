import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medify/repositories/user_repository.dart';

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
      print(e.toString());
      emit(ChangePasswordFailed("Connection timeout."));
    }
  }
}

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

class ChangePasswordInitial extends ChangePasswordState {
  @override
  List<Object> get props => [];
}

class ChangePasswordLoading extends ChangePasswordState {
  @override
  List<Object> get props => [];
}

class ChangePasswordSucceeded extends ChangePasswordState {
  @override
  List<Object> get props => [];
}

class ChangePasswordFailed extends ChangePasswordState {
  final String errorMsg;

  ChangePasswordFailed(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}

