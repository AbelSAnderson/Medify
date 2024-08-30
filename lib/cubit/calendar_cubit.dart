import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medify/database1/model_queries/medication_event_queries.dart';
import 'package:medify/database1/models/medication_event.dart';
import 'package:medify/repositories/medication_event_repository.dart';
import 'package:meta/meta.dart';

// TODO-REFACTOR
class CalendarCubit extends Cubit<CalendarState> {
  final MedicationEventQueries medicationEventQueries;
  final MedicationEventRepository medicationEventRepository;
  late StreamSubscription _streamSubscription;

  CalendarCubit(this.medicationEventQueries, this.medicationEventRepository) : super(CalendarInitial()) {
    _streamSubscription = medicationEventRepository.streamController.stream.listen((events) {
      emit(CalendarLoadInProgress());
      _wait();
      var medicationEventsMapped = _createMedicationEventsMap(events);
      emit(CalendarLoaded(medicationEventsMapped));
    });
  }

  ///Load all the medication events
  Future<void> getAllMedicationEvents() async {
    await Future<void>.delayed(const Duration(milliseconds: 1));
    emit(CalendarLoadInProgress());
    try {
      var medicationEvents = await medicationEventRepository.getMedicationEvents();
      var medEventsMapped = _createMedicationEventsMap(medicationEvents);
      await Future.delayed(Duration(seconds: 1));
      emit(CalendarLoaded(medEventsMapped));
    } catch (e) {
      emit(CalendarFailure());
    }
  }

  Future<void> takeMedication(MedicationEvent medicationEvent) async {
    if (state is CalendarLoaded) {
      _wait();
      var previousState = state as CalendarLoaded;
      emit(CalendarLoadInProgress());
      try {
        var medEvents = previousState.medicationEvents;
        // Get date of the medication event and take out the time from it
        var medDate = medicationEvent.datetime;
        medDate = DateTime(medDate.year, medDate.month, medDate.day);
        medicationEvent.medTaken = true;
        medicationEvent.amountTaken = 1;
        await medicationEventQueries.updateToApi(medicationEvent);
        medEvents[medDate]!.firstWhere((element) => element.id == medicationEvent.id).medTaken = true;
        medEvents[medDate]!.firstWhere((element) => element.id == medicationEvent.id).amountTaken = 1;
        emit(CalendarLoaded(medEvents));
      } catch (e) {
        emit(CalendarFailure());
      }
    }
  }

  undoTakeMedication(MedicationEvent medicationEvent) async {
    if (state is CalendarLoaded) {
      _wait();
      var previousState = state as CalendarLoaded;
      emit(CalendarLoadInProgress());
      try {
        var medEvents = previousState.medicationEvents;
        // Get date of the medication event and take out the time from it
        var medDate = medicationEvent.datetime;
        medDate = DateTime(medDate.year, medDate.month, medDate.day);
        medicationEvent.medTaken = false;
        medicationEvent.amountTaken = 0;
        await medicationEventQueries.updateToApi(medicationEvent);
        medEvents[medDate]!.firstWhere((element) => element.id == medicationEvent.id).medTaken = false;
        medEvents[medDate]!.firstWhere((element) => element.id == medicationEvent.id).amountTaken = 0;
        emit(CalendarLoaded(medEvents));
      } catch (e) {
        emit(CalendarFailure());
      }
    }
  }

  checkMedsCompleteForDay(List<MedicationEvent> medEvents) {
    var medsNotTaken = medEvents.where((element) => element.medTaken == false);

    var medEventsMapped = (state as CalendarLoaded).medicationEvents;

    if (medsNotTaken.isEmpty) {
      emit(CalendarLoaded(medEventsMapped, true));
    }
  }

  _createMedicationEventsMap(List<MedicationEvent> eventsList) {
    Map<DateTime, List<MedicationEvent>> eventsMapped = {};

    for (int i = 0; i < eventsList.length; i++) {
      var dateTime = eventsList[i].datetime;
      var date = DateTime(dateTime.year, dateTime.month, dateTime.day);

      if (eventsMapped[date] == null) {
        // Create new entry
        eventsMapped[date] = [eventsList[i]];
      } else {
        // Clone the list and add the new value
        eventsMapped[date] = eventsMapped[date]!..addAll([eventsList[i]]);
      }
    }

    return eventsMapped;
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

@immutable
abstract class CalendarState extends Equatable {
  const CalendarState();
}

class CalendarInitial extends CalendarState {
  @override
  List<Object> get props => [];
}

class CalendarLoadInProgress extends CalendarState {
  @override
  List<Object> get props => [];
}

class CalendarLoaded extends CalendarState {
  final Map<DateTime, List<MedicationEvent>> medicationEvents;
  final bool medsComplete;

  const CalendarLoaded([this.medicationEvents = const {}, this.medsComplete = false]);

  @override
  List<Object> get props => [medicationEvents, medsComplete];
}

class CalendarFailure extends CalendarState {
  @override
  List<Object> get props => [];
}

