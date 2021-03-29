import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medify/database/models/medication_event.dart';
import 'package:meta/meta.dart';
import 'package:medify/dummy_data.dart' as DummyData;

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit() : super(CalendarInitial());

  ///Load all the medications events
  void getAllMedicationEvents() async {
    await Future<void>.delayed(const Duration(milliseconds: 1));
    emit(CalendarLoadInProgress());
    await Future<void>.delayed(const Duration(seconds: 1));
    var medicationEvents = DummyData.getMedicationEvents({});
    emit(CalendarLoaded(medicationEvents));
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
}
