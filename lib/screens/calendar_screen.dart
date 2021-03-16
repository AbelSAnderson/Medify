import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/constants.dart';
import 'package:medify/cubit/calendar_cubit.dart';
import 'package:medify/database/models/medication.dart';
import 'package:medify/database/models/medication_event.dart';
import 'package:medify/database/models/medication_info.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> with TickerProviderStateMixin {
  var _events = {};
  List _selectedEvents = [];
  AnimationController _animationController;
  CalendarController _calendarController = CalendarController();
  final _today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  var _calendarCreated = false;

  @override
  void initState() {
    super.initState();

    // _selectedEvents = [];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildTableCalendar(),
          Expanded(child: _buildEventList()),
        ],
      ),
    );
  }

  _buildTableCalendar() {
    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        if (state is CalendarInitial) {
          BlocProvider.of<CalendarCubit>(context).getAllMedicationEvents();
        }
        if (state is CalendarLoadInProgress) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is CalendarLoaded) {
          _events = state.medicationEvents;

          _selectedEvents = _events[_today] ?? [];

          return TableCalendar(
            calendarController: _calendarController,
            events: _events,
            startingDayOfWeek: StartingDayOfWeek.sunday,
            availableGestures: AvailableGestures.horizontalSwipe,
            initialSelectedDay: _today,
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
        return Container();
      },
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
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
