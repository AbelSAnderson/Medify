part of 'client_details_cubit.dart';

abstract class ClientDetailsState extends Equatable {
  const ClientDetailsState();

  @override
  List<Object> get props => [];
}

class ClientDetailsInitial extends ClientDetailsState {
  @override
  List<Object> get props => [];
}

class ClientDetailsLoading extends ClientDetailsState {
  @override
  List<Object> get props => [];
}

class ClientDetailsLoaded extends ClientDetailsState {
  final List<MedicationEvent> medications;

  const ClientDetailsLoaded([this.medications = const []]);

  @override
  List<Object> get props => [medications];
}

class ClientDetailsError extends ClientDetailsState {
  @override
  List<Object> get props => [];
}
