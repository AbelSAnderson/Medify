import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medify/database/models/medication_event.dart';
import 'package:medify/dummy_data.dart' as DummyData;

part 'client_details_state.dart';

class ClientDetailsCubit extends Cubit<ClientDetailsState> {
  ClientDetailsCubit() : super(ClientDetailsInitial());

  loadClientMedications() async {
    await Future<void>.delayed(Duration(milliseconds: 100));
    emit(ClientDetailsLoading());
    var medications = DummyData.getMedications();
    emit(ClientDetailsLoaded(medications));
  }
}
