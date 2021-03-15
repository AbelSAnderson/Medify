import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medify/database/models/medication_event.dart';
import 'package:meta/meta.dart';
import 'package:medify/dummy_data.dart' as DummyData;

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit() : super(CalendarInitial());

  void getAllMedicationEvents() async {
    await Future<void>.delayed(const Duration(milliseconds: 1));
    emit(CalendarLoadInProgress());
    await Future<void>.delayed(const Duration(seconds: 1));
    var medicationEvents = DummyData.getMedicationEvents({});
    emit(CalendarLoaded(medicationEvents));
  }
}
