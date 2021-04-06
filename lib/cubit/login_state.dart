part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginValidating extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSucceeded extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginFailed extends LoginState {

  final String errorMessage;

  LoginFailed(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
