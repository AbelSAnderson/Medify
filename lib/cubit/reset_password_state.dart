part of 'reset_password_cubit.dart';

abstract class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object> get props => [];
}

class ResetInitial extends ResetPasswordState {
  @override
  List<Object> get props => [];
}

class ResetValidating extends ResetPasswordState {
  @override
  List<Object> get props => [];
}

class ResetSucceeded extends ResetPasswordState {
  @override
  List<Object> get props => [];
}

class ResetFailed extends ResetPasswordState {

  final String errorMessage;

  ResetFailed(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
