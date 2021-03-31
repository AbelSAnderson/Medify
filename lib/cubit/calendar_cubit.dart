import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medify/database/model_queries/medication_event_queries.dart';
import 'package:medify/database/models/medication_event.dart';
import 'package:meta/meta.dart';
import 'package:medify/dummy_data.dart' as DummyData;

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  final MedicationEventQueries medicationEventQueries;

  CalendarCubit(this.medicationEventQueries) : super(CalendarInitial());

  ///Load all the medications events
  Future<void> getAllMedicationEvents() async {
    await Future<void>.delayed(const Duration(milliseconds: 1));
    emit(CalendarLoadInProgress());
    await Future<void>.delayed(const Duration(seconds: 1));
    // var medicationEvents = DummyData.getMedicationEvents({});
    var medicationEvents = await medicationEventQueries.retrieveAllFromApi();
    var medEventsMapped = _createMedicationEventsMap(medicationEvents);
    emit(CalendarLoaded(medEventsMapped));
  }

  ///Add a medication event to the calendar
  addMedicationEvent(MedicationEvent medicationEvent) async {
    if (state is CalendarLoaded) {
      var currentMedEvents = (state as CalendarLoaded).medicationEvents;
      var newEvents = _addMedEventToMedEventsList(currentMedEvents, medicationEvent);
      emit(CalendarLoadInProgress());
      await Future<void>.delayed(const Duration(milliseconds: 1));
      emit(CalendarLoaded(newEvents));
    }
  }

  ///This method returns the new medication events list with the new medication event added to it
  _addMedEventToMedEventsList(Map<DateTime, List<MedicationEvent>> events, MedicationEvent event) {
    var dateTime = event.datetime;
    var date = DateTime(dateTime.year, dateTime.month, dateTime.day);

    //check if the date already exists in the mapped list
    if (events[date] == null) {
      //create a new list with the event
      events[date] = [event];
    } else {
      //clone the existing list and add the new event
      events[date] = List.from(events[date])..addAll([event]);
    }

    return events;
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
}
