part of 'add_caregiver_cubit.dart';

class AddCaregiverState extends Equatable {
  final String response;
  final bool isLoading;

  const AddCaregiverState({
    this.response,
    this.isLoading,
  });

  AddCaregiverState.initial()
      : this(
          response: "",
          isLoading: false,
        );

  AddCaregiverState copyWith({
    String response,
    bool isLoading,
  }) {
    return AddCaregiverState(
      response: response ?? this.response,
      isLoading: isLoading ?? false,
    );
  }

  @override
  List<Object> get props => [response, isLoading];
}
