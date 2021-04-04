import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medify/database/model_queries/medication_info_queries.dart';
import 'package:medify/database/models/medication.dart';
import 'package:medify/database/models/medication_event.dart';
import 'package:medify/database/models/medication_info.dart';
import 'package:medify/dummy_data.dart' as DummyData;
import 'package:medify/repositories/medication_info_repository.dart';

part 'medications_state.dart';

class MedicationsCubit extends Cubit<MedicationsState> {
  final MedicationInfoQueries medicationInfoQueries;
  final MedicationInfoRepository medicationInfoRepository;

  MedicationsCubit(this.medicationInfoQueries, this.medicationInfoRepository) : super(MedicationsInitial()) {
    //whenever medication info list changes, update state with new data
    medicationInfoRepository.streamController.stream.listen((data) async {
      emit(MedicationsLoading());
      _wait();
      emit(MedicationsLoaded(data));
    });
  }

  loadMedications() async {
    _wait();
    emit(MedicationsLoading());
    medicationInfoRepository.getMedicationInfos();
    var medicationInfos = medicationInfoRepository.medicationInfos;
    emit(MedicationsLoaded(medicationInfos));
  }

  deleteMedication(MedicationInfo medicationInfo) async {
    _wait();
    emit(MedicationsLoading());
    await medicationInfoRepository.deleteMedicationInfo(medicationInfo);
    var medicationInfos = medicationInfoRepository.medicationInfos;
    emit(MedicationsLoaded(medicationInfos));
  }

  _wait() async {
    await Future.delayed(Duration(milliseconds: 1));
  }
}
