import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medify/database/model_queries/medication_event_queries.dart';
import 'package:medify/database/models/medication_event.dart';

part 'client_details_state.dart';

class ClientDetailsCubit extends Cubit<ClientDetailsState> {
  ClientDetailsCubit(this.medicationEventQueries) : super(ClientDetailsInitial());

  final MedicationEventQueries medicationEventQueries;

  loadClientMedications(int userId) async {
    await Future<void>.delayed(Duration(milliseconds: 100));
    emit(ClientDetailsLoading());
    var medications = await medicationEventQueries.retrieveAllFromApiForUser(userId);
    emit(ClientDetailsLoaded(_sortMedications(medications)));
  }

  _sortMedications(List<MedicationEvent> medicationEvents) {
    return medicationEvents
      ..sort((a, b) {
        if (a.medTaken) {
          return 1;
        } else {
          return 0;
        }
      });
  }

  int _getMedTakenValue(String value) {
    switch (value) {
      case "Not Taken":
        return 0;
      case "Taken":
        return 1;
      default:
        return 0;
    }
  }

  refreshState() {
    emit(ClientDetailsInitial());
  }
}
