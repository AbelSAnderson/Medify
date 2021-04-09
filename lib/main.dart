import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medify/cubit/add_caregiver_cubit.dart';
import 'package:medify/cubit/caregivers_cubit.dart';
import 'package:medify/cubit/change_password_cubit.dart';
import 'package:medify/cubit/client_details_cubit.dart';
import 'package:medify/cubit/clients_cubit.dart';
import 'package:medify/cubit/login_cubit.dart';
import 'package:medify/cubit/medication_form_cubit.dart';
import 'package:medify/cubit/medications_cubit.dart';
import 'package:medify/cubit/profile_cubit.dart';
import 'package:medify/cubit/search_cubit.dart';
import 'package:medify/cubit/settings_cubit.dart';
import 'package:medify/database/database_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/cubit/calendar_cubit.dart';
import 'package:medify/cubit/nav_bar_cubit.dart';
import 'package:medify/database/model_queries/caregivers_queries.dart';
import 'package:medify/database/model_queries/client_queries.dart';
import 'package:medify/database/model_queries/medication_event_queries.dart';
import 'package:medify/database/model_queries/medication_info_queries.dart';
import 'package:medify/database/model_queries/medication_queries.dart';
import 'package:medify/repositories/medication_event_repository.dart';
import 'package:medify/repositories/medication_info_repository.dart';
import 'package:medify/repositories/user_repository.dart';
import 'package:medify/scale.dart';
import 'package:medify/screens/login_screen.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

void main() async {
  // Ensure Widgets are initialized before starting the database
  WidgetsFlutterBinding.ensureInitialized();

  await DatabaseHandler().initializeHive();

  // Allow Http requests to be sent - should be changed to only allow openFDA & our API requests through
  HttpOverrides.global = new MyHttpOverrides();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider(
          create: (context) => MedicationInfoRepository(),
        ),
        RepositoryProvider(
          create: (context) => MedicationEventRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<NavBarCubit>(
            create: (context) => NavBarCubit(RepositoryProvider.of<UserRepository>(context)),
          ),
          BlocProvider(
            create: (context) => SettingsCubit(),
          ),
          BlocProvider<CalendarCubit>(
            create: (context) => CalendarCubit(MedicationEventQueries(), RepositoryProvider.of<MedicationEventRepository>(context)),
          ),
          BlocProvider(
            create: (context) => ProfileCubit(RepositoryProvider.of<UserRepository>(context)),
          ),
          BlocProvider<SearchCubit>(
            create: (context) => SearchCubit(),
          ),
          BlocProvider<CaregiversCubit>(
            create: (context) => CaregiversCubit(CaregiversQueries()),
          ),
          BlocProvider<MedicationsCubit>(
            create: (context) => MedicationsCubit(MedicationInfoQueries(), RepositoryProvider.of<MedicationInfoRepository>(context), RepositoryProvider.of<UserRepository>(context), RepositoryProvider.of<MedicationEventRepository>(context)),
          ),
          BlocProvider<AddCaregiverCubit>(
            create: (context) => AddCaregiverCubit(CaregiversQueries()),
          ),
          BlocProvider<ClientsCubit>(
            create: (context) => ClientsCubit(ClientQueries()),
          ),
          BlocProvider<ClientDetailsCubit>(
            create: (context) => ClientDetailsCubit(),
          ),
          BlocProvider<MedicationFormCubit>(
            create: (context) => MedicationFormCubit(MedicationQueries(), RepositoryProvider.of<MedicationInfoRepository>(context), RepositoryProvider.of<MedicationEventRepository>(context), RepositoryProvider.of<UserRepository>(context)),
          ),
          BlocProvider<LoginCubit>(
            create: (context) => LoginCubit(RepositoryProvider.of<UserRepository>(context)),
          ),
          BlocProvider(
            create: (context) => ChangePasswordCubit(RepositoryProvider.of<UserRepository>(context)),
          ),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //create custom color swatch for flutter to use on material components
    const Map<int, Color> colors = {
      50: Color.fromRGBO(1, 105, 255, 0.1),
      100: Color.fromRGBO(1, 105, 255, 0.2),
      200: Color.fromRGBO(1, 105, 255, 0.3),
      300: Color.fromRGBO(1, 105, 255, 0.4),
      400: Color.fromRGBO(1, 105, 255, 0.5),
      500: Color.fromRGBO(1, 105, 255, 0.6),
      600: Color.fromRGBO(1, 105, 255, 0.7),
      700: Color.fromRGBO(1, 105, 255, 0.8),
      800: Color.fromRGBO(1, 105, 255, 0.9),
      900: Color.fromRGBO(1, 105, 255, 1),
    };
    return MaterialApp(
      builder: (context, child) {
        //Setup scaling for mobile (this is independent from the ResponsiveWrapper Scaling for Tablets)
        Scale.setup(context, Size(411.43, 683.43));
        List<ResponsiveBreakpoint> breakpoints = [];
        //Don't have any breakpoints for mobile (we only want to use responsive wrapper for tablets)
        //This fixes the breakpoints hitting on mobile for landscape orientation causing it to scale and looks huge
        if (!Scale.isMobile) {
          breakpoints.addAll([
            ResponsiveBreakpoint.resize(400, name: MOBILE),
            ResponsiveBreakpoint.autoScale(600, name: TABLET, scaleFactor: 1),
            ResponsiveBreakpoint.autoScale(950, name: "TabletLarge", scaleFactor: 1),
          ]);
        }
        return BlocBuilder<SettingsCubit, SettingsState>(
          buildWhen: (previous, current) => previous.fontScaleFactor != current.fontScaleFactor,
          builder: (context, state) {
            return ResponsiveWrapper.builder(
              child,
              minWidth: 400,
              defaultScale: false,
              breakpoints: breakpoints,
              mediaQueryData: MediaQuery.of(context).copyWith(textScaleFactor: state.fontScaleFactor / 1.5),
            );
          },
        );
      },
      title: 'Medify',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: MaterialColor(0xFF0169FF, colors),
        //primaryColor: Color.fromRGBO(1, 105, 255, 1),
        accentColor: Color.fromRGBO(230, 0, 233, 1),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}

/// Http override class for allowing Http requests
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
