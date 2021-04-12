import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:medify/constants.dart';
import 'package:medify/cubit/calendar_cubit.dart';
import 'package:medify/database/models/medication_event.dart';
import 'package:medify/widgets/confirmation_dialog.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:medify/scale.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  var _events = {};
  List _selectedEvents = [];
  var _selectedDay;
  CalendarController _calendarController = CalendarController();
  final _today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  var _calendarCreated = false;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _selectedDay = _today;
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    _selectedDay = day;
    setState(() {
      _selectedEvents = events;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
        ),
      ),
      body: BlocBuilder<CalendarCubit, CalendarState>(
        builder: (context, state) {
          if (state is CalendarInitial) {
            BlocProvider.of<CalendarCubit>(context).getAllMedicationEvents();
          }
          if (state is CalendarLoadInProgress) {
            return Center(child: CircularProgressIndicator.adaptive());
          }
          if (state is CalendarLoaded) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                InteractiveViewer(child: _buildTableCalendar(state)),
                Expanded(child: _buildEventList()),
              ],
            );
          }
          if (state is CalendarFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "No Internet Connection.",
                    style: TextStyle(fontSize: 18.sf),
                  ),
                  TextButton(
                    child: Text("Try Again"),
                    onPressed: () => BlocProvider.of<CalendarCubit>(context).getAllMedicationEvents(),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  _buildTableCalendar(CalendarLoaded state) {
    _events = state.medicationEvents;
    var date = DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day);
    _selectedEvents = _events[date] ?? [];

    if (_calendarCreated) {
      _calendarController.setCalendarFormat(MediaQuery.of(context).orientation == Orientation.portrait ? CalendarFormat.month : CalendarFormat.week);
    }
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.horizontalSwipe,
      startDay: DateTime.now().subtract(Duration(days: 30)),
      endDay: DateTime.now().add(Duration(days: 30)),
      initialSelectedDay: _selectedDay,
      initialCalendarFormat: MediaQuery.of(context).orientation == Orientation.portrait ? CalendarFormat.month : CalendarFormat.week,
      calendarStyle: CalendarStyle(
        selectedColor: Theme.of(context).primaryColor,
        todayColor: Theme.of(context).primaryColorLight,
        markersColor: Theme.of(context).accentColor,
        outsideDaysVisible: true,
      ),
      rowHeight: 50.sv,
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        centerHeaderTitle: true,
        formatButtonTextStyle: TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.deepOrange[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onCalendarCreated: (first, last, format) {
        _calendarCreated = true;
      },
      onDaySelected: _onDaySelected,
      headerVisible: true,
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map(
            (event) => Container(
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.grey),
                borderRadius: BorderRadius.circular(12.0),
              ),
              margin: EdgeInsets.symmetric(horizontal: 8.sh, vertical: 4.sv),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.sv, horizontal: 8.sh),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Row(
                        children: [
                          Image(
                            image: getMedTypeImage(event.medicationInfo.medicationType, false),
                            width: 40.sf,
                            height: 40.sf,
                          ),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.sh),
                              child: Text(
                                event.medicationInfo.medication.brandName,
                                style: TextStyle(fontSize: 14.sf),
                                overflow: TextOverflow.fade,
                                softWrap: false,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Text(
                        "Taken",
                        style: TextStyle(
                          fontSize: 14.sf,
                          color: event.medTaken ? Colors.black : Colors.transparent,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Text(
                        formatDate(event.datetime, [h, ":", nn, " ", am]),
                        style: TextStyle(fontSize: 14.sf),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: !event.medTaken ? _takenIconButton(event) : _undoIconButton(event),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _takenIconButton(MedicationEvent medicationEvent) {
    return PlatformIconButton(
      padding: EdgeInsets.all(0),
      icon: Icon(
        Icons.check_circle,
        color: Theme.of(context).primaryColor,
        size: 32.sf,
      ),
      onPressed: () {
        BlocProvider.of<CalendarCubit>(context).takeMedication(medicationEvent);
      },
    );
  }

  Widget _undoIconButton(MedicationEvent medicationEvent) {
    return PlatformIconButton(
      padding: EdgeInsets.all(0),
      // icon: Icon(
      //   Icons.replay_circle_filled,
      //   color: Theme.of(context).accentColor,
      //   size: 32.sf,
      // ),
      icon: Text(
        "Undo",
        style: TextStyle(
          fontSize: 14.sf,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).accentColor,
        ),
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => ConfirmationDialog(
            confirmClicked: () => BlocProvider.of<CalendarCubit>(context).undoTakeMedication(medicationEvent),
            title: "Undo Take Medication",
            message: "Are you want to undo taking the medication?",
            buttonTitle: "Undo",
          ),
        );
      },
    );
  }
}
