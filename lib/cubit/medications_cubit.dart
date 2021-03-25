import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medify/database/models/medication_event.dart';
import 'package:medify/dummy_data.dart' as DummyData;

part 'medications_state.dart';

class MedicationsCubit extends Cubit<MedicationsState> {
  MedicationsCubit() : super(MedicationsInitial());

  loadMedications() async {
    await Future<void>.delayed(Duration(milliseconds: 1));
    emit(MedicationsLoading());
    var medications = DummyData.getMedications();
    emit(MedicationsLoaded(medications));
  }
}
