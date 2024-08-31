import 'dart:io';

import 'package:flutter/material.dart';
import 'package:medify/cubit/remember_me_cubit.dart';
import 'package:medify/cubit/settings_cubit.dart';
import 'package:medify/database/database_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/repositories/user_repository.dart';
import 'package:medify/scale.dart';
import 'package:medify/screens/splash_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';

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
      ],
      child: MyApp(),
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
    precacheImage(AssetImage("assets/launcher_icons/RXMedifyLogo.png"), context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        // TODO-CHECK
        if (child == null) return Container();

        // Setup scaling for mobile (this is independent from the ResponsiveWrapper Scaling for Tablets)
        Scale().setup(context, Size(411.43, 683.43));
        List<Breakpoint> breakpoints = [];

        // Don't have any breakpoints for mobile (we only want to use responsive wrapper for tablets)
        // This fixes the breakpoints hitting on mobile for landscape orientation causing it to scale and looks huge
        if (!Scale().isMobile) {
          breakpoints.addAll([
            Breakpoint(start: 400, end: 600, name: MOBILE),
            Breakpoint(start: 600, end: 950, name: TABLET),
            Breakpoint(start: 950, end: double.infinity, name: "TabletLarge"),

            // Breakpoint.resize(400, name: MOBILE),
            // Breakpoint.autoScale(600, name: TABLET, scaleFactor: 1),
            // Breakpoint.autoScale(950, name: "TabletLarge", scaleFactor: 1),
          ]);

          child = ResponsiveScaledBox(
            width: ResponsiveValue<double>(context, conditionalValues: [
              Condition.equals(name: MOBILE, value: 400),
              Condition.between(start: 600, end: 950, value: 600),
            ]).value,
            child: child,
          );
        }

        return BlocProvider<SettingsCubit>(
          create: (context) => SettingsCubit(),
          child: BlocBuilder<SettingsCubit, SettingsState>(
            buildWhen: (previous, current) => previous.fontScaleFactor != current.fontScaleFactor,
            builder: (context, state) {

              // TODO-CHECK: https://github.com/Codelessly/ResponsiveFramework/blob/master/migration_0.2.0_to_1.0.0.md
              return ResponsiveBreakpoints.builder(
                breakpoints: breakpoints,
                // mediaQueryData: MediaQuery.of(context).copyWith(textScaleFactor: state.fontScaleFactor / 1.5),

                child: child!,
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
        // TODO-FIX
        // accentColor: Color.fromRGBO(175, 0, 233, 1),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider<RememberMeCubit>(
        create: (context) => RememberMeCubit(RepositoryProvider.of<UserRepository>(context)),
        child: SplashScreen(),
      ),
    );
  }
}

/// Http override class for allowing Http requests
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
