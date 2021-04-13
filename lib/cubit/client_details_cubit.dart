import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medify/database/model_queries/medication_event_queries.dart';
import 'package:medify/database/models/medication_event.dart';
import 'package:medify/dummy_data.dart' as DummyData;

part 'client_details_state.dart';

class ClientDetailsCubit extends Cubit<ClientDetailsState> {
  ClientDetailsCubit(this.medicationEventQueries) : super(ClientDetailsInitial());

  final MedicationEventQueries medicationEventQueries;

  loadClientMedications(int userId) async {
    await Future<void>.delayed(Duration(milliseconds: 100));
    emit(ClientDetailsLoading());
    //replace this with retrieve all today for one user
    // var medications = await medicationEventQueries.retrieveAllFromApi(userId);
    var medications = DummyData.getMedications();
    emit(ClientDetailsLoaded(medications));
  }

  refreshState() {
    emit(ClientDetailsInitial());
  }
}
