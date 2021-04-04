import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:medify/cubit/nav_bar_cubit.dart';
import 'package:medify/screens/calendar_screen.dart';
import 'package:medify/screens/profile_screen.dart';
import 'package:medify/screens/search_medication_screen.dart';

import '../scale.dart';
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
      bottomNavigationBar: PlatformNavBar(
        currentIndex: index,
        itemChanged: (index) => BlocProvider.of<NavBarCubit>(context).updateIndex(index),
        material: (context, platform) => MaterialNavBarData(
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.black54,
          showUnselectedLabels: true,
        ),
        cupertino: (context, platform) => CupertinoTabBarData(
          activeColor: Theme.of(context).accentColor,
          inactiveColor: Colors.black54,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Icon(PlatformIcons(context).home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(PlatformIcons(context).search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(PlatformIcons(context).person),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: PlatformWidget(
              cupertino: (context, platform) => Icon(CupertinoIcons.person_3),
              material: (context, platform) => Icon(Icons.group),
            ),
            label: "Clients",
          ),
        ],
      ),
      body: IndexedStack(
        children: screens,
        index: index,
      ),
    );
  }
}
