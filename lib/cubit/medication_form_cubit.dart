import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/constants.dart';
import 'package:medify/cubit/calendar_cubit.dart';
import 'package:medify/database/models/medication.dart';
import 'package:medify/database/models/medication_event.dart';
import 'package:medify/database/models/medication_info.dart';
import 'package:meta/meta.dart';

part 'medication_form_state.dart';

class MedicationFormCubit extends Cubit<MedicationFormState> {
  MedicationFormCubit() : super(MedicationFormState.initial());

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
        pillAmount: parsedValue == null ? -1 : parsedValue, //if its null than the user left box empty (-1 represents empty)
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

  submitForm(BuildContext context) {
    print(state.toString());
    DateTime dateTime = DateTime(state.startDate.year, state.startDate.month, state.startDate.day, state.time.hour, state.time.minute);
    MedicationInfo medicationInfo = MedicationInfo(0, state.medType, state.pillAmount, dateTime, getRepeatsInt(state.interval), state.medication);
    MedicationEvent medicationEvent = MedicationEvent(0, medicationInfo.takeAt, medicationInfo, false, 0);
    BlocProvider.of<CalendarCubit>(context).addMedicationEvent(medicationEvent);
  }

  resetState() {
    emit(MedicationFormState.initial());
  }
}
