import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medify/database/model_queries/caregivers_queries.dart';

part 'add_caregiver_state.dart';

class AddCaregiverCubit extends Cubit<AddCaregiverState> {
  AddCaregiverCubit(this.caregiversQueries) : super(AddCaregiverState.initial());

  final CaregiversQueries caregiversQueries;

  addCaregiver(String email) async {
    emit(state.copyWith(isLoading: true));
    try {
      var jsonResponse = await caregiversQueries.requestCaregiver(email);
      if (jsonResponse["status"] != null) {
        if (jsonResponse["status"] == true) {
          //request sent
          print("Request Sent: ${jsonResponse["status"]}");
          emit(state.copyWith(response: "Request sent successfully."));
          return;
        }
      }
      print(jsonResponse.toString());
      emit(state.copyWith(response: "Could not send request."));
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(response: "Could not send request."));
    }
  }

  resetState() {
    emit(AddCaregiverState.initial());
  }
}
