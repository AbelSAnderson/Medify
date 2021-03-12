import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/cubit/nav_bar_cubit.dart';
import 'package:medify/screens/calendar_screen.dart';
import 'package:medify/screens/profile_screen.dart';
import 'package:medify/screens/search_medication_screen.dart';

import 'clients_screen.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final screens = [CalendarScreen(), SearchMedicationScreen(), ProfileScreen(), ClientsScreen()];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarCubit, NavBarState>(
      builder: (BuildContext context, NavBarState state) {
        return _buildPage(state.title, state.index);
      },
    );
  }

  Widget _buildPage(String title, int index) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (index) => BlocProvider.of<NavBarCubit>(context).updateIndex(index),
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.black54,
        showUnselectedLabels: true,
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
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box),
            label: "Clients",
          ),
        ],
      ),
      body: screens.elementAt(index),
    );
  }
}
