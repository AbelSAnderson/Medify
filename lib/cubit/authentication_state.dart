part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationAuthenticated extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationUnauthenticated extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationUnknown extends AuthenticationState {
  @override
  List<Object> get props => [];
}
