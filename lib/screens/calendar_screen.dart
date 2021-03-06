import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:medify/constants.dart';
import 'package:medify/database/models/medication.dart';
import 'package:medify/database/models/medication_event.dart';
import 'package:medify/database/models/medication_info.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> with TickerProviderStateMixin {
  Map<DateTime, List> _events = {};
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();

    _createEventsList();

    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    setState(() {
      _selectedEvents = events;
    });
  }

  void _createEventsList() {
    Medication med = Medication(null, "Medicine", null, null, null, null);
    var medInfo = MedicationInfo(null, 1, 100, null, null, med);

    List<MedicationEvent> list = [
      MedicationEvent(null, DateTime.now(), medInfo, true, null),
      MedicationEvent(null, DateTime.now(), medInfo, true, null),
      MedicationEvent(null, DateTime.now(), medInfo, true, null),
      MedicationEvent(null, DateTime.now().add(Duration(seconds: 2)), medInfo, false, null),
      MedicationEvent(null, DateTime.utc(2021, 03, 19), medInfo, true, null),
      MedicationEvent(null, DateTime.utc(2021, 03, 18), medInfo, true, null),
      MedicationEvent(null, DateTime.utc(2021, 03, 15), medInfo, false, null),
      MedicationEvent(null, DateTime.utc(2021, 03, 16), medInfo, false, null),
      MedicationEvent(null, DateTime.utc(2021, 03, 16), medInfo, false, null),
      MedicationEvent(null, DateTime.utc(2021, 03, 16), medInfo, false, null),
      MedicationEvent(null, DateTime.utc(2021, 03, 16), medInfo, false, null),
      MedicationEvent(null, DateTime.utc(2021, 03, 16), medInfo, false, null),
      MedicationEvent(null, DateTime.utc(2021, 03, 16), medInfo, false, null),
      MedicationEvent(null, DateTime.utc(2021, 03, 16), medInfo, false, null),
      MedicationEvent(null, DateTime.utc(2021, 03, 16), medInfo, false, null),
      MedicationEvent(null, DateTime.utc(2021, 03, 16), medInfo, false, null),
      MedicationEvent(null, DateTime.utc(2021, 03, 16), medInfo, false, null),
    ];

    for (int i = 0; i < list.length; i++) {
      var dateTime = list[i].datetime;
      var date = DateTime(dateTime.year, dateTime.month, dateTime.day);

      if (_events[date] == null) {
        //create new list
        _events[date] = [list[i]];
      } else {
        //clone the list and add the new value
        _events[date] = List.from(_events[date])..addAll([list[i]]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        _buildTableCalendar(),
        Expanded(child: _buildEventList()),
      ],
    );
  }

  _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.horizontalSwipe,
      calendarStyle: CalendarStyle(
        selectedColor: Theme.of(context).primaryColor,
        todayColor: Theme.of(context).primaryColorLight,
        markersColor: Theme.of(context).accentColor,
        outsideDaysVisible: true,
      ),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        centerHeaderTitle: true,
        formatButtonTextStyle: TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.deepOrange[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,
      headerVisible: true,
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.grey),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image(
                            image: getMedTypeImage(event.medicationInfo.medicationType, false),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(event.medicationInfo.medication.brandName),
                          ),
                        ],
                      ),
                      Container(width: 50, child: Text(event.medTaken ? "Taken" : "")),
                      Text(formatDate(event.datetime, [h, ":", nn, " ", am])),
                      IconButton(
                        icon: Icon(Icons.repeat, color: Theme.of(context).accentColor),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }
}
