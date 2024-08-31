import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:medify/cubit/caregivers_cubit.dart';
import 'package:medify/cubit/profile_cubit.dart';
import 'package:medify/database/model_queries/caregivers_queries.dart';
import 'package:medify/database/model_queries/client_queries.dart';
import 'package:medify/cubit/clients_cubit.dart';
import 'package:medify/database/model_queries/medication_info_queries.dart';
import 'package:medify/cubit/medications_cubit.dart';
import 'package:medify/database/model_queries/medication_event_queries.dart';
import 'package:medify/cubit/calendar_cubit.dart';
import 'package:medify/cubit/nav_bar_cubit.dart';
import 'package:medify/cubit/search_cubit.dart';
import 'package:medify/repositories/medication_event_repository.dart';
import 'package:medify/repositories/medication_info_repository.dart';
import 'package:medify/repositories/user_repository.dart';
import 'package:medify/screens/calendar_screen.dart';
import 'package:medify/screens/profile_screen.dart';
import 'package:medify/screens/search_medication_screen.dart';

import 'clients_screen.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({required this.title, Key? key}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final screens = [
    BlocProvider<CalendarCubit>(
      create: (context) => CalendarCubit(MedicationEventQueries(), RepositoryProvider.of<MedicationEventRepository>(context)),
      child: CalendarScreen(),
    ),
    BlocProvider<SearchCubit>(
      create: (context) => SearchCubit(),
      child: SearchMedicationScreen(),
    ),
    MultiBlocProvider(
      providers: [
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(RepositoryProvider.of<UserRepository>(context)),
        ),
        BlocProvider<CaregiversCubit>(
          create: (context) => CaregiversCubit(CaregiversQueries()),
        ),
        BlocProvider<MedicationsCubit>(
          create: (context) => MedicationsCubit(MedicationInfoQueries(), RepositoryProvider.of<MedicationInfoRepository>(context), RepositoryProvider.of<UserRepository>(context), RepositoryProvider.of<MedicationEventRepository>(context)),
        ),
      ],
      child: ProfileScreen(),
    ),
    BlocProvider<ClientsCubit>(
      create: (context) => ClientsCubit(ClientQueries()),
      child: ClientsScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarCubit, NavBarState>(
      builder: (BuildContext context, NavBarState state) {
        return _buildPage(state.title, state.index, state.showClients);
      },
    );
  }

  Widget _buildPage(String title, int index, bool showClients) {
    return Scaffold(
      bottomNavigationBar: PlatformNavBar(
        currentIndex: index,
        itemChanged: (index) => BlocProvider.of<NavBarCubit>(context).updateIndex(index),
        material: (context, platform) => MaterialNavBarData(
          // TODO-FIX
          // selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.black54,
          showUnselectedLabels: true,
        ),
        cupertino: (context, platform) => CupertinoTabBarData(
          // TODO-FIX
          // activeColor: Theme.of(context).accentColor,
          inactiveColor: Colors.black54,
        ),
        items: !showClients
            ? [
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
              ]
            : [
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
