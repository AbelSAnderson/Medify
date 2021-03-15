import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medify/database/models/user.dart';
import 'package:medify/dummy_data.dart' as DummyData;

part 'clients_state.dart';

class ClientsCubit extends Cubit<ClientsState> {
  ClientsCubit() : super(ClientsInitial());

  ///List for all the clients who sent a request to connect
  List<User> requestedUsers;

  ///List for all the clients who are connected with the caregiver
  List<User> connectedUsers;

  ///Loads all the clients (requested and connected users)
  loadClients() async {
    //Required wait time or the state does not emit
    await Future<void>.delayed(const Duration(milliseconds: 100));
    emit(ClientsLoadingInProgress());
    connectedUsers = DummyData.getConnectedUsers();
    requestedUsers = DummyData.getRequestedUsers();
    emit(ClientsLoaded(_createClientList(), _getThreshold()));
  }

  ///User accepted the request, client is removed from requested users list and added to the connected users list
  acceptRequest(int index) async {
    emit(ClientsLoadingInProgress());
    var user = requestedUsers[index];
    requestedUsers.remove(user);
    connectedUsers.add(user);
    emit(ClientsLoaded(_createClientList(), _getThreshold()));
  }

  ///User declined the request, the client is removed from the requested users list
  declineRequest(int index) async {
    emit(ClientsLoadingInProgress());
    var user = requestedUsers[index];
    requestedUsers.remove(user);
    emit(ClientsLoaded(_createClientList(), _getThreshold()));
  }

  ///Removes a connected client from the list
  removeClient(User user) async {
    emit(ClientsLoadingInProgress());
    connectedUsers.remove(user);
    emit(ClientsLoaded(_createClientList(), _getThreshold()));
  }

  ///Creates list of clients from the requested users and connected users list
  List<User> _createClientList() {
    return List.from(requestedUsers)..addAll(connectedUsers);
  }

  ///List seperator threshold for the index of when the clients list seperates from requested users to connected users
  int _getThreshold() {
    return requestedUsers.length;
  }
}
