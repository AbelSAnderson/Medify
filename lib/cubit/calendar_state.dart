part of 'calendar_cubit.dart';

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
