import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medify/database/model_queries/medication_event_queries.dart';
import 'package:medify/database/models/medication_event.dart';
import 'package:medify/repositories/medication_event_repository.dart';
import 'package:meta/meta.dart';
import 'package:medify/dummy_data.dart' as DummyData;

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  final MedicationEventQueries medicationEventQueries;
  final MedicationEventRepository medicationEventRepository;

  CalendarCubit(this.medicationEventQueries, this.medicationEventRepository) : super(CalendarInitial()) {
    medicationEventRepository.streamController.stream.listen((events) {
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
    var medicationEvents = await medicationEventRepository.getMedicationEvents();
    var medEventsMapped = _createMedicationEventsMap(medicationEvents);
    await Future.delayed(Duration(seconds: 1));
    emit(CalendarLoaded(medEventsMapped));
  }

  _createMedicationEventsMap(List<MedicationEvent> eventsList) {
    Map<DateTime, List<MedicationEvent>> eventsMapped = {};

    for (int i = 0; i < eventsList.length; i++) {
      var dateTime = eventsList[i].datetime;
      var date = DateTime(dateTime.year, dateTime.month, dateTime.day);

      if (eventsMapped[date] == null) {
        //create new list
        eventsMapped[date] = [eventsList[i]];
      } else {
        //clone the list and add the new value
        eventsMapped[date] = List.from(eventsMapped[date])..addAll([eventsList[i]]);
      }
    }

    return eventsMapped;
  }

  _wait() async {
    await Future.delayed(Duration(milliseconds: 1));
  }
}
