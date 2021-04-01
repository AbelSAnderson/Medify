import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medify/database/model_queries/medication_info_queries.dart';
import 'package:medify/database/models/medication_event.dart';
import 'package:medify/database/models/medication_info.dart';
import 'package:medify/dummy_data.dart' as DummyData;

part 'medications_state.dart';

class MedicationsCubit extends Cubit<MedicationsState> {
  final MedicationInfoQueries medicationInfoQueries;

  MedicationsCubit(this.medicationInfoQueries) : super(MedicationsInitial());

  loadMedications() async {
    await Future<void>.delayed(Duration(milliseconds: 1));
    emit(MedicationsLoading());
    var medications = DummyData.getMedicationInfos();
    //var medications = await medicationInfoQueries.retrieveAllFromApi();
    emit(MedicationsLoaded(medications));
  }
}
