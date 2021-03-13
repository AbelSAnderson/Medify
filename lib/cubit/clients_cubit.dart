import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medify/database/models/user.dart';
import 'package:medify/dummy_data.dart' as DummyData;

part 'clients_state.dart';

class ClientsCubit extends Cubit<ClientsState> {
  ClientsCubit() : super(ClientsInitial());

  loadClients() async {
    await Future<void>.delayed(const Duration(milliseconds: 1));
    emit(ClientsLoadingInProgress());
    var connectedUsers = DummyData.getConnectedUsers();
    var requestedUsers = DummyData.getRequestedUsers();
    List<User> allClients = List.from(requestedUsers)..addAll(connectedUsers);
    var listSeperatorThreshold = requestedUsers.length;
    emit(ClientsLoaded(allClients, listSeperatorThreshold));
  }

  acceptRequest(List users, int index, int listSeperatorThreshold) async {
    //TODO: SWITCH THE CLIENTS LIST TO A MAP OF <String, List<User>> --> {"Requests": [], "Connected": []}
    // ^ will allow us to uniquely identify which users are requesting and which are connected in a single map
    await Future<void>.delayed(const Duration(milliseconds: 1));
    emit(ClientsLoadingInProgress());
    var user = users[index];
    var updatedList = users
      ..remove(user)
      ..add(user);
    var newThreshold = listSeperatorThreshold - 1;
    await Future<void>.delayed(const Duration(milliseconds: 1));
    emit(ClientsLoaded(updatedList, newThreshold));
    await Future<void>.delayed(const Duration(milliseconds: 1));
  }

  declineRequest(List users, int index, int listSeperatorThreshold) async {
    await Future<void>.delayed(const Duration(milliseconds: 1));
    emit(ClientsLoadingInProgress());
    var user = users[index];
    var updatedList = users..remove(user);
    var newThreshold = listSeperatorThreshold - 1;
    await Future<void>.delayed(const Duration(milliseconds: 1));
    emit(ClientsLoaded(updatedList, newThreshold));
    await Future<void>.delayed(const Duration(milliseconds: 1));
  }
}
