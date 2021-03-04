import 'package:flutter/material.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Calendar Screen",
        style: TextStyle(fontSize: 30),
      ),
    );
  }
}
