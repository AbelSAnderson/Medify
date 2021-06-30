part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {
  final bool attemptingInitialLogin;

  LoginInitial({this.attemptingInitialLogin = true});

  @override
  List<Object> get props => [attemptingInitialLogin];
}

class LoginValidating extends LoginState {
  LoginValidating();

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
