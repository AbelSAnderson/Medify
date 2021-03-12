import 'package:flutter/material.dart';
import 'package:medify/database/models/medication.dart';
import 'package:medify/screens/calendar_screen.dart';
import 'package:medify/screens/search_medication_screen.dart';
import 'package:medify/widgets/medication_details.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final screens = [CalendarScreen(), SearchMedicationScreen(), MedicationDetails(Medication("0", "brandName", "usageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusageusage", "precaution", "dosage", "ingredient"))];

  onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: onTabSelected,
        selectedItemColor: Theme.of(context).accentColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
      body: screens.elementAt(_selectedIndex),
    );
  }
}
