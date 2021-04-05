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
  final List<UserConnection> clients;

  const ClientsLoaded([this.clients = const []]);

  @override
  List<Object> get props => [clients];
}

class ClientsError extends ClientsState {
  @override
  List<Object> get props => [];
}
