import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/database/models/medication_event.dart';
import 'package:medify/constants.dart';
import 'package:medify/database/model_queries/medication_queries.dart';
import 'package:medify/database/models/medication.dart';
import 'package:medify/database/models/medication_info.dart';
import 'package:medify/repositories/medication_event_repository.dart';
import 'package:medify/repositories/medication_info_repository.dart';
import 'package:medify/repositories/user_repository.dart';

class MedicationFormCubit extends Cubit<MedicationFormState> {
  MedicationFormCubit(this.medicationQueries, this.medicationInfoRepository,
      this.medicationEventRepository, this.userRepository)
      : super(MedicationFormState.initial());

  final MedicationQueries medicationQueries;
  final MedicationInfoRepository medicationInfoRepository;
  final MedicationEventRepository medicationEventRepository;
  final UserRepository userRepository;

  changeMedication(Medication medication) {
    emit(state.copyWith(medication: medication));
  }

  changeRepeats(String? repeats) {
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
        pillAmount: parsedValue == null ? -1 : parsedValue,
        //if its null then the user left box empty (-1 represents empty)
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

  submitForm(BuildContext context) async {
    DateTime dateTime = DateTime(state.startDate.year, state.startDate.month,
        state.startDate.day, state.time.hour, state.time.minute);
    Medication? medication = state.medication;
    MedicationInfo medicationInfo = MedicationInfo(0, state.medType,
        state.pillAmount, dateTime, getRepeatsInt(state.interval), medication);
    try {
      // TODO-REFACTOR
      var medicationFromJson = await medicationQueries.insertToApi(medication!);
      medicationInfo.medication = medicationFromJson;
      var currentUser = userRepository.currentUser;
      var medicationInfoFromApi = await medicationInfoRepository
          .addMedicationInfo(medicationInfo, currentUser.id);
      var medicationEvent = MedicationEvent(
          0, medicationInfoFromApi.takeAt, medicationInfoFromApi, false, 0);
      medicationEventRepository.addMedicationEvents(medicationEvent);
    } catch (e) {}
  }
}

class MedicationFormState extends Equatable {
  // TODO-FIX
  final Medication? medication;
  final String interval; // Nullable?
  final DateTime startDate;
  final TimeOfDay time;
  final int? pillAmount;
  final bool isPillAmountValid;
  final int medType;

  const MedicationFormState({
    required this.medication,
    required this.interval,
    required this.startDate,
    required this.time,
    required this.pillAmount,
    required this.isPillAmountValid,
    required this.medType,
  });

  MedicationFormState.initial()
      : this(
          medication: null,
          interval: "Weekly",
          startDate: DateTime.now(),
          time: TimeOfDay.now(),
          pillAmount: null,
          isPillAmountValid: false,
          medType: 0,
        );

  MedicationFormState copyWith({
    Medication? medication,
    String? interval,
    DateTime? startDate,
    TimeOfDay? time,
    int? pillAmount,
    bool? isPillAmountValid,
    int? medType,
  }) {
    return MedicationFormState(
      medication: medication ?? this.medication,
      interval: interval ?? this.interval,
      startDate: startDate ?? this.startDate,
      time: time ?? this.time,
      pillAmount: pillAmount ?? this.pillAmount,
      isPillAmountValid: isPillAmountValid ?? this.isPillAmountValid,
      medType: medType ?? this.medType,
    );
  }

  @override
  List<Object?> get props => [
        medication,
        interval,
        startDate,
        time,
        pillAmount,
        isPillAmountValid,
        medType,
      ];

  @override
  String toString() {
    return "${medication?.brandName} $interval $startDate $time $pillAmount $medType";
  }
}
