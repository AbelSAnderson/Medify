part of 'clients_cubit.dart';

abstract class ClientsState extends Equatable {
  const ClientsState();

  @override
  List<Object> get props => [];
}

class ClientsInitial extends ClientsState {
  @override
  List<Object> get props => [];
}

class ClientsLoadingInProgress extends ClientsState {
  @override
  List<Object> get props => [];
}

class ClientsLoaded extends ClientsState {
  final List<User> clients;
  final int listSeperatorThreshold;

  const ClientsLoaded([this.clients = const [], this.listSeperatorThreshold = 0]);

  @override
  List<Object> get props => [clients];
}

class ClientsError extends ClientsState {
  @override
  List<Object> get props => [];
}
