part of 'change_password_cubit.dart';

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
