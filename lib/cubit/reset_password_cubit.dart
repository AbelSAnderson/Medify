import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medify/database1/model_queries/user_queries.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetInitial());

  resetPassword(String email) async {
    emit(ResetValidating());

    try {
      var jsonResponse = await new UserQueries().resetPassword(email);

      if (jsonResponse['status']) {
        emit(ResetSucceeded());
      } else {
        emit(ResetFailed(jsonResponse['message']));
      }
    } catch (exception) {
      emit(ResetFailed("Internal server error"));
    }
  }

  resetState() {
    emit(ResetInitial());
  }
}

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

