part of 'add_caregiver_cubit.dart';

abstract class AddCaregiverState extends Equatable {
  const AddCaregiverState();

  @override
  List<Object> get props => [];
}

class AddCaregiverInitial extends AddCaregiverState {
  @override
  List<Object> get props => [];
}

class AddCaregiverLoading extends AddCaregiverState {
  @override
  List<Object> get props => [];
}

class AddCaregiverLoaded extends AddCaregiverState {
  final List<CaregiverResults> caregivers;

  const AddCaregiverLoaded([this.caregivers = const []]);

  @override
  List<Object> get props => [caregivers];
}

class AddCaregiverError extends AddCaregiverState {
  @override
  List<Object> get props => [];
}
