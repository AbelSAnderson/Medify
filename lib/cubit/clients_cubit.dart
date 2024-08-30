import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medify/database1/model_queries/client_queries.dart';
import 'package:medify/database1/models/user_connection.dart';

class ClientsCubit extends Cubit<ClientsState> {
  ClientsCubit(this.clientQueries) : super(ClientsInitial());

  final ClientQueries clientQueries;

  ///Loads all the clients (requested and connected users)
  loadClients() async {
    //Required wait time or the state does not emit
    emit(ClientsLoadingInProgress());
    await Future<void>.delayed(const Duration(milliseconds: 250));
    try {
      var userConnections = await clientQueries.retrieveAllFromApi();
      userConnections = _sortUserConnections(userConnections);
      emit(ClientsLoaded(userConnections));
    } catch (e) {
      emit(ClientsError());
    }
  }

  ///User accepted the request, client is removed from requested users list and added to the connected users list
  acceptRequest(UserConnection userConnection) async {
    if (state is ClientsLoaded) {
      var previousState = state as ClientsLoaded;
      emit(ClientsLoadingInProgress());
      try {
        var jsonResponse = await clientQueries.acceptRequest(userConnection.user.id);
        if (jsonResponse["status"] != null) {
          if (jsonResponse["status"] == true) {
            userConnection.status = Status.connected;
            var userConnections = previousState.clients..removeWhere((element) => element.user.id == userConnection.user.id);
            var newUserConnections = userConnections..add(userConnection);
            //sort user connections so requested are first
            newUserConnections = _sortUserConnections(newUserConnections);
            emit(ClientsLoaded(newUserConnections));
          }
        } else {
          emit(ClientsError());
        }
      } catch (e) {
        emit(ClientsError());
      }
    }
  }

  ///User declined the request, the client is removed from the requested users list
  removeClient(UserConnection userConnection) async {
    if (state is ClientsLoaded) {
      var previousState = state as ClientsLoaded;
      emit(ClientsLoadingInProgress());
      try {
        var jsonResponse = await clientQueries.removeClient(userConnection.user.id);
        if (jsonResponse["status"] != null) {
          if (jsonResponse["status"] == true) {
            var newUserConnections = previousState.clients..removeWhere((element) => element.user.id == userConnection.user.id);
            //sort user connections so requested are first
            newUserConnections = _sortUserConnections(newUserConnections);
            emit(ClientsLoaded(newUserConnections));
          } else {
            emit(ClientsError());
          }
        } else {
          emit(ClientsError());
        }
      } catch (e) {
        emit(ClientsError());
      }
    }
  }

  ///Removes a connected client from the list
  // removeClient(User user) async {
  //   if (state is ClientsLoaded) {
  //     var previousState = state as ClientsLoaded;
  //     emit(ClientsLoadingInProgress());
  //     var newUserConnections = previousState.clients..removeWhere((element) => element.user.id == user.id);
  //     newUserConnections = _sortUserConnections(newUserConnections);
  //     emit(ClientsLoaded(newUserConnections));
  //   }
  // }

  ///Sorts user connections so the requested clients are first in the list
  List<UserConnection> _sortUserConnections(List<UserConnection> userConnections) {
    return userConnections..sort((a, b) => a.status.index.compareTo(b.status.index));
  }
}

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
