import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medify/database1/model_queries/medication_info_queries.dart';
import 'package:medify/database1/models/medication_info.dart';
import 'package:medify/repositories/medication_event_repository.dart';
import 'package:medify/repositories/medication_info_repository.dart';
import 'package:medify/repositories/user_repository.dart';

part 'medications_state.dart';

class MedicationsCubit extends Cubit<MedicationsState> {
  final MedicationInfoQueries medicationInfoQueries;
  final MedicationInfoRepository medicationInfoRepository;
  final UserRepository userRepository;
  final MedicationEventRepository medicationEventRepository;
  StreamSubscription _streamSubscription;

  MedicationsCubit(this.medicationInfoQueries, this.medicationInfoRepository, this.userRepository, this.medicationEventRepository) : super(MedicationsInitial()) {
    //whenever medication info list changes, update state with new data
    _streamSubscription = medicationInfoRepository.streamController.stream.listen((data) {
      emit(MedicationsLoading());
      _wait();
      emit(MedicationsLoaded(data));
    });
  }

  loadMedications() async {
    _wait();
    emit(MedicationsLoading());
    try {
      var currentUser = userRepository.currentUser;
      await medicationInfoRepository.getMedicationInfos(currentUser.id);
      var medicationInfos = medicationInfoRepository.medicationInfos;
      emit(MedicationsLoaded(medicationInfos));
    } catch (e) {
      emit(MedicationsError());
    }
  }

  deleteMedication(MedicationInfo medicationInfo) async {
    _wait();
    emit(MedicationsLoading());
    try {
      await medicationInfoRepository.deleteMedicationInfo(medicationInfo);
      medicationEventRepository.deleteMedicationEvents(medicationInfo);
      var medicationInfos = medicationInfoRepository.medicationInfos;
      emit(MedicationsLoaded(medicationInfos));
    } catch (e) {
      emit(MedicationsError());
    }
  }

  _wait() async {
    await Future.delayed(Duration(milliseconds: 1));
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
