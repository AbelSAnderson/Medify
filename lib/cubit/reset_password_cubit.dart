import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medify/database/model_queries/user_queries.dart';

part 'reset_password_state.dart';

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
