import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/constants.dart';
import 'package:medify/cubit/calendar_cubit.dart';
import 'package:medify/cubit/medications_cubit.dart';
import 'package:medify/database/model_queries/medication_info_queries.dart';
import 'package:medify/database/model_queries/medication_queries.dart';
import 'package:medify/database/models/medication.dart';
import 'package:medify/database/models/medication_event.dart';
import 'package:medify/database/models/medication_info.dart';
import 'package:medify/repositories/medication_event_repository.dart';
import 'package:medify/repositories/medication_info_repository.dart';
import 'package:meta/meta.dart';

part 'medication_form_state.dart';

class MedicationFormCubit extends Cubit<MedicationFormState> {
  MedicationFormCubit(this.medicationQueries, this.medicationInfoRepository, this.medicationEventRepository) : super(MedicationFormState.initial());

  // MedicationInfoQueries medicationInfoQueries = MedicationInfoQueries();

  final MedicationQueries medicationQueries;
  final MedicationInfoRepository medicationInfoRepository;
  final MedicationEventRepository medicationEventRepository;

  changeMedication(Medication medication) {
    emit(state.copyWith(medication: medication));
  }

  changeRepeats(String repeats) {
    emit(state.copyWith(interval: repeats));
  }

  changeStartDate(DateTime startDate) {
    emit(state.copyWith(startDate: startDate));
  }

  changeTime(TimeOfDay time) {
    emit(state.copyWith(time: time));
  }

  changePillAmount(String value) {
    var parsedValue = int.tryParse(value);
    var valid = _pillAmountValid(value);
    if (valid) {
      emit(state.copyWith(
        pillAmount: parsedValue == null ? -1 : parsedValue, //if its null then the user left box empty (-1 represents empty)
        isPillAmountValid: true,
      ));
    } else {
      emit(state.copyWith(
        isPillAmountValid: false,
      ));
    }
  }

  _pillAmountValid(String value) {
    if (value == "") return true;
    var parsedValue = int.tryParse(value);
    if (parsedValue == null) return false;
    if (parsedValue < 0) return false;
    return true;
  }

  changeMedicationType(int index) {
    emit(state.copyWith(medType: index));
  }

  // submitForm(BuildContext context) async {
  //   print(state.toString());
  //   DateTime dateTime = DateTime(state.startDate.year, state.startDate.month, state.startDate.day, state.time.hour, state.time.minute);
  //   Medication medication = state.medication;
  //   MedicationInfo medicationInfo = MedicationInfo(0, state.medType, state.pillAmount, dateTime, getRepeatsInt(state.interval), medication);
  //   var medicationFromJson = await medicationQueries.insertToApi(medication);
  //   medicationInfo.medication = medicationFromJson;

  //   var medicationInfoFromJson = await medicationInfoQueries.insertToApi(medicationInfo);
  //   // BlocProvider.of<MedicationsCubit>(context).addMedication(medicationInfoFromJson);

  // MedicationEvent medicationEvent = MedicationEvent(0, medicationInfo.takeAt, medicationInfo, false, 0);
  // // BlocProvider.of<CalendarCubit>(context).addMedicationEvent(medicationEvent);
  // }

  submitForm(BuildContext context) async {
    print(state.toString());
    DateTime dateTime = DateTime(state.startDate.year, state.startDate.month, state.startDate.day, state.time.hour, state.time.minute);
    Medication medication = state.medication;
    MedicationInfo medicationInfo = MedicationInfo(0, state.medType, state.pillAmount, dateTime, getRepeatsInt(state.interval), medication);
    try {
      var medicationFromJson = await medicationQueries.insertToApi(medication);
      medicationInfo.medication = medicationFromJson;

      medicationInfoRepository.addMedicationInfo(medicationInfo);
      // MedicationEvent medicationEvent = MedicationEvent(0, medicationInfo.takeAt, medicationInfo, false, 0);
      // medicationEventRepository.addMedicationEvents([medicationEvent]);
      var medicationEvents = _generateMedicationEvents(medicationInfo);
      medicationEventRepository.addMedicationEvents(await medicationEvents);
    } catch (e) {}
  }

  Future<List<MedicationEvent>> _generateMedicationEvents(MedicationInfo medicationInfo) async {
    var daysToLoad = _daysToLoad(medicationInfo.repeat);
    List<MedicationEvent> medicationEvents = [];
    for (int i = 0; i < daysToLoad; i++) {
      var dateTime = i == 0 ? medicationInfo.takeAt : medicationEvents[i - 1].datetime.add(Duration(days: medicationInfo.repeat));
      var medicationEvent = MedicationEvent(0, dateTime, medicationInfo, false, 0);
      medicationEvents.add(medicationEvent);
    }
    return medicationEvents;
  }

  int _daysToLoad(int value) {
    switch (value) {
      case 1:
        return 90;
      case 7:
        return 13;
      case 14:
        return 7;
      case 30:
        return 3;
      default:
        return 90;
    }
  }

  resetState() {
    emit(MedicationFormState.initial());
  }
}
