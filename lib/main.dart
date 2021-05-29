import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:medify/cubit/login_cubit.dart';
import 'package:medify/cubit/settings_cubit.dart';
import 'package:medify/database/database_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    Phoenix(
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => UserRepository(),
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
      50: Color.fromRGBO(52, 88, 166, 0.1),
      100: Color.fromRGBO(52, 88, 166, 0.2),
      200: Color.fromRGBO(52, 88, 166, 0.3),
      300: Color.fromRGBO(52, 88, 166, 0.4),
      400: Color.fromRGBO(52, 88, 166, 0.5),
      500: Color.fromRGBO(52, 88, 166, 0.6),
      600: Color.fromRGBO(52, 88, 166, 0.7),
      700: Color.fromRGBO(52, 88, 166, 0.8),
      800: Color.fromRGBO(52, 88, 166, 0.9),
      900: Color.fromRGBO(52, 88, 166, 1),
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
        return BlocProvider<SettingsCubit>(
          create: (context) => SettingsCubit(),
          child: BlocBuilder<SettingsCubit, SettingsState>(
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
          ),
        );
      },
      title: 'RX-Medify',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: MaterialColor(0xFF3458a6, colors),
        //primaryColor: Color.fromRGBO(1, 105, 255, 1),
        accentColor: Color.fromRGBO(175, 0, 233, 1),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider<LoginCubit>(
        create: (context) => LoginCubit(RepositoryProvider.of<UserRepository>(context)),
        child: LoginScreen(),
      ),
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
