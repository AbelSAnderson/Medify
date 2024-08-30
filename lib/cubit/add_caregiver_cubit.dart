import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medify/database1/model_queries/caregivers_queries.dart';

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
          emit(state.copyWith(response: "Request sent successfully."));
          return;
        }
      }
      emit(state.copyWith(response: "Could not send request."));
    } catch (e) {
      emit(state.copyWith(response: "Could not send request."));
    }
  }
}

class AddCaregiverState extends Equatable {
  final String response;
  final bool isLoading;

  const AddCaregiverState({
    required this.response,
    required this.isLoading,
  });

  AddCaregiverState.initial()
      : this(
    response: "",
    isLoading: false,
  );

  AddCaregiverState copyWith({
    String? response,
    bool? isLoading,
  }) {
    return AddCaregiverState(
      response: response ?? this.response,
      isLoading: isLoading ?? false,
    );
  }

  @override
  List<Object> get props => [response, isLoading];
}

