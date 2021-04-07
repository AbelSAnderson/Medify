import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medify/cubit/caregivers_cubit.dart';
import 'package:medify/database/model_queries/client_queries.dart';
import 'package:medify/database/models/user.dart';
import 'package:medify/database/models/user_connection.dart';
import 'package:medify/dummy_data.dart' as DummyData;

part 'clients_state.dart';

class ClientsCubit extends Cubit<ClientsState> {
  ClientsCubit(this.clientQueries) : super(ClientsInitial());

  final ClientQueries clientQueries;

  ///Loads all the clients (requested and connected users)
  loadClients() async {
    //Required wait time or the state does not emit
    await Future<void>.delayed(const Duration(milliseconds: 100));
    emit(ClientsLoadingInProgress());
    try {
      var userConnections = await clientQueries.retrieveAllFromApi();
      userConnections = _sortUserConnections(userConnections);
      emit(ClientsLoaded(userConnections));
    } catch (e) {}
  }

  ///User accepted the request, client is removed from requested users list and added to the connected users list
  acceptRequest(UserConnection userConnection) async {
    if (state is ClientsLoaded) {
      var previousState = state as ClientsLoaded;
      emit(ClientsLoadingInProgress());
      userConnection.status = Status.connected;
      var userConnections = previousState.clients..removeWhere((element) => element.user.id == userConnection.user.id);
      var newUserConnections = userConnections..add(userConnection);
      //sort user connections so requested are first
      newUserConnections = _sortUserConnections(newUserConnections);
      emit(ClientsLoaded(newUserConnections));
    }
  }

  ///User declined the request, the client is removed from the requested users list
  declineRequest(UserConnection userConnection) async {
    if (state is ClientsLoaded) {
      var previousState = state as ClientsLoaded;
      emit(ClientsLoadingInProgress());
      var newUserConnections = previousState.clients..removeWhere((element) => element.user.id == userConnection.user.id);
      //sort user connections so requested are first
      newUserConnections = _sortUserConnections(newUserConnections);
      emit(ClientsLoaded(newUserConnections));
    }
  }

  ///Removes a connected client from the list
  removeClient(User user) async {
    if (state is ClientsLoaded) {
      var previousState = state as ClientsLoaded;
      emit(ClientsLoadingInProgress());
      var newUserConnections = previousState.clients..removeWhere((element) => element.user.id == user.id);
      newUserConnections = _sortUserConnections(newUserConnections);
      emit(ClientsLoaded(newUserConnections));
    }
  }

  List<UserConnection> _sortUserConnections(List<UserConnection> userConnections) {
    return userConnections..sort((a, b) => a.status.index.compareTo(b.status.index));
  }
}
