part of 'medications_cubit.dart';

abstract class MedicationsState extends Equatable {
  const MedicationsState();

  @override
  List<Object> get props => [];
}

class MedicationsInitial extends MedicationsState {
  @override
  List<Object> get props => [];
}

class MedicationsLoading extends MedicationsState {
  @override
  List<Object> get props => [];
}

class MedicationsLoaded extends MedicationsState {
  final List<MedicationInfo> medications;

  const MedicationsLoaded([this.medications = const []]);

  @override
  List<Object> get props => [medications];
}

class MedicationsError extends MedicationsState {
  @override
  List<Object> get props => [];
}
