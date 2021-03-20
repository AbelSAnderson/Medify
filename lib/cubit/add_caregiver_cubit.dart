import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medify/database/models/user.dart';
import 'package:medify/database/models/user_connection.dart';
import 'package:medify/dummy_data.dart' as DummyData;

part 'add_caregiver_state.dart';

class AddCaregiverCubit extends Cubit<AddCaregiverState> {
  AddCaregiverCubit() : super(AddCaregiverInitial());

  searchForCaregiver(String input) async {
    await Future<void>.delayed(Duration(milliseconds: 1));
    emit(AddCaregiverLoading());
    var userConnections = DummyData.getUserConnections();
    var caregivers = DummyData.getConnectedUsers();
    List<CaregiverConnections> caregiverConnections = [];
    for (int i = 0; i < caregivers.length; i++) {
      var caregiverId = caregivers[i].id;
      //check to see if the client already has a connection (requested/connected) with the caregiver
      var userConnection = userConnections.firstWhere((element) => element.user.id == caregiverId, orElse: () {
        return null;
      });
      //if not null then user has a connection
      if (userConnection != null) {
        //check the type of connection the client has with the caregiver
        if (userConnection.status == Status.requested) {
          caregiverConnections.add(CaregiverConnections(caregivers[i], Status.requested));
        } else if (userConnection.status == Status.connected) {
          caregiverConnections.add(CaregiverConnections(caregivers[i], Status.connected));
        }
      }
      //if its null then user has no connection
      else {
        caregiverConnections.add(CaregiverConnections(caregivers[i], null));
      }
    }
    emit(AddCaregiverLoaded(caregiverConnections));
  }
}

class CaregiverConnections {
  User user;
  Status status;

  CaregiverConnections(this.user, this.status);
}
